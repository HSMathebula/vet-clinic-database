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

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(250),
    age INT
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(250)
);

CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(250),
  age INT,
  date_of_graduation DATE
);

ALTER TABLE animal ADD COLUMN species VARCHAR(200);

ALTER TABLE animal DROP id;
ALTER TABLE animal ADD id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

ALTER TABLE animal DROP COLUMN species;

-- ADD COLUMN SPECIES
ALTER TABLE animal ADD species_id INT;

-- ADD COLUMN OWNER_ID
ALTER TABLE animal ADD owner_id INT;

-- set constraint for primary key species_id
ALTER TABLE animal ADD CONSTRAINT fk_species_table FOREIGN KEY(species_id) REFERENCES species(id);

-- set constraint for primary key owners-id
ALTER TABLE animal ADD CONSTRAINT fk_owner_table FOREIGN KEY(owner_id) REFERENCES owners(id);