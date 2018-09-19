CREATE VIEW [dbo].[vwInvoices] AS
 
	SELECT *, [BalanceDue] = (InvoiceTotal - PaymentTotal - CreditTotal)
	FROM [Invoices]
	WHERE isDeleted = 0
