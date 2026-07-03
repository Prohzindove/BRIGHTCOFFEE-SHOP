# Brightlearn Coffee Shop Sales Analysis

# Project Overview

The Brightlearn Coffee Shop Sales Analysis project was conducted to analyse historical sales data from it's three locations and generate actionable business insights to support strategic decision-making. Using SQL, Databricks, Google Sheets, Data Studio and Canva the project follows a complete data analytics workflow; from data extraction and cleaning to visualization and business recommendations.

The analysis focuses on identifying customer purchasing patterns, peak sales periods, product performance, and revenue trends across multiple store locations.

# Objectives

The project aimed to:

* Analyze sales trends across product types, product categories, and store locations.
* Identify top-performing and low-performing products.
* Identify peak sales periods throughout the day and month.
* Develop business recommendations to improve sales performance.

# Dataset Description

The dataset contains transactional sales data collected from three Brightlearn Coffee Shop locations during the first six months of the year 2023:

* Lower Manhattan
* Hell's Kitchen
* Astoria

The dataset includes information such as:

* Transaction date
* Transaction time
* Store location
* Product category
* Product type
* Product detail
* Transaction quantity
* Unit price

# Tools Used
* Miro:	Project planning and workflow documentation
* Databricks:	Data extraction, SQL queries, ETL pipeline
* SQL:	Data cleaning, transformation, aggregation, feature engineering
* Google Sheets:	Data validation and chart creation
* Google Data Studio:	Interactive dashboard development
* Canva:	Business presentation

# Data Quality Checks
Before analysis, the dataset was assessed to ensure its suitability for business intelligence reporting.

The following quality dimensions were verified:

* Accuracy
* Completeness
* Consistency
* Validity
* Timeliness

The dataset represented real-world sales transactions, contained consistent formatting and met all the quality checks, making it suitable for analysis.

# Data Preparation

An ETL process was implemented using Databricks.

The workflow included:

* Importing the CSV dataset into Databricks
* Cleaning and transforming the data
* Performing exploratory data analysis
* Engineering new analytical features
* Exporting the cleaned dataset for visualization


# Data Cleaning

Several preprocessing steps were completed before analysis:

* Checked for missing values
* Validated data types
* Standardized date and time formats
* Removed unnecessary inconsistencies
* Prepared data for feature engineering

# Exploratory Data Analysis (EDA)

EDA was conducted to understand relationships and trends within the dataset.

The analysis included:

* Revenue by product category
* Revenue by product type
* Quantity sold by product
* Monthly revenue trends
* Sales by time of day and month period
* Peak sales periods
* Top-performing products
* Lowest-performing products
* Store performance comparison

# Feature Engineering

To enhance the analysis, new variables were created.

# Revenue

Revenue was calculated as:

Revenue = Transaction Quantity × Unit Price

### Time Buckets

Transaction times were grouped into meaningful business periods:

* Morning
* Mid-Morning
* Afternoon
* Late Afternoon
* Evening
* Early month
* Mid month
* Monthend
These buckets enabled time-based sales analysis.

# Data Visualization

Interactive dashboards and business charts were developed using Google Data Studio and Google Sheets.

Visualizations include:

* KPI cards
* Monthly revenue trends
* Revenue by store
* Revenue by product category
* Revenue by product type
* Transaction quantity analysis
* Top-performing products
* Lowest-performing products
* Time-of-day sales analysis

Chart types used:

* Bar charts
* Column charts
* Pie charts
* Line charts
* Score cards
---

# Key Insights

The analysis revealed several important business insights:

* Brightlearn generated $698,812 in total revenue across all three store locations.
* Sales remained relatively consistent throughout the month, with mid-month contributing the highest revenue (34.8%) and early month contributing the lowest (31.4%).
* Morning and mid-morning recorded the highest customer activity and sales volume.
* A small number of products (Coffee and Tea) generated a significant proportion of overall revenue.
* Several products consistently underperformed, presenting opportunities for sales improvement.
* Revenue patterns were consistent across multiple months, indicating stable customer demand.
* Store performance varied across product categories, suggesting location-specific customer preferences.

# Business Recommendations

Based on the findings, the following recommendations are proposed:

* Increase promotions for low-performing products.
* Optimize staffing during peak sales hours.
* Introduce interbranch and inhouse trainings.
* Maintain adequate inventory for high-demand products.
* Remain consistent on high performing products
* Introduce targeted marketing campaigns during slower periods.
* Review pricing or product offerings for consistently low-performing items.
* Continue monitoring sales trends using dashboards to support data-driven decision-making.

# Skills Demonstrated

This project demonstrates practical experience in:

* SQL
* Databricks
* ETL Processes
* Data Cleaning
* Exploratory Data Analysis (EDA)
* Feature Engineering
* Data Visualization
* Dashboard Development
* Business Intelligence
* Business Analysis
* Data Storytelling
* KPI Reporting

# Project Links

# Interactive Sales Dashboard

https://datastudio.google.com/s/v5kXiwgJ2mw

# Project Planning (Miro)

https://miro.com/welcomeonboard/RVp0ZGZsazZMSVVESUhiQWVXa3YrazhrR3Q1S0ZTcHJoUWg5eTEyZ1RJNEFoL0xWVDdrQUphMjhraGVLaVFzcTUyMWlnQnluaWduR29PTXJoMlNJbjhCRnpvRjdQQ0RSTmQvbW4zSmdpc0pNZEM3SndOU1hwZlNKU3pTRnBqREV3VHhHVHd5UWtSM1BidUtUYmxycDRnPT0hdjE=?share_link_id=557476428554

# Excel Dataset

https://docs.google.com/spreadsheets/d/1MUsy84SoqmYd-U3Ky3FNJWeIQCGmgFMj6XKYuAxru0k/edit?usp=sharing

# Raw Dataset

https://docs.google.com/spreadsheets/d/1MUsy84SoqmYd-U3Ky3FNJWeIQCGmgFMj6XKYuAxru0k/edit?usp=sharing

# Conclusion

The Brightlearn Coffee Shop Sales Analysis successfully transformed raw transactional data into meaningful business insights. Through data cleaning, SQL analysis, feature engineering, visualization, and dashboard development, the project identified sales trends, customer purchasing patterns, and product performance across multiple locations.

The findings provide management with actionable recommendations to improve revenue, optimise operations, and support informed business decisions. This project demonstrates an end-to-end data analytics workflow and showcases practical skills in SQL, business intelligence, data visualization, and data storytelling.


