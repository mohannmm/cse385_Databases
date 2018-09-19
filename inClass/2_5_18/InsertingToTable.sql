SELECT * FROM tblFriends

SET IDENTITY_INSERT tblFriends ON
INSERT INTO tblFriends (friendID, firstName, lastName, age, phoneNumber)
VALUES 
	(9,'bo','Nickal',20,'555-222-2222'),
	(10,'John','tara',500,'543-234-2123')

SET IDENTITY_INSERT tblFriends OFF

SELECT * FROM tblFriends
