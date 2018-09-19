
SELECT InvoiceNumber, VendorName
FROM Vendors
	JOIN Invoices ON
		(Vendors.VendorID = Invoices.VendorID)

WHERE Invoices.InvoiceTotal > 200



-- Selecting from views and table and joining
SELECT InvoiceNumber, VendorName, v.VendorID

FROM Vendors AS v		-- Correlation names, NOT RENAMING COLS
	JOIN vwInvoices AS i ON
		(v.VendorID = i.VendorID)

WHERE i.BalanceDue > 200
ORDER BY i.BalanceDue --ORDER BY VendorName



-- Explicit

SELECT	v.VendorName, 
		c.CustLastName, 
		c.CustFirstName,
		[State] = v.VendorState, 
		[City] = v.VendorCity

FROM Vendors v -- Optional to say : Vendors AS v
	JOIN ProductOrders..Customers AS c ON
		(v.VendorZipCode = c.CustZip)

ORDER BY [State], [City]


-- Implicit

SELECT	v.VendorName, 
		[State] = v.VendorState, 
		[City] = v.VendorCity

FROM	Vendors v, -- Optional to say : Vendors AS v
		Invoices as i
WHERE (v.VendorID = i.VendorID)
ORDER BY [State], City


---- Example......


-- Excplicit
SELECT v.VendorName, i.InvoiceNumber, Balance

FROM Vendors v
	JOIN vwInvoices i ON 
		(v.VendorID = i.VendorID)
WHERE Balance > 0


-- Implicit
SELECT v.VendorName, i.InvoiceNumber, BalanceDue

FROM Vendors v, vwInvoices i 		
WHERE (v.VendorID = i.VendorID) AND BalanceDue > 0

