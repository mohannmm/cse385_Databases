CREATE PROCEDURE [dbo].[spAddTerm]
	@TermsDescription VARCHAR(50) = 0,
	@TermsDueDays SMALLINT
AS
	--Must account for duplicates
IF NOT EXISTS (	SELECT	NULL -- Accounts for duplicates
				FROM	TERMS
				WHERE	TermsDescription = @TermsDescription AND
						TermsDueDays = @TermsDueDays) BEGIN	

	INSERT INTO Terms (TermsDescription, TermsDueDays)
	VALUES (@TermsDescription, @TermsDueDays)



	-- Can return a single value, or use a select statement and select the desired return value
-- RETURN @@IDENTITY	--Returns unique id of the row

--Other way
SELECT @@IDENTITY AS NEWID
RETURN --Prevents the second SELECT
END

--RETURN 0
SELECT 0 AS NEWID -- this line executes when there was an attempt to add duplicate
