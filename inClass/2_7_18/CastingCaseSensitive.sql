
--This Query is NOT case sensitive
SELECT * 
FROM Users
WHERE	UserName = 'langelo0' And 
		Password = '0ke2oMrG8w' 


--This Query is IS case sensitive 
SELECT * 
FROM Users
WHERE	UserName = 'langelo0' And 
		CAST(Password AS VARBINARY(100)) = CAST('0ke2oMrG8w' AS VARBINARY(100)) 


--This Query is IS case sensitive (Only works for NVARCHAR)  
SELECT * 
FROM Users
WHERE	UserName = 'langelo0' And 
		Password Collate Latin1_General_CS_AS = '0ke2oMrG8w' 