from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, conint, confloat
import joblib
import pandas as pd
import uvicorn

# Initializing FastAPI app
app = FastAPI(title="Boston Housing Price Prediction API")

# Allowing CORS for all origins (for simplicity)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Loading the trained model
model = joblib.load('boston_model.pkl')

# Defining input data using Pydantic BaseModel
class HouseFeatures(BaseModel):
    crim: confloat(ge=0.0, le=100.0)  # Crime rate
    zn: confloat(ge=0.0, le=100.0)    # Residential land zoning
    indus: confloat(ge=0.0, le=30.0)  # Industrial proportion
    rm: confloat(ge=3.0, le=10.0)     # Avg number of rooms
    age: confloat(ge=0.0, le=100.0)   # Age of buildings
    dis: confloat(ge=1.0, le=12.0)    # Distance to employment centers
    rad: conint(ge=1, le=24)          # Accessibility to highways
    tax: conint(ge=100, le=800)       # Property tax rate
    ptratio: confloat(ge=10.0, le=25.0) # Pupil-teacher ratio
    lstat: confloat(ge=1.0, le=40.0)  # Lower-status population percentage

@app.post('/predict')
def predict(features: HouseFeatures):
    input_df = pd.DataFrame([features.model_dump()])
    prediction = model.predict(input_df)[0]

    return {"predicted_price": round(prediction, 2)}

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
