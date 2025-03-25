# 🏡 Boston Housing Price Predictor

This is a mobile Flutter app that predicts house prices in the Boston area using a machine learning model. The app takes various housing-related input values like crime rate, number of rooms, and tax rate, then displays the estimated price using a remote prediction API.

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


