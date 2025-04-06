CREATE DATABASE 2025Hack;

use 2025Hack;

/* ###########################     Data Cleaning    ##############################*/

SELECT * FROM ecommerce;

DESCRIBE ecommerce;

SET sql_safe_updates = 0; /* change database from safemode to updatemode to allow update */

UPDATE ecommerce    /* change date column to the right format that is required by MySQL */
SET OrderDate = CASE
	WHEN OrderDate LIKE '%/%' THEN date_format(str_to_date (OrderDate, '%d/%m/%Y'), '%Y-%m-%d')
    ELSE null
END;

ALTER TABLE ecommerce   /* change date column datatype from text to date */
MODIFY COLUMN OrderDate DATE;

describe ecommerce; 


/* #########################   Sales Analysis   ##################################*/ 

SELECT * FROM ecommerce;

-- Total Sales Revenue (KPI Card)
SELECT SUM(TotalPrice) AS Total_Sales_Revenue$ 
FROM ecommerce;

-- Revenue by Product Category (Bar Chart)
SELECT Category, SUM(TotalPrice) AS Revenue 
FROM ecommerce 
GROUP BY Category 
ORDER BY Revenue DESC;

-- Revenue by Region (Map/Bar Chart)
SELECT Region, SUM(TotalPrice) AS TotalSales  
FROM ecommerce
GROUP BY Region                 
ORDER BY TotalSales DESC;

-- Revenue by Month (Line Chart)
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, SUM(TotalPrice) AS Revenue 
FROM ecommerce 
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m') 
ORDER BY Month;

-- Top Selling Products in Revenue (Bar Chart)
SELECT ProductName, 
       SUM(Quantity) AS Total_Quantity_Sold, 
       SUM(TotalPrice) AS Total_Sales
FROM ecommerce 
GROUP BY ProductName 
ORDER BY Total_Sales DESC;


/* ##########################   Customer Behavior   ######################## */

-- Customer Segmentation by Gender (Pie Chart)
SELECT Gender, COUNT(DISTINCT CustomerID) AS Customer_Count 
FROM ecommerce 
GROUP BY Gender;

-- Age Distribution of Customers (Histogram)
SELECT Age, COUNT(CustomerID) AS Customer_Count 
FROM ecommerce 
GROUP BY Age 
ORDER BY Age;

-- Identifying the Age Group with the Highest Spending (Bar chart)
SELECT  
    CASE  
        WHEN Age BETWEEN 18 AND 29 THEN 'Young Adults 18-29'  
        WHEN Age BETWEEN 30 AND 39 THEN 'Established Workforce 30-39'  
        WHEN Age BETWEEN 40 AND 49 THEN 'Senior Professionals 40-49'  
        ELSE 'Retirement Age 50+'  
    END AS AgeGroup,  
    SUM(TotalPrice) AS TotalSpending  
FROM ecommerce  
GROUP BY AgeGroup  
ORDER BY TotalSpending DESC; 

-- Customer Spending Behavior (Scatter Plot)
SELECT CustomerID, SUM(TotalPrice) AS Total_Spent, COUNT(DISTINCT ProductName) AS Products_Purchased 
FROM ecommerce 
GROUP BY CustomerID 
ORDER BY Total_Spent DESC;

-- Average Order Value (KPI Card)
SELECT ROUND(SUM(TotalPrice) / COUNT(DISTINCT CustomerID), 2) AS Average_Order_Value 
FROM ecommerce;


-- Returning vs. New Customers (Pie Chart)
SELECT 'New Customer' AS Customer_Type, COUNT(*) AS Customer_Count
FROM (SELECT CustomerID FROM ecommerce GROUP BY CustomerID HAVING COUNT(CustomerID) = 1) AS New_Customers
UNION ALL
SELECT 'Returning Customer' AS Customer_Type, COUNT(*) AS Customer_Count
FROM (SELECT CustomerID FROM ecommerce GROUP BY CustomerID HAVING COUNT(CustomerID) > 1) AS Returning_Customers;


/* ##########################   Order Fulfillment    ######################### */

-- Shipping Status Distribution (Pie Chart)
SELECT ShippingStatus, COUNT(*) AS Order_Count 
FROM ecommerce 
GROUP BY ShippingStatus;

-- Average Shipping Fee per Region (Bar Chart)
SELECT Region, ROUND(AVG(ShippingFee), 2) AS Avg_Shipping_Fee 
FROM ecommerce 
GROUP BY Region 
ORDER BY Avg_Shipping_Fee DESC;

-- Orders Delivered vs. Returned vs. In Transit (Bar Chart)
SELECT ShippingStatus, COUNT(*) AS Order_Count 
FROM ecommerce 
WHERE ShippingStatus IN ('Delivered', 'Returned', 'In Transit') 
GROUP BY ShippingStatus;

-- Delivery Performance Over Time (Line Chart)
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, 
       COUNT(*) AS Total_Orders, 
       SUM(CASE WHEN ShippingStatus = 'Delivered' THEN 1 ELSE 0 END) AS Delivered_Orders 
FROM ecommerce 
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m') 
ORDER BY Month;


/* ########################### EDA ############################### */

-- Highest & Lowest Revenue Categories
(
    SELECT 
        'Highest Revenue Category' AS Title, 
        Category, 
        SUM(TotalPrice) AS TotalRevenue  
    FROM 2025hack.ecommerce
    GROUP BY Category  
    ORDER BY TotalRevenue DESC  
    LIMIT 1
)
UNION ALL
(
    SELECT 
        'Lowest Revenue Category' AS Title, 
        Category, 
        SUM(TotalPrice) AS TotalRevenue  
    FROM 2025hack.ecommerce
    GROUP BY Category  
    ORDER BY TotalRevenue ASC  
    LIMIT 1
);


-- Youngest & Oldest Customer Age
SELECT 
    MIN(Age) AS Youngest_Age,  
    MAX(Age) AS Oldest_Age     
FROM ecommerce;


-- Average Order Value by Age Group
SELECT     
    CASE 
        WHEN Age BETWEEN 18 AND 29 THEN 'Young Adults 18-29'
        WHEN Age BETWEEN 30 AND 39 THEN 'Established Workforce 30-39'
        WHEN Age BETWEEN 40 AND 49 THEN 'Senior Professionals 40-49'
        ELSE 'Retirement Age 50+'  
    END AS AgeGroup, 
    ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM ecommerce
GROUP BY AgeGroup
ORDER BY AvgOrderValue DESC;


-- Number of Purchases by Age Group (bar/pie chart)
SELECT  
    CASE 
        WHEN Age BETWEEN 18 AND 29 THEN 'Young Adults 18-29'
        WHEN Age BETWEEN 30 AND 39 THEN 'Established Workforce 30-39'
        WHEN Age BETWEEN 40 AND 49 THEN 'Senior Professionals 40-49'
        ELSE 'Retirement Age 50+'
    END AS AgeGroup, 
    COUNT(CustomerID) AS NumberOfPurchases
FROM ecommerce
GROUP BY AgeGroup
ORDER BY NumberOfPurchases DESC;


-- Purchase Distribution by Age Group and Category (heatmap/Stacked Bar Chart)
SELECT  
    Category,
    SUM(CASE WHEN Age BETWEEN 18 AND 29 THEN 1 ELSE 0 END) AS `Young Adults 18-29`,
    SUM(CASE WHEN Age BETWEEN 30 AND 39 THEN 1 ELSE 0 END) AS `Established Workforce 30-39`,
    SUM(CASE WHEN Age BETWEEN 40 AND 49 THEN 1 ELSE 0 END) AS `Senior Professionals 40-49`,
    SUM(CASE WHEN Age >= 50 THEN 1 ELSE 0 END) AS `Retirement Age 50+`
FROM ecommerce
GROUP BY Category
ORDER BY 
    `Young Adults 18-29` DESC,
    `Established Workforce 30-39` DESC,
    `Senior Professionals 40-49` DESC,
    `Retirement Age 50+` DESC;


-- Product Purchases by Gender (Stacked or Grouped Bar Chart , heatmap)
SELECT 
    ProductName,
    SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS `Male_Purchases`,
    SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS `Female_Purchases`,
    COUNT(*) AS `Total_Purchases`
FROM ecommerce
GROUP BY ProductName
ORDER BY `Total_Purchases` DESC;



-- Top Purchased Product by Gender (KPI Cards)
SELECT Gender, ProductName, PurchaseCount    
FROM (
    SELECT 
        Gender, 
        ProductName, 
        COUNT(*) AS PurchaseCount,
        RANK() OVER (PARTITION BY Gender ORDER BY COUNT(*) DESC) AS rnk
    FROM ecommerce
    GROUP BY Gender, ProductName
) ranked
WHERE rnk = 1;


-- Order Fulfillment & Delivery Performance Analysis (Gauge Chart/Stacked Bar Chart )
SELECT   
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN ShippingStatus = 'Delivered' THEN 1 ELSE 0 END) AS DeliveredOrders,
    SUM(CASE WHEN ShippingStatus = 'In Transit' THEN 1 ELSE 0 END) AS InTransitOrders,
    SUM(CASE WHEN ShippingStatus = 'Returned' THEN 1 ELSE 0 END) AS ReturnedOrders,
    
    ROUND((SUM(CASE WHEN ShippingStatus = 'Delivered' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS FulfillmentRate,
    ROUND((SUM(CASE WHEN ShippingStatus = 'In Transit' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS InTransitRate,
    ROUND((SUM(CASE WHEN ShippingStatus = 'Returned' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS ReturnRate
FROM ecommerce;


-- Most Expensive & Cheapest Products
(
    SELECT 
        'Most Expensive Product' AS Title, 
        ProductName, 
        Category, 
        UnitPrice 
    FROM ecommerce 
    ORDER BY UnitPrice DESC 
    LIMIT 1
)
UNION ALL
(
    SELECT 
        'Cheapest Product' AS Title, 
        ProductName, 
        Category, 
        UnitPrice 
    FROM ecommerce 
    ORDER BY UnitPrice ASC 
    LIMIT 1
);



-- Total Products & Categories Overview
SELECT 
    'Number of Products & Categories' AS Title, 
    COUNT(DISTINCT ProductName) AS Available_Products, 
    COUNT(DISTINCT Category) AS Available_Categories 
FROM ecommerce;





















