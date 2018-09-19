SELECT 
	[OneBigColomn] = 'Invoice #: ' + InvoiceNumber + 
	'InvoiceDate: ' + CONVERT(char(8), InvoiceDate, 1) + 
	'Today is: ' + CAST( CAST(GETDATE() AS DATE) AS varchar(15) )+ 
	'PaymentTotal: ' + CAST(PaymentTotal AS varchar(15)),
	[UTCTimeOffset] = SYSDATETIMEOFFSET()

FROM INVOICES