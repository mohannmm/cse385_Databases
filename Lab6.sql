CREATE PROCEDURE [dbo].[spAddUpdateDeleteCustomersByXML]
@XML XML
AS
SET @XML =	'
			<Records>
				<AddNoConflict EmailAddress = "email@gmail.com" Password = "abc123" FirstName = "Jon" LastName ="Doe" ShippingAddressID = "138" BillingAddressID = "45">
				</AddNoConflict>
				
				<AddConflict EmailAddress = "marge@gmail.com" Password = "1111" FirstName = "Jo" LastName ="smo" ShippingAddressID = "138" BillingAddressID = "45">
				</AddConflict>

				<UpdateNoConflict CustomerID = "1" EmailAddress = "updated@gmail.com" >
				</UpdateNoConflict>

				<UpdateConflict CustomerID = "1" EmailAddress = "mitsue_tollner@yahoo.com" >
				</UpdateConflict>

				<DeleteNoConflict CustomerID = "486" >
				</DeleteNoConflict>

				<DeleteConflict CustomerID = "" >
				</DeleteConflict>
			</Records>
			'

SELECT *
FROM Customers

------ ADD No Conflict------
INSERT INTO Customers ([EmailAddress], [Password], [FirstName], [LastName],	[ShippingAddressID], [BillingAddressID])

SELECT ea, p, fn, ln, saID, baID

FROM ( SELECT	[ea] = parent.value('@EmailAddress', 'VARCHAR(50)'),
				[p] = parent.value('@Password', 'VARCHAR(30)'),
				[fn] = parent.value('@FirstName', 'VARCHAR(30)'),
				[ln] = parent.value('@LastName', 'VARCHAR(30)'),
				[saID] = parent.value('@ShippingAddressID','INT'),
				[baID] = parent.value('@BillingAddressID','INT')
	FROM @XML.nodes('/Records/AddNoConflict') AS parent(parent)
) tbl

WHERE NOT EXISTS (SELECT NULL FROM Customers WHERE [EmailAddress] = tbl.ea)

SELECT *
FROM Customers


------ ADD Conflict------
INSERT INTO Customers ([EmailAddress], [Password], [FirstName], [LastName],	[ShippingAddressID], [BillingAddressID])

SELECT ea, p, fn, ln, saID, baID

FROM ( SELECT	[ea] = parent.value('@EmailAddress', 'VARCHAR(50)'),
				[p] = parent.value('@Password', 'VARCHAR(30)'),
				[fn] = parent.value('@FirstName', 'VARCHAR(30)'),
				[ln] = parent.value('@LastName', 'VARCHAR(30)'),
				[saID] = parent.value('@ShippingAddressID','INT'),
				[baID] = parent.value('@BillingAddressID','INT')
	FROM @XML.nodes('/Records/AddConflict') AS parent(parent)
) tbl

WHERE NOT EXISTS (SELECT NULL FROM Customers WHERE [EmailAddress] = tbl.ea)

SELECT *
FROM Customers


------ UPDATE NO CONFLICT------
UPDATE Customers
	SET EmailAddress = tbl.nEmail

FROM (
SELECT	[cID] = parent.value('@CustomerID','INT'),
		[nEmail] = parent.value('@EmailAddress','VARCHAR(50)')

FROM @XML.nodes('/Records/UpdateNoConflict') AS parent(parent)
) tbl

WHERE tbl.cID = CustomerID AND NOT EXISTS (SELECT NULL FROM Customers WHERE [EmailAddress] = tbl.nEmail)

SELECT *
FROM Customers


------ UPDATE CONFLICT------
UPDATE Customers
	SET EmailAddress = tbl.nEmail

FROM (
SELECT	[cID] = parent.value('@CustomerID','INT'),
		[nEmail] = parent.value('@EmailAddress','VARCHAR(50)')

FROM @XML.nodes('/Records/UpdateConflict') AS parent(parent)
) tbl

WHERE tbl.cID = CustomerID AND NOT EXISTS (SELECT NULL FROM Customers WHERE [EmailAddress] = tbl.nEmail)

SELECT *
FROM Customers

------ DELETE ------
DELETE FROM Customers

(
SELECT	[cID] = parent.value('@CustomerID','INT'),
		[nEmail] = parent.value('@EmailAddress','VARCHAR(50)')

FROM @XML.nodes('/Records/UpdateConflict') AS parent(parent)
) tbl

WHERE tbl.cID = CustomerID AND NOT EXISTS (SELECT NULL FROM Orders WHERE [CustomerID] = tbl.cID

SELECT *
FROM Customers