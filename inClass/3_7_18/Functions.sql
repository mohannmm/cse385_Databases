/*
SELECT	COUNT(InvoiceTotal)			AS [cntI], --Count of rows, excluding fields that contain nulls
		COUNT(PaymentDate)			AS [cntP],
		COUNT(DISTINCT PaymentDate)	AS [cntDP],
		SUM(InvoiceTotal)			AS [sum],
		AVG(InvoiceTotal)			AS [avg],
		MIN(InvoiceTotal)			AS [min],
		MAX(InvoiceTotal)			AS [max]
FROM Invoices
*/


/*
SELECT	VendorID, --Can group by multiple fields
		PaymentDate,
		COUNT(*)			AS [cnt],
		SUM(InvoiceTotal)	AS [sum],
		AVG(InvoiceTotal)	AS [avg],
		SUM(BalanceDue)		AS [balanceSum]
FROM vwInvoices
GROUP BY VendorID, PaymentDate
ORDER BY VendorID
*/



/*
SELECT	VendorID,
		COUNT(*)			AS [cnt],
		SUM(InvoiceTotal)	AS [sum],
		AVG(InvoiceTotal)	AS [avg],
		SUM(BalanceDue)		AS [balanceSum]
FROM vwInvoices
WHERE BalanceDue > 0 -- Should not use here if you have an average. WHERE happens before grouping
GROUP BY VendorID

HAVING SUM(BalanceDue) > 500 --Use having two filter out the second table created by group by
ORDER BY [balanceSum]
*/


/*
SELECT	VendorID,
		SUM(BalanceDue)		AS [balanceSum]
FROM vwInvoices
WHERE BalanceDue > 50
GROUP BY VendorID
HAVING SUM(BalanceDue) > 0
ORDER BY VendorID
*/



--ALL Invoices after 2015-09-01
--Return count, count of any amount paid invoices, average, min, max, sum of all invoices afer that date

SELECT	VendorID,
		COUNT(*)				AS [cnt],
		COUNT(PaymentDate)		AS [cntPd],
		AVG(InvoiceTotal)		AS [avgTotal],
		SUM(InvoiceTotal)		AS [sumTotal]

FROM Invoices
WHERE InvoiceDate > '2015-09-01'
GROUP BY VendorID
HAVING SUM(InvoiceTotal) > 5000
ORDER BY VendorID



--Count of invoices and sum of all invoices by state/city
SELECT	VendorState, VendorCity,
		COUNT(*) AS [cnt],
		SUM(InvoiceTotal) AS [sum]

FROM Vendors v
	JOIN Invoices i
		ON (v.VendorID = i.InvoiceID)
GROUP BY VendorState, VendorCity
ORDER BY VendorState, VendorCity



SELECT	*
FROM Invoices