-- Write queries to return the following:
-- The following queries utilize the "world" database.

-- 1. The city name, country name, and city population of all cities in Europe with population greater than 1 million
-- (36 rows)

SELECT city.name, c.name, city.population
FROM city
         JOIN country c ON city.countrycode = c.code
WHERE continent ILIKE 'europe'
  AND city.population > 1000000;

-- 2. The city name, country name, and city population of all cities in countries where French is an official language and the city population is greater than 1 million
-- (2 rows)

SELECT city.name, c.name, city.population
FROM city
         JOIN country c ON city.countrycode = c.code
         JOIN countrylanguage c2 ON c.code = c2.countrycode
WHERE c2.language ILIKE 'french'
  AND isofficial = TRUE
  AND city.population > 1000000;

-- 3. The name of the countries and continents where the language Javanese is spoken
-- (1 row)

SELECT country.name, continent
FROM country
         JOIN countrylanguage c ON country.code = c.countrycode
WHERE language ILIKE 'javanese';

-- 4. The names of all of the countries in Africa that speak French as an official language
-- (5 row)

SELECT name
FROM country
         JOIN countrylanguage c ON country.code = c.countrycode
WHERE language ILIKE 'french'
  AND isofficial = TRUE
  AND continent ILIKE 'africa';

-- 5. The average city population of cities in Europe
-- (average city population in Europe: 287,684)

SELECT AVG(city.population)
FROM city
         JOIN country c ON city.countrycode = c.code
WHERE continent ILIKE 'europe';

-- 6. The average city population of cities in Asia
-- (average city population in Asia: 395,019)

SELECT AVG(city.population)
FROM city
         JOIN country c ON city.countrycode = c.code
WHERE continent ILIKE 'asia';

-- 7. The number of cities in countries where English is an official language
-- (number of cities where English is official language: 523)

SELECT COUNT(city.name)
FROM city
         JOIN countrylanguage c ON city.countrycode = c.countrycode
WHERE language ILIKE 'english'
  AND isofficial = TRUE;


-- 8. The average population of cities in countries where the official language is English
-- (average population of cities where English is official language: 285,809)

SELECT AVG(city.population)
FROM city
         JOIN countrylanguage c ON city.countrycode = c.countrycode
WHERE language ILIKE 'english'
  AND isofficial = TRUE;

-- 9. The names of all of the continents and the population of the continent’s largest city
-- (6 rows, largest population for North America: 8,591,309)

SELECT continent, MAX(c.population)
FROM country
         JOIN city c ON country.capital = c.id
GROUP BY continent;

-- 10. The names of all of the cities in South America that have a population
-- of more than 1 million people and the official language of each city’s country
-- (29 rows)

SELECT DISTINCT(city.name), language
FROM city
         JOIN country c ON city.countrycode = c.code
         JOIN countrylanguage c2 ON c.code = c2.countrycode
WHERE isofficial = TRUE
  AND c.continent ILIKE 'south america'
  AND city.population > 1000000
GROUP BY language, (city.name);

