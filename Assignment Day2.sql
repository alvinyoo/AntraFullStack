-- Assignment 2

---- Answer these questions:
-- 1.	What is a result set?
--the output table of a SQL query

-- 2.	What is the difference between Union and Union All?
-- 1) UNION removes duplicate records, UNION ALL does not
-- 2) By UNION, the records from the first column will be sorted ascendingly, but not for UNION ALL
-- 3) UNION cannot be used in recursive cte, but UNION ALL can

-- 3.	What are the other Set Operators SQL Server has?
-- INTERSECT and EXCEPT.

-- 4.	What is the difference between Union and Join?
-- UNION combine the rows together vertically. JOIN combine table colunms horizentally.

-- 5.	What is the difference between INNER JOIN and FULL JOIN?
-- INNER JOIN keep only rows that appear in both tables. FULL JOIN will use NULL to fillup those missing values.

-- 6.	What is difference between left join and outer join?
-- LEFT JOIN keep everything  from the table on the left, OUTRT JOIN keep everything from both tables

-- 7.	What is cross join?
-- CROSS JOIN will join two tables with all the possible combination between rows.

-- 8.	What is the difference between WHERE clause and HAVING clause?
-- 1) both are used as filters. HAVING applies only to groups as a whole, as only filter aggretated fileds, but WHERE appleis to individual rows
-- 2) WHERE goes before aggregations, but HAVING filters after the aggregtions

-- 9.	Can there be multiple group by columns?
-- Yes


---- Write queries for following scenarios
-- 1.	How many products can you find in the Production.Product table?
USE AdventureWorks2019
GO
SELECT COUNT(*) FROM Production.Product;

-- 2.	Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(ProductSubcategoryID) FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

-- 3.	How many Products reside in each SubCategory? Write a query to display the results with the following titles.
-- ProductSubcategoryID CountedProducts
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID;

-- 4.	How many products that do not have a product subcategory. 
SELECT COUNT(ProductSubcategoryID) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

-- 5.	Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity) AS 'sum of quantity' FROM Production.ProductInventory;

-- 6.	 Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
--               ProductID    TheSum
SELECT ProductID, Quantity As TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity < 100;

-- 7.	Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
-- Shelf      ProductID    TheSum
SELECT TOP 100 * 
FROM Production.ProductInventory
WHERE LocationID = 40;

-- 8.	Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT AVG(Quantity) FROM Production.ProductInventory
WHERE LocationID = 10;

-- 9.	Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
-- ProductID   Shelf      TheAvg
SELECT ProductID, Shelf, AVG(Quantity) AS 'average quantity'
FROM Production.ProductInventory
GROUP BY ProductID, Shelf
ORDER BY ProductID; 

-- 10.	Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
-- ProductID   Shelf      TheAvg
SELECT ProductID, Shelf, AVG(Quantity) AS 'average quantity'
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf
ORDER BY ProductID; 

-- 11.	List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
-- Color           	Class 	TheCount   	 AvgPrice
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS [AvgPrice]
FROM Production.Product
WHERE Color IS NOT NULL
	AND Class IS NOT NULL
GROUP BY Color, Class;

-- 12.	  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following. 
-- Country                        Province
SELECT cr.Name AS Country, sp.Name AS Province FROM Person.CountryRegion cr, Person.StateProvince sp;

-- 13.	Write a query that lists the country and province names from person.CountryRegion and person.StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
-- Country                        Province
SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr
JOIN Person.StateProvince sp ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name NOT IN ('Germany', 'Canada');

-- Using Northwnd Database: (Use aliases for all the Joins)
-- 14.	List all Products that has been sold at least once in last 25 years.
USE Northwind
GO

SELECT DISTINCT p.ProductName FROM dbo.Orders o 
JOIN dbo.[Order Details] d ON o.OrderID = d.OrderID 
JOIN dbo.Products p ON d.ProductID = p.ProductID 
ORDER BY 1;

-- 15.	List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 c.PostalCode 
FROM dbo.Customers c 
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.PostalCode 
ORDER BY COUNT(*) DESC;

-- 16.	List top 5 locations (Zip Code) where the products sold most in last 25 years.
SELECT TOP 5 c.PostalCode, YEAR(o.OrderDate)
FROM dbo.Customers c 
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) BETWEEN 2016 AND 2021
GROUP BY c.PostalCode, YEAR(o.OrderDate)
ORDER BY COUNT(*) DESC;

-- 17.	 List all city names and number of customers in that city.    
SELECT City, COUNT(*) AS [Number of Customers] FROM dbo.Customers GROUP BY City

-- 18.	List city names which have more than 2 customers, and number of customers in that city 
SELECT City, COUNT(*) AS [Number of Customers]
FROM dbo.Customers GROUP BY City
HAVING COUNT(*) > 2;

-- 19.	List the names of customers who placed orders after 1/1/98 with order date.
SELECT c.CompanyName, o.OrderDate
FROM dbo.Customers c
LEFT JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) >= 1998

-- 20.	List the names of all customers with most recent order dates 
SELECT c.CompanyName
FROM dbo.Customers c
LEFT JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC;

-- 21.	Display the names of all customers  along with the  count of products they bought 
SELECT c.CompanyName, COUNT(d.Quantity) AS [the count of products they bought]
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN dbo.[Order Details] d ON d.OrderID = o.OrderID
GROUP BY c.CompanyName
ORDER BY 2 DESC;
 
-- 22.	Display the customer ids who bought more than 100 Products with count of products.
SELECT c.CustomerID, COUNT(d.Quantity) AS [the count of products they bought]
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN dbo.[Order Details] d ON d.OrderID = o.OrderID
GROUP BY c.CustomerID
HAVING COUNT(d.Quantity) > 100
ORDER BY 2 DESC;

-- 23.	List all of the possible ways that suppliers can ship their products. Display the results as below
-- Supplier Company Name   	Shipping Company Name
SELECT p.CompanyName AS [Supplier Company Name], l.CompanyName AS [Shipping Company Name]
FROM dbo.Shippers p, dbo.Suppliers l;

-- 24.	Display the products order each day. Show Order date and Product Name.
SELECT * FROM dbo.Products
SELECT * FROM dbo.Orders
SELECT * FROM dbo.[Order Details]

SELECT p.ProductName, o.OrderDate AS [Order date]
FROM dbo.Products p
JOIN dbo.[Order Details] d ON p.ProductID = d.ProductID
JOIN dbo.Orders o ON o.OrderID = d.OrderID
GROUP BY o.OrderDate, p.ProductName
ORDER BY o.OrderDate;


-- 25.	Displays pairs of employees who have the same job title.
SELECT e1.FirstName + ' ' + e1.LastName As Name1, e2.FirstName + ' ' + e2.LastName AS Name2
FROM dbo.Employees e1
JOIN dbo.Employees e2 ON e1.Title = e2.Title
WHERE e1.FirstName + ' ' + e1.LastName != e2.FirstName + ' ' + e2.LastName
ORDER BY 1, 2;

-- 26.	Display all the Managers who have more than 2 employees reporting to them.
SELECT e1.FirstName + ' ' + e1.LastName As Manager
FROM dbo.Employees e1
LEFT JOIN dbo.Employees e2 ON e1.EmployeeID = e2.ReportsTo
GROUP BY e1.FirstName + ' ' + e1.LastName
HAVING COUNT(*) > 2
ORDER BY 1;

-- 27.	Display the customers and suppliers by city. The results should have the following columns
-- City 
-- Name 
-- Contact Name,
-- Type (Customer or Supplier)
SELECT City, CompanyName AS Name, ContactName AS [Contact Name], 'Customer' AS Type
FROM dbo.Customers
UNION
SELECT City, CompanyName AS Name, ContactName AS [Contact Name], 'Supplier' AS Type
FROM dbo.Suppliers
