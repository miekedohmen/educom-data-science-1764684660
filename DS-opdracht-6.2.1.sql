SELECT id, DATE_FORMAT(joindate, '%d-%m-%Y') AS joindate FROM mhl_suppliers WHERE joindate BETWEEN DATE_SUB(LAST_DAY(joindate), INTERVAL 6 DAY) AND LAST_DAY(joindate) ORDER BY joindate ASC;
