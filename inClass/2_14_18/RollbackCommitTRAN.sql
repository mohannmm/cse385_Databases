-- Use a transaction to create a temporary backup. Rollback to revert, commit to lock in changes
BEGIN TRAN
	
	--Updating
	UPDATE tblFriends
	SET phoneNumber
	SELECT * FROM tblFriends

	--Deleting
	DELETE FROM tblFriends 
	--vs--
	TRUNCATE TABLE tblFriends

	--Inserting
	INSERT INTO tblFriends (firstName, lastName, age, phoneNumber)
	VALUES ('Jack', 'Box', 99, '000-000-0000')

-- ROLLBACK TRAN
-- COMMIT TRAN