/* Populate database with sample data. */

INSERT INTO animal (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', date '2020-02-03', 0, 'true', 10.23);

INSERT INTO animal (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', date '2018-11-15', 2, 'true', 8);

INSERT INTO animal (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Pikachu', date '2021-1-7', 1, 'false', 15.04);

INSERT INTO animal (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Devimon', date '2017-05-12', 5, 'true', 11);

INSERT INTO  animal(name,date_of_birth,escape_attempts, neutered , weight_kg)
VALUES('Charmander', 'Feb 08 2020',0, false, 11),
('Plantmon', 'Nov 15 2021',2, true, 5.7),
('Squirtle', 'Apr 02 1993',3, false, 12.13),
('Angemon', 'Jun 12 2005',1, true, 45), 
('Boarmon', 'Jun 07 2005',7, true, 20.4),
('Blossom', 'Oct 13 1998',3, true, 17),
('Ditto', 'May 14 2022',4, true, 22);

-- insert data into owners table
INSERT INTO  owners(full_name, age)
VALUES('Sam Smith ', 34),
('Jennifer Orwell', 19 ),
('Bob', 45 ),
('Melody Pond', 77 ),
('Dean Winchester', 14 ),
('Jodie Whittaker', 38 );

-- insert data for species
INSERT INTO  species(name) VALUES('Pokemon'), ('Digimon');

-- Modify inserted animals so it includes the species_id value
UPDATE animal SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';

UPDATE animal SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id)
UPDATE animal SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animal SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animal SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animal SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animal SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

-- insert data into vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Vet William Tatcher', 45, 'Apr 23 2000'),
('Vet Maisy Smith', 26 ,'Jan 17 2019'),
('Vet Stephanie Mendez', 64, 'May 04 1981'),
('Vet Jack Harkness', 38,'Jun 08 2008');

-- insert data into specializations
INSERT INTO specializations(species_id, vets_id)
VALUES ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),

((SELECT id FROM species WHERE name = 'Digimon' OR name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez')),

((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Vet Jack Harkness'));
