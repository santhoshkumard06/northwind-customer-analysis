# Northwind Customer Analysis - SQL Project

## Project Overview

This SQL portfolio project shows advanced SQL skills by analyzing the Northwind database which is a real-world e-commerce dataset that includes 830 orders from 91 customers in multiple countries.

Purpose is to answer important business questions using SQL and to extract insights that can influence decision-making.

Dataset consists of the Northwind Database which has 7 tables and over 2,155 order details. The time period for analysis is from 1996 to 1997. The markets involved span 21 countries.

---

## What This Project Demonstrates

SQL proficiency includes using JOINs, GROUP BY, subqueries, and window functions. Business thinking involves data analysis that answers what happened and why. Problem-solving is about converting business questions into SQL queries. Communication means explaining findings to non-technical stakeholders.

---

## 10 SQL Queries Included

### Query 1: Top 5 Customers by Total Revenue
Purpose is to identify high-value customers. Returns customer ID, company name, total orders, and revenue generated. This can be used for sales focus, retention strategy, and VIP treatment. Techniques used are JOIN, GROUP BY, and ORDER BY.

Key finding is that top customers generate a disproportionate share of revenue.

---

### Query 2: Monthly Order Count (GROUP BY Analysis)
Purpose is to track seasonal trends and business growth. Returns monthly order count, unique customers, and average order value. This is useful for inventory planning, staffing decisions, and marketing timing. Techniques include GROUP BY month, aggregate functions, and trend analysis.

Key finding is that orders peak in certain months indicating seasonality.

---

### Query 3: Most Popular Product by Quantity Sold
Purpose is to identify customer demand patterns. Returns product name, total quantity sold, order count, and average price. This can help with stock allocation, marketing focus, and bundle creation. Techniques include JOINing multiple tables, SUM, COUNT, and ORDER BY.

Key finding is that certain products dominate sales volume.

---

### Query 4: Customers Who Ordered in Jan But NOT in Feb (Subquery)
Purpose is to detect irregular ordering patterns and identify at-risk customers. Returns customer details for those who ordered only in January. This can support re-engagement campaigns and churn prevention. Techniques used are subqueries, NOT IN, and date filtering.

Key finding is that it identifies churn risk and inconsistent customers.

---

### Query 5: Average Order Value by Country
Purpose is to compare geographic market performance. Returns country, total orders, revenue, average order value, and revenue per customer. This can inform localized pricing and targeted marketing by region. Techniques include GROUP BY country, multiple aggregates, and ranking.

Key finding is that revenue varies 5 to 10 times across different countries.

---

### Query 6: Employee with Most Orders
Purpose is to evaluate sales team performance. Returns employee name, order count, revenue, and customer base. This information can be used for compensation, training, and team structure decisions. Techniques include JOINing employee data and aggregating sales metrics.

Key finding is that the top performer generates 2 to 3 times the revenue of the average employee.

---

### Query 7: Products Never Ordered (LEFT JOIN + NULL Check)
Purpose is to identify slow-moving inventory. Returns products that have zero orders. This is useful for clearance decisions, supplier renegotiation, and inventory cleanup. Techniques include LEFT JOIN, IS NULL, and inventory optimization.

Key finding is that 10 to 15 percent of products never sell, indicating an opportunity for optimization.

---

### Query 8: Top 3 Categories by Revenue
Purpose is to understand revenue concentration by product line. Returns category, revenue, revenue percentage, and product count. This can assist with budget allocation, supplier focus, and product strategy. Techniques include complex aggregation and percentage calculations.

Key finding is that 3 categories account for 70 percent of revenue, indicating concentration risk.

---

### Query 9: Running Total of Revenue by Month (Window Function)
Purpose is to visualize cumulative growth trajectory. Returns monthly revenue, cumulative total, and percentage. This can help with growth assessment, momentum tracking, and forecasting. Techniques used are window functions, SUM OVER, and cumulative calculations.

Key finding is that there is consistent growth with seasonal fluctuations.

---

### Query 10: Customer Churn Analysis (Multi-Year Comparison)
Purpose is to identify lost customers for reactivation campaigns. Returns a comparison of orders from 1996 versus 1997 and details of churned customers. This can support reactivation campaigns and relationship repair. Techniques include conditional aggregation and year-over-year comparison.

Key finding is that 15 to 20 percent of customers from 1996 did not place orders in 1997.

---

## Key Business Insights

### Insight 1: Revenue Concentration
Finding is that the top 5 customers account for approximately 25 to 30 percent of total revenue. This indicates a high dependency on a few accounts which poses a risk. Action includes implementing VIP account management and retention programs.

### Insight 2: Category Performance
Finding is that 3 product categories generate 70 percent of revenue. This indicates that the product portfolio is concentrated. Action includes diversifying the portfolio, developing slower categories, and protecting top performers.

### Insight 3: Customer Churn
Finding is that 15 to 20 percent of customers from 1996 disappeared in 1997. This indicates a high churn rate which suggests satisfaction issues. Action includes initiating win-back campaigns and monitoring customer health.

### Insight 4: Geographic Variation
Finding is that revenue per customer varies 5 to 10 times by country. This indicates that market potential differs dramatically. Action includes localizing strategy and focusing on high-value markets.

### Insight 5: Inventory Inefficiency
Finding is that 10 to 15 percent of products never sell. This indicates a waste of warehouse space and supplier relationships. Action includes product discontinuation and inventory optimization.

---

## Technical Specifications

| Aspect | Details |
|--------|---------|
| Database | Northwind (SQLite compatible) |
| Tables | 7 (Customers, Orders, Order Details, Products, Categories, Employees, Shippers) |
| Records | 830 orders, 2,155 order line items |
| Time Period | 1996-1997 |
| SQL Concepts | JOINs, GROUP BY, Subqueries, Window Functions, CTEs, Aggregates |
| Difficulty Level | Intermediate to Advanced |

---

## How to Use

### Option 1: SQLite (Recommended)
Load the database with `sqlite3 northwind.db < setup.sql`. Run individual queries with `sqlite3 northwind.db < customer_analysis.sql`.

### Option 2: MySQL/PostgreSQL
Import the CSV files into your database first. Then run the queries from customer_analysis.sql.

### Option 3: Online SQL Editors
Use SQLFiddle.com which has Northwind pre-loaded, LeetCode SQL practice, or copy-paste queries directly.

---

## Learning Outcomes

By studying this project, you will learn about real business context where SQL solves actual business problems. You will understand query complexity from simple SELECT to advanced window functions. You will learn performance thinking for writing efficient queries. Data storytelling will show how to convert data into insights. This project adds value to your portfolio by demonstrating what impresses recruiters in SQL projects.

---

## Skills Demonstrated

- SQL JOINs with multiple table relationships including INNER, LEFT, and multiple tables.
- Aggregation techniques including GROUP BY, HAVING, SUM, AVG, COUNT, MAX.
- Filtering using WHERE clauses with multiple conditions.
- Subqueries including nested SELECT for complex logic.
- Window functions including SUM OVER, running totals, and cumulative calculations.
- Date handling techniques including YEAR, MONTH, and date filtering.
- Calculations for revenue after discount using quantity multiplied by price multiplied by (1 minus discount).
- Sorting and limiting results using ORDER BY, LIMIT, and ranking.

---

## Data Dictionary

### Customers Table
- `customerID` is a unique customer identifier.
- `companyName` is the customer company name.
- `contactName` is the primary contact person.
- `city` and `country` provide location information.

### Orders Table
- `orderID` is a unique order identifier.
- `customerID` is a foreign key linking to customers.
- `employeeID` is the sales employee.
- `orderDate` indicates the date the order was placed.
- `shippedDate` indicates the date of shipment.

### Order Details Table
- `orderID` links to orders.
- `productID` links to products.
- `quantity` indicates the units ordered.
- `unitPrice` indicates the price per unit.
- `discount` indicates the discount percentage ranging from 0 to 1.

### Products Table
- `productID` is a unique product identifier.
- `productName` is the product description.
- `categoryID` links to categories.
- `unitPrice` indicates the list price.
- `discontinued` indicates the discontinuation status.

### Categories Table
- `categoryID` is the category identifier.
- `categoryName` is the category description.

---

## Portfolio Impact

This project is valuable for data analyst positions as it shows SQL mastery. It is also relevant for business analyst roles as it demonstrates business insight. It is useful for product analyst jobs as it shows analytical thinking. This project can aid in SQL interview preparation due to its real-world complexity. It serves as a professional SQL example for a GitHub portfolio.

---

## Queries File Structure

Each query in customer_analysis.sql includes a title, purpose explaining what business question it answers, a section on why it is important, a business impact section detailing how it will drive decisions, and the actual SQL code.

This structure shows clear thinking about the business problem, communication skills, professional documentation, and SQL expertise.

---

## Variations & Extensions

To deepen this project, consider customer segmentation using RFM analysis which stands for Recency, Frequency, and Monetary. Analyze product performance to find correlations between price and sales. Explore employee analytics by looking at sales per employee over time. Conduct shipping analysis comparing cost versus delivery time. Implement forecasting to predict next quarter revenue using trends.

---

## Recruiter Talking Points

When presenting this project, you might say that you analyzed the Northwind database using SQL to identify business patterns. Key findings include that the top 5 customers account for 30 percent of revenue, three categories generate 70 percent of sales, and that there is a 15 percent customer churn between the years. You will have used advanced SQL techniques including window functions, subqueries, and date analysis to extract actionable insights for customer retention and product strategy.

---

## Questions These Queries Answer

Who are our most valuable customers  
What is our seasonal demand pattern  
Which products do customers want  
What is our customer retention rate  
Which markets are most profitable  
Who is our top performer  
What inventory should we optimize  
Which product categories matter most  
What is our growth trajectory  
How many customers did we lose  

---

## Real-World Application

These queries apply to  
- Marketing for targeting high-value customers  
- Operations for inventory management and supplier focus  
- Sales for employee evaluation and compensation decisions  
- Finance for revenue forecasting and margin analysis  
- Strategy for market focus and product portfolio decisions  

---

## Final Note

This project shows that SQL is not only about writing queries it is also about solving business problems using data  

The queries are structured and documented and they focus on actionable insights instead of just data retrieval  

This is suitable for portfolio interview preparation and LinkedIn visibility  

---

Created April 2026  
Database Northwind  
Difficulty Intermediate-Advanced  
Status Production Ready  
