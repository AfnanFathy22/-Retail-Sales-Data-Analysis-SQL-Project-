# 🛒 Retail Sales Data Analysis (SQL Project)

This project analyzes U.S. monthly retail sales data using SQL to answer key business questions, uncover trends, analyze seasonality, measure industry performance, and detect outliers using statistical methods.

## 📌 Project Overview
In this project, a retail_sales database was created and the dataset us_monthly_retail_sales_wrangled was analyzed. The workflow includes data cleaning, aggregation, business-driven queries, contribution percentage calculations, seasonal analysis (Month-over-Month), top-performing industry identification, and outlier detection using Z-Score.

## 🧹 Data Cleaning
Sales values equal to 0 were converted to NULL to ensure accurate analysis. SQL safe updates were temporarily disabled to perform cleaning operations safely, then re-enabled after execution.

## 📊 Business Questions Answered
1. Which specific kind of businesses contribute the most? Total sales were grouped by kind_of_business and ranked by revenue.
2. What is the sales distribution by NAICS code? Sales were aggregated by naics_code to identify dominant sectors.
3. Is there seasonality in sales? Monthly sales were calculated by industry, year, and month to analyze trends.
4. Which businesses have average sales greater than 10 billion? The HAVING clause with AVG(sales) was used to filter high-performing categories.
5. What were the highest automotive sales revenues in 2022? Automotive-related industries were filtered and ranked by total revenue.
6. What is the contribution percentage of each automotive business in 2022? A CTE was used to compute percentage contribution per business.
7. What were the top-performing industries in 2021? Total sales per industry were calculated along with month-over-month comparison.
8. Are there sales outliers? Z-Score was calculated using industry-level mean and standard deviation, and records with |Z| > 2 were flagged.

## 🛠️ SQL Concepts Used
GROUP BY, HAVING, ORDER BY, WHERE filtering, Aggregate functions (SUM, AVG, STDDEV), CTE (WITH clause), NULL handling, Percentage contribution analysis, and Z-Score calculation.

## 🚀 How to Run
Import the dataset into MySQL, create the retail_sales database, use it, and run the SQL script step by step to reproduce the analysis results.

## 🎯 Skills Demonstrated
SQL for Business Intelligence, Data Cleaning, Statistical Analysis in SQL, Analytical Thinking, Business-Oriented Data Interpretation.

