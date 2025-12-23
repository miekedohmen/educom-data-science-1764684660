# WORLD POPULATION ANALYSIS QUERIES JSON

# Opdracht 1 -> bevolkingsdichtheid in 1970 voor ieder land.
```bash
jq '.[] | {country: .country, density_1970: (.population_1970 / .area_km2)}' world-population.json
```
# Opdracht 2 -> absolute bevolkingsgroei tussen 1970 en 2022 weergeeft
```bash
jq '.[] | select(.area_km2 > 0) | {country: .country, density: (.population_1970 / .area_km2)}' world-population.json
```

# Opdracht 3 -> absolute aantallen per gegeven jaar
```bash
jq 'group_by(.continent) | .[] | {
  continent: .[0].continent,
  "2022": (map(.population_2022) | add),
  "2020": (map(.population_2020) | add),
  "2015": (map(.population_2015) | add),
  "2010": (map(.population_2010) | add),
  "2000": (map(.population_2000) | add),
  "1990": (map(.population_1990) | add),
  "1980": (map(.population_1980) | add),
  "1970": (map(.population_1970) | add)
}' world-population.json
```

# Opdracht 4 -> percentage van de wereldbevolking van het continent
```bash
jq '(map(.population_2022) | add) as $total | group_by(.continent) | .[] | {continent: .[0].continent, percentage: (((map(.population_2022) | add) / $total) * 100)}' world-population.json
```

# Opdracht 5 -> per continent groei ten opzichte van 1970 weergeeft.
```bash
jq 'group_by(.continent) | .[] | {
  continent: .[0].continent,
  groei_percentage: (
    ((map(.population_2022) | add) - (map(.population_1970) | add)) 
    / (map(.population_1970) | add) 
    * 100
  )
}' world-population.json
```

# Opdracht 6 -> csv bestanden & charts

# Opdracht 7 -> oplossing omzetten naar andere structuur.
```bash
jq 'map({
  rank: .rank,
  cca3: .cca3,
  country: .country,
  capital: .capital,
  continent: .continent,
  population: [
    { year: 2022, population: .population_2022 },
    { year: 2020, population: .population_2020 },
    { year: 2015, population: .population_2015 },
    { year: 2010, population: .population_1970 },
    { year: 2000, population: .population_2000 },
    { year: 1990, population: .population_1990 },
    { year: 1980, population: .population_1980 },
    { year: 1970, population: .population_1970 }
  ],
  area_km2: .area_km2,
  population_density: .population_density,
  population_growth_rate: .population_growth_rate,
  percentage_world_population: .percentage_world_population
})' world-population.json
```

# Opdracht 8 -> Normaliseren van de data aan de hand van "Codd" en formateer de data met jq
```bash
jq -r 'map(.continent) | unique | .[] | "INSERT INTO continents (name) VALUES (\"\(@text)\");"' world-population.json >> import_world_data.sql

jq -r '.[] | "INSERT INTO countries (cca3, name, capital, area_km2, continent_id) SELECT \"\(.cca3)\", \"\(.country)\", \"\(.capital)\", \(.area_km2), id FROM continents WHERE name=\"\(.continent)\";"' world-population.json >> import_world_data.sql

jq -r '.[] as $land | [2022, 2020, 2015, 2010, 2000, 1990, 1980, 1970] | .[] as $jaar | "INSERT INTO population_records (country_cca3, year, population) VALUES (\"\($land.cca3)\", \($jaar), \($land["population_\($jaar)"] // 0));"' world-population.json >> import_world_data.sql
```