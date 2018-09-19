/*
SELECT	VendorName,
		ISNULL(VendorAddress1, '') AS [Address1], 
		ISNULL(VendorAddress2, '') AS [Address2]
FROM Vendors
*/

-- This is a comment line

/*	--Can check if null
SELECT	VendorName + '''s address is: ' +
		ISNULL(VendorAddress1, '') + ' ' + 
		ISNULL(VendorAddress2, '') + ' ' +
		VendorCity + ', ' + VendorState + ' ' +
		VendorZipCode
FROM Vendors

*/


/*	--Doing math is the same
SELECT InvoiceId, [Q] = InvoiceID%10

FROM Invoices

ORDER BY InvoiceID
*/



/*	-- Prints first initial and last name
SELECT	VendorID,
		[Contact] = LEFT(VendorContactFName, 1) + '.' + VendorContactLName

FROM Vendors
*/


SELECT * 
FROM Invoices
WHERE InvoiceDate BETWEEN '2016-01-01' AND '2016-05-31'