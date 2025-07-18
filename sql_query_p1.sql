-- SQL Retail Sales Analysis - P1
CREATE DATABASE p1_retail_db;
SELECT * FROM retail_sales;
--  Assigning a primary key to the transactions_id column

ALTER TABLE retail_sales
ADD PRIMARY KEY (transactions_id);


-- Data Exploration & Cleaning

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- Data Anlysis And Finding

-- Q.1 How many Total Records of Sales we have?
-- Q.2 How many unique customers we have?
-- Q.3 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- Q.4 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.5 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.6 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.7 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.8 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.9 Write a SQL query to calculate the average sale for each month.
-- Q.10 Also find out best selling month in each year
-- Q.11 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.12 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.13 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 How many Total Records of Sales we have?

SELECT COUNT(total_sale) AS Count_of_total_sale FROM retail_sales;

--Q.2 How many unique customers we have?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

--Q.3 Write a SQL query to retrieve all columns for sales made on '2022-11-05':

SELECT *
FROM retail_sales
WHERE STR_TO_DATE(sale_date, '%d-%m-%Y') = '2022-11-05';

-- Q.4 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE 
    category = 'Clothing'
	AND quantiy >= 4
    AND MONTH(STR_TO_DATE(sale_date, '%d-%m-%Y')) = 11
    AND YEAR(STR_TO_DATE(sale_date, '%d-%m-%Y')) = 2022;  

-- Q.5 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) as net_sale,COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q.6 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.7 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.8 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender, COUNT(*) as total_transactions_id
FROM retail_sales
GROUP BY category,gender
ORDER BY 1;

-- Q.9 Write a SQL query to calculate the average sale for each month.

SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(sale_date, '%d-%m-%Y')) AS year,
    EXTRACT(MONTH FROM STR_TO_DATE(sale_date, '%d-%m-%Y')) AS month,
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY year , month 
ORDER BY year, month;

-- Q.10 Also find out best selling month in each year.

SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(sale_date, '%d-%m-%Y')) AS year,
    EXTRACT(MONTH FROM STR_TO_DATE(sale_date, '%d-%m-%Y')) AS month,
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY year , month 
ORDER BY avg_sale DESC LIMIT 2;

-- Q.11 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- Q.12 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category;

-- Q.13 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift
ORDER BY FIELD(shift, 'Morning', 'Afternoon', 'Evening');

-- End of project

