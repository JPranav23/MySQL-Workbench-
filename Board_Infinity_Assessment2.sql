# Problem 2:

# Task 1: 

CREATE DATABASE Superstores;
USE Superstores;

# Question 1 and 2:
# Describe the data in hand in your own words.
# List the Primary Keys and Foreign Keys

# The database/schema 'Superstore' consists of 5 tables namely: 
# (1) cust_dimen (2) market_fact (3) orders_dimen (4) prod_dimen (5) shipping_dimen

# The cust_dimen table has 5 columns cust_dimen namely: 
# (1) Customer_Name (2) Province (3) Region (4) Customer_Segment (5) Cust_id
# In cust_dimen table, primary key (PK) and foreign key (FK) is 'Cust_id' with datatype VARCHAR(10)
# Rest of the columns; Customer_Name, Province, Region and Customer_Segment have datatype VARCHAR(35)

# The market_fact  table has 10 columns cust_dimen namely: 
# (1) Ord_id (2) Prod_id (3) Ship_id (4) Cust_id (5) Sales (6) Discount
# (7) Order_Quantity (8) Profit (9) Shipping_Cost (10) Product_Base_Margin
# There are some duplicate values in Ord_id, Prod_id, Ship_id, Cust_id, hence there is no primary key in this table.
# Ord_id, Prod_id, Ship_id and Cust_id are all foreign keys (FKs)
# Ord_id, Prod_id, Ship_id, Cust_id have VARCHAR(35) datatype; Order_Quantity has INT(11) datatype and Sales, Discount, Profit, Shipping_Cost, Product_Base_Margin have FLOAT datatype.

# The orders_dimen table has 4 columns namely: 
# (1) Order_ID (2) Order_Date (3) Order_Priority (4) Ord_id
# Ord_id is the primary key (PK) as well as foreign key (FK) whereas Order_ID is just a foreign key (FK).
# All the columns have VARCHAR datatype

# The prod_dimen table has 3 columns namely: 
# (1) Product_Category (2) Product_Sub_Category (3) Prod_id
# Prod_id is the primary key (PK) as well as foreign key (FK).
# Product_Category, Product_Sub_Category and Prod_id all of these have VARCHAR(35) datatype

# The shipping_dimen table has 4 columns namely: 
# (1) Order_ID (2) Ship_Mode (3) Ship_Date (4) Ship_id
# Ship_id is the primary key (PK) as well as foreign key (FK), whereas Order_ID is just a foreign key (FK).
# Order_ID has INT datatype; Ship_Mode, Ship_Date and Ship_id have VARCHAR datatype

# Relations between tables:

# Order_ID is a foreign key to both shipping_dimen as well as orders_dimen table.
# Ship_id is foreign key to shipping_dimen as well as market_fact.
# Ord_id is foreign key to both orders_dimen as well as market_fact.
# Prod_id is te foreign key to both prod_dimen as well as market_fact.
# Cust_id is the foreign key to both cust_dimen as well as market_fact.
# Each of the tables cust_dimen, prod_dimen, orders_dimen and shipping_dimen are connect to market_fact through different foreign keys.

# Task 2:
# Question 1:

SELECT Customer_Name, Customer Segment
FROM cust_dimen
;

# Question 2:

SELECT * FROM cust_dimen
ORDER BY Cust_id DESC
;

# Question 3:

SELECT Order_ID, Order_Date 
FROM orders_dimen
WHERE Order_Priority = HIGH
;

# Question 4:

SELECT AVG(Sales) AS avg_sales, SUM(Sales) AS total_sales
FROM market_fact
;

# Question 5:

SELECT MAX(Sales) AS 'Max', MIN(Sales) AS 'Min'
FROM market_fact
;

# Question 6:

SELECT Region, COUNT(DISTINCT cust_id) AS no_of_customers
FROM cust_dimen
ORDER BY no_of_customers
;

# Question 7:

SELECT Region, MAX(COUNT(DISTINCT cust_id)) AS max_no_of_customers
FROM cust_dimen
;

# Question 8:

SELECT Customer_Name
FROM cust_dimen
RIGHT JOIN market_fact.Order_Quantity AS no_of_tables
ON cust_dimen.Cust_id = market_fact.Cust_id
INNER JOIN prod_dimen 
ON market_fact.Prod_id = prod_dimen.Prod_id
WHERE prod_dimen.Product_Sub-Category = 'TABLES' AND cust_dimen.Region = ATLANTIC
;

# Question 9:

SELECT Customer_Name, COUNT(Customer_Segment) AS no_small_business
FROM cust_dimen
WHERE cust_dimen.Province = ONTARIO AND cust_dimen.Customer_Segment = 'SMALL BUSINESS'
;

# Question 10:

SELECT prod_id
FROM prod_dimen
RIGHT JOIN market_fact.Order_Quantity AS no_of_products
ON prod_dimen.prod_id = market_fact.prod_id
ORDER BY no_of_products DESC
;

# Question 11:

SELECT prod_id, Product_Sub_Category
FROM prod_dimen
WHERE Product_Category = FURNITURE OR Product_Category = TECHNOLOGY
;

# Question 12:
# Display the product categories in descending order of profits

SELECT Product_Sub_Category
FROM prod_dimen
RIGHT JOIN market_fact.Profit AS Profit
ON prod_dimen.prod_id = market_fact.prod_id
ORDER BY Profit DESC
;

# Question 13:
# Display the product category, product sub-category and the profit within each subcategory in three columns.

SELECT Product_Category, Product_Sub_Category
FROM prod_dimen
RIGHT JOIN market_fact.Profit AS Profit
ON prod_dimen.prod_id = market_fact.prod_id
ORDER BY Product_Sub_Category
;

# Question 14:
# Display the order date, order quantity and the sales for the order

SELECT Order_Quantity, Sales
FROM market_fact
RIGHT JOIN orders_dimen.Order_Date AS Order_Date
ON orders_dimen.Ord_id = market_fact.Ord_id
;

# Question 15:

SELECT Customer_Name  
FROM cust_dimen
WHERE first_name LIKE '_r%'
;

SELECT Customer_Name  
FROM cust_dimen
WHERE first_name LIKE '___d%'
;

# Question 16:

SELECT Cust_id, Sales
FROM market_fact
RIGHT JOIN cust_dimen.Customer_Name AS Customer_Name
ON cust_dimen.Cust_id = market_fact.Cust_id
RIGHT JOIN cust_dimen.Region AS Region
ON cust_dimen.Cust_id = market_fact.Cust_id
WHERE market_fact.Sales >= 1000 AND market_fact.Sales <= 5000
ORDER BY market_fact.Sales
;

# Question 17:
# Write a SQL query to find the 3rd highest sales.

SELECT Sales FROM market_fact
ORDER BY Sales DESC LIMIT 2,1
;

# Question 18:
# Least Profitable Product_Sub_Category

SELECT Region
FROM cust_dimen
INNER JOIN market_fact
ON cust_dimen.Cust_id = market_fact.Cust_id
INNER JOIN prod_dimen
ON prod_dimen.Prod_id = market_fact.Prod_id
GROUP BY prod_dimen.Product_Sub_Category
ORDER BY market_fact.Profit ASC LIMIT 1
;

# For the least profitable product sub-category, display the region-wise no_of_shipments and the profit made in each region in decreasing order of profits

SELECT Order_Quantity AS no_of_shipments, Profit AS Profit_in_each_region
FROM market_fact
RIGHT JOIN cust_dimen.Region AS Region
ON cust_dimen.Cust_id = market_fact.Cust_id
IN (SELECT Region
FROM cust_dimen
INNER JOIN market_fact
ON cust_dimen.Cust_id = market_fact.Cust_id
INNER JOIN prod_dimen
ON prod_dimen.Prod_id = market_fact.Prod_id)
GROUP BY Region
ORDER BY Profit DESC
;














