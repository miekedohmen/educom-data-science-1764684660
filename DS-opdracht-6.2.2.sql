SELECT id, joindate, DATEDIFF(CURDATE(), joindate) AS aantal_dagen_lid FROM mhl_suppliers ORDER BY aantal_dagen_lid ASC;
