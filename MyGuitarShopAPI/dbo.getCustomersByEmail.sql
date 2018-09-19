CREATE PROCEDURE [dbo].[spGetCustomersByEmail]
	@email varchar(10)
AS
	SELECT * FROM Customers WHERE EmailAddress LIKE '%' + @email + ''
