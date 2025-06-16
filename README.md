Retail Sales Analysis SQL Project
Project Overview
Project Title: Retail Sales Analysis
Database: retail_sales_analysis

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database,
performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.


Project Structure
-- Database Setup
Database Creation: The project starts by creating a database named retail_sales_analysis .
TableCreation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale_date, sale_time, customer_id, gender, age, category, quantity , price_per_unit , cogs(cost of goods sold),  total_sale.

-- Create Database
CREATE DATABASE retail_sales_analysis;
USE retail_sales_analysis;

-- Create Table
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(19),
quantity INT,
prive_per_unit FLOAT,
cogs  FLOAT,
total_sale FLOAT
);

--  Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.


SELECT * FROM retail_sales;

ALTER TABLE retail_sales
RENAME COLUMN prive_per_unit to price_per_unit;

SELECT COUNT(*) AS total_sales FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales
SELECT DISTINCT category AS total_category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL
     ;

 DELETE FROM retail_sales
WHERE      
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL
     ;

-- Data Analysis & Findings
   
Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';

/* Write a SQL query to retrieve all transactions where the category is 'clothing' and quantity sold is more than or equal to 4 in 
in the month of Nov-2022 */
SELECT *
FROM retail_sales
WHERE category = 'clothing' 
AND 
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND
quantity >= 4;


-- Write a SQL query to calculate the total_sales for each category
SELECT category,
SUM(total_sale) AS net_sales,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'beauty' category.
SELECT category,
ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * , COUNT(*) FROM retail_sales
WHERE total_sale > 1000;


-- Write a SQL query to find out total number of transactions made by each gender in each category.
SELECT category,
gender,
COUNT(transactions_id) AS total_trans
FROM retail_sales
GROUP BY 
category,
gender
ORDER BY category;


-- Write a SQL query to calculate the average sale for each month . find out best selling month in each year.
SELECT year(sale_date) AS year,
month(sale_date) AS month,
AVG(total_sale) AS average_sale,
RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale) DESC)
FROM retail_sales
GROUP BY
year,month;
	

-- Writea a SQL query to find the top 5 customers based on the highest total sales.
SELECT  customer_id,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-- Write a SQL query to find the number of unique  customers who purchased items from each category.
SELECT category,
COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY category; 

-- Write a SQL query to create each shift and number of orders(example morning <= 12, afternoon between 12 & 17, evening > 17).
SELECT * ,
CASE
    WHEN hour(sale_time) < 12 THEN 'morning'
    WHEN hour(sale_time) BETWEEN 12 and 17 THEN 'afternoon'
    ELSE 'evening'
END AS shift   
FROM retail_sales;


-- End of Project

