**Dataset:** Sales Data Sample (Kaggle)
**Database:** SQL Server

---

# Task 1: Basic Filtering

Find all records from New York (NY) using the `STATE` column.

`WHERE` is used to filter rows based on a specific condition.

```sql
SELECT *
FROM sales_data_sample
WHERE STATE = 'NY';
```

---

# Task 2: Multi-Condition Filtering

Find all orders where the status is cancelled, and the sales amount is greater than 5000.

`AND` is used when multiple conditions must be true.

```sql
SELECT *
FROM sales_data_sample
WHERE STATUS = 'Cancelled'
AND SALES > 5000;
```

---

# Task 3: Ranking Query

Find the single highest sales record.

`TOP 1` returns one row, and `ORDER BY DESC` sorts values from highest to lowest.

```sql
SELECT TOP 1
ORDERLINENUMBER,
SALES
FROM sales_data_sample
ORDER BY SALES DESC;
```

---

# Task 4: Category Breakdown

Find total sales for each product line.

`SUM()` calculates total values and `GROUP BY` creates groups.

```sql
SELECT
PRODUCTLINE,
SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY PRODUCTLINE;
```

---

# Task 5: Multi-Group Breakdown

Find total sales by year and product line.

Multiple columns can be grouped together for detailed analysis.

```sql
SELECT
YEAR_ID,
PRODUCTLINE,
SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY YEAR_ID, PRODUCTLINE;
```

---

# Task 6: High-Performing Countries

Find countries with lifetime sales greater than 1,000,000.

`HAVING` is used to filter aggregated results after `GROUP BY`.

```sql
SELECT
COUNTRY,
SUM(SALES) AS total_lifetime_sales
FROM sales_data_sample
GROUP BY COUNTRY
HAVING SUM(SALES) > 1000000;
```

---

# Task 7: Formatting Dates

Display order dates in YYYY-MM-DD format.

`FORMAT()` changes how date values are displayed.

```sql
SELECT
ORDERDATE,
FORMAT(ORDERDATE, 'yyyy-MM-dd') AS FORMATTED_DATE
FROM sales_data_sample;
```

---

# Task 8: Cleaning Contact Names

Combine the first name and last name into one column.

`CONCAT()` combines multiple string values.

```sql
SELECT
CONCAT(CONTACTFIRSTNAME, ' ', CONTACTLASTNAME) AS FULL_NAME
FROM sales_data_sample;
```

---

# Task 9: Categorizing Order Sizes

Create categories based on quantity ordered.

`CASE` applies conditional logic to create new categories.

```sql
SELECT
QUANTITYORDERED,
CASE
    WHEN QUANTITYORDERED > 40 THEN 'LARGE'
    WHEN QUANTITYORDERED BETWEEN 20 AND 40 THEN 'MEDIUM'
    WHEN QUANTITYORDERED < 20 THEN 'SMALL'
END AS ORDER_SIZE_CATEGORY
FROM sales_data_sample;
```

---

# Task 10: Conditional Summary

Count shipped orders by country.

`COUNT()` counts records and `WHERE` filters only shipped orders.

```sql
SELECT
COUNTRY,
COUNT(ORDERNUMBER) AS total_orders
FROM sales_data_sample
WHERE STATUS = 'SHIPPED'
GROUP BY COUNTRY;
```

---

# Task 11: String Concatenation

Combine multiple text columns into a single descriptive string.

`CONCAT()` or the `+` operator can be used to join text values together.

```sql
SELECT
CONTACTFIRSTNAME + ' ' + CONTACTLASTNAME AS FULL_NAME
FROM sales_data_sample;
```

---

# Task 12: Handling NULL Values

Replace missing STATE values with a default value.

`ISNULL()` replaces NULL values with a specified replacement value.

```sql
SELECT
ISNULL(STATE, 'N/A') AS CLEANED_STATE
FROM sales_data_sample;
```

---

# Task 13: Trimming & Character Count

Remove extra spaces and calculate text length.

`TRIM()` removes unwanted spaces and `LEN()` counts characters.

```sql
SELECT
LEN(TRIM(PRODUCTCODE)) AS CLEAN_LENGTH
FROM sales_data_sample;
```

---

# Task 14: Unique Character Lengths

Find unique phone numbers and their character lengths.

`DISTINCT` removes duplicate values and `LEN()` calculates length.

```sql
SELECT DISTINCT
PHONE,
LEN(PHONE) AS PHONE_LENGTH
FROM sales_data_sample;
```

---

# Task 15: Adding Dates

Add days to an existing order date.

`DATEADD()` shifts dates forward or backward by a specific interval.

```sql
SELECT
ORDERNUMBER,
ORDERDATE,
DATEADD(day, 7, ORDERDATE) AS TARGET_DELIVERY_DATE
FROM sales_data_sample;
```

---

# Task 16: Extracting Date Parts

Extract specific parts of a date, such as month, year, or day.

Date functions help in creating time-based analysis.

```sql
SELECT
ORDERNUMBER,
ORDERDATE,
MONTH(ORDERDATE) AS EXTRACTED_MONTH
FROM sales_data_sample;
```

---

# Task 17: Scalar Subquery

Find orders where sales are higher than the average sales value.

A scalar subquery returns a single value that can be used for comparison.

```sql
SELECT
ORDERNUMBER,
SALES
FROM sales_data_sample
WHERE SALES >
(
    SELECT AVG(SALES)
    FROM sales_data_sample
);
```

---

# Task 18: Subquery with IN

Find customers who have at least one order with sales greater than 10,000.

`IN` checks whether a value exists inside the result returned by another query.

```sql
SELECT DISTINCT CUSTOMERNAME
FROM sales_data_sample
WHERE CUSTOMERNAME IN
(
    SELECT CUSTOMERNAME
    FROM sales_data_sample
    WHERE SALES > 10000
);
```

---

# Task 19: Correlated Subquery with EXISTS

Find records where a matching order exists with sales greater than 10,000.

A correlated subquery uses values from the outer query and runs for each row.

```sql
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
```

---

# Task 20: Derived Table Subquery

Find the highest total sales made by a customer.

A derived table is a subquery inside the FROM clause that works like a temporary table.

```sql
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
