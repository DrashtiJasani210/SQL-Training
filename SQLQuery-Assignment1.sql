/*1. Write a query to get a Product list (id, name, unit price) where current products cost
less than $20.*/
select ProductID, ProductName, UnitPrice from Products where UnitPrice<20

/*2. Write a query to get Product list (id, name, unit price) where products cost between
$15 and $25*/
select ProductID, ProductName, UnitPrice from Products where UnitPrice between 15 and 25

/*3. Write a query to get Product list (name, unit price) of above average price.*/
select ProductName, UnitPrice from Products where UnitPrice>(select avg(UnitPrice) from Products)

/*4. Write a query to get Product list (name, unit price) of ten most expensive products*/
select top 10 ProductName, UnitPrice from Products order by UnitPrice desc

/*5. Write a query to count current and discontinued products*/
select sum(UnitsInStock) as 'current & discontinued' from Products where discontinued=1 and UnitsInStock<>0

/*6. Write a query to get Product list (name, units on order , units in stock) of stock is less
than the quantity on order*/
select ProductName, UnitsOnOrder, UnitsInStock from Products where UnitsInStock<UnitsOnOrder


select * from Products