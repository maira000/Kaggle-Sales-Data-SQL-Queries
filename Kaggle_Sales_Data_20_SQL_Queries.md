---

## Task 1: Basic Filtering

### Objective:

Find all records from New York (NY) in the STATE column.

### Correct Query:

```sql
SELECT * FROM sales_data_sample
WHERE STATE = 'NY';
```

---

# Task 2: Multi-Condition Filtering

### Objective:

Find all orders where the STATUS is 'Cancelled' AND the total SALES amount was greater than 5000.

### Correct Query:

```sql
SELECT *
FROM sales_data_sample
WHERE STATUS = 'Cancelled' AND Sales > 5000;
```

---

# Task 3: The Ranking Query

### Objective:

Find the single largest order line ever recorded based on the SALES column (Top 1 highest record).

### Correct Query:

```sql
SELECT TOP 1
ORDERLINENUMBER,
SALES
FROM sales_data_sample
ORDER BY SALES DESC;
```

### Mistakes & Lessons Learned:

- **Aggregate vs. Sorting:** Initially tried using `MAX(ORDERLINENUMBER)`, but `MAX()` alone collapses rows and doesn't reveal the context of the highest row. The best approach for a "Top 1" row is combining `TOP 1` with `ORDER BY`.
- **Sorting Direction:** Forgot that `ORDER BY` defaults to Ascending (`ASC`). Had to add `DESC` to ensure the highest sales value came to the top.
- **Data Context:** Discovered that `ORDERLINENUMBER` is a line-item index on a receipt (e.g., item #18 on the invoice), not the quantity ordered.

---

# Task 4: The Category Breakdown

### Objective:

Show the total sales (`SUM`) made by each PRODUCTLINE.

### Correct Query:

```sql
SELECT
PRODUCTLINE,
SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY PRODUCTLINE;
```

---

# Task 5: The Multi-Group Breakdown

### Objective:

Show the total sales (`SUM`) broken down by both YEAR_ID AND PRODUCTLINE.

### Correct Query:

```sql
SELECT
YEAR_ID,
PRODUCTLINE,
SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY YEAR_ID, PRODUCTLINE;
```

---

# Task 6: The High-Performing Countries

### Objective:

Find countries that generated more than $1,000,000 in total lifetime sales.

### Correct Query:

```sql
SELECT
COUNTRY,
SUM(SALES) AS total_lifetime_sales
FROM sales_data_sample
GROUP BY COUNTRY
HAVING SUM(SALES) > 1000000;
```

### Key Concept Mastered:

Successfully used `HAVING` instead of `WHERE` to filter on an aggregated total (`SUM(SALES)`).

---

# Task 7: Formatting the Date

### Objective:

Display unique ORDERDATE values formatted strictly as YYYY-MM-DD.

### Correct Query:

```sql
SELECT
ORDERDATE,
FORMAT(ORDERDATE, 'yyyy-MM-dd') AS FORMATTED_DATE
FROM sales_data_sample;
```

### Mistakes & Lessons Learned:

- **Function Syntax:** `FORMAT()` requires two arguments inside the parentheses: the column name, and the format string pattern (`FORMAT(column, 'string')`).
- **Case Sensitivity:** In SQL Server's `FORMAT()`, years must be lowercase `yyyy` and days must be lowercase `dd`. Months must be uppercase `MM` to prevent SQL from confusing them with minutes (`mm`).
- **Spacing:** Extra spaces inside the format string pattern (like `'YYYY - MM- DD'`) will literally render into the output data. Keep it tight: `'yyyy-MM-dd'`.

---

# Task 8: Cleaning up Contact Names

### Objective:

Combine CONTACTFIRSTNAME and CONTACTLASTNAME into a single column called FULL_NAME with a space between them.

### Correct Query:

```sql
SELECT
CONCAT(CONTACTFIRSTNAME, ' ', CONTACTLASTNAME) AS Contact_fullname
FROM sales_data_sample;
```

---

# Task 9: Categorizing Order Sizes

### Objective:

Create a conditional column using a CASE statement to classify QUANTITYORDERED as:

- Large (`>40`)
- Medium (`20-40`)
- Small (`<20`)

### Correct Query:

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

### Mistakes & Lessons Learned:

- **Structural Syntax:** CASE blocks do not require parentheses `()` around their logical branches.
- **Punctuation:** Do not put commas `,` between `WHEN/THEN` statement blocks; clauses inside a CASE flow sequentially without individual line separators.
- **Aliasing:** The column alias (`AS alias_name`) belongs outside the block, immediately following the `END` keyword.

---

# Task 10: The Conditional Summary

### Objective:

Find the total number of orders shipped to each country, filtering only for rows where STATUS is 'Shipped'.

### Correct Query:

```sql
SELECT
COUNTRY,
COUNT(ORDERNUMBER) AS total_orders
FROM sales_data_sample
WHERE STATUS = 'SHIPPED'
GROUP BY COUNTRY;
```

## Functions, Dates, & Subqueries

---

# 🧮 Part 1: String & Aggregate Functions (Tasks 11–14)

---

# Task 11: String Concatenation

### Concept:

Combining multiple text columns into a single descriptive string.

### Key Syntax:

Using the `+` operator or `CONCAT()` function in SQL Server.

### Code Template:

```sql
SELECT CONTACTFIRSTNAME + ' ' + CONTACTLASTNAME AS FULL_NAME
FROM sales_data_sample;
```

---

# Task 12: Conditional Replacement (ISNULL)

### Concept:

Preventing blank or missing data (`NULL`) from showing up in reports by providing a default fallback string.

### Key Syntax:

```sql
ISNULL(column_to_check, 'replacement_value')
```

### Code Template:

```sql
SELECT ISNULL(STATE, 'N/A') AS CLEANED_STATE
FROM sales_data_sample;
```

---

# Task 13: Trimming & Character Counts

### Concept:

Removing accidental trailing/leading blank spaces from strings and measuring text length.

### Key Syntax:

`TRIM()` cleans up hidden whitespace, and `LEN()` counts characters.

### Code Template:

```sql
SELECT LEN(TRIM(PRODUCTCODE)) AS CLEAN_LENGTH
FROM sales_data_sample;
```

---

# Task 14: Unique Character Lengths

### Concept:

Combining `DISTINCT` with string functions to analyze the structural properties of unique values in a column.

### Code Template:

```sql
SELECT DISTINCT PHONE, LEN(PHONE) AS PHONE_LENGTH
FROM sales_data_sample;
```

---

# 📅 Part 2: Working with Dates (Tasks 15–16)

---

# Task 15: Date Additions (DATEADD)

### Concept:

Shifting timestamps forward or backward along a specific interval timeline (days, months, years).

### Key Syntax:

```sql
DATEADD(datepart, number, date_column)
```

### Code Template:

```sql
SELECT ORDERNUMBER, ORDERDATE,
       DATEADD(day, 7, ORDERDATE) AS TARGET_DELIVERY_DATE
FROM sales_data_sample;
```

---

# Task 16: Extracting Parts of a Timestamp

### Concept:

Pulling out isolated parts of a full datetime value (like just the month number) for seasonal or monthly groupings.

### Key Syntax:

```sql
MONTH(date_column)
YEAR(date_column)
DAY(date_column)
```

### Code Template:

```sql
SELECT ORDERNUMBER, ORDERDATE,
       MONTH(ORDERDATE) AS EXTRACTED_MONTH
FROM sales_data_sample;
```

---

# 🔍 Part 3: Mastering Subqueries (Tasks 17–20)

## 💡 Notion Cheat Sheet:

A subquery is a query nested inside another query. The inner query runs first and hands its results to the outer query.

---

# Task 17: Scalar Subquery (Single Value)

### Concept:

Used when you want to filter records against a calculated value (like an overall average).

You cannot use aggregate functions like `AVG()` directly inside a `WHERE` clause, so a subquery calculates it first.

### Code Template:

```sql
SELECT ORDERNUMBER, SALES
FROM sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM sales_data_sample);
```

---

# Task 18: Table Subquery with IN

### Concept:

Evaluates whether a value belongs to a dynamic list or checklist generated by a nested query.

Great alternative to basic joins when you only need to check for existence.

### Code Template:

```sql
SELECT DISTINCT CUSTOMERNAME
FROM sales_data_sample
WHERE CUSTOMERNAME IN (
    SELECT CUSTOMERNAME FROM sales_data_sample WHERE SALES > 10000
);
```

---

# Task 19: Correlated Subquery with EXISTS

### Concept:

The inner query executes once for every single row evaluated by the outer query.

It checks for table relationships using aliases (main vs sub) and returns TRUE or FALSE based on whether rows match the criteria.

### Code Template:

```sql
SELECT main.ORDERNUMBER, main.CUSTOMERNAME, main.SALES
FROM sales_data_sample main
WHERE EXISTS (
    SELECT 1 FROM sales_data_sample sub
    WHERE sub.ORDERNUMBER = main.ORDERNUMBER AND sub.SALES > 10000
);
```

---

# Task 20: Derived Tables (Subquery in FROM)

### Concept:

When you need to run an aggregation on data that has already been aggregated.

Example: Finding the maximum value out of a list of customer sums.

The inner query must always be given a table alias.

### Code Template:

```sql
SELECT MAX(customer_totals.total_sales) AS MAX_CUSTOMER_SALES
FROM (
    SELECT CUSTOMERNAME, SUM(SALES) AS total_sales
    FROM sales_data_sample
    GROUP BY CUSTOMERNAME
) AS customer_totals;
```
