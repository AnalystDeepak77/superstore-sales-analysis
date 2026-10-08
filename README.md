# Superstore Sales & Profitability Analysis

End-to-end data analytics project using **Excel, SQL (MySQL) and Power BI** on a 9,994-row retail dataset (2016-2019) to find where the business makes and loses money.

## Dashboard Preview

**Page 1: Executive Overview**

<img width="1287" height="716" alt="Superstore_Dashboard_Page1" src="https://github.com/user-attachments/assets/5f669973-2e34-4b9f-a30c-488a3adea04f" />

**Page 2: Deep Dive**
<img width="1296" height="722" alt="Superstore_Dashboard_Page2" src="https://github.com/user-attachments/assets/32b62ff9-521c-47e9-bab8-b2addccb9a5b" />

## Project Workflow

| Tool | What I Did |
|---|---|
| **Excel** | Cleaned the raw data (duplicates, missing values, data types, formatting) and built summary tables and charts |
| **SQL (MySQL)** | Built a 3-table database, fixed data types, and wrote 10 analysis queries using GROUP BY, CASE and JOINs |
| **Power BI** | Connected to MySQL, created table relationships and DAX measures, and built a 2-page interactive dashboard |

## Database Structure

- **orders**: 9,994 rows (order lines)
- **returns**: 800 rows (296 unique returned orders)
- **people**: 4 rows (regional managers)

Relationships: `orders.Order ID` to `returns.Order ID` and `orders.Region` to `people.Region`

## SQL Reports (superstore_sql_analysis.sql)

1. Overall Business Summary
2. Region-wise Sales & Profit
3. Category-wise Performance
4. Top 10 Customers by Sales
5. Loss-Making Sub-Categories
6. Return Rate by Category (JOIN with returns)
7. Monthly Sales Trend
8. Segment-wise Performance
9. Discount Impact on Profit Margin
10. Regional Manager Performance (JOIN with people)

## Key Insights

- **Discounts are hurting profit:** orders with 20%+ discount had a **-37.3%** profit margin, while orders with no discount earned **+29.5%**.
- **Loss-making products:** Tables (-$17,726), Bookcases (-$3,473) and Supplies (-$1,189) lose money overall.
- **Returns:** 296 of 5,009 orders were returned (5.9%). Technology has the highest return rate (8.0%) and Office Supplies the lowest (6.3%).
- **Regions:** West leads in sales ($725K) and profit ($108K). Central earns the least profit ($39.7K) despite higher sales than South.
- **Overall:** $2.30M in sales, $286K profit, 12.5% profit margin.

## Dashboard Features

- 6 KPI cards (Sales, Profit, Orders, Returned Orders, Profit Margin %, Return Rate %)
- Slicers for Year, Region, Category and Segment
- Monthly trend, region/category/segment charts and a state-wise sales map
- Conditional formatting to highlight losses in red

## Files in this Repository

- `superstore_sql_analysis.sql`: all 10 SQL queries with comments
- `Sample - Superstore.xlsx`: cleaned Excel summary report
- `superstore_dashboard_overview.png`: dashboard_page1.png
- `superstore_dashboard_deep_dive.png`: dashboard_page2.png`: dashboard screenshots

## Tools Used

Excel, MySQL 8.0, MySQL Workbench, Power BI Desktop, DAX

## Connect With Me

**Deepak Kumar** | Aspiring Data Analyst

[LinkedIn Profile](https://www.linkedin.com/in/analystdeepak/)
