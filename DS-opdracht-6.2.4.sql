SELECT 
    YEAR(joindate) AS jaar,
    CASE MONTH(joindate)
        WHEN 1 THEN 'Januari'
        WHEN 2 THEN 'Februari'
        WHEN 3 THEN 'Maart'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'Mei'
        WHEN 6 THEN 'Juni'
        WHEN 7 THEN 'Juli'
        WHEN 8 THEN 'Augustus'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'Oktober'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS maand,
    COUNT(id) AS aantal_leveranciers
FROM 
    mhl_suppliers
GROUP BY 
    jaar, MONTH(joindate)
ORDER BY 
    jaar DESC, MONTH(joindate) ASC;