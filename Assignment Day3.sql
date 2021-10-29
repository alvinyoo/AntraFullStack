-- Assignment Day1 - SQL: Comprehensive practice

---- Answer these questions:
-- 1. In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
-- I prefer to use the JOIN, since they both will get the same result but JOIN will cost less resouce than subqueries.

-- 2. What is CTE and when to use it?
-- CTE means common table expression and for use only within the context of a larger query

-- 3. What are Table Variables? What is their scope and where are they created in SQL Server?
-- The 'Table Variables' refers to a variable type is table. A table variable behaves like a local variable. It has a well-defined scope.
-- This variable can be used in the function, stored procedure, or batch in which it's declared.

-- 4. What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
-- Truncate removes all records and doesn't fire triggers. Truncate is faster compared to delete as it makes less use of the transaction log.

-- (**) 5. What is Identity column? How does DELETE and TRUNCATE affect it?


-- (**) 6. What is difference between “delete from table_name” and “truncate table table_name”?



---- Write queries for following scenarios
-- All scenarios are based on Database NORTHWND.
USE Northwind
GO

-- 1.	List all cities that have both Employees and Customers.
SELECT DISTINCT c.City
FROM dbo.Customers c
JOIN dbo.Employees e ON c.City = e.City;

-- 2.	List all cities that have Customers but no Employee.
-- a.	Use sub-query
SELECT DISTINCT City FROM dbo.Customers
WHERE City NOT IN
(
SELECT City FROM dbo.Employees
);

-- b.	Do not use sub-query
SELECT DISTINCT c.City 
FROM dbo.Customers c
FULL JOIN dbo.Employees e ON c.City = e.City
WHERE e.City IS NULL;

-- 3.	List all products and their total order quantities throughout all orders.
SELECT ProductName, dt.[total order quantities]
FROM dbo.Products p
LEFT JOIN (
SELECT d.ProductID, SUM(d.Quantity) AS [total order quantities]
FROM dbo.[Order Details] d
LEFT JOIN dbo.Orders o ON d.OrderID = o.OrderID
GROUP BY d.ProductID) dt
ON p.ProductID = dt.ProductID
ORDER BY 1;

-- 4.	List all Customer Cities and total products ordered by that city.
SELECT c.City, SUM(dt1.Quantity) AS [total products ordered]
FROM dbo.Customers c
LEFT JOIN (
SELECT o.OrderID, o.CustomerID, d.ProductID, d.Quantity
FROM dbo.Orders o
JOIN dbo.[Order Details] d ON o.OrderID = d.OrderID) dt1
ON c.CustomerID = dt1.CustomerID
GROUP BY c.City
ORDER BY 1;

-- 5.	List all Customer Cities that have at least two customers.
-- (**) a.	Use union
SELECT * FROM dbo.Products
SELECT * FROM dbo.Orders
SELECT * FROM dbo.[Order Details]
SELECT * FROM dbo.Customers

-- b.	Use sub-query and no union
SELECT dt.City
FROM (
SELECT c1.City, COUNT(c1.CustomerID) [have customers]
FROM dbo.Customers c1
GROUP BY c1.City
HAVING COUNT(c1.CustomerID) >= 2) dt
ORDER BY 1;

-- 6.	List all Customer Cities that have ordered at least two different kinds of products.
SELECT dt3.City
FROM
(SELECT dt2.City, COUNT(dt2.ProductID) AS cnt
FROM(
SELECT dt.ProductID, c.City
FROM (
SELECT o.CustomerID, d.ProductID
FROM dbo.[Order Details] d
JOIN dbo.Orders o ON o.OrderID = d.OrderID) dt
JOIN dbo.Customers c ON c.CustomerID = dt.CustomerID) dt2
GROUP BY dt2.City
HAVING COUNT(dt2.ProductID) >= 2) dt3;

-- 7.	List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT * FROM dbo.Products
SELECT * FROM dbo.Orders
SELECT * FROM dbo.[Order Details]
SELECT * FROM dbo.Customers

-- find out all customers city(customers) and all ship city(orders) -- customerid(order)
SELECT dt.CompanyName
FROM (
SELECT c.CompanyName, o.ShipCity, c.City
FROM dbo.Orders o
JOIN dbo.Customers c ON c.CustomerID = o.CustomerID) dt
WHERE dt.City != dt.City;

-- 8.	List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
-- Assume the 'most popular' as the most quantity
SELECT p.ProductName, dt2.ProductID, dt2.City
FROM (
SELECT dt.ProductID, dt.[average price], c.City
FROM (
SELECT TOP 5 d.ProductID, SUM(d.Quantity) AS [Total Quantities], (d.UnitPrice * (1 - d.Discount)) AS [average price], o.CustomerID
FROM dbo.[Order Details] d
LEFT JOIN dbo.Orders o ON o.OrderID = d.OrderID
GROUP BY ProductID, o.CustomerID, (d.UnitPrice * (1 - d.Discount))
ORDER BY 2 DESC) dt, dbo.Customers c
WHERE dt.CustomerID = c.CustomerID) dt2, dbo.Products p
WHERE p.ProductID = dt2.ProductID


-- find out all customers city and all ship city -- 

-- 9.	List all cities that have never ordered something but we have employees there.
-- a.	Use sub-query
SELECT DISTINCT e.City
FROM dbo.Employees e
WHERE City NOT IN (
SELECT DISTINCT o.ShipCity
FROM dbo.Orders o);

-- b.	Do not use sub-query
SELECT DISTINCT e.City
FROM dbo.Employees e
LEFT JOIN dbo.Orders o
ON o.ShipCity = e.City
WHERE o.ShipCity IS NULL;

-- (**) 10.	List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
SELECT dt2.City
FROM (
SELECT c.City, COUNT(o.OrderID) AS cnt
FROM dbo.Orders o, dbo.Customers c
WHERE c.CustomerID = o.CustomerID
GROUP BY c.City) dt2
JOIN (
SELECT c.City, SUM(dt1.Quantity) AS smr
FROM dbo.Customers c, (
SELECT o.CustomerID, d.Quantity
FROM dbo.[Order Details] d, dbo.Orders o
WHERE d.OrderID = o.OrderID) dt1
WHERE c.CustomerID = dt1.CustomerID
GROUP BY c.City) dt3
ON dt2.City = dt3.City

-- 11. How do you remove the duplicates record of a table?
-- By using GROUP BY statement

-- 12. Sample table to be used for solutions below- Employee (empid integer, mgrid integer, deptid integer, salary money) Dept (deptid integer, deptname varchar(20))
-- Find employees who do not manage anybody.
WITH Hierachy
AS
(
SELECT e.empid, e.mgrid, e.deptid, e.salary, 1 lv
FROM Employee e
WHERE mgrid IS NULL
UNION ALL
SELECT e.empid, e.mgrid, e.deptid, e.salary, cte lv + 1
FROM Employee e INNER JOIN Hierachy cte ON e.mgrid = cte.empid
)

SELECT empid FROM Hierachy WHERE lv = MAX(lv);

-- 13. Find departments that have maximum number of employees. (solution should consider scenario having more than 1 departments that have maximum number of employees). Result should only have - deptname, count of employees sorted by deptname.
SELECT dt.deptname, dt.COUNT(e.deptid) AS [count of employees]
FROM
(
SELECT d.deptname, COUNT(e.deptid)
FROM Employees e, Dept d
WHERE e.deptid = d.deptid
GROUP BY d.deptname
) dt
WHERE [count of employees] = (MAX(dt.COUNT(e.deptid))

-- (**) 14. Find top 3 employees (salary based) in every department. Result should have deptname, empid, salary sorted by deptname and then employee with high to low salary.
