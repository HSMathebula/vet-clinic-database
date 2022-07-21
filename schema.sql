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
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(250),
    age INT
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(250)
);

ALTER TABLE animal DROP id;
ALTER TABLE animal ADD id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
