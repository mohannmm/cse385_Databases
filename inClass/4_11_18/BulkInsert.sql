CREATE TABLE zTemp (
	id			INT,
	fName		varchar(40),
	lName		varchar(40),
	email		varchar(40)	
) 
GO

BULK INSERT zTemp
FROM 'C:\temp\BulkInsertTest.txt'
--rules for bulk insert
WITH (
	FIRSTROW = 2, --Not 0 based
	FIELDTERMINATOR = '\t', --Delimiter for each col is tab
	ROWTERMINATOR = '\n', --Delimiter for each row is enter
	TABLOCK --locks the table from insertions somewhere else
)
GO

SELECT *
FROM zTemp
GO

DROP TABLE zTEMP
GO
