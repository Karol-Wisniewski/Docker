const express = require('express');
const { Pool } = require('pg');

const app = express();

const port = 4000;

app.use(express.json());

const pool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST,
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: process.env.POSTGRES_PORT,
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.get('/db_health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.status(200).send('OK');
  } catch (error) {
    res.status(500).send('Database connection failed');
    res.send("Error: ", error);
  }
});

app.get('/people', async (req, res) => {
  const client = await pool.connect();
  try {
    const result = await client.query('SELECT * FROM people');
    res.status(200).json(result.rows);
  } catch (error) {
    res.status(500).send('Database connection failed');
    res.send("Error: ", error);
  } finally {
    client.release();
  }
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
