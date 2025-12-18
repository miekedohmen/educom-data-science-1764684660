SELECT
    RC.ID,
    IFNULL(RP.name, RC.name) AS hoofdrubriek,
    IF(ISNULL(RP.name), '', RC.name) AS subrubriek
FROM mhl_rubrieken RP
RIGHT OUTER JOIN mhl_rubrieken RC ON RC.parent = RP.id
ORDER BY hoofdrubriek, subrubriek