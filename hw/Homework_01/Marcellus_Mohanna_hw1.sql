-- Q1: Returns 122 Records

SELECT	VendorContactFName,
		VendorContactLName,
		VendorName  
FROM	Vendors

ORDER BY VendorContactLName, VendorContactFName
 

-- Q2: Returns 114 Records each

SELECT	InvoiceNumber									AS	[NUMBER],
		InvoiceTotal									AS	[Total],		
		(PaymentTotal + CreditTotal)					AS	[Credits],	
		(InvoiceTotal - (PaymentTotal + CreditTotal))	AS	[Balance]

FROM	Invoices  

-- Q3: Returns 122 Records

SELECT	(VendorContactFName + ', ' + VendorContactLName)	AS	[FullName] 

FROM	Vendors
 
ORDER BY VendorContactLName, VendorContactFName

-- Q4: Returns 2 Records

 SELECT	InvoiceTotal,
		(InvoiceTotal * 0.1)	AS	[10%],
		(InvoiceTotal * 1.1)	AS	[PLUS10%]

 FROM	Invoices

 WHERE	(InvoiceTotal - (PaymentTotal + CreditTotal)) > 1000	--Balance due > 1000
 
 ORDER BY InvoiceTotal DESC

-- Q5: Returns 33 Records

SELECT	InvoiceNumber									AS	[NUMBER],
		InvoiceTotal									AS	[Total],		
		(PaymentTotal + CreditTotal)					AS	[Credits],	
		(InvoiceTotal - (PaymentTotal + CreditTotal))	AS	[Balance]

FROM	Invoices  

WHERE	InvoiceTotal >= 500 AND InvoiceTotal <= 10000
 

-- Q6: Returns 41 Records

SELECT	(VendorContactFName + ', ' + VendorContactLName)	AS	[FullName] 

FROM	Vendors
 
WHERE	LEFT(VendorContactLName, 1) IN ('A','B','C','E')
		
ORDER BY VendorContactLName, VendorContactFName


-- Q7: Returns 0 Records

SELECT	*

FROM	Invoices

--Checking for invalids. Invalid if:
	-- 1. Balance due AND PaymentDate is not null
	-- 2. Balance not due AND PaymentDate is null

WHERE	(InvoiceTotal - (PaymentTotal + CreditTotal) != 0)	AND (ISNULL(PaymentDate,'') != '')
		OR
		(InvoiceTotal - (PaymentTotal + CreditTotal) = 0)	AND (ISNULL(PaymentDate,'') = '')
