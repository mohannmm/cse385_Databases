--General procedure that records an error in the ErrorLog table

CREATE PROCEDURE [dbo].[spRecordError]

AS

	BEGIN TRY
		
		INSERT INTO ErrorLog(	ERROR_NUMBER, ERROR_SEVERITY, 
								ERROR_STATE, ERROR_PROCEDURE, 
								ERROR_LINE, ERROR_MESSAGE
							)  			

			SELECT	ERROR_NUMBER(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE()

	END TRY 

	BEGIN CATCH
	END CATCH
