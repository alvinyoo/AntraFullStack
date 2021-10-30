-- Assignment Day4 - SQL: Comprehensive practice

---- Answer these questions:
/**
-- 1.	What is View? What are the benefits of using views?
VIEW is a Virtual table that reference to data from one or multiple tables. It does bot hold any data and does not exist phisically in the database. Similar to a
regular table, the VIEW name should be unique in a database. In a VIEW, we can also cntrol user security for accessing the data from the database tables. We can allow
users to get the data from the VIEW, and the users does not require permission for each table or column to fetch data.
Benefits:
	1) VIEW can represent a subset of the data contained in a table. Consequently, a VIEW can limit the degree of exposure of the underlying tables to the outer world:
	   a given user may have permission to query the VIEW, while denied access to the rest of the data table.
	2) VIEW can join and simplify mutiple tables into a single virtual table.
	3) VIEW can act as aggregated table. Where the database engine aggregates data (SUM, AVERAGE, etc.) and presents the calculated results as part of the data.
	4) VIEW can hide the complexity of data. For example, a VIEW could appear as Salse2000 or Salse2001, transparently partitioning the underlying table.
	5) VIEW takes very little space to store, the database contains only the definition of a VIEW, not a copy of all data that it presents.
	6) Depending on the SQL engine used, VIEW can provide extra security. 
	
-- 2.	Can data be modified through views?
Yes, users can modify the actual table from where the VIEW is referencing or edited the VIEW itself. Either way, the data in actual table will be modified.
But there is read-only VIEW which will not allow users to update or insert data into read-only VIEW.

-- 3.	What is stored procedure and what are the benefits of using it?
Stored procedure is a prepared SQL query, we can save and reuse it over and over again.

-- 4.	What is the difference between view and stored procedure?
VIEW is a virtual table which contains data. Stored procedure is a block of SQL code.

-- 5.	What is the difference between stored procedure and functions?
It is a option for stored procedure to return a value, but function must return a value. Functions can have only input parameters for it whereas Procedures can have 
input or output parameters. Functions can be called from Procedure but Procedures cannot be called from a function.

-- 6.	Can stored procedure return multiple result sets?
Yes

-- 7.	Can stored procedure be executed as part of SELECT Statement? Why?
No, stored procedure relies on "EXEC stroed_procedure_name". SELECT cannot call stored procedure.

-- 8.	What is Trigger? What types of Triggers are there?


-- 9.	What is the difference between Trigger and Stored Procedure?

**/

---- Write queries for following scenarios
-- Use Northwind database. All questions are based on assumptions described by the Database Diagram sent to you yesterday.
-- When inserting, make up info if necessary. Write query for each step. Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.
USE Northwind
GO

-- 1.	Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
CREATE VIEW view_product_order_Yao
AS
SELECT p.ProductName, SUM(d.Quantity) AS [Total Quantity]
FROM dbo.Products p
RIGHT JOIN dbo.[Order Details] d
ON p.ProductID = d.ProductID
GROUP BY p.ProductName;

-- 2.	Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
CREATE PROC sp_product_order_quantity_Yao
@product_id INT,
@total_quantities INT OUTPUT
AS
BEGIN
	SELECT @total_quantities = SUM(Quantity)
	FROM dbo.[Order Details]
	WHERE ProductID = @product_id
	GROUP BY ProductID
END

-- 3.	Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities that ordered most that product
-- combined with the total quantity of that product ordered from that city as output.
CREATE PROC sp_product_order_city_Yao
@product_name VARCHAR(20),
@cities VARCHAR(20) OUTPUT,
@total_quantities INT OUTPUT
AS
BEGIN
	SELECT TOP 5 @cities = City, @total_quantities = SUM(Quantity)
	FROM dbo.Customers c
	JOIN dbo.Orders o
	ON c.CustomerID = o.CustomerID
	JOIN dbo.[Order Details] d
	ON o.OrderID = d.OrderID
	JOIN dbo.Products p
	ON p.ProductID = d.ProductID
	WHERE p.ProductName = @product_name
	GROUP BY City
	ORDER BY SUM(Quantity) DESC
END;

-- 4.	Create 2 new tables “people_your_last_name” “city_your_last_name”. City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}.
-- People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}.
CREATE TABLE city_Yao(
Id INT PRIMARY KEY,
City VARCHAR(20) NOT NULL) ;

CREATE TABLE people_Yao(
Id INT PRIMARY KEY,
Name VARCHAR(20),
City INT FOREIGN KEY REFERENCES city_Yao(Id));

INSERT INTO people_Yao
VALUES (1, 'Aaron Rodgers', 2),
       (2, 'Russell Wilson', 1),
	   (3, 'Jody Nelson', 2);

INSERT INTO city_Yao
VALUES (1, 'Seattle'),
       (2, 'Green Bay');
	   
SELECT * FROM city_Yao;
SELECT * FROM people_Yao;

-- Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”.
UPDATE city_Yao
SET City = 'Madison' WHERE City = 'Seattle';

-- Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.
CREATE VIEW Packers_Alvin
AS
SELECT p.Name
FROM city_Yao c
JOIN people_Yao p
ON c.Id = p.City
WHERE c.City = 'Green Bay';

-- 5.	 Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and fill it with
-- all employees that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.
CREATE PROC sp_birthday_employees_Yao
AS
BEGIN
	SELECT
	FROM 
END

-- 6.	How do you make sure two tables have the same data?
-- By using the EXCEPT dunction, if the result is empty, that means they are the same.

-- 7.        --------------------------------------
--           |First Name | Last Name | Middle Name|
--           |   John	 |   Green   |            |
--           |   Mike    |   White   |      M     |
--           --------------------------------------
-- Output should be     ---------------
--                      |  Full Name  |
--                      | John Green  |
--                      |Mike White M.|
--                      ---------------
-- Note: There is a dot after M when you output.
SELECT [First Name] + ' ' + [Last Name] + ' ' + [Middle Name] + '.'
FROM StrangTable;

-- 8.         -----------------------
--            | Student	Marks	Sex |
--            |   Ci	 70      F  |
--            |   Bob	 80      M  |
--            |   Li	 90      F  |
--            |   Mi	 95      M  |
--            -----------------------
-- Find the top marks of Female students.
-- If there are tow students have the max score, only output one.
SELECT MAX(Marks)
FORM MarkTable
WHERE Sex = 'F';

-- 9.         -----------------------
--            |Student	Marks	Sex |
--            |  Li      90      F  |
--            |  Ci      70      F  |
--            |  Mi      95      M  |
--            |  Bob     80      M  |
--            -----------------------
-- How do you out put this?
SELECT * 
FROM MarkTable
ORDER BY Sex, Marks;
