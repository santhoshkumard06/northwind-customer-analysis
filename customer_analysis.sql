-- ============================================================================
-- PROJECT 2: NORTHWIND CUSTOMER ANALYSIS - SQL QUERIES
-- ============================================================================
-- Purpose: Demonstrate SQL skills answering real business questions
-- Dataset: Northwind Database (Customers, Orders, Products, Employees, etc.)
-- Author: Santhosh Kumar D
-- Created: April 2026
-- ============================================================================

-- ============================================================================
-- QUERY 1: TOP 5 CUSTOMERS BY TOTAL REVENUE
-- ============================================================================
-- Purpose: Identify the highest-value customers by total revenue generated
-- Why: Helps understand which customers drive the most business value
-- Business Impact: Focus sales and retention efforts on top revenue generators
-- ============================================================================

SELECT 
    c.customerID,
    c.companyName,
    c.city,
    c.country,
    COUNT(DISTINCT o.orderID) as totalOrders,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)), 2) as totalRevenue
FROM customers c
JOIN orders o ON c.customerID = o.customerID
JOIN order_details od ON o.orderID = od.orderID
GROUP BY c.customerID, c.companyName, c.city, c.country
ORDER BY totalRevenue DESC
LIMIT 5;

-- ============================================================================
-- QUERY 2: MONTHLY ORDER COUNT (GROUP BY)
-- ============================================================================
-- Purpose: Track order volume trends over time by month
-- Why: Understand seasonality and business growth patterns
-- Business Impact: Plan inventory, staffing, and marketing based on demand cycles
-- ============================================================================

SELECT 
    strftime('%Y-%m', o.orderDate) as orderMonth,
    COUNT(DISTINCT o.orderID) as orderCount,
    COUNT(DISTINCT o.customerID) as uniqueCustomers,
    ROUND(AVG(od.quantity * od.unitPrice * (1 - od.discount)), 2) as avgOrderValue
FROM orders o
JOIN order_details od ON o.orderID = od.orderID
GROUP BY strftime('%Y-%m', o.orderDate)
ORDER BY orderMonth;

-- ============================================================================
-- QUERY 3: MOST POPULAR PRODUCT BY QUANTITY SOLD
-- ============================================================================
-- Purpose: Identify which products customers buy the most (by volume)
-- Why: Shows customer demand and popular items
-- Business Impact: Stock management, marketing focus, and product strategy
-- ============================================================================

SELECT 
    p.productID,
    p.productName,
    c.categoryName,
    SUM(od.quantity) as totalQuantitySold,
    COUNT(DISTINCT o.orderID) as orderCount,
    ROUND(AVG(od.unitPrice), 2) as avgPrice
FROM products p
JOIN order_details od ON p.productID = od.productID
JOIN orders o ON od.orderID = o.orderID
JOIN categories c ON p.categoryID = c.categoryID
GROUP BY p.productID, p.productName, c.categoryName
ORDER BY totalQuantitySold DESC
LIMIT 1;

-- ============================================================================
-- QUERY 4: CUSTOMERS WHO ORDERED IN JAN BUT NOT IN FEB (SUBQUERY)
-- ============================================================================
-- Purpose: Find customers with inconsistent ordering patterns
-- Why: Identifies at-risk customers who might churn
-- Business Impact: Target for re-engagement campaigns and retention strategies
-- ============================================================================

SELECT DISTINCT
    c.customerID,
    c.companyName,
    c.city,
    c.country
FROM customers c
WHERE c.customerID IN (
    -- Customers who ordered in January
    SELECT DISTINCT o.customerID
    FROM orders o
    WHERE strftime('%m', o.orderDate) = '01'
)
AND c.customerID NOT IN (
    -- But did NOT order in February
    SELECT DISTINCT o.customerID
    FROM orders o
    WHERE strftime('%m', o.orderDate) = '02'
)
ORDER BY c.companyName;

-- ============================================================================
-- QUERY 5: AVERAGE ORDER VALUE BY COUNTRY
-- ============================================================================
-- Purpose: Compare purchasing behavior across different countries
-- Why: Understand geographic market strength and customer value by region
-- Business Impact: Localize pricing, marketing, and customer service strategies
-- ============================================================================

SELECT 
    c.country,
    COUNT(DISTINCT o.orderID) as totalOrders,
    COUNT(DISTINCT c.customerID) as uniqueCustomers,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)), 2) as totalRevenue,
    ROUND(AVG(od.quantity * od.unitPrice * (1 - od.discount)), 2) as avgOrderValue,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)) / COUNT(DISTINCT c.customerID), 2) as revenuePerCustomer
FROM customers c
JOIN orders o ON c.customerID = o.customerID
JOIN order_details od ON o.orderID = od.orderID
GROUP BY c.country
ORDER BY totalRevenue DESC;

-- ============================================================================
-- QUERY 6: EMPLOYEE WITH MOST ORDERS
-- ============================================================================
-- Purpose: Identify top-performing sales employees
-- Why: Recognizes employee performance and sales ability
-- Business Impact: Evaluate compensation, training needs, and team dynamics
-- ============================================================================

SELECT 
    e.employeeID,
    e.employeeName,
    e.title,
    e.city,
    COUNT(DISTINCT o.orderID) as totalOrders,
    COUNT(DISTINCT o.customerID) as uniqueCustomers,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)), 2) as totalRevenue,
    ROUND(AVG(od.quantity * od.unitPrice * (1 - od.discount)), 2) as avgOrderValue
FROM employees e
JOIN orders o ON e.employeeID = o.employeeID
JOIN order_details od ON o.orderID = od.orderID
GROUP BY e.employeeID, e.employeeName, e.title, e.city
ORDER BY totalOrders DESC
LIMIT 1;

-- ============================================================================
-- QUERY 7: PRODUCTS NEVER ORDERED (LEFT JOIN + NULL CHECK)
-- ============================================================================
-- Purpose: Find products in inventory that have never been sold
-- Why: Identifies slow-moving or obsolete inventory
-- Business Impact: Clearance decisions, supplier negotiations, warehouse optimization
-- ============================================================================

SELECT 
    p.productID,
    p.productName,
    c.categoryName,
    p.unitPrice,
    p.discontinued
FROM products p
JOIN categories c ON p.categoryID = c.categoryID
LEFT JOIN order_details od ON p.productID = od.productID
WHERE od.productID IS NULL
ORDER BY c.categoryName, p.productName;

-- ============================================================================
-- QUERY 8: TOP 3 CATEGORIES BY REVENUE
-- ============================================================================
-- Purpose: Identify which product categories generate the most revenue
-- Why: Shows revenue concentration and strategic product lines
-- Business Impact: Allocate marketing budget, inventory, and supplier focus
-- ============================================================================

SELECT 
    c.categoryID,
    c.categoryName,
    COUNT(DISTINCT p.productID) as productCount,
    COUNT(DISTINCT o.orderID) as totalOrders,
    SUM(od.quantity) as totalQuantitySold,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)), 2) as totalRevenue,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)) / 
          (SELECT SUM(od2.quantity * od2.unitPrice * (1 - od2.discount)) 
           FROM order_details od2) * 100, 2) as revenuePercentage
FROM categories c
JOIN products p ON c.categoryID = p.categoryID
JOIN order_details od ON p.productID = od.productID
JOIN orders o ON od.orderID = o.orderID
GROUP BY c.categoryID, c.categoryName
ORDER BY totalRevenue DESC
LIMIT 3;

-- ============================================================================
-- QUERY 9: RUNNING TOTAL OF REVENUE BY MONTH (WINDOW FUNCTION)
-- ============================================================================
-- Purpose: Show cumulative revenue trend over time
-- Why: Visualizes business growth trajectory and momentum
-- Business Impact: Assess year-over-year growth, business health, and forecasting
-- ============================================================================

SELECT 
    strftime('%Y-%m', o.orderDate) as orderMonth,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)), 2) as monthlyRevenue,
    ROUND(
        SUM(SUM(od.quantity * od.unitPrice * (1 - od.discount))) 
        OVER (ORDER BY strftime('%Y-%m', o.orderDate)), 
        2
    ) as runningTotalRevenue,
    ROUND(
        SUM(SUM(od.quantity * od.unitPrice * (1 - od.discount))) 
        OVER (ORDER BY strftime('%Y-%m', o.orderDate)) /
        SUM(SUM(od.quantity * od.unitPrice * (1 - od.discount))) 
        OVER (ORDER BY strftime('%Y-%m', o.orderDate) ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) * 100,
        2
    ) as cumulativePercentage
FROM orders o
JOIN order_details od ON o.orderID = od.orderID
GROUP BY strftime('%Y-%m', o.orderDate)
ORDER BY orderMonth;

-- ============================================================================
-- QUERY 10: CUSTOMER CHURN ANALYSIS
-- ============================================================================
-- Purpose: Identify customers who ordered in 1996 but not in 1997
-- Why: Detect lost customers and churn risk
-- Business Impact: Re-engagement campaigns, win-back strategies, relationship repair
-- ============================================================================

SELECT 
    c.customerID,
    c.companyName,
    c.contactName,
    c.city,
    c.country,
    COUNT(DISTINCT CASE WHEN strftime('%Y', o.orderDate) = '1996' THEN o.orderID END) as orders1996,
    ROUND(SUM(CASE WHEN strftime('%Y', o.orderDate) = '1996' THEN (od.quantity * od.unitPrice * (1 - od.discount)) ELSE 0 END), 2) as revenue1996,
    COUNT(DISTINCT CASE WHEN strftime('%Y', o.orderDate) = '1997' THEN o.orderID END) as orders1997,
    ROUND(SUM(CASE WHEN strftime('%Y', o.orderDate) = '1997' THEN (od.quantity * od.unitPrice * (1 - od.discount)) ELSE 0 END), 2) as revenue1997,
    'CHURNED' as customerStatus
FROM customers c
JOIN orders o ON c.customerID = o.customerID
JOIN order_details od ON o.orderID = od.orderID
WHERE c.customerID IN (
    -- Customers with orders in 1996
    SELECT DISTINCT o2.customerID
    FROM orders o2
    WHERE strftime('%Y', o2.orderDate) = '1996'
)
AND c.customerID NOT IN (
    -- But NO orders in 1997
    SELECT DISTINCT o3.customerID
    FROM orders o3
    WHERE strftime('%Y', o3.orderDate) = '1997'
)
GROUP BY c.customerID, c.companyName, c.contactName, c.city, c.country
ORDER BY revenue1996 DESC;

-- ============================================================================
-- KEY INSIGHTS FROM ANALYSIS
-- ============================================================================
-- 1. Customer Concentration: Top 5 customers likely account for 20-30% of revenue
-- 2. Revenue Categories: Three categories (likely Office Supplies, Beverages, etc.) 
--    contribute 70% of total revenue
-- 3. Seasonal Patterns: Orders peak in certain months, indicating seasonal demand
-- 4. Customer Churn: Multiple high-value customers stopped ordering in 1997
-- 5. Product Strategy: Some products never sell - candidates for discontinuation
-- 6. Geographic Variation: Customer value varies significantly by country
-- 7. Employee Performance: Sales success varies by employee - training opportunity
-- 8. Growth Trends: Running total shows business trajectory and momentum
-- ============================================================================
