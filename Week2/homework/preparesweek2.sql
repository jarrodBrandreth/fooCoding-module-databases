
-- What is the capital of country X ? (Accept X from user)
-- SELECT city.name AS capital,country.name AS country
-- FROM city INNER JOIN country ON capital = city.id 
-- WHERE country.name = 'Spain';

PREPARE capitals FROM 'SELECT city.name AS capital,country.name AS country
FROM city INNER JOIN country ON capital = city.id 
WHERE country.name = ?';
SET @X = 'Spain';
EXECUTE capitals using @X;

-- List all the languages spoken in the region Y (Accept Y from user)
-- SELECT Language, Name 
-- FROM countryLanguage INNER JOIN country ON country.Code = countrylanguage.CountryCode 
-- WHERE country.name = 'Spain';

PREPARE languages FROM 'SELECT Language, Name 
FROM countryLanguage INNER JOIN country ON country.Code = countrylanguage.CountryCode 
WHERE country.name = ?';
SET @Y = 'Spain';
EXECUTE languages using @Y;

-- Find the number of cities in which language Z is spoken (Accept Z from user)
-- SELECT count(city.name) AS cities FROM city 
-- INNER JOIN countryLanguage ON countryLanguage.CountryCode = city.CountryCode
-- WHERE countryLanguage.Language = 'Yi';

PREPARE numberOfCitiesForLanguage FROM 'SELECT count(city.name) AS cities FROM city 
INNER JOIN countryLanguage ON countryLanguage.CountryCode = city.CountryCode
WHERE countryLanguage.Language = ?';
SET @Z = 'Yi';
EXECUTE numberOfCitiesForLanguage using @Z;

-- List all the continents with the number of languages spoken in each continent
-- SELECT Continent, count(countryLanguage.Language) AS NumOfLanguages FROM country
-- INNER JOIN countryLanguage ON country.Code = countryLanguage.CountryCode
-- GROUP BY Continent
-- ORDER BY NumOfLanguages DESC;

PREPARE numberOfLanguagesPerContinent FROM 'SELECT Continent, count(countryLanguage.Language) AS NumOfLanguages FROM country
INNER JOIN countryLanguage ON country.Code = countryLanguage.CountryCode
GROUP BY Continent
ORDER BY NumOfLanguages DESC';
EXECUTE numberOfLanguagesPerContinent;

