-- Databricks notebook source
USE CATALOG brightlearncoffe_case_study;
USE brightlearncoffe_case_study.default;

--PREVIEWING DATASET
SELECT*
FROM bright_coffee_shop_sales;

--DESCRIBING THE DATA TYPES AND CHECK ON EACH COLUMN FOR NULLS

DESCRIBE TABLE bright_coffee_shop_sales;

--FINDING THE UNIQUE STORE LOCATIONS
SELECT DISTINCT store_location
FROM brightlearncoffe_case_study.default.bright_coffee_shop_sales;

SELECT COUNT(*)AS TOTAL_ROWS
FROM bright_coffee_shop_sales;


--COUNTING THE NUMBER OF ROWS IN THE TABLE AND CHECKING FOR DUPLICATE TRANSACTION_ids
SELECT COUNT(transaction_id) AS trans_id_count,
       COUNT(DISTINCT transaction_id) AS trans_id_count
FROM bright_coffee_shop_sales;
