# 🏡 Boston Housing Price Predictor

This is a mobile Flutter app that predicts house prices in the Boston area using a machine learning model. The app takes various housing-related input values like crime rate, number of rooms, and tax rate, then displays the estimated price using a remote prediction API.

---

## 🌐 Public API Endpoint

This app uses a publicly available API to return predictions based on user input:

https://bostonhousing-wo52.onrender.com/predict


- Method: `POST`
- Content-Type: `application/json`
- Example request body:

```json
{
  "crim": 18.0,
  "zn": 0.0,
  "indus": 20.0,
  "rm": 4.5,
  "age": 85.0,
  "dis": 1.5,
  "rad": 24,
  "tax": 666,
  "ptratio": 20.2,
  "lstat": 30.0
}

Example response:

{
  "predicted_price": 49250.0
}

```json


# Watch the demo here: YouTube Demo Video

# How to Run the App

Clone my repo: 

Open your termainal

Type git clone https://github.com/lmurayire12/linear_regression_model.git

Navigate to the app folder:

cd summative/FlutterApp/boston_housing

Prerequisites

Flutter SDK installed (Install Flutter)

Android Studio or Visual Studio Code

Physical or virtual device (emulator)

Installation Steps

1. Get dependencies: RUN flutter pub get

2. RUN the app: flutter run

Ensure your device or emulator is connected.


