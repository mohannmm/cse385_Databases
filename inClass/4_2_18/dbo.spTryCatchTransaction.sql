-- *** We want to create a new table to fill with error messages ***

CREATE PROCEDURE [dbo].[spTryCatchTransaction]

AS

	BEGIN TRAN
		BEGIN TRY
			SELECT 1/0 --Generates an error
		END TRY

	
		BEGIN CATCH
			IF @@TRANCOUNT > 0 ROLLBACK --Asks if there is a tran started, then decrease TRANCOUNT by 1
			
			EXEC spRecordError

		END CATCH
	IF @@TRANCOUNT > 0 COMMIT TRAN

