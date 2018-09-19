DECLARE @SampleTable TABLE (

	[RowId]	INT	IDENTITY(100,1)	PRIMARY KEY,	
	[Type]	INT,
	[Id]	INT,
	[Name]	VARCHAR(30)

)

INSERT INTO @SampleTable ([Type], [Id], [Name])
VALUES (5, 1, '*********')


DECLARE @XML AS XML
SET @XML =	'
			<Entities>
				<Add Type = "5">
					<Item Id = "1" Name = "Tom"/>
					<Item Id = "2" Name = "Bob"/>
					<Item Id = "3" Name = "Mike"/>
				</Add>
				<Add Type = "6">
					<Item Id = "4" Name = "Brenda"/>
					<Item Id = "5" Name = "Sallie"/>
					<Item Id = "6" Name = "Nin"/>
				</Add>
				<Update Id = "5">
					<Item newId = "22"/> 
					<Item newName = "Sally"/>
				</Update>

				<UpdateV2 Id = "6" newId = "6" newName = "Nina"/>

				<Delete Id = "100"/>
				<Delete Id = "103"/>
				<Delete Id = "104"/>
				<Delete Id = "1"/>
			</Entities>	
			'

------------------------------------- INSERT ------------------------------------
INSERT INTO @SampleTable ([Type], [Id], [Name])

SELECT t, i, n
FROM (
	SELECT	[t] = parent.value('@Type','INT'),
			[i] = child.value('@Id','INT'),
			[n] = child.value('@Name','VARCHAR(30)') 
	FROM @XML.nodes('/Entities/Add') AS parent(parent)
	CROSS APPLY parent.nodes('Item') AS child(child)
) tbl

WHERE NOT EXISTS (SELECT NULL FROM @SampleTable WHERE [Type] = tbl.t AND [Id] = tbl.i)

SELECT * FROM @SampleTable



------------------------------------- Update ------------------------------------
UPDATE @SampleTable
SET Id = tbl.nId, Name = tbl.nName

FROM (
SELECT
		[nId] = child.value('@newId','INT'),
		[nName] = child.value('@newName','VARCHAR(30)'),
		[oId] = parent.value('@Id','INT')

FROM @XML.nodes('/Entities/Update') AS parent(parent)
CROSS APPLY parent.nodes('Item') AS child(child)

) tbl

WHERE Id = tbl.oId
SELECT * FROM @SampleTable



------------------------------------- UpdateV2 ------------------------------------

UPDATE @SampleTable
SET Id = tbl.nId, Name = tbl.nName

FROM (
SELECT
		[nId] = parent.value('@newId','INT'),
		[nName] = parent.value('@newName','VARCHAR(30)'),
		[oId] = parent.value('@Id','INT')

FROM @XML.nodes('/Entities/UpdateV2') AS parent(parent)

) tbl

WHERE Id = tbl.oId
SELECT * FROM @SampleTable



------------------------------------- Delete ------------------------------------
DELETE FROM @SampleTable

FROM (
		SELECT [tid] = parent.value('@Id','INT')
		FROM @XML.nodes('Entities/Delete') AS parent(parent)

) tbl

WHERE rowID = tbl.tid
SELECT * FROM @SampleTable
