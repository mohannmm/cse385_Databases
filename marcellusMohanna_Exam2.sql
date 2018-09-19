-- Q1--
USE master
GO

IF DB_ID('Exam2') IS NOT NULL
	DROP DATABASE Exam2
GO

CREATE DATABASE Exam2
GO 

USE Exam2
GO

-- Q2 --
CREATE TABLE tblUsers(
	userId INT PRIMARY KEY IDENTITY,
	firstName VARCHAR(50),
	lastName VARCHAR(50),
	email VARCHAR(50),
	password VARCHAR(50)
)
GO

CREATE TABLE tblWorkouts(
	workOutId INT PRIMARY KEY IDENTITY,
	userId INT FOREIGN KEY REFERENCES tblUsers(userId),
	runDate DATETIME DEFAULT(GETDATE()),
	totalMiles INT
)
GO

CREATE TABLE tblErrors(
	errorLogId INT PRIMARY KEY IDENTITY,
	ERROR_NUMBER INT,
	ERROR_LINE INT,
	ERROR_PROCEDURE VARCHAR(50),
	ERROR_MESSAGE VARCHAR(2000),
	errorDate DATETIME DEFAULT(GETDATE())
)
GO

CREATE PROCEDURE [dbo].[spRecordError]
AS
	BEGIN TRY
		INSERT INTO tblErrors(ERROR_NUMBER, ERROR_LINE, ERROR_PROCEDURE, ERROR_MESSAGE)  			

			SELECT	ERROR_NUMBER(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE()
	END TRY 
	BEGIN CATCH
	END CATCH
GO


-- Q3 --
BEGIN TRAN
	BEGIN TRY
		BULK INSERT tblUsers
		FROM 'C:\temp\users.txt'

		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = '\t',
			ROWTERMINATOR = '\n',
			TABLOCK 
		)
	END TRY
	BEGIN CATCH
		IF (@@TRANCOUNT > 0) ROLLBACK TRAN
			EXEC spRecordError
	END CATCH
IF (@@TRANCOUNT > 0) COMMIT TRAN
GO

BEGIN TRAN
	BEGIN TRY
		BULK INSERT tblWorkouts
		FROM 'C:\temp\rundata.txt'

		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = '\t',
			ROWTERMINATOR = '\n',
			TABLOCK 
		)
	END TRY
	BEGIN CATCH
		IF (@@TRANCOUNT > 0) ROLLBACK TRAN
			EXEC spRecordError
	END CATCH
IF (@@TRANCOUNT > 0) COMMIT TRAN
GO

-- Q4 --
DECLARE @xml XML = 
	'<records>
			<workouts>
				<add>
					<record userId="1" date="2018-1-1" miles="4" />
					<record userId="1" date="2018-1-2" miles="5" />
					<record userId="1" date="2018-1-4" miles="9" />
					<record userId="1" date="2018-1-5" miles="1" />
					<record userId="4" date="2018-12-14" miles="5" />
				</add>
			</workouts>
			<users>
				<passwordUpdate>
					<record userId="20" newPassword="Ex@m-2" />
				</passwordUpdate>
				<delete>
					<record userId="2" />
					<record userId="3" />
					<record userId="4" />
				</delete>
			</users>
	</records>'

------------------------------------- add ------------------------------------
INSERT INTO tblWorkouts(userId, runDate, totalMiles)

SELECT u, d, m
FROM (
	SELECT	[u] = parent.value('@userId','INT'),
			[d] = parent.value('@date','DATETIME'),
			[m] = parent.value('@miles','INT') 
	FROM @xml.nodes('/records/workouts/add/record') AS parent(parent)
) tbl

WHERE NOT EXISTS (SELECT NULL FROM tblWorkouts WHERE userId = tbl.u AND runDate = tbl.d AND totalMiles = tbl.m)

SELECT * FROM tblWorkouts


------------------------------------- update ------------------------------------
UPDATE tblUsers
SET password=tbl.pwd

FROM (
SELECT
		[id] = parent.value('@userId','INT'),
		[pwd] = parent.value('@newPassword','VARCHAR(50)')

FROM @xml.nodes('/records/users/passwordUpdate/record') AS parent(parent)

) tbl

WHERE userId = tbl.id
SELECT * FROM tblUsers


------------------------------------- delete ------------------------------------
DELETE FROM tblUsers

FROM (
		SELECT [id] = parent.value('@userId','INT')
		FROM @XML.nodes('/records/users/delete/record') AS parent(parent)

) tbl

WHERE userId = tbl.id AND NOT EXISTS (SELECT NULL FROM tblWorkouts tw WHERE userId = tw.userId)
SELECT * FROM tblUsers
GO


-- Q5 --
SELECT	w.userId,
		[Name] = u.firstName + ' '+u.lastName,
		[Total] = SUM(w.totalMiles),
		[RunCount] = COUNT(w.userId)

FROM tblWorkouts w
	JOIN tblUsers u ON w.userId = u.userId
GROUP BY w.userId, u.firstName, u.lastName
ORDER BY u.lastName, u.firstName
GO

-- Q6 --
SELECT	*
FROM tblWorkouts w
WHERE NOT EXISTS(SELECT * FROM tblUsers u WHERE w.userId = u.userId)
GO

-- Q7 --
CREATE VIEW vwView AS (
	SELECT		u.userID,
				u.firstName, 
				u.lastName,
				[runYear] = YEAR(w.runDate),
				[totalMilesRun] = SUM(w.totalMiles)
	FROM tblUsers u
		JOIN tblWorkouts w ON u.userId = w.userId
	GROUP BY u.userId, u.firstName, u.lastName, w.runDate
)
GO
SELECT * FROM vwView


-- Q8 --

SELECT *

FROM 

(SELECT userID
FROM vwView
GROUP BY userID
HAVING COUNT(userId) > 1
)AS tbl