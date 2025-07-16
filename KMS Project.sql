SELECT * FROM employee_data.`kms sql case study`;

RENAME table `kms sql case study` -- Renaming the table for easy call
TO kms_sql_project;

SELECT *
FROM kms_sql_project;

-- Renaming the field headers
ALTER table kms_sql_project
RENAME column `Order ID`
TO Order_Id;

ALTER table kms_sql_project
RENAME column `Order Priority`
TO Order_Priority;

ALTER table kms_sql_project
RENAME column `Order Quantity`
TO Order_Quantity;

-- Which product category had the highest sales?
SELECT `Product Category`, ROUND(SUM(Sales)) AS Total_Sale
FROM kms_sql_project
GROUP BY `Product Category`
ORDER BY Total_sale DESC
LIMIT 1;

-- What are the Top 3 and Bottom 3 regions in terms of sales?
SELECT Region, ROUND(SUM(sales)) AS Total_sale -- Top 3
FROM kms_sql_project
GROUP BY Region
ORDER BY Total_sale DESC
Limit 3;

SELECT Region, ROUND(SUM(sales)) AS Total_sale -- Bottom 3
FROM kms_sql_project
GROUP BY Region
ORDER BY Total_sale ASC
Limit 3;

SELECT *
FROM kms_sql_project; 

-- What were the total sales of appliances in Ontario?
SELECT Region, `Product Sub-Category`, ROUND(SUM(sales)) Total_sale
FROM kms_sql_project
WHERE `Product Sub-Category` = 'Appliances'
AND Region ='Ontario';

-- Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers?
SELECT `Customer Name`, ROUND(SUM(sales)) AS REVENUE
FROM kms_sql_project
GROUP BY `Customer Name`
ORDER BY `Customer Name` ASC
LIMIT 10;

-- KMS incurred the most shipping cost using which shipping method?
SELECT `Ship Mode`, ROUND(SUM(`shipping cost`)) AS Total_Shipcost
FROM kms_sql_project
GROUP BY `Ship Mode`
ORDER BY Total_Shipcost DESC;

-- SECTION 2
-- Who are the most valuable customers, and what products or services do they typically purchase?
-- To identify the valuable customers
SELECT `customer name`, ROUND(SUM(sales)) AS Total_revenue
FROM kms_sql_project
GROUP BY `Customer Name`
ORDER BY Total_revenue DESC
LIMIT 10;

-- Top 10 customers and products they purchased
SELECT `customer name`,
       `product name`,
      ROUND(SUM(sales)) AS total_spent
FROM kms_sql_project 
WHERE `customer name` IN (
    SELECT `customer name`
    FROM kms_sql_project
    GROUP BY `customer name`
    ORDER BY ROUND(SUM(sales)) DESC
    LIMIT 10)
GROUP BY `customer name`, `product name`
ORDER BY `customer name`, total_spent DESC;

-- Which small business customer had the highest sales?
SELECT `customer segment`, `customer name`, ROUND(SUM(sales)) AS Totalsale
FROM kms_sql_project
WHERE `customer segment` = 'small business'
GROUP BY `customer segment`, `customer name`
ORDER BY Totalsale DESC;

-- Which Corporate Customer placed the most number of orders in 2009 – 2012?
SELECT *
FROM kms_sql_project;

UPDATE kms_sql_project -- update order date to sql date format
SET `order date` = str_to_date(`order date`, '%m/ %d/ %Y');

SELECT `customer name`, `customer segment`, COUNT(DISTINCT(order_id)) AS Total_order, `order date`
FROM kms_sql_project
WHERE `customer segment` = 'corporate'
AND YEAR(`order date`)  BETWEEN 2009 AND 2012
GROUP BY `customer name`, `customer segment`
ORDER BY Total_order DESC
LIMIT 1;

-- Which consumer customer was the most profitable one?
SELECT `customer name`, `customer segment`, ROUND(SUM(profit)) AS Total_profit
FROM kms_sql_project
WHERE `customer segment` = 'consumer'
GROUP BY `customer name`, `customer segment`
ORDER BY Total_profit DESC
LIMIT 1;

