CREATE TABLE zTemp (
	id			INT,
	fName		varchar(40),
	lName		varchar(40),
	exam1		INT,
	exam2		INT,
	exam3		INT,
	exam4		INT,
	exam5		INT	
) 
GO

-- What fixes did you have to make to the file?

--id 21 had a missing exam (added an exam grade)
--id 25 had an extra exam (removed the last one) 
--id 57 had an extra tab between exams (removed the extra tab)
--id 74 had an extra tab between exams (removed the extra tab)
--id 969 had an extra tab between exams (removed the extra tab)
--id 981 had an extra tab between exams (removed the extra tab)

BULK INSERT zTemp
FROM 'C:\temp\Lab-05_DataProcessing-SECTION-D.txt'
--rules for bulk insert
WITH (
	FIRSTROW = 2, --Not 0 based
	FIELDTERMINATOR = '\t', --Delimiter for each col is tab
	ROWTERMINATOR = '\n', --Delimiter for each row is enter
	TABLOCK --locks the table from insertions somewhere else
)
GO

--Query 1
SELECT	fName, 
		lName, 
		[Average] = (exam1 + exam2 + exam3 + exam4 + exam5) / 5,
		CASE	WHEN ((exam1 + exam2 + exam3 + exam4 + exam5) / 5) >= 90 THEN 'A'
				WHEN ((exam1 + exam2 + exam3 + exam4 + exam5) / 5) >= 80 THEN 'B'
				WHEN ((exam1 + exam2 + exam3 + exam4 + exam5) / 5) >= 70 THEN 'C'
				WHEN ((exam1 + exam2 + exam3 + exam4 + exam5) / 5) >= 60 THEN 'D'
				ELSE 'F'
				END AS [Grade]
FROM zTemp
GO


--Query 2

WITH tblAvg (fName, lName, Average)
AS (
	SELECT	fName,
			lName,
			[Average] = (sum(exam1) + sum(exam2) + sum(exam3) + sum(exam4)
						 + sum(exam5)) / 5
	FROM zTemp
	GROUP BY fName, lName, exam1, exam2, exam3, exam4, exam5
)

SELECT	fName, 
		lName, 
		CASE	
		WHEN	((exam1 + exam2 + exam3 + exam4 + exam5) / 5) > (
		SELECT AVG(Average) FROM tblAvg)
				THEN 'Above'
		WHEN	((exam1 + exam2 + exam3 + exam4 + exam5) / 5) = (
		SELECT AVG(Average) FROM tblAvg)
				THEN 'Average' 
				ELSE 'Below'
				END AS [Standing]
FROM zTemp
GO


--Query 3
SELECT	fName, 
		lName, 
		[Average] = ((exam1 + exam2 + exam3 + exam4 + exam5) / 5)
FROM zTemp
GROUP BY fName, lName, exam1, exam2, exam3, exam4, exam5
ORDER BY ((exam1 + exam2 + exam3 + exam4 + exam5) / 5) DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY
GO

DROP TABLE zTEMP
GO
