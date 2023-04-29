const express = require('express');
const Redis = require('ioredis');
const { promisify } = require('util');

const app = express();
app.use(express.json());

const client = new Redis({ host: 'redis', port: 6379 });
client.on('error', (err) => console.error('ERR:REDIS:', err));

app.post('/messages', async (req, res) => {
  try {
    const { message } = req.body;
    await client.rpush('messages', message);
    res.status(201).send('Message added');
  } catch (error) {
    res.status(500).send('Error while adding message');
  }
});

app.get('/messages', async (req, res) => {
  try {
    const messages = await client.lrange('messages', 0, -1);
    res.status(200).json(messages);
  } catch (error) {
    res.status(500).send('Error while getting message');
  }
});

app.listen(3000, () => {
  console.log(`App is running on port 3000`);
});
