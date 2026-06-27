```sql
-- Kaggle Sales Data SQL Practice
-- 20 SQL Queries using sales_data_sample dataset


-- Task 1: Basic Filtering
-- Find all records from New York (NY)

SELECT *
FROM sales_data_sample
WHERE STATE = 'NY';


--------------------------------------------------


-- Task 2: Multi-Condition Filtering
-- Find cancelled orders with sales greater than 5000

SELECT *
FROM sales_data_sample
WHERE STATUS = 'Cancelled'
AND SALES > 5000;


--------------------------------------------------


-- Task 3: Ranking Query
-- Find the highest sales record

SELECT TOP 1
ORDERLINENUMBER,
SALES
FROM sales_data_sample
ORDER BY SALES DESC;


--------------------------------------------------


-- Task 4: Category Breakdown
-- Total sales by product line

SELECT
PRODUCTLINE,
SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY PRODUCTLINE;


--------------------------------------------------


-- Task 5: Multi-Group Breakdown
-- Total sales by year and product line

SELECT
YEAR_ID,
PRODUCTLINE,
SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY YEAR_ID, PRODUCTLINE;


--------------------------------------------------


-- Task 6: High Performing Countries
-- Countries with lifetime sales greater than 1,000,000

SELECT
COUNTRY,
SUM(SALES) AS total_lifetime_sales
FROM sales_data_sample
GROUP BY COUNTRY
HAVING SUM(SALES) > 1000000;


--------------------------------------------------


-- Task 7: Formatting Dates
-- Display order dates as YYYY-MM-DD

SELECT
ORDERDATE,
FORMAT(ORDERDATE, 'yyyy-MM-dd') AS FORMATTED_DATE
FROM sales_data_sample;


--------------------------------------------------


-- Task 8: Cleaning Contact Names
-- Combine first name and last name

SELECT
CONCAT(CONTACTFIRSTNAME, ' ', CONTACTLASTNAME) AS FULL_NAME
FROM sales_data_sample;


--------------------------------------------------


-- Task 9: Categorizing Order Sizes
-- Create categories based on quantity ordered

SELECT
QUANTITYORDERED,
CASE
    WHEN QUANTITYORDERED > 40 THEN 'LARGE'
    WHEN QUANTITYORDERED BETWEEN 20 AND 40 THEN 'MEDIUM'
    WHEN QUANTITYORDERED < 20 THEN 'SMALL'
END AS ORDER_SIZE_CATEGORY
FROM sales_data_sample;


--------------------------------------------------


-- Task 10: Conditional Summary
-- Count shipped orders by country

SELECT
COUNTRY,
COUNT(ORDERNUMBER) AS total_orders
FROM sales_data_sample
WHERE STATUS = 'SHIPPED'
GROUP BY COUNTRY;


--------------------------------------------------


-- Task 11: String Concatenation
-- Combine contact names

SELECT
CONTACTFIRSTNAME + ' ' + CONTACTLASTNAME AS FULL_NAME
FROM sales_data_sample;


--------------------------------------------------


-- Task 12: Handling NULL Values
-- Replace missing state values

SELECT
ISNULL(STATE, 'N/A') AS CLEANED_STATE
FROM sales_data_sample;


--------------------------------------------------


-- Task 13: Trimming & Character Count

SELECT
LEN(TRIM(PRODUCTCODE)) AS CLEAN_LENGTH
FROM sales_data_sample;


--------------------------------------------------


-- Task 14: Unique Character Lengths

SELECT DISTINCT
PHONE,
LEN(PHONE) AS PHONE_LENGTH
FROM sales_data_sample;


--------------------------------------------------


-- Task 15: Adding Dates
-- Add 7 days to order date

SELECT
ORDERNUMBER,
ORDERDATE,
DATEADD(day, 7, ORDERDATE) AS TARGET_DELIVERY_DATE
FROM sales_data_sample;


--------------------------------------------------


-- Task 16: Extracting Date Parts

SELECT
ORDERNUMBER,
ORDERDATE,
MONTH(ORDERDATE) AS EXTRACTED_MONTH
FROM sales_data_sample;


--------------------------------------------------


-- Task 17: Scalar Subquery
-- Find orders above average sales

SELECT
ORDERNUMBER,
SALES
FROM sales_data_sample
WHERE SALES >
(
    SELECT AVG(SALES)
    FROM sales_data_sample
);


--------------------------------------------------


-- Task 18: IN Subquery
-- Find customers with orders above 10000 sales

SELECT DISTINCT
CUSTOMERNAME
FROM sales_data_sample
WHERE CUSTOMERNAME IN
(
    SELECT CUSTOMERNAME
    FROM sales_data_sample
    WHERE SALES > 10000
);


--------------------------------------------------


-- Task 19: Correlated Subquery with EXISTS

SELECT
main.ORDERNUMBER,
main.CUSTOMERNAME,
main.SALES
FROM sales_data_sample main
WHERE EXISTS
(
    SELECT 1
    FROM sales_data_sample sub
    WHERE sub.ORDERNUMBER = main.ORDERNUMBER
    AND sub.SALES > 10000
);


--------------------------------------------------


-- Task 20: Derived Table Subquery
-- Find maximum customer sales

SELECT
MAX(customer_totals.total_sales) AS MAX_CUSTOMER_SALES
FROM
(
    SELECT
    CUSTOMERNAME,
    SUM(SALES) AS total_sales
    FROM sales_data_sample
    GROUP BY CUSTOMERNAME
) AS customer_totals;
```
