from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
from joblib import load
from pathlib import Path

app = FastAPI()

# Fix: allow_credentials should be bool, not string
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True,  # Bool, not "*"
)


class PredictionInput(BaseModel):
    location: str
    property_type: str
    city: str
    baths: int
    bedrooms: int
    Area_in_Marla: float


class PredictionResult(BaseModel):
    prediction: float


# Get the directory where predict.py is located
MODEL_DIR = Path(__file__).parent / "model"  # Points to /backend/model/
MODEL_PATH = MODEL_DIR / "knn_model_house_price_estimator.joblib"  # Full path to model

CITY_ENCODER_DIR = Path(__file__).parent / "model"
CITY_ENCODER_PATH = CITY_ENCODER_DIR / "label_encoder_city.joblib"

LOCATION_ENCODER_DIR = Path(__file__).parent / "model"
LOCATION_ENCODER_PATH = LOCATION_ENCODER_DIR / "label_encoder_location.joblib"

# Load the model
model = load(MODEL_PATH)

# Load model and encoders (do this once when the module loads)
knn_model = load(MODEL_PATH)
city_encoder = load(CITY_ENCODER_PATH)  # Renamed for clarity
location_encoder = load(LOCATION_ENCODER_PATH)


def predict_property_price(input_data):
    """
    Predicts house price based on input data.

    Args:
        input_data (dict): Dictionary containing feature values. Example:
            {
                "property_type": "Flat",
                "location": "G-10",
                "city": "Karachi",
                "baths": 4,
                "bedrooms": 5,
                "Area_in_Marla": 20
            }

    Returns:
        float: Predicted price
    """
    try:
        # Convert input to DataFrame
        new_data = pd.DataFrame([input_data])

        # Preprocess data
        new_data = preprocess_input(new_data)

        # Make prediction
        prediction = knn_model.predict(new_data)
        return round(float(prediction[0]), 2)  # Return rounded float

    except Exception as e:
        print(f"Prediction error: {str(e)}")
        raise  # Re-raise for the caller to handle


def preprocess_input(data):
    """Preprocesses the input data to match training format"""
    # Encode categorical columns
    data["location"] = location_encoder.transform(data["location"])
    data["city"] = city_encoder.transform(data["city"])

    # Map property_type (handle unknown values)
    data["property_type"] = (
        data["property_type"]
        .map({"Flat": 0, "House": 1})
        .fillna(2)  # Unknown types get 2
    )

    # Ensure correct column order (match training data)
    expected_columns = [
        "property_type",
        "location",
        "city",
        "baths",
        "bedrooms",
        "Area_in_Marla",
    ]
    return data[expected_columns]


@app.post("/predict", response_model=PredictionResult)
async def predict_property(data: PredictionInput):
    input_features = data.dict()
    print("Input features received:", input_features)  # Debug log

    prediction = predict_property_price(input_features)

    return PredictionResult(prediction=prediction)
