const express = require('express');
const app = express();
const mysql = require('mysql2');
const passwordArg = process.argv[2];

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: passwordArg,
  database: 'new_world',
});

app.listen('3000', () => {
  console.log('Server started on port 3000');
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('MySql Connected');
});

// -- What is the capital of country X ? (Accept X from user)
app.get('/capitalOfCountry/:userInput', (req, res) => {
  db.execute(
    'SELECT city.name AS capital,country.name AS country FROM city INNER JOIN country ON capital = city.id WHERE country.name = ?',
    [req.params.userInput],
    function (err, results, fields) {
      console.log(results);
      res.send(results);
    },
  );
});

// -- List all the languages spoken in the region Y (Accept Y from user)
app.get('/languagesOfRegion/:userInput', (req, res) => {
  db.execute(
    'SELECT Language, Name FROM countryLanguage INNER JOIN country ON country.Code = countrylanguage.CountryCode WHERE country.name = ?',
    [req.params.userInput],
    function (err, results, fields) {
      console.log(results);
      res.send(results);
    },
  );
});

// -- Find the number of cities in which language Z is spoken (Accept Z from user)
app.get('/numberOfCitiesForLanguage/:userInput', (req, res) => {
  db.execute(
    'SELECT count(city.name) AS cities FROM city INNER JOIN countryLanguage ON countryLanguage.CountryCode = city.CountryCode WHERE countryLanguage.Language = ?',
    [req.params.userInput],
    function (err, results, fields) {
      console.log(results);
      res.send(results);
    },
  );
});

// -- List all the continents with the number of languages spoken in each continent
app.get('/numberOfLanguagesPerContinent', (req, res) => {
  db.execute(
    'SELECT Continent, count(countryLanguage.Language) AS NumOfLanguages FROM country INNER JOIN countryLanguage ON country.Code = countryLanguage.CountryCode GROUP BY Continent ORDER BY NumOfLanguages DESC',
    [],
    function (err, results, fields) {
      console.log(results);
      res.send(results);
    },
  );
});
