SELECT	InvoiceID, 
		VendorID,
		InvoiceTotal,
		InvoiceTotal - PaymentTotal + CreditTotal AS [BalanceDue]
		/* [BalanceDue = InvoiceTotal - PaymentTotal + CreditTotal] */

FROM Invoices

/* Can't say WHERE BalanceDue > 0, because it actually doesn't exist yet */
WHERE (InvoiceTotal - PaymentTotal + CreditTotal) > 0

ORDER BY VendorID, BalanceDue

