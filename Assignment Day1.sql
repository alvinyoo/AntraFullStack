 -- Assignment Day1 - SQL: Comprehensive practice
 
 USE AdventureWorks2019
 GO

 -- 1. Write a query that restrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter
 SELECT ProductID, Name, Color, ListPrice
 FROM Production.Product;

 -- 2. Write a query that restrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows taht ListPrice is 0
 SELECT ProductID, Name, Color, ListPrice
 FROM Production.Product
 WHERE ListPrice != 0;

 -- 3. Write a query that restrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column
 SELECT ProductID, Name, Color, ListPrice
 FROM Production.Product
 WHERE Color IS NULL;

 -- 4. Write a query that restrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that ae not NULL for the Color column
 SELECT ProductID, Name, Color, ListPrice
 FROM Production.Product
 WHERE Color IS NOT NULL;

 -- 5. Write a query that restrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that ae not NULL for the Color column, and the column ListPrice has a value greater than zero
 SELECT ProductID, Name, Color, ListPrice
 FROM Production.Product
 WHERE Color IS NOT NULL AND ListPrice > 0;

 -- 6. Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows taht are null for color
 SELECT Name + ' ' + Color AS 'Name And Color'
 FROM Production.Product
 WHERE Color IS NOT NULL;

 -- 7. Write a query that generates the following results set from Production.Product 
 --			Name And Color
 --			---------------------------------------
 --			NAME: LL Crankarm  --  COLOR: Black
 --			NAME: ML Crankarm  --  COLOR: Black
 --			NAME: HL Crankarm  --  COLOR: Black
 --			NAME: Chainring Bolts  --  COLOR: Silver
 --			NAME: Chainring Nut  --  COLOR: Silver
 --			NAME: Chainring  --  COLOR: Black
 SELECT 'NAME: ' + Name + ' -- ' + 'COLOR: ' + Color AS 'Name And Color'
 FROM Production.Product
 WHERE Name IS NOT NULL AND Color IS NOT NULL;

 -- 8. Write a query to retrive the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
 SELECT ProductID, Name
 FROM Production.Product
 WHERE ProductID BETWEEN 400 AND 500;

 -- 9. Write a query to retrive the columns ProductID, Name and Color from the Production.Product table restricted to the colors black and blue
 SELECT ProductID, Name, Color
 FROM Production.Product
 WHERE Color IN('Black', 'Blue');

 -- 10. Write a query to get a result set on products that begins with the letter S
 SELECT * FROM Production.Product
 WHERE Name LIKE 'S%';

 -- 11. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the serult set by the Name column
 --            Name                      ListPrice
 --       ----------------------------------------
 --       Seat Lug                           0,00
 --       Seat Post                          0,00
 --       Seat Stays                         0,00
 --       Seat Tube                          0,00
 --       Short-Sleeve Classic Jersy, L      53,99
 --       Short-Sleeve Classic Jersy, M      53,99
 SELECT Name, ListPrice
 FROM Production.Product
 ORDER BY 1;

 -- 12. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the serult set by the Name column. The products name should start with either 'A' or 'S'
 --            Name                      ListPrice
 --       ----------------------------------------
 --       Adjustable Race                    0,00
 --       All-Purpose Bike Stand            159,00
 --       AWC Logo Cap                       8,00
 --       Seat Lug                           0,00
 --       Seat Post                          0,00
 SELECT Name, ListPrice
 FROM Production.Product
 WHERE Name LIKE '[A, S]%'
 ORDER BY 1;

 -- 13. Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the Letter K. After this zero or more letters can exist. Order the result ser by the Name column.
 SELECT * FROM Production.Product
 WHERE Name Like 'SPO%' AND Name NOT LIKE '____K%'
 ORDER BY 1;

 -- 14. Write a query the retrieves unique colors from the table Productions.Product. Order the result in descending manner
 SELECT DISTINCT Color
 FROM Production.Product
 ORDER BY 1 DESC;

 -- 15. Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Producyion.Product table. Format and sort so the result set accordingly to the following:
 --     We do not want any rows that are NULL in any of the two columns in the results
 SELECT  DISTINCT ProductSubcategoryID, Color
 FROM Production.Product
 WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL;
