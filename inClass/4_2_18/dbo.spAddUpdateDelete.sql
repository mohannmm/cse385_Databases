CREATE PROCEDURE [dbo].[spAddUpdateDelete_Invoice]
	
	@InvoiceID			INT,          
	@VendorID			INT,          
	@InvoiceNumber		VARCHAR (50),
	@InvoiceDate		SMALLDATETIME,
	@InvoiceTotal		MONEY,        
	@PaymentTotal		MONEY,        
	@CreditTotal		MONEY,        
	@TermsID			INT,          
	@InvoiceDueDate		SMALLDATETIME,
	@PaymentDate		SMALLDATETIME,
	@IsDeleted			BIT,
	@HardDelete			BIT = 0
	 
AS	          

	BEGIN TRAN
		
		BEGIN TRY
			--delete	
			IF(@HardDelete = 1) BEGIN
				DELETE FROM InvoiceLineItems WHERE InvoiceID = @InvoiceID
				DELETE FROM Invoices WHERE InvoiceID = @InvoiceID
				SELECT [InvoiceID] = 0, [ErrorCode] = 0, [ErrorMsg] = ''
		
			END
			--add (in this case, we have decided that an invoiceID = 0 means we should add it)
			ELSE IF(@InvoiceID = 0) BEGIN
				IF(	(EXISTS SELECT NULL FROM Vendors WHERE VendorID = @VendorID) AND
					(EXISTS SELECT NULL FROM Terms WHERE TermsID = @TermsID) AND
					(NOT EXISTS SELECT NULL FROM Invoices WHERE InvoiceNUmber = @InvoiceNumber)) BEGIN
						INSERT INTO Invoices(
								InvoiceID,		VendorID,		InvoiceNumber,
								InvoiceDate,	InvoiceTotal,	PaymentTotal,
								CreditTotal,	TermsID,		InvoiceDueDate,	
								PaymentDate,	IsDeleted,		HardDelete	)
						
						Values(
							@InvoiceID		
							,@VendorID		
							,@InvoiceNumber	
							,@InvoiceDate	
							,@InvoiceTotal	
							,@PaymentTotal	
							,@CreditTotal	
							,@TermsID		
							,@InvoiceDueDate	
							,@PaymentDate	
							,0		
						
						)						
					SELECT [InvoiceID] = @@IDENTITY, [ErrorCode] = 0, [ErrorMsg] = ''
				END ELSE BEGIN
					SELECT [InvoiceID] = 0, [ErrorCode] = 1, [ErrorMsg] = 'Dup Invoice number or VendorID not found, or TermsID not found'
				END

			END ELSE IF(@InvoiceID > 0) BEGIN
				SELECT [InvoiceID] = @InvoiceID, [ErrorCode] = 1, [ErrorMsg] = 'Dup Invoice number or VendorID not found, or TermsID not found'
			END
		
		END TRY
		
		BEGIN CATCH

			IF (@@TRANCOUNT > 0) ROLLBACK TRAN
			EXEC spRecordError

		END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN
