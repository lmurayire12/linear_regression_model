# 🏡 Boston Housing Price Drop Predictor

This is a mobile Flutter app that predicts how house prices may drop in the Boston area based on negative property and neighborhood conditions.

The app takes various housing-related inputs like crime rate, number of rooms, and tax rate, then shows the estimated price using a remote machine learning API helping users understand how specific factors can reduce home value.

---

## 🌐 Public API Endpoint

This app uses a publicly available API to return predictions based on user input:

https://bostonhousing-wo52.onrender.com/predict


- **Method:** POST  
- **Content-Type:** application/json

### 📥 Example Input

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
```

Example response:
```json
{
  "predicted_price": 49250.0
}
```

## Watch the video demo here: https://youtu.be/A0QLtXzVFRs

# How to Run the App
##  Clone my repo 
Open your terminal

```bash
git clone https://github.com/lmurayire12/linear_regression_model.git
```
 Navigate to the Project Folder
 ```bash
cd summative/FlutterApp/boston_housing 

```

# Prerequisites
Flutter SDK installed
Android Studio or Visual Studio Code
A physical or virtual device (emulator)

## Run the App

1. ### Install dependencies

```bash
flutter pub get

```

2. ### Run the app:

```bash
flutter run
```

### Ensure your device/emulator is connected before running the app.

# 🖼️  Assets 
Make sure this image exists in the assets folder:

```bash
    assets/house.jpg
```

Then include it in your pubspec.yaml:

```bash
flutter:
  assets:
    - assets/house.jpg
```

🛠️ Tech Stack
- Frontend: Flutter (Dart)

- Backend: Python Flask (hoted on Render)

- API Requests: http package


