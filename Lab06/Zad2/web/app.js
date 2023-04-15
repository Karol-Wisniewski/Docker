const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;

const db = mysql.createConnection({
  host: 'db',
  user: 'root',
  password: 'mysecretpassword',
  database: 'my_database',
  port: 3306
});

function connectWithRetry() {
  console.log('Trying to connect to the database...');
  db.connect((err) => {
    if (err) {
      console.error('Failed to connect to the database. Retrying in 5 seconds...');
      setTimeout(connectWithRetry, 5000);
    } else {
      console.log('Connected to the database!');
    }
  });
}

connectWithRetry();

app.get('/', (req, res) => {
  db.query('SELECT 1 + 1 AS solution', (err, results) => {
    if (err) throw err;
    res.send(`Hello World! The result of the query is ${results[0].solution}`);
  });
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});