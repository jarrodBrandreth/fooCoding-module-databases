use new_world;

-- 1. What are the names of countries with population greater than 8 million
SELECT name, population 
FROM country
WHERE population > 8000000;

-- 2. What are the names of countries that have “land” in their names ?
SELECT name
FROM country
WHERE name LIKE '%land%';

-- 3. What are the names of the cities with population in between 500,000 and 1 million ?
SELECT name
FROM city
WHERE population BETWEEN 550000 AND 1000000;

-- 4. What's the name of all the countries on the continent ‘Europe’ ?
SELECT name
FROM country
WHERE continent = 'Europe';

-- 5. List all the countries in the descending order of their surface areas.
SELECT name, SurfaceArea 
FROM country
ORDER BY SurfaceArea DESC;

-- 6. What are the names of all the cities in the Netherlands?
 SELECT city.name, country.name
 FROM country
 INNER JOIN city ON city.countryCode = country.Code
 HAVING country.name = 'Netherlands';

-- 7. What is the population of Rotterdam ?
SELECT name, population
FROM city
WHERE name = 'Rotterdam';

-- 8. What's the top 10 countries by Surface Area ?
SELECT name, SurfaceArea
FROM country
ORDER BY SurfaceArea DESC
LIMIT 10;

-- 9. What's the top 10 most populated cities?
SELECT country.name AS country ,city.name AS city, city.population
FROM city
INNER JOIN country
ON city.countryCode = country.Code
ORDER BY population DESC
LIMIT 10;

-- 10. What is the population of the world ?
 SELECT SUM(population) as WorldPopulation
 FROM country










