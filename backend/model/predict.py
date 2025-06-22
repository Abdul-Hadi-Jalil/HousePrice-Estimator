import pandas as pd
from joblib import load
from pathlib import Path

# Get the directory where predict.py is located
MODEL_DIR = Path(__file__).parent  # Points to /backend/model/
MODEL_PATH = MODEL_DIR / "knn_model_house_price_estimator.joblib"  # Full path to model

CITY_ENCODER_DIR = Path(__file__).parent
CITY_ENCODER_PATH = CITY_ENCODER_DIR / "label_encoder_city.joblib"

LOCATION_ENCODER_DIR = Path(__file__).parent
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


if __name__ == "__main__":
    # Example usage (for testing)
    test_data = {
        "property_type": "Flat",
        "location": "G-10",
        "city": "Karachi",
        "baths": 4,
        "bedrooms": 5,
        "Area_in_Marla": 20,
    }

    print("Predicted price:", predict_property_price(test_data))
