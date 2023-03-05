import express from 'express';
import { MongoClient } from 'mongodb';

const client = new MongoClient('mongodb://mongo:27017/');

const server = express();

server.get('/', async (_, res) => {
  await client.connect();

  const stats = await client.db('test').stats();
  res.status(200).json(stats);

  client.close();
});

server.listen(8080, () => {
  console.log(`Server running at http://localhost:8080/`);
});
