/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic_db;

CREATE TABLE animal (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR (100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

ALTER TABLE animal ADD COLUMN species VARCHAR(200);

CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    age INT NOT NULL
);