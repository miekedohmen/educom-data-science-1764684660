SELECT 
    DISTINCT name,
    CONCAT(
        UPPER(LEFT(name, 1)), 
        LOWER(SUBSTRING(name, 2))
    ) AS aangepaste_naam
FROM 
    mhl_districts
ORDER BY 
    name ASC;