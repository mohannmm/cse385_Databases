DECLARE @tbl TABLE (
	tableName VARCHAR(20),
	tableType VARCHAR(20)

)

DECLARE @tableName VARCHAR(20)
DECLARE @tableType VARCHAR(20)

--Declare a cursor variable. A cursor variable is differnet than a variable
DECLARE tableCursor CURSOR FOR 
	SELECT TABLE_NAME, TABLE_TYPE

	--Tells all the info about the tables in a DB
	FROM INFORMATION_SCHEMA.TABLES

OPEN tableCursor

	FETCH NEXT FROM tableCursor INTO @tableName, @tableType
	WHILE @@FETCH_STATUS = 0 BEGIN
		INSERT INTO @tbl(tableName, tableType)
		VALUES (@tableName, @tableType)

		FETCH NEXT FROM tableCursor INTO @tableName, @tableType --Keep fetching untl status = 0, then we have no more data to fetch from
	END

CLOSE tableCursor
DEALLOCATE tableCursor --Very important so as not to lose memory

-- Temporary table VARIABLE. A temp table would create a real table, this just 
-- creates a variable which is only local to the procedure call
SELECT * FROM @tbl
DELETE @tbl