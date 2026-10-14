/*
===============================================================================
  SUPERSTORE SALES ANALYSIS - SQL QUERIES
===============================================================================
  Project   : Superstore Sales Performance Analysis
  Database  : superstore_sales
  Tables    : orders (9,994 rows), people (4 rows), returns (800 rows, 296 unique returned orders)
  Tools Used: Excel (cleaning & formatting) -> MySQL (this file) -> Power BI
  Author    : [Your Name]
  Purpose   : Analyze sales, profit, customer, and return trends to uncover
              actionable business insights. These queries form the backbone
              of the Power BI dashboard built on top of this dataset.
===============================================================================
*/

USE superstore_sales;


/* -------------------------------------------------------------------------
   REPORT 1: OVERALL BUSINESS SUMMARY
   Purpose: High-level snapshot of total orders, sales, profit, and AOV.
--------------------------------------------------------------------------*/
SELECT 
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    COUNT(*) AS Total_Order_Lines,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Percent,
    ROUND(SUM(Sales)/COUNT(DISTINCT `Order ID`), 2) AS Avg_Order_Value
FROM orders;


/* -------------------------------------------------------------------------
   REPORT 2: REGION-WISE SALES & PROFIT
   Purpose: Identify which region generates the highest sales and profit.
--------------------------------------------------------------------------*/
SELECT 
    Region,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM orders
GROUP BY Region
ORDER BY Total_Sales DESC;


/* -------------------------------------------------------------------------
   REPORT 3: CATEGORY-WISE PERFORMANCE
   Purpose: Compare sales, profit, and profit margin across categories.
--------------------------------------------------------------------------*/
SELECT 
    Category,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Percent
FROM orders
GROUP BY Category
ORDER BY Total_Sales DESC;


/* -------------------------------------------------------------------------
   REPORT 4: TOP 10 CUSTOMERS BY SALES
   Purpose: Identify the highest-value customers by total sales generated.
--------------------------------------------------------------------------*/
SELECT 
    `Customer Name`,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;


/* -------------------------------------------------------------------------
   REPORT 5: LOSS-MAKING SUB-CATEGORIES
   Purpose: Find sub-categories with the lowest (most negative) profit.
--------------------------------------------------------------------------*/
SELECT 
    `Sub-Category`,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM orders
GROUP BY `Sub-Category`
ORDER BY Total_Profit ASC
LIMIT 5;


/* -------------------------------------------------------------------------
   REPORT 6: RETURN RATE BY CATEGORY (JOIN: orders + returns)
   Purpose: Measure what percentage of orders in each category were returned.
   Note   : The returns table contains repeated Order IDs, so it is
            de-duplicated (DISTINCT) before joining. Joining the raw table
            would multiply order rows and inflate the counts.
--------------------------------------------------------------------------*/
SELECT 
    o.Category,
    COUNT(DISTINCT o.`Order ID`) AS Total_Orders,
    COUNT(DISTINCT r.`Order ID`) AS Returned_Orders,
    ROUND(COUNT(DISTINCT r.`Order ID`) * 100.0 / COUNT(DISTINCT o.`Order ID`), 2) AS Return_Rate_Percent
FROM orders o
LEFT JOIN (SELECT DISTINCT `Order ID` FROM returns) r 
    ON o.`Order ID` = r.`Order ID`
GROUP BY o.Category
ORDER BY Return_Rate_Percent DESC;


/* -------------------------------------------------------------------------
   REPORT 7: MONTHLY SALES TREND
   Purpose: Track how sales and profit have changed month-over-month
            across the full date range (2016-2019).
--------------------------------------------------------------------------*/
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS Month,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM orders
GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
ORDER BY Month ASC;


/* -------------------------------------------------------------------------
   REPORT 8: SEGMENT-WISE PERFORMANCE
   Purpose: Compare Consumer / Corporate / Home Office segments.
--------------------------------------------------------------------------*/
SELECT 
    Segment,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM orders
GROUP BY Segment
ORDER BY Total_Sales DESC;


/* -------------------------------------------------------------------------
   REPORT 9: DISCOUNT IMPACT ON PROFIT MARGIN
   Purpose: See how increasing discount levels affect profit margin.
--------------------------------------------------------------------------*/
SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.1 THEN 'Low (upto 10%)'
        WHEN Discount <= 0.2 THEN 'Medium (10-20%)'
        ELSE 'High (20%+)'
    END AS Discount_Range,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Percent
FROM orders
GROUP BY Discount_Range
ORDER BY Profit_Margin_Percent DESC;


/* -------------------------------------------------------------------------
   REPORT 10: REGION MANAGER PERFORMANCE (JOIN: orders + people)
   Purpose: Attribute sales and profit to each Regional Manager by
            joining orders with the people table on Region.
--------------------------------------------------------------------------*/
SELECT 
    p.Person AS Regional_Manager,
    o.Region,
    COUNT(*) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM orders o
LEFT JOIN people p ON o.Region = p.Region
GROUP BY p.Person, o.Region
ORDER BY Total_Sales DESC;
