--Lab ในชั้นเรียนวันที่  6 สิงหาคม 2569
--ใช้ ฐานข้อมูล Northwind เพื่อ Query ข้อมูลต่อไปนี้

--1.ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ที่อยู่ในเมือง London
SELECT TitleOfCourtesy, FirstName, LastName, City
FROM Employees 
WHERE City = 'London';

--2.ข้อมูล รหัสสินค้า ชื่อสินค้า ราคา จำนวน ของสินค้าที่มีจำนวนน้อยกว่า 30
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock < 30;

--3.รหัสลูกค้า ชื่อบริษัท เบอร์โทรศัพท์ ของลูกค้าที่อยู่ในประเทศต่อไปนี้ 
--    Sweden, Germany, France, Spain, UK
SELECT CustomerID,CompanyName, Phone, Country
FROM Customers
WHERE Country IN ('Sweden','Germany','France','Spain','UK');

--4.ข้อมูลลูกค้าที่ไม่มีหมายเลขโทรสาร (Fax) 
SELECT * FROM Customers
WHERE fax is Null

--5.ข้อมูลสินค้าที่มีจำนวนสินค้าต่ำกว่าจุดสั่งซื้อ และ มีจำนวนที่สั่งซื้อแล้ว 
SELECT * 
FROM Products 
WHERE UnitsInStock < ReorderLevel AND UnitsOnOrder > 0;

--6.ชื่อ นามสกุล พนักงานที่เข้าทำงานในปี 1992 
SELECT FirstName, LastName, HireDate
FROM Employees
WHERE YEAR(HireDate) = 1992;

--7.ต้องการข้อมูลสินค้าที่มีราคาตั้งแต่ 20-70
SELECT * FROM Products
WHERE UnitPrice Between 20 and 70

--8.ข้อมูลลูกค้าที่มีชื่อบริษัทขึ้นต้นด้วย S และอยู่ประเทศ Mexico
SELECT * FROM Customers
WHERE CompanyName LIKE 'S%' AND Country = 'Mexico';

--Aggregate Function (หรือเรียกว่า Group Function)
-- เป็น Function ที่คำนวณมาจากข้อมูลหลายแถว

SELECT TOP(5) * FROM Products

SELECT Count(*) as จำนวนชนิด, Max(UnitPrice) as ราคาสูงสุด, Min(UnitPrice) as ราคาต่ำสุด, Avg(UnitPrice) as คาราเฉลี่ย, Sum(UnitsInStock) จำนวนรวมทั้งหมด
FROM Products

-- ต้องการทราบว่าสินค้าแต่ละหมวดหมู่(CategoryID) มีสินค้ากี่ชนิด แต่ละชนิดมีราคาเฉลี่ย มีราคาสูงสุด และต่ำสุด
SELECT CategoryID, Count(*) จำนวนชนิด , avg(UnitPrice) ราคาเฉลี่ย, Max(UnitPrice) ราคาสูงสุด, Min(UnitPrice) ราคาต่ำสุด
FROM Products
Group by CategoryID

--ต้องการทราบ ข้อมูลว่าแต่ในละประเทศ (Country) มีลูกค้าอยู่กี่ราย
SELECT Country,City, Count(*) จำนวนลูกค้า 
FROM Customers
Group by Country , City
Order by Country ASC , count(*) DESC
--order by Count(*) desc
--Order by 3 DESC

--ต้องการทราบ ข้อมูลว่าแต่ในละประเทศ (Country) แสดงเฉพาะที่มีจำนวนลูกค้า 10 รายขึ้นไป
SELECT Country, Count(*) จำนวนลูกค้า 
FROM Customers
Group by Country 
Having Count(*) >= 10


--ต้องการทราบว่า สินค้าที่มีมูลค่าสูง (ตั้งแต่ราคา 75 ขึ้นไป) แต่ละหมวดหมู๋มีจำนวนกี่ชนิด มีราคาเฉลี่ยเท่าไหร่
--ให้แสดงเฉพาะสินค้าที่มีราคาสูงกว่าค่าเฉลี่ย
SELECT CategoryID, Count(*) จำนวนชนิด , Avg(UnitPrice) ราคาเฉลี่ย 
FROM Products
WHERE UnitPrice >= 75
GROUP BY CategoryID
HAVING avg(UnitPrice) > 200

-- จากตาราง [Order Details] ให้รวบรวมว่าแต่ละในการสั่งซื้อ มียอดเงินรวมเท่าไหร่
SELECT OrderID, UnitPrice, Quantity , Discount, 
	   UnitPrice * Quantity ราคาเต็ม, 
	   UnitPrice * Quantity * Discount ส่วนลด,
	   (UnitPrice * Quantity) - (UnitPrice * Quantity * Discount) ราคาหักส่วนลด, 
	   (UnitPrice * Quantity) * (1 - Discount) ราคาหักส่วนลดสูตร2
FROM [Order Details]

SELECT OrderID, COUNT(*) จำวนวรายการ,
		SUM((UnitPrice * Quantity * (1-Discount))) ยอดเงินรวม
FROM [Order Details]
Group by OrderID
Having SUM((UnitPrice * Quantity * (1-Discount))) >= 1000
Order by 3 DESC