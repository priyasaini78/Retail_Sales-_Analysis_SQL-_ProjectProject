-- SQL Retail Sales Aalysis

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

SELECT * FROM retail_sales;

ALTER TABLE retail_sales
RENAME COLUMN prive_per_unit to price_per_unit;

SELECT 
COUNT(*)
FROM retail_sales;

# Checking null values 
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;
 
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;


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
     
-- Data Exploration    
 
 -- How many sales we have?
 SELECT COUNT(*) AS total_sales FROM retail_sales;
 
 -- How many customer we have?
 SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;
 
 SELECT DISTINCT category AS total_category FROM retail_sales;
 
-- Data Analysis & Business key problems & Answers
 
--  Write a SQL query to retrieve all rows for sales made on '2022-11-05'.
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


