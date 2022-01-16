## Session 1 :

use new_world;
begin;
SELECT city.name, country.name FROM country LEFT JOIN city ON city.CountryCode = country.code WHERE country.name LIKE "Netherlands";

## Session 2 :

use new_world;
begin;
SELECT city.name, country.name FROM country LEFT JOIN city ON city.CountryCode = country.code WHERE country.name LIKE "Netherlands";

## Session 1 :

delete from city where countrycode = 'NLD';

SELECT city.name, country.name FROM country LEFT JOIN city ON city.CountryCode = country.code WHERE country.name LIKE "Netherlands";

##  Session 2 :

SELECT city.name, country.name FROM country LEFT JOIN city ON city.CountryCode = country.code WHERE country.name LIKE "Netherlands";

rollback;

SELECT city.name, country.name FROM country LEFT JOIN city ON city.CountryCode = country.code WHERE country.name LIKE "Netherlands";

## Session 1 : 

/* rollback / commit */


