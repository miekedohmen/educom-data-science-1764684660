SELECT 
    c.name AS stad_naam, 
    c.id AS stad_id, 
    m.name AS gemeente_naam, 
    m.id AS gemeente_id
FROM mhl_cities c
JOIN mhl_communes m ON c.commune_ID = m.id
WHERE c.name IN (
    SELECT name 
    FROM mhl_cities 
    GROUP BY name 
    HAVING COUNT(*) > 1
)
ORDER BY c.name ASC;