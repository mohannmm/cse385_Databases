-- Select vendors that have invoices

SELECT DISTINCT v.VendorName

FROM Vendors v, vwInvoices i
WHERE v.VendorID = i.VendorID


-- Inner Query join of vendors with invoices
SELECT VendorName
FROM Vendors
WHERE VendorID IN (SELECT DISTINCT VendorID FROM Invoices)

-- Inner Query join of vendors WITHOUT invoices
SELECT VendorName
FROM Vendors
WHERE VendorID IN (SELECT DISTINCT VendorID FROM Invoices)

-- LEFT JOIN
SELECT v.VendorName,
FROM Vendors v
	LEFT JOIN vwInvoices i ON 
		(v.VendorID = i.VendorID)
WHERE i.VendorID IS NULL




-- Examples table now...LEFT vs RIGHT vs FULL (ALL different results)
SELECT e.*, d.*
FROM Employees e
	LEFT JOIN Departments d ON
		e.DeptNO = d.DeptNo

SELECT e.*, d.*
FROM Employees e
	RIGHT JOIN Departments d ON
		e.DeptNO = d.DeptNo

SELECT e.*, d.*
FROM Employees e
	FULL JOIN Departments d ON
		e.DeptNO = d.DeptNo
