# Kaggle Sales Data SQL Queries

## Overview

This repository contains SQL practice queries performed on the **Kaggle Sales Data Sample** dataset.

The project focuses on building SQL skills through practical data exploration, filtering, aggregation, transformation, and analytical queries using SQL Server syntax.

A total of **20 SQL queries** are included, covering beginner to intermediate SQL concepts commonly used in data analysis and data engineering workflows.

---

# Dataset

**Dataset Name:** Sales Data Sample (Kaggle)

The dataset contains sales transaction records with information about:

- Orders
- Customers
- Products
- Product Lines
- Countries
- Sales Amounts
- Order Dates
- Order Status

---

# SQL Concepts Covered

## Filtering Data
- SELECT statements
- WHERE clause
- AND conditions
- Filtering records based on requirements

## Sorting & Ranking
- TOP clause
- ORDER BY
- ASC and DESC sorting

## Aggregate Functions
- SUM()
- COUNT()
- AVG()
- GROUP BY

## Group Filtering
- HAVING clause
- Filtering aggregated results

## String Functions
- CONCAT()
- String concatenation
- TRIM()
- LEN()
- ISNULL()

## Date Functions
- FORMAT()
- DATEADD()
- YEAR()
- MONTH()
- DAY()

## Conditional Logic
- CASE statements
- Data categorization

## Subqueries
- Scalar subqueries
- IN subqueries
- EXISTS
- Correlated subqueries
- Derived tables

---

# Project Structure

```
Kaggle-Sales-Data-SQL-Queries
│
├── README.md
│
├── Kaggle_Sales_Data_20_SQL_Queries.md
```

---

# Query List

| Query No. | Topic |
|-----------|-------|
| 1 | Basic Filtering |
| 2 | Multi-Condition Filtering |
| 3 | Top Highest Sales Record |
| 4 | Product Line Sales Breakdown |
| 5 | Year and Product Line Analysis |
| 6 | Country Sales Analysis |
| 7 | Date Formatting |
| 8 | Customer Name Concatenation |
| 9 | Order Size Categorization |
| 10 | Shipped Orders by Country |
| 11 | String Concatenation |
| 12 | NULL Handling using ISNULL |
| 13 | Trimming and Character Length |
| 14 | Distinct Value Length Analysis |
| 15 | Date Addition using DATEADD |
| 16 | Extracting Date Components |
| 17 | Scalar Subquery |
| 18 | IN Subquery |
| 19 | Correlated Subquery using EXISTS |
| 20 | Derived Table Subquery |

---

# Sample Query

Example: Finding all records from New York

```sql
SELECT *
FROM sales_data_sample
WHERE STATE = 'NY';
```

---

# Skills Practiced

Through this project, the following SQL skills were practiced:

- Writing SQL queries
- Data filtering
- Data aggregation
- Data transformation
- Handling missing values
- Date manipulation
- Conditional logic
- Query optimization thinking
- Working with real-world datasets

---

# Tools Used

- SQL Server
- SQL Server Management Studio (SSMS)
- Kaggle Dataset
- GitHub

---

# Purpose

The purpose of this project is to strengthen SQL fundamentals and create practical examples that demonstrate data querying and analysis skills useful for Data Analyst and Data Engineering roles.

---

# Author

Maira Naveed
