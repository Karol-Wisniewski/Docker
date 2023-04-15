const express = require('express');
const mongoose = require('mongoose');
const app = express();

mongoose.connect('mongodb://mongodb:27017/test', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB'))
    .catch((err) => console.error('Error connecting to MongoDB:', err));

app.use((req, res, next) => {
    const dbStatus = mongoose.connection.readyState;
    res.setHeader('DB-Status', dbStatus);
    next();
});

app.get('/', (req, res) => {
    res.send('Hello from API!');
});

app.listen(80, () => console.log('App listening on port 80'));
