const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const redis = require('redis');

const app = express();
app.use(bodyParser.json());

// Połącz z MongoDB
const db = mongoose.connection;
mongoose.connect(process.env.DATABASE_URL, { useNewUrlParser: true, useUnifiedTopology: true });
db.on('error', (error) => console.error(error));
db.once('open', () => console.log('Connected to database'));

// Połącz z Redis
const redisClient = redis.createClient({
    url: process.env.REDIS_URL,
    retry_strategy: function(options) {
        if (options.error && options.error.code === "ECONNREFUSED") {
        // End reconnecting on a specific error and flush all commands with
        // a individual error
        return new Error("The server refused the connection");
        }
        if (options.total_retry_time > 1000 * 60 * 60) {
        // End reconnecting after a specific timeout and flush all commands
        // with a individual error
        return new Error("Retry time exhausted");
        }
        if (options.attempt > 10) {
        // End reconnecting with built in error
        return undefined;
        }
        // reconnect after
        return Math.min(options.attempt * 100, 3000);
    },
});
redisClient.on('connect', () => console.log('Connected to Redis'));
redisClient.on('error', (error) => console.error('Error connecting to Redis:', error));

// Zdefiniuj schemat zadania
const taskSchema = new mongoose.Schema({
  name: String,
  status: String,
});
const Task = mongoose.model('Task', taskSchema);

// Endpointy
app.get('/', (req, res) => {
    res.send('Welcome to express API! Endpoints: /tasks (GET, POST), /tasks/:id (PUT)');
});

app.get('/tasks', async (req, res) => {
  const tasks = await Task.find();
  res.json(tasks);
});

app.post('/tasks', async (req, res) => {
  const task = new Task(req.body);
  await task.save();
  res.status(201).json(task);
});

app.put('/tasks/:id', async (req, res) => {
    try {
        const task = await Task.findByIdAndUpdate(req.params.id, req.body, { new: true });
        redisClient.incr('updatedTasks', (err, count) => {
        if (err) res.status(500).json({ error: err.message });
        else res.json({ task, updatedTasksCount: count });
    });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.delete('/tasks/:id', async (req, res) => {
    await Task.findByIdAndDelete(req.params.id);
    res.status(204).send();
});

app.listen(3000, () => console.log('Server started on port 3000'));
