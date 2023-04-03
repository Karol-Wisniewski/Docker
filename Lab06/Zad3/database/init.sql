SELECT 'CREATE DATABASE people' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'people');

CREATE TABLE IF NOT EXISTS people (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    gender CHAR(1) NOT NULL
);

INSERT INTO people (first_name, last_name, age, gender) VALUES
    ('Jan', 'Kowalski', 30, 'M'),
    ('Anna', 'Nowak', 28, 'K'),
    ('Piotr', 'Zielinski', 34, 'M');
