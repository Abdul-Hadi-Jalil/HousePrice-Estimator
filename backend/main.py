from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from pydantic import BaseModel
from model.predict import predict_property_price

app = FastAPI()

# Fix: allow_credentials should be bool, not string
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # List[str] or "*"
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


@app.post("/predict", response_model=PredictionResult)
async def predict_property(data: PredictionInput):
    input_features = data.dict()

    # Call ML model and create a PredictionResult instance
    prediction = predict_property_price(list(input_features.values()))

    return PredictionResult(prediction=prediction)  # Return an instance
