SELECT c.name, c.commune_ID FROM mhl_cities c LEFT JOIN mhl_communes m ON c.commune_ID = m.id WHERE m.id IS NULL;
