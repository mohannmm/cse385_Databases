
-- Distinct combination of city and state
SELECT DISTINCT VendorCity, VendorState
FROM Vendors
ORDER BY VendorState, VendorCity

-- TOP 5 of table (USE BRACKETS FOR VARIABLES
DECLARE @count int = 10

SELECT TOP (@count) VendorCity, VendorState
FROM Vendors
ORDER BY VendorState, VendorCity