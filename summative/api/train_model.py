# train_model.py
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import joblib

# Load dataset
url = "https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv"
data = pd.read_csv(url)

# Selecting features and target
X = data[['crim', 'zn', 'indus', 'rm', 'age', 'dis', 'rad', 'tax', 'ptratio', 'lstat']]
y = data['medv']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
model = LinearRegression()
model.fit(X_train, y_train)

# Save trained model
joblib.dump(model, 'boston_model.pkl')
print("Model trained and saved as boston_model.pkl")
