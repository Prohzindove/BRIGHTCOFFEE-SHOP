-- Databricks notebook source
-- DBTITLE 1,Cell 1
---1. LOADING THE DATASET
USE CATALOG brightlearncoffe_case_study;
USE brightlearncoffe_case_study.default;

---2. DATA INSPECTION/UNDERSTANDING THE DATA

--PREVIEWING THE DATASET 
SELECT*
FROM bright_coffee_shop_sales;

--CHECKING THE AMOUNT OF ROWS IN THE DATASET (the dataset contains 149116 rows)
SELECT COUNT(*)AS total_rows
FROM bright_coffee_shop_sales;

--CHECKING FOR THE NUMBER OF COLUMNS IN THE DATASET (there are 11 columns in the dataset)
SELECT COUNT (*) AS total_columns
FROM brightlearncoffe_case_study.information_schema.columns
WHERE table_schema= 'default'
AND table_name= 'bright_coffee_shop_sales';

--CHECKING FOR DATA TYPES IN THE DATASET (the dataset contains string, bigint, date and timestamp data types). 
DESCRIBE TABLE bright_coffee_shop_sales;

--Checking the product categories in the dataset (there are 9 product categories in the dataset)
SELECT DISTINCT product_category
FROM bright_coffee_shop_sales;

--Checking the different types of products in the dataset (there are 29 different types of products)
SELECT DISTINCT product_type
FROM bright_coffee_shop_sales;

--Checking for date range of dataset (the data spans over 6 months, captured from January 2023 to June 2023)
SELECT MIN(transaction_date) AS earliest_date,
       MAX(transaction_date) AS latest_date
FROM bright_coffee_shop_sales; 

--Checking the number of store locations in the dataset (the data was collected from 3 different locations)
SELECT DISTINCT store_location
FROM bright_coffee_shop_sales;

---3. DATA CLEANING

--CHECKING FOR DUPLICATE ENTRIES USING THE transaction_id COLUMN (there are no duplicates)
SELECT transaction_id,
       COUNT(*) AS duplicates
FROM bright_coffee_shop_sales
GROUP BY transaction_id
HAVING COUNT(*) >1;

--CHECKING ON EACH COLUMN FOR NULLS (there are no NULL values in all the columns)
SELECT *
FROM bright_coffee_shop_sales
WHERE transaction_id IS NULL
    OR transaction_date IS NULL
    OR transaction_time IS NULL
    OR transaction_qty IS NULL
    OR store_id IS NULL
    OR unit_price IS NULL
    OR store_location IS NULL
    OR product_id IS NULL
    OR product_category IS NULL
    OR product_type IS NULL
    OR product_detail IS NULL;

--Transforming transaction_time column from timestamp format to a normal date format in hours, minutes and seconds
SELECT transaction_time,
       DATE_FORMAT(transaction_time, 'HH:mm:ss') AS clean_time
FROM bright_coffee_shop_sales;

---4. EXPLORATORY DATA ANALYSIS (EDA)

--Transactions per day
SELECT transaction_date,
       COUNT (DISTINCT transaction_id) AS total_transactions
FROM bright_coffee_shop_sales
GROUP BY transaction_date;

--Transactions per month
SELECT MONTHNAME(transaction_date) AS month,
       COUNT(DISTINCT transaction_id) AS total_transactions
FROM bright_coffee_shop_sales
GROUP BY month;

--Transactions per month per store
SELECT store_location,
       DATE_FORMAT (transaction_date, 'MMMM') As_transaction_month,
       SUM (transaction_qty) AS amount_sold_per_month
FROM bright_coffee_shop_sales
GROUP BY store_location, DATE_FORMAT (transaction_date, 'MMMM'), MONTH(transaction_date) 
ORDER BY store_location, MONTH(transaction_date);

--Total units sold per each store
SELECT DISTINCT store_location,
                SUM (transaction_qty) AS total_store_sales
FROM bright_coffee_shop_sales
GROUP BY store_location;

--Total units sold per each product category
SELECT DISTINCT product_category,
                SUM (transaction_qty) AS total_product_sales
FROM bright_coffee_shop_sales
GROUP BY product_category
ORDER BY total_product_sales DESC;

--Top 5 performing product categories
SELECT DISTINCT product_category,
                SUM (transaction_qty) AS total_product_sales
FROM bright_coffee_shop_sales
GROUP BY product_category
ORDER BY total_product_sales DESC
LIMIT 5;

--Least 3 performing product categories
SELECT DISTINCT product_category,
                SUM (transaction_qty) AS total_product_sales
FROM bright_coffee_shop_sales
GROUP BY product_category
ORDER BY total_product_sales ASC
LIMIT 3;

-- Types of products sold per store
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty);

--Top 10 performing products in Astoria store location
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
WHERE store_location ='Astoria'
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty) DESC
LIMIT 10;

--Least 10 performing products in Astoria store location
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
WHERE store_location ='Astoria'
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty) ASC
LIMIT 10;

--Top 10 perfoming products in Hell's Kitchen store location
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
WHERE store_location LIKE '%Kitchen%'
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty) DESC
LIMIT 10;

--Least 10 perfoming products in Hell's Kitchen store location
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
WHERE store_location LIKE '%Kitchen%'
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty) ASC
LIMIT 10;

--Top 10 perfoming products in Lower Manhattan store location
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
WHERE store_location= 'Lower Manhattan'
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty) DESC
LIMIT 10;

--Least 10 perfoming products in Lower Manhattan store location
SELECT store_location,
       product_type,
       SUM (transaction_qty) AS Products_sold_per_store
FROM bright_coffee_shop_sales
WHERE store_location= 'Lower Manhattan'
GROUP BY product_type, store_location
ORDER BY store_location, SUM (transaction_qty) ASC
LIMIT 10;

--Find average quantity of each product sold per store
SELECT product_type,
       store_location,
       ROUND (AVG (transaction_qty),2) AS AVG_Products_sold_per_store
FROM bright_coffee_shop_sales
GROUP BY product_type, store_location;

--Sales records at 30 minutes intervals
SELECT product_category,
       DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30) AS half_hourly_sales,
       SUM(transaction_qty) AS total_half_hourly_sales
FROM bright_coffee_shop_sales
GROUP BY product_category, DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30)
ORDER BY half_hourly_sales, total_half_hourly_sales DESC;

--Sales records at hourly intervals
SELECT product_category,
       DATE_TRUNC('hour', transaction_time) AS hourly_sales,
       SUM(transaction_qty) AS total_hourly_sales
FROM bright_coffee_shop_sales
GROUP BY product_category, DATE_TRUNC('hour', transaction_time)
ORDER BY hourly_sales, total_hourly_sales DESC;

--Sales records at daily intervals
SELECT product_category,
       transaction_date,
       SUM(transaction_qty) AS total_daily_sales
FROM bright_coffee_shop_sales
GROUP BY product_category, transaction_date
ORDER BY transaction_date, total_daily_sales DESC;

--Revenue per product_category
SELECT product_category,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 2) AS revenue
FROM bright_coffee_shop_sales
GROUP BY product_category
ORDER BY revenue DESC;

--Revenue per month rounded to the nearest two decimal places
SELECT MONTHNAME (transaction_date) AS sales_month,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 2) AS revenue
FROM bright_coffee_shop_sales
GROUP BY sales_month;

--Revenue per product category per month
SELECT product_category,
       MONTHNAME (transaction_date) AS sales_month,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY product_category, MONTH(transaction_date),
         MONTHNAME (transaction_date)
ORDER BY MONTH(transaction_date), revenue;

--Revenue per store location
SELECT store_location,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 2) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location
ORDER BY revenue ASC;

--Revenue per product category per store location per month
SELECT store_location,
       product_category,
       MONTHNAME (transaction_date) AS sales_month,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_category, 
         MONTH(transaction_date),
         MONTHNAME (transaction_date)
ORDER BY MONTH(transaction_date), store_location, revenue;

--Revenue per store location per product type per month
SELECT store_location,
       product_type,
       MONTHNAME (transaction_date) AS sales_month,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_type, 
         MONTH(transaction_date),
         MONTHNAME (transaction_date)
ORDER BY MONTH(transaction_date), store_location, revenue;

--Revenue per store location per product category per 30minutes intervals
SELECT store_location,
       product_category,
       DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30) AS half_hourly_sales,
       SUM(transaction_qty) AS total_half_hourly_sales,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_category,
         DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30)
ORDER BY DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30), store_location, revenue;

--Revenue per store location per product category per hourly intervals
SELECT store_location,
       product_category,
       DATE_TRUNC('hour', transaction_time) AS hourly_sales,
       SUM(transaction_qty) AS total_hourly_sales,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_category,
         DATE_TRUNC('hour', transaction_time)
ORDER BY DATE_TRUNC('hour', transaction_time), store_location, revenue;

--Revenue per store location per product category per day
SELECT store_location,
       product_category,
       transaction_date,
       SUM(transaction_qty) AS total_daily_sales,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_category,
         transaction_date
ORDER BY store_location, product_category, transaction_date;

--Revenue per store location per product type per 30minutes intervals
SELECT store_location,
       product_type,
       DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30) AS half_hourly_sales,
       SUM(transaction_qty) AS total_half_hourly_sales,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_type,
         DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30)
ORDER BY DATE_TRUNC('hour', transaction_time) + INTERVAL 30 MINUTES * FLOOR(MINUTE(transaction_time)/30), store_location, revenue;

--Revenue per store location per product type per hourly intervals
SELECT store_location,
       product_type,
       DATE_TRUNC('hour', transaction_time) AS hourly_sales,
       SUM(transaction_qty) AS total_hourly_sales,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_type,
         DATE_TRUNC('hour', transaction_time)
ORDER BY DATE_TRUNC('hour', transaction_time) DESC, store_location, revenue;

--Revenue per store location per product type per day
SELECT store_location,
       product_type,
       transaction_date,
       SUM(transaction_qty) AS total_daily_sales,
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 0) AS revenue
FROM bright_coffee_shop_sales
GROUP BY store_location,
         product_type,
         transaction_date
ORDER BY store_location, transaction_date;

--Calculating total revenue
SELECT 
       ROUND(SUM(CAST(transaction_qty AS DOUBLE) * CAST (REPLACE (unit_price, ',', '.') AS DOUBLE)), 2) AS revenue
FROM bright_coffee_shop_sales;

--5. FEATURE ENGINEERING
-- Creating time buckets using case statements
SELECT transaction_time,
       DATE_FORMAT(transaction_time, 'HH:mm:ss') AS clean_time,
       CASE 
           WHEN HOUR (transaction_time) BETWEEN 6 AND 9 THEN 'Morning'
           WHEN HOUR (transaction_time) BETWEEN 9 AND 11 THEN 'Mid Morning'
           WHEN HOUR (transaction_time) BETWEEN 11 AND 14 THEN 'Afternoon'
           WHEN HOUR (transaction_time) BETWEEN 14 and 17 THEN 'Late Afternoon'
           ELSE 'Evening'
        END AS time_bucket
FROM bright_coffee_shop_sales;

--Creating days of the week feature for example Monday, Tuesday....
SELECT
    DAYNAME(transaction_date) AS day_name
FROM bright_coffee_shop_sales;

--Creating days of the month feature for example 1-31
SELECT
        DAYOFMONTH(transaction_date) AS day_of_month
FROM bright_coffee_shop_sales;
   
--Creating name of the month feature for example January, February....
SELECT 
      MONTHNAME(transaction_date) AS month_name
FROM bright_coffee_shop_sales;

--Creating week of the day buckets using case statements
SELECT DAYNAME (transaction_date),
       DAYOFWEEK (transaction_date),
       CASE 
           WHEN DAYNAME(transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
           ELSE 'Weekday'
        END AS day_type
FROM bright_coffee_shop_sales;

--Creating month period classification buckets
SELECT
  CASE
        WHEN DAYOFMONTH (transaction_date) BETWEEN 1 AND 10 THEN ('Early Month')
        WHEN DAYOFMONTH (transaction_date) BETWEEN 11 AND 20 THEN 'Mid Month'
        ELSE 'Month End'
    END AS month_period
FROM bright_coffee_shop_sales;

--Classification of expenditure using case statements
SELECT
    CASE
        WHEN (CAST(transaction_qty AS DOUBLE))* CAST(REPLACE(unit_price,',','.') AS DOUBLE)<=4 THEN 'Low spend'
        WHEN (CAST(transaction_qty AS DOUBLE))* CAST(REPLACE(unit_price,',','.') AS DOUBLE) BETWEEN 4 AND 7 THEN 'Medium spend'
        ELSE 'High spend'
        END AS spend_bucket,
        CAST(REPLACE(unit_price, ',','.') AS DOUBLE)AS clean_unit_price,
        ROUND ((CAST(transaction_qty AS DOUBLE)+ CAST (REPLACE(unit_price, ',','.')AS DOUBLE)),2) AS revenue
FROM bright_coffee_shop_sales;

--CREATING THE FINAL BIG QUERY WITH ALL NEW FEATURES
SELECT transaction_id,
       transaction_date,
        DATE_FORMAT (transaction_time, 'HH:mm:ss') AS clean_time,--removes timestamp formatting)
        transaction_qty,
        store_id,
        store_location,
        product_id,
        unit_price,
        product_category,
        product_type,
        product_detail,
        DAYNAME(transaction_date) AS day_name,--Day Name (Monday, Tuesday...)
        MONTHNAME(transaction_date) AS month_name,--Month name (January, February.....)
        DAYOFMONTH(transaction_date) AS day_of_month,--Month day (1-31)
    CASE 
        WHEN DAYNAME(transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,--Type of day
        CASE 
           WHEN HOUR (transaction_time) BETWEEN 6 AND 9 THEN 'Morning'
           WHEN HOUR (transaction_time) BETWEEN 9 AND 11 THEN 'Mid Morning'
           WHEN HOUR (transaction_time) BETWEEN 11 AND 14 THEN 'Afternoon'
           WHEN HOUR (transaction_time) BETWEEN 14 and 17 THEN 'Late Afternoon'
        ELSE 'Evening'
    END AS time_bucket,--Time of day classification
    CASE
        WHEN DAYOFMONTH(transaction_date) BETWEEN 1 AND 10 THEN ('Early Month')
        WHEN DAYOFMONTH (transaction_date) BETWEEN 11 AND 20 THEN 'Mid Month'
        ELSE 'Month End'
    END AS month_period, -- Month classification
    CASE
        WHEN (CAST(transaction_qty AS DOUBLE))* CAST(REPLACE(unit_price,',','.') AS DOUBLE)<=4 THEN 'Low spend'
        WHEN (CAST(transaction_qty AS DOUBLE))* CAST(REPLACE(unit_price,',','.') AS DOUBLE) BETWEEN 4 AND 7 THEN 'Medium spend'
        ELSE 'High spend'
        END AS spend_bucket,--Expenditure classification
        CAST(REPLACE(unit_price, ',','.') AS DOUBLE)AS clean_unit_price,
        ROUND ((CAST(transaction_qty AS DOUBLE)* CAST (REPLACE(unit_price, ',','.')AS DOUBLE)),2) AS revenue --Total revenue
FROM bright_coffee_shop_sales;









