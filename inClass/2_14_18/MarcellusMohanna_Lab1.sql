-- Question 1,  10 Records
SELECT 
ProductCode, ProductName, ListPrice, DiscountPercent

FROM Products
ORDER BY ListPrice DESC, DiscountPercent ASC

-- Question 2,  392 Records
SELECT
[FullName] = LastName +', '+ FirstName

FROM Customers
WHERE LastName LIKE '[^H-L]%'
ORDER BY LastName, FirstName

-- Question 3,  5 Records

SELECT 
ProductName, ListPrice, DateAdded

FROM Products
WHERE ListPrice > 500 AND ListPrice < 2000
ORDER BY DateAdded


-- Question 4,  10 Records

SELECT
ProductName, 
ListPrice, 
DiscountPercent, 
[DiscountAmount] = (DiscountPercent/100.0 * ListPrice),
[DiscountPrice] = (ListPrice - (DiscountPercent/100.0) * ListPrice)

FROM Products
ORDER BY ListPrice - (ListPrice - (DiscountPercent/100.0) * ListPrice) DESC


-- Question 5,  1 Records

SELECT
ItemId, 
ItemPrice, 
DiscountAmount, 
Quantity,
[PriceTotal] = ItemPrice * Quantity,
[DiscountTotal] = DiscountAmount * Quantity,
[ItemTotal] = (ItemPrice - DiscountAmount) * Quantity

FROM OrderItems
WHERE (ItemPrice - DiscountAmount) * Quantity > 500
ORDER BY (ItemPrice - DiscountAmount) * Quantity DESC

-- Question 6,  26 Records

SELECT
OrderID, OrderDate, ShipDate

FROM Orders
WHERE ShipDate IS NOT NULL AND CardType = 'Visa'

-- Question 7,  1 Records

SELECT
[Price] = 100,
[TaxRate] = .07,
[TaxAmount] = 100 * .07,
[Total] = 100 + (100 *.07)


-- Question 8,  ? Records (NOT FINISHED)

CREATE TABLE Employees (
EmployeeID		int				PRIMARY KEY		IDENTITY,	
EmployeeName	varchar(30),
Salary			float,
Hourly			bit,
PartTime		bit				DEFAULT 0,
WorkDays		varchar(30),	DEFAULT '',
HomePhone		varchar(10)
);

-- Question 9,  ? Records (NOT FINISHED)
SELECT
FROM Employees
WHERE ('Mon','Wed','Fri') IN (WorkDays)

-- Question 10,  ? Records (NOT FINISHED)

INSERT INTO Employees

Salary = Salary *1.12

WHERE PartTime = 0 AND Hourly = 0