
CREATE DATABASE retail_sales;

USE retail_sales;

select *
from us_monthly_retail_sales_wrangled;

SET SQL_SAFE_UPDATES = 0;

UPDATE us_monthly_retail_sales_wrangled
SET sales = NULL
WHERE sales = 0;

SET SQL_SAFE_UPDATES = 1;

/* =========================================
   Check first 50 rows by ID
========================================= */

SELECT *
FROM retail_sales_stage
ORDER BY id DESC
LIMIT 50;


/* =========================================
   Business Q1:
   Which specific kind of businesses contribute the most?
========================================= */
SELECT kind_of_business,
       SUM(sales) AS total_sales
FROM us_monthly_retail_sales_wrangled
GROUP BY kind_of_business
ORDER BY total_sales DESC;


/* =========================================
   Business Q2:
   Sales distribution by NAICS code
========================================= */
SELECT naics_code,
       SUM(sales) AS total_sales
FROM us_monthly_retail_sales_wrangled
GROUP BY naics_code
ORDER BY total_sales DESC;


/* =========================================
   Business Q3:
   Seasonality - Month over Month
========================================= */
SELECT industry,
       year AS sales_year,
       month AS sales_month,
       SUM(sales) AS monthly_sales
FROM us_monthly_retail_sales_wrangled
GROUP BY industry, year, month
ORDER BY industry, year, month;


/* =========================================
   Business Q4:
   Businesses with avg sale > 10 billion
========================================= */
SELECT kind_of_business,
       AVG(sales) AS avg_sales
FROM us_monthly_retail_sales_wrangled
GROUP BY kind_of_business
HAVING AVG(sales) > 10000000000;


/* =========================================
   Business Q5:
   Highest automotive sales revenue 2022
========================================= */
SELECT kind_of_business,
       SUM(sales) AS total_sales_2022
FROM us_monthly_retail_sales_wrangled
WHERE industry LIKE '%Automotive%'
  AND year = 2022
GROUP BY kind_of_business
ORDER BY total_sales_2022 DESC;



/* =========================================
   Business Q5:
   Contribution percentage (Automotive 2022)
========================================= */

-- Percentage Contribution
WITH total_auto AS (
    SELECT SUM(sales) AS total_sales
    FROM us_monthly_retail_sales_wrangled
    WHERE industry LIKE '%Automotive%'
      AND year = 2022
)

SELECT r.kind_of_business,
       SUM(r.sales) AS business_sales,
       (SUM(r.sales) * 100.0 / t.total_sales) AS contribution_percentage
FROM us_monthly_retail_sales_wrangled r
JOIN total_auto t
WHERE r.industry LIKE '%Automotive%'
  AND r.year = 2022
GROUP BY r.kind_of_business, t.total_sales
ORDER BY contribution_percentage DESC;


/* =========================================
   Business Q6:
   Top-performing industries 2021
========================================= */

-- Total sales per industry 2021
WITH industry_2021 AS (
    SELECT industry,
           SUM(sales) AS total_sales
    FROM us_monthly_retail_sales_wrangled
    WHERE year = 2021
    GROUP BY industry
)
SELECT *
FROM industry_2021
ORDER BY total_sales DESC;


-- Month over Month comparison
SELECT industry,
       year AS sales_year,
       month AS sales_month,
       SUM(sales) AS monthly_sales
FROM us_monthly_retail_sales_wrangled
WHERE year = 2021
GROUP BY industry, year, month
ORDER BY industry, month;

/* =========================================
   Business Q7:
   Detect outliers (using Z-Score)
========================================= */

-- Calculate mean and std dev per industry
WITH stats AS (
    SELECT industry,
           AVG(sales) AS avg_sales,
           STDDEV(sales) AS std_sales
    FROM us_monthly_retail_sales_wrangled
    GROUP BY industry
)
SELECT r.industry,
       r.sales,          -- replace sales_date if actual column differs
       (r.sales - s.avg_sales) / NULLIF(s.std_sales,0) AS z_score
FROM us_monthly_retail_sales_wrangled r
JOIN stats s
  ON r.industry = s.industry
WHERE ABS((r.sales - s.avg_sales) / NULLIF(s.std_sales,0)) > 2
ORDER BY r.industry;
