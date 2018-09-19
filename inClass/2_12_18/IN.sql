/*
SELECT *, [NullPhoneNumber] = ISNULL(VendorPhone,'') 
FROM Vendors

-- WHERE VendorID IN (89,121,123)

--SUBQUERY
WHERE -- VendorPhone IS NOT NULL AND
VendorID IN(
SELECT VendorID
FROM Invoices
WHERE InvoiceDate = '2015-12-24'
)
*/



/*
SELECT *, [Balance] = (InvoiceTotal -PaymentTotal -CreditTotal)
FROM Invoices
-- Can't do this -- WHERE [Balance] BETWEEN 200 AND 500
WHERE (InvoiceTotal -PaymentTotal - CreditTotal) BETWEEN 200 AND 500
--WHERE (InvoiceTotal -PaymentTotal - CreditTotal) NOT BETWEEN 200 AND 500
ORDER BY [Balance]
*/




/*
SELECT *

FROM Vendors

-- WHERE LEFT(VendorState,1) = 'N'
-- WHERE VendorState LIKE 'N%'	Same thing, but LIKE is faster

-- WHERE VendorState LIKE 'N%' -- Anything that starts with N
-- WHERE VendorState LIKE 'N[A-J]%' -- Anything that starts with N and between A-J
-- WHERE VendorContactLName LIKE 'DAMI[EO]N' -- Can be E or O
-- WHERE VendorContactLName LIKE 'DAMI[^EO]N'-- Cannot be E or O 

-- _ Only one letter wildcard, than anything after er -- WHERE VendorName LIKE 'Compu_er%'
-- Can have anything after u -- WHERE VendorName LIKE 'Compu%er'
*/


/*
-- Paging
SELECT *

FROM Vendors

ORDER BY VendorState, VendorCity, VendorName
	OFFSET 0 ROWS -- Offset is what is incremented
	FETCH  NEXT 10 ROWS ONLY
	*/


	-- using a view
SELECT	VendorId, 
		InvoiceNumber, 
		BalanceDue
FROM vwInvoices
WHERE BalanceDue > 0
ORDER BY VendorID

--UPDATE Invoices SET isDeleted = 1 WHERE InvoiceNumber = '39104' -- manually "delete" this invoice