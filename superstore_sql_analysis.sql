-- ===*===*===*===*===*===*===*===*===*===
-- Superstore_Sales_Project => 10 Reports
-- ===*===*===*===*===*===*===*===*===*===

-- Report 1: Overall Business Summary
SELECT 
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM superstore_sales.orders;


-- Report 2: Region-wise Sales & Profit
SELECT 
    Region,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM superstore_sales.orders
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Report 3: Category-wise Performance
SELECT 
    Category,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Percent
FROM superstore_sales.orders
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Report 4: Top 10 Customers by Sales
SELECT 
    `Customer Name`,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore_sales.orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;


-- Report 5: Loss-Making Sub-Categories
SELECT 
    `Sub-Category`,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore_sales.orders
GROUP BY `Sub-Category`
ORDER BY Total_Profit ASC
LIMIT 5;


-- Report 6: Return Rate by Category (JOIN with returns table)
SELECT 
    o.Category,
    COUNT(o.`Order ID`) AS Total_Orders,
    COUNT(r.`Order ID`) AS Returned_Orders,
    ROUND(COUNT(r.`Order ID`) * 100.0 / COUNT(o.`Order ID`), 2) AS Return_Rate_Percent
FROM superstore_sales.orders o
LEFT JOIN superstore_sales.returns r ON o.`Order ID` = r.`Order ID`
GROUP BY o.Category
ORDER BY Return_Rate_Percent DESC;


-- Report 7: Monthly Sales Trend
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS Month,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore_sales.orders
GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
ORDER BY Month ASC;


-- Report 8: Segment-wise Performance
SELECT 
    Segment,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM superstore_sales.orders
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- Report 9: Discount Impact on Profit Margin
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
FROM superstore_sales.orders
GROUP BY Discount_Range
ORDER BY Profit_Margin_Percent DESC;


-- Report 10: Region Manager Performance (JOIN with people table)
SELECT 
    p.Person AS Regional_Manager,
    o.Region,
    COUNT(*) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM superstore_sales.orders o
LEFT JOIN superstore_sales.people p ON o.Region = p.Region
GROUP BY p.Person, o.Region
ORDER BY Total_Sales DESC;
