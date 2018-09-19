SELECT
		v.VendorID,
		v.VendorName,
		v.VendorCity,
		v.VendorState,
		i.InvoiceNumber,
		i.Balance,
		ili.InvoiceLineItemDescription,
		ili.InvoiceLineItemAmount

FROM Vendors v
	JOIN vwInvoices i
		ON v.VendorID = i.VendorID
	JOIN InvoiceLineItems ili
		ON i.InvoiceID = ili.InvoiceID
		
ORDER BY v.VendorName, i.InvoiceNumber

-- Because only ILI desc. and amount are the only unique fields, lets create a hash table of a vendor id, and add the unique fields to it an array inside that hash table