/*
Name: Ouokanouon Yves Valere Zoh
Course: IT143
Assignment: W3.4 AdventureWorks Questions and Answers
*/

USE AdventureWorks2025;
GO

/*============================================================
Question 1
Category: Marginal
Author: Another Student

Business Question:
What are the ten most expensive products based on their list prices

My Understanding: 
The goal is the identify the products with the highest ListPrice values and display the top 10.
==============================================================*/

SELECT TOP 10
       ProductID,
       Name,
       ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

-- Answer:
-- Returns the ten products with the highest list prices.

/*============================================================
Question 2
Category: Marginal
Author: Another Student

Business Question:
Whhich ten customers have the highest customer IDs?

My Understanding: 
Find the ten customers with the largest CustomerID values.
==============================================================*/

SELECT TOP 10
       CustomerID
FROM Sales.Customer
ORDER BY CustomerID DESC;

-- Answer:
-- Returns the ten customers with the highest CustomerID values.

/*============================================================
Question 3
Category: Moderate 
Author: Another Student

Business Question:
I want to understand our product inventory. Which products belong to each product category? Can you provide their names and category names?

My Understanding: 
Display products along with the category to which each product belongs.
==============================================================*/

SELECT
      p.Name AS ProductName,
      pc.Name AS CategoryName
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps
      ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc
      ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY pc.Name, p.Name;

-- Answer:
-- Returns product names and their associates categories.

/*============================================================
Question 4
Category: Moderate
Author: Another Student

Business Question:
I want to evaluate our sales performance.
Which sales territories generate the highest revenue?

My Understanding: 
Calculate total sales for each territory and rank territories by revenue.
==============================================================*/

SELECT
      st.Name AS TerritoryName,
      SUM(soh.TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory st
      ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalRevenue DESC;

-- Answer:
-- Displays territories ranked by total revenue.

/*============================================================
Question 5
Category: Increased
Author: Another Student

Business Question:
For 2013, compare each sales territory's total order value from
salesperson-assited orders against online orders.

My Understanding: 
Compare territory sales totals in 2013 by order type.
==============================================================*/

SELECT
      st.Name AS TerritoryName,
      CASE
          WHEN soh.SalesPersonID IS NULL
               THEN 'Online Order'
          ELSE 'Saleperson-Assited Order'
      END AS OrderType,
      SUM(soh.TotalDue) AS TotalOrderValue
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory st
       ON soh.TerritoryID = st.TerritoryID
WHERE YEAR(soh.OrderDate) = 2013
GROUP BY
      st.Name,
      CASE
          WHEN soh.SalesPersonID IS NULL
               THEN 'Online Order'
          ELSE 'Salesperson-Assisted Order'
      END
ORDER BY st.Name;
-- Answer:
-- Compares online and salesperson-assisted sales by victory.

/*============================================================
Question 6
Category: Increased
Author: Another Student

Business Question:
For each salesperson, compare total 2013 quarterly quotas with total 2013 sales.
Who fell short, and by how much?

My Understanding: 
Calculate total quotas and total sales for 2013,
then determine any shortfall.
==============================================================*/

SELECT
      p.FirstName + ' ' + p.LastName AS SalesPersonName,
      SUM(spq.SalesQuota) AS TotalQuota,
      sp.SalesYTD AS TotalSales,
      SUM(spq.SalesQuota) - sp.SalesYTD AS Shortfall
FROM Sales.SalesPersonQuotaHistory spq
INNER JOIN Sales.SalesPerson sp
       ON spq.BusinessEntityID = sp.BusinessEntityID
INNER JOIN Person.Person p
       ON sp.BusinessEntityID = p.BusinessEntityID
WHERE YEAR(spq.QuotaDate) = 2013
GROUP BY
       p.FirstName,
       p.LastName,
       sp.SalesYTD
HAVING SUM(spq.SalesQuota) > sp.SalesYTD
ORDER BY Shortfall DESC;

-- Answer:
-- Lists salespeople who did not meet their quotas and 
-- shows the amount by which they fell short.

/*============================================================
Question 7
Category: Metadata
Author: Me

Business Question:
Which AdventureWorks tables contain a column named 
ProductID?

My Understanding: 
Search database Metadata to identify all tables that contain a ProductID column.
==============================================================*/

SELECT
      TABLE_SCHEMA,
      TABLE_NAME,
      COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductID'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

-- Answer 
-- Returns all tables containing a ProductID column.

/*============================================================
Question 8
Category: Metadata
Author: Me

Business Question:
Which columns in AdventureWorks contain the word 'Customer' in their name?

My Understanding: 
Searcg the metadata to identify all columns whose names contain the word Customer.
==============================================================*/

SELECT
      TABLE_SCHEMA,
      TABLE_NAME,
      COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%Customer%'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

-- Answer:
-- Returns all columns containing the word Customer 
-- in their column name.