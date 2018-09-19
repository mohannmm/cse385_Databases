-- Marcellus Mohanna
-- CSE 385
-- HW4


-- Q1: Returns 34 Records
SELECT	VendorID,
		[PaymentSum] = SUM(PaymentTotal)
FROM Invoices
GROUP BY VendorID


-- Q2: Returns 10 Records
SELECT	TOP(10) 
		v.VendorName,
		[PaymentSum] = SUM(i.PaymentTotal)
FROM Invoices i
	JOIN Vendors v ON v.VendorID = i.VendorID
GROUP BY v.VendorName
ORDER BY [PaymentSum] DESC

-- Q3: Returns 34 Records
SELECT	v.VendorName,
		[InvoiceCount] = COUNT(v.VendorID),
		[InvoiceSum] = SUM(i.InvoiceTotal)
FROM Invoices i
	JOIN Vendors v ON v.VendorID = i.VendorID
GROUP BY v.VendorName
ORDER BY [InvoiceCount] DESC


-- Q4: Returns 10 Records
SELECT	gla.AccountDescription,
		[LineItemCount] = COUNT(li.AccountNo),
		[LineItemSum] = SUM(li.InvoiceLineItemAmount)

FROM InvoiceLineItems li
	JOIN GLAccounts gla ON li.AccountNo = gla.AccountNo
GROUP BY gla.AccountDescription
HAVING COUNT(li.AccountNo) > 1
ORDER BY [LineItemCount] DESC



-- Q5: Returns 10 Records
SELECT	gla.AccountDescription,
		[LineItemCount] = COUNT(li.AccountNo),
		[LineItemSum] = SUM(li.InvoiceLineItemAmount)
		--[InvoiceDate] = i.InvoiceDate

FROM InvoiceLineItems li
	JOIN GLAccounts gla ON li.AccountNo = gla.AccountNo
	JOIN Invoices i ON li.InvoiceID = i.InvoiceID
		AND i.InvoiceDate > '12/1/2015 12:00:00 AM' AND i.InvoiceDate < '2/29/2016 12:00:00 AM'
GROUP BY gla.AccountDescription
HAVING COUNT(li.AccountNo) > 1 
	

-- Q6: Returns 22 Records
SELECT	AccountNo,
		[LineItemSum] = SUM(InvoiceLineItemAmount)

FROM InvoiceLineItems
GROUP BY AccountNo WITH ROLLUP


-- Q7: Returns 37 Records
SELECT	v.VendorName,
		gla.AccountDescription,
		[LineItemCount] = COUNT(li.AccountNo),
		[LineItemSum] = SUM(li.InvoiceLineItemAmount)

FROM Vendors v
	JOIN Invoices i ON i.VendorID = v.VendorID
	JOIN InvoiceLineItems li ON li.InvoiceID = i.InvoiceID
	JOIN GLAccounts gla ON gla.AccountNo = li.AccountNo
GROUP BY v.VendorName, gla.AccountNo, gla.AccountDescription
ORDER BY v.VendorName, gla.AccountDescription


-- Q8: Returns 2 Records
SELECT	v.VendorName,
		[TotalAccounts] = COUNT(DISTINCT li.AccountNo)

FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID
	JOIN InvoiceLineItems li ON li.InvoiceID = i.InvoiceID
GROUP BY v.VendorName
HAVING COUNT(DISTINCT li.AccountNo) > 1
