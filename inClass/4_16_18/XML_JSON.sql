SELECT	TOP(3)
		v.VendorID,
		v.VendorName,
		v.VendorCity,
		v.VendorState,
		[Invoices] = (
			SELECT 
					i.InvoiceNumber,
					i.Balance,
					[Items] = (
						SELECT
							[Amount] = ili.InvoiceLineItemAmount,
							[Description] = ili.InvoiceLineItemDescription

							FROM InvoiceLineItems ili
							WHERE i.InvoiceID = ili.InvoiceID
							FOR JSON PATH
					)

			FROM vwInvoices i
			WHERE v.VendorID = i.VendorID 
			FOR JSON PATH
		)

FROM Vendors v
WHERE v.VendorID IN (SELECT VendorID FROM Invoices) --Makes sure we only see vendors with invoices
FOR JSON PATH, ROOT('Vendors')