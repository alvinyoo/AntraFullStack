-------------Assignment 3--------------------------------------

--1 Joins is preferred because perforemce is high.

--2 A CTE is temperory view. We can use CTE for recursive queries. We can also use CTE if the scope of a table is very limited.

--3.A table variable is a data type that can be used within a Transact-SQL batch, stored procedure, or function�and is 
created and defined similarly to a table, only with a strictly defined lifetime scope. 
The lifetime of the table variable only lasts for the duration of the batch, function, or stored procedure 
Table variables will be created in temp db.

--4.Delete will keep all deleted rows in log while truncate permenently delets records. Truncate will have more performence.

--5.Identity column is autogenerated column in a table. Identity column will will not get reset to initial value incase of delete but truncate will reset value to its initial value.

--6
/*The DELETE command is used to remove rows from a table. A WHERE clause can be used to only remove some rows. 
If no WHERE condition is specified, all rows will be removed. After performing a DELETE operation you need to COMMIT or 
ROLLBACK the transaction to make the change permanent or to undo it. Note that this operation will cause all DELETE triggers on the table to fire.*/
/*TRUNCATE removes all rows from a table. The operation cannot be rolled back and no triggers will be fired. As such, 
TRUCATE is faster and doesn't use as much undo space as a DELETE.*/


*/

---1
select distinct city from Customers where city in (select city from Employees)
---2
select distinct city  from Customers 
where City not in (select distinct city from employees where city is not null)

select distinct city from Customers  
except 
select distinct city from Employees

---3
select ProductID,SUM(Quantity) as QunatityOrdered from [order details]
group by ProductID

--4
select city,sum(Quantity) as TotalQty from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
group by city

--5
--a 
select city from Customers
except
select city from customers
group by city
having COUNT(*)=1
union 
select city from customers
group by city
having COUNT(*)=0

--b
select city from customers group by city having COUNT(*)>=2

--6
select distinct city from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
group by city
having COUNT(*)>=2

--7
select distinct c.CustomerID from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
where City <> ShipCity

--8
select top 5 ProductID,AVG(UnitPrice) as AvgPrice,(select top 1 City from Customers c join Orders o on o.CustomerID=c.CustomerID join [Order Details] od2 on od2.OrderID=o.OrderID where od2.ProductID=od1.ProductID group by city order by SUM(Quantity) desc) as City from [Order Details] od1
group by ProductID 
order by sum(Quantity) desc

--9
--a
select distinct City from Employees where city not in (select ShipCity from Orders where ShipCity is not null)

--b
select distinct City from Employees where City is not null except (select ShipCity from Orders where ShipCity is not null)

--10

select (select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by COUNT(*) desc) as MostOrderedCity,
(select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by sum(Quantity) desc) as MostQunatitySoldCity

--11 use group by and count(*), if count(*)>1 then delete the rows using sub query

--12 select empid from Employee except select mgrid from Employee

--13 select deptid from employee group by deptid having count(*) = (select top 1 count(*) from employee group by deptid order by count(*) desc)
--14 select top 3 deptname,empid,salary from employee e join dep d on e.deptid=d.deptid order by salary,deptname,empid desc


