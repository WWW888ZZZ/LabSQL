
----------------- PART 1--------------------------
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID = 'ALFKI'


BEGIN TRANSACTION 

INSERT INTO Orders (CustomerID, EmployeeID , OrderDate, RequiredDate ,Freight)
VALUES ('ALFKI',1,GETDATE(),DATEADD(DAY,7,GETDATE()), 50.00)

SELECT SCOPE_IDENTITY() AS NewOrderID

INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11078,ProductID,UnitPrice,2,0 FROM Products
WHERE ProductID = 1

SELECT * FROM Orders
WHERE OrderID = 11078

SELECT * FROM [Order Details]
WHERE OrderID = 11078

COMMIT

-------------------------------PART 2-------------------------------------------

BEGIN TRANSACTION 

INSERT INTO Orders (CustomerID, EmployeeID , OrderDate, RequiredDate ,Freight)
VALUES ('ALFKI',1,GETDATE(),DATEADD(DAY,7,GETDATE()), 75.00)

SELECT SCOPE_IDENTITY() AS RollbackOrderID

INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079,ProductID,UnitPrice,2,0 FROM Products
WHERE ProductID = 2

SELECT * FROM Orders
WHERE OrderID = 11079

SELECT * FROM [Order Details]
WHERE OrderID = 11079

ROllBACK