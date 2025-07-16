# 🏡 House_Rate_Prediction

This repository contains a project that predicts house prices using the Boston Housing Dataset. Two machine learning models—Linear Regression and Random Forest—were implemented and evaluated.

# 📂 Dataset
The dataset used is the Boston House Pricing dataset, maintained at Carnegie Mellon University and available from the UCI Machine Learning Repository. It consists of 506 observations with 14 attributes, including crime rate, average number of rooms, and property tax rate.

# 📊 Models Used
1️⃣ Linear Regression
- Used lm() function in R.
- Applied log transformation on MEDV (house prices) due to skewed distribution.
- Evaluated using Root Mean Squared Error (RMSE) and R².

2️⃣ Random Forest
- Used randomForest() function.
- Trained on the same dataset.
- Performance measured using RMSE and pseudo R².

# 🔍 Exploratory Data Analysis (EDA)
- Checked for missing values.
- Visualized price distribution using ggplot2.
- Split data into train (70%) and test (30%).

# 📈 Results & Conclusion
Model	RMSE	R² / Pseudo R²
Linear Regression	Higher RMSE	Lower R²
Random Forest	Lower RMSE	Better Performance
The Random Forest model outperformed the Linear Regression model, achieving a lower RMSE and better predictive power.

# 📷 Visualization
The scatter plot below shows the actual vs. predicted prices:

## 🖥️ Shiny App (Interactive Dashboard)

This project includes a Shiny app that allows users to interactively predict house prices by adjusting features such as:
- **Crime rate (CRIM)**
- **Average number of rooms (RM)**
- **Lower status percentage (LSTAT)**

### 💡 To Run the App Locally:

```r
library(shiny)
runApp("app.R")
