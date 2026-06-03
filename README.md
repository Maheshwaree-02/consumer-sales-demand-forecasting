# AI-Driven Consumer Demand Forecasting for Precision Marketing

**End-to-End AI Platform for Understanding Consumer Behavior & Demand Patterns**

![Consumer Sales & Demand Forecasting Dashboard](powerbi/dashboard_mockup.png)

> *Interactive Power BI dashboard (in progress). High-fidelity mockup shown above. Actual `.pbix` file and live dashboard coming soon.*

## 🎯 Project Overview

Developed an **AI-powered demand forecasting system** that analyzes consumer purchasing behavior using rich retail data (promotions, weather, competitor pricing, seasonality, discounts, etc.).

This project directly aligns with **AI applications in Consumer Behavior, Marketing, and Digital Ecosystems** by combining predictive modeling with interpretability to uncover *why* and *when* consumers buy.

**Key Objective**: Build accurate demand forecasts while extracting actionable marketing insights (promotion effectiveness, price sensitivity, weather-driven behavior, etc.) to support precision marketing and inventory optimization.

## ✨ Key Achievements

- **Data Pipeline**: Cleaned and engineered features from 76,000+ records with rich behavioral variables.
- **Advanced Modeling**: Built XGBoost model with proper time-series validation and achieved strong forecasting performance.
- **Interpretability**: Used SHAP values to identify key drivers of consumer demand (Promotion, Price Elasticity, Weather, Seasonality, etc.).
- **Business Impact**: Framework can help reduce stockouts and optimize promotional strategies through consumer behavior insights.
- **Interactive Dashboard**: Built in Power BI for stakeholders to explore demand patterns and forecasts.

## 🛠️ Tech Stack

- **Python**: Pandas, NumPy, Scikit-learn, XGBoost, SHAP
- **SQL**: Star Schema design for KPI analysis
- **Visualization**: Power BI, Matplotlib, Seaborn
- **Tools**: Git, Jupyter Notebooks

## 📊 Results

- **Model Performance**:
  - MAE: XX.XX | MAPE: XX.XX% | RMSE: XX.XX
- Identified **Promotion** and **Price Elasticity** as top drivers of demand spikes.
- Strong seasonal and weather-based consumer behavior patterns detected.

## 📁 Project Structure

```bash
├── notebooks/
│   ├── 01_Data_Cleaning_EDA.ipynb
│   ├── 02_Feature_Engineering.ipynb
│   └── 04_Forecasting_Models.ipynb
├── data/
│   └── processed/
├── models/
├── powerbi/                  # Dashboard + Screenshots
├── sql/                      # Star Schema & KPI queries
├── reports/
└── README.md
