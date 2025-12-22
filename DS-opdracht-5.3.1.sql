CREATE VIEW DIRECTIE AS
SELECT 
    c.supplier_ID,
    c.name AS contact,
    c.contacttype,
    d.name AS department
FROM 
    mhl_contacts c
JOIN 
    mhl_departments d ON c.department = d.id
WHERE 
    d.name = 'Directie' 
    OR c.contacttype LIKE '%directeur%';