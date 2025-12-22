SELECT year, SUM(hitcount) AS total_hits FROM mhl_hitcount GROUP BY year ORDER BY year DESC;
