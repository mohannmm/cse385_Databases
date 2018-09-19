/*
SELECT

VendorName,
[CountOfInvoices] = COUNT(*),
SumOfBalance = SUM(Balance)

FROM Vendors v JOIN vwInvoices i
	ON v.VendorID = i.VendorID
GROUP BY VendorName
HAVING (SUM(Balance) > 0) AND (Count(*) > 2)
*/

/*
SELECT

v.VendorName,
i.InvoiceNumber,
li.InvoiceLineItemDescription,
li.InvoiceLineItemAmount,
[SumOfBalance] = SUM(i.Balance)
COUNT(*) AS NumOfLine -- Remember to group by all fields so you don't leave out any unique fields

FROM Vendors v 
	JOIN vwInvoices i
		ON v.VendorID = i .VendorID	
	JOIN InvoiceLineItems li
		ON i.InvoiceID = li.InvoiceID
GROUP BY v.VendorName, i.InvoiceNumber, li.InvoiceLineItemDescription, li.InvoiceLineItemAmount
	HAVING SUM(i.Balance) > 0
*/




/*
SELECT
v.VendorState,
v.VendorCity,
[InvoiceSum] = SUM(i.InvoiceTotal),
[InvoicesQty] = COUNT(*),
[InvoiceAvg] = AVG(i.InvoiceTotal)

FROM vwInvoices i JOIN Vendors v
	ON i.VendorID = v.VendorID

GROUP BY VendorCity, VendorState
HAVING COUNT(*) > 1 -- InvoicesQty > 1
-- Also, remember count will not count nulls

*/




-------
-- if sum(balance) = 0 return 'Good Standing'
-- if sum(balance) > 0 and countofInvoices > 3 return 'Overdue'
-- if sum(balance) < 0 return 'We owe you money'
-- else return 'You owe us money but few invoices'
-------
-- if sum(balance) < 1000 return 'Low' ELSE return 'high'


--Creates temporary table for this query
WITH [tblData] AS (
	SELECT
	VendorID,
	[CountOfInvoices] = COUNT(*),
	[SumOfBalance] = SUM(Balance),
	[Standing] = 
		CASE
			WHEN SUM(Balance) < 0 THEN 'We owe you money'
			WHEN SUM(Balance) = 0 THEN 'GOOD Standing'
			WHEN COUNT(*) > 3 THEN 'Overdue'
			ELSE 'You owe us money, but few invoices' 
		END,
	[Level] = IIF(SUM(Balance) < 1000, 'Low', 'High')


	FROM vwInvoices

	GROUP BY VendorID
) SELECT
	v.VendorName,
	t.*

FROM Vendors v JOIN tblData t
	ON v.VendorID = t.VendorID
WHERE t.Standing = 'Overdue'