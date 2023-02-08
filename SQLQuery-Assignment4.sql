use northwind

/*1. Create a stored procedure in the Northwind database that will calculate the average
value of Freight for a specified customer.Then, a business rule will be added that will
be triggered before every Update and Insert command in the Orders controller,and
will use the stored procedure to verify that the Freight does not exceed the average
freight. If it does, a message will be displayed and the command will be cancelled.*/


Alter Procedure spCalculateAvgFreight
	@CustomerID nchar(10),
	@AvgFreight money out
as
Begin
	Select @AvgFreight = avg(Freight) 
	From Orders
	Where CustomerID = @CustomerID
End


--Trigger for before update and insert
Alter Trigger check_freight
ON Orders
Instead of Insert, Update
as
Begin
	Declare @Avg money
	Declare @CustomerId nchar(10)
	Declare @OrderId int

	Select @CustomerId = CustomerID
	From inserted

	Exec spCalculateAvgFreight  @CustomerId, @Avg out

	Declare @Freight money
	Select @Freight = Freight from inserted
	if(@Freight > @Avg)
	Begin
		Print cast(@Freight as varchar) + ' is greater than ' + cast(@Avg as varchar) + ' so Command is cancelled and Data is not Inserted Or Updated'
		Return
	End

	Select @OrderID = OrderID
	From inserted

	IF EXISTS(SELECT 1 FROM Orders
          WHERE OrderID = @OrderId)
		BEGIN
				UPDATE Orders 
				SET Orders.Freight = (select freight from inserted)
				Where OrderID =@OrderId

				print 'Data Updated Successfully'
		END
	
	ELSE
		BEGIN
			INSERT INTO "Orders"
				("CustomerID","EmployeeID","OrderDate","RequiredDate",
				"ShippedDate","ShipVia","Freight","ShipName","ShipAddress",
				"ShipCity","ShipRegion","ShipPostalCode","ShipCountry")
			SELECT CustomerID,EmployeeID,OrderDate,RequiredDate,
				ShippedDate,ShipVia,Freight,ShipName,ShipAddress,
				ShipCity,ShipRegion,ShipPostalCode,ShipCountry
				FROM inserted
		END
End

INSERT INTO "Orders"
("CustomerID","EmployeeID","OrderDate","RequiredDate",
	"ShippedDate","ShipVia","Freight","ShipName","ShipAddress",
	"ShipCity","ShipRegion","ShipPostalCode","ShipCountry")
VALUES (N'VINET',1,'7/4/1996','8/1/1996','7/16/1996',3,10,
	N'Vins et alcools Chevalier',N'59 rue de l''Abbaye',N'Reims',
	NULL,N'51100',N'France')

UPDATE Orders
Set Freight=34
Where OrderID = 10248

select * from orders where OrderID = 10248


/*2. write a SQL query to Create Stored procedure in the Northwind database to retrieve
Employee Sales by Country*/
Create Procedure spSalesByCountry
AS
BEGIN
	Select Subtotal.OrderID, [Sale amount Per Order],e.EmployeeID,e.FirstName,e.LastName,Country
	From Orders o
	Inner JOIN
	(Select OrderID,Sum(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) [Sale amount Per Order]
	FROM "Order Details"
	GROUP BY "Order Details".OrderID) Subtotal
	ON Subtotal.OrderID = o.OrderID
	Inner JOIN Employees e
	ON e.EmployeeID = o.EmployeeID
END

spSalesByCountry





/*3. write a SQL query to Create Stored procedure in the Northwind database to retrieve
Sales by Year*/
Create Procedure spSalesByYear
AS
BEGIN
	Select Orders.OrderID ,Subtotal.[Sale amount Per Order] ,YEAR(Orders.ShippedDate) [Year]
	From Orders
	INNER JOIN
	(Select OrderID,Sum(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) [Sale amount Per Order]
	FROM "Order Details"
	GROUP BY "Order Details".OrderID) Subtotal
	ON Orders.OrderID = Subtotal.OrderID
END

EXEC spSalesByYear


/*4. write a SQL query to Create Stored procedure in the Northwind database to retrieve
Sales By Category*/
Alter Procedure  SaleByCategory
	@Category nvarchar(30)
As
BEGIN
	Select p.ProductName,Sum(CONVERT(money,(od.UnitPrice*Quantity*(1-Discount)/100))*100)
	From Categories c
	INNER JOIN Products p
	ON p.CategoryID = c.CategoryID
	INNER JOIN [Order Details] od
	ON p.ProductID = od.ProductID
	Where c.CategoryName = @Category
	Group By p.ProductName
	
END

SaleByCategory Beverages


/*5. write a SQL query to Create Stored procedure in the Northwind database to retrieve
Ten Most Expensive Products*/
Create Procedure spGetTop10MostExpensive
As
Begin
	Select Top 10 p.ProductName, p.UnitPrice
	From Products p
	order by p.UnitPrice DESC
End

spGetTop10MostExpensive

/*6. write a SQL query to Create Stored procedure in the Northwind database to insert
Customer Order Details*/
Create Procedure InsertData
@OrderID int ,
@ProductID int,
@UnitPrice Money,
@Quantity int,
@Discount Real

As 
Begin
	Insert Into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
	VALUES (@OrderID,@ProductID,ROUND(@UnitPrice,2),@Quantity,@Discount)
End

EXEC InsertData
@OrderID=10247,
@ProductID=10,
@UnitPrice=25.00,
@Quantity=8,
@Discount=0


/*7. write a SQL query to Create Stored procedure in the Northwind database to Update
Customer Order Details*/
Alter Procedure UpdateData
@OrderID int ,
@ProductID int,
@UnitPrice Money,
@Quantity int,
@Discount Real

As 
Begin
	Update [Order Details]
	Set  UnitPrice = ROUND(@UnitPrice,2),Quantity = @Quantity, Discount = @Discount
	Where OrderID = @OrderID AND ProductID = @ProductID
End

EXEC UpdateData
@OrderID=10448,
@ProductID=10,
@UnitPrice=25.00,
@Quantity=8,
@Discount=0.15

	

