SELECT DISTINCT
    s.name, 
    s.straat, 
    s.huisnr, 
    s.postcode
FROM mhl_suppliers s
JOIN mhl_cities c ON s.city_ID = c.id
JOIN mhl_suppliers_mhl_rubriek_view srv ON s.id = srv.mhl_suppliers_ID
JOIN mhl_rubrieken r ON srv.mhl_rubriek_view_ID = r.id
LEFT JOIN mhl_rubrieken parent ON r.parent = parent.id
WHERE c.name = 'Amsterdam'
  AND (r.name LIKE '%drank%' OR parent.name LIKE '%drank%')
ORDER BY r.name, s.name;