SELECT 
    m.name AS gemeente,
    s.name AS leverancier,
    total_hits.totaal_hitcount,
    avg_hits.gemiddelde_gemeente_hitcount
FROM mhl_suppliers s
JOIN (
    SELECT supplier_ID, SUM(hitcount) AS totaal_hitcount
    FROM mhl_hitcount
    GROUP BY supplier_ID
) AS total_hits ON s.id = total_hits.supplier_ID
JOIN mhl_cities c ON s.city_ID = c.id
JOIN mhl_communes m ON c.commune_ID = m.id
JOIN (
    SELECT c2.commune_ID, AVG(th.totaal_hitcount) AS gemiddelde_gemeente_hitcount
    FROM mhl_suppliers s2
    JOIN mhl_cities c2 ON s2.city_ID = c2.id
    JOIN (
        SELECT supplier_ID, SUM(hitcount) AS totaal_hitcount
        FROM mhl_hitcount
        GROUP BY supplier_ID
    ) AS th ON s2.id = th.supplier_ID
    GROUP BY c2.commune_ID
) AS avg_hits ON m.id = avg_hits.commune_ID
WHERE 
    total_hits.totaal_hitcount > avg_hits.gemiddelde_gemeente_hitcount
ORDER BY 
    (total_hits.totaal_hitcount - avg_hits.gemiddelde_gemeente_hitcount) DESC;