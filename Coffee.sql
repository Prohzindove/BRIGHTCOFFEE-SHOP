-- Databricks notebook source
---starting code
WITH sales_cleaned AS (
    SELECT
        *,
        CAST(REPLACE(unit_price, ',', '.') AS DOUBLE) AS price
    FROM brightlearn_coffe_case_study.default.sales
)

WITH sales_cleaned AS (
    SELECT
        transaction_qty,
        CAST(REPLACE(unit_price, ',', '.') AS DOUBLE) AS price,
        ROUND(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DOUBLE), 0) AS revenue
    FROM brightlearncoffe_case_study.default.bright_coffee_shop_sales
)

SELECT
    SUM(transaction_qty) AS total_daily_sales,
    SUM (revenue)
FROM sales_cleaned
GROUP BY revenue;
