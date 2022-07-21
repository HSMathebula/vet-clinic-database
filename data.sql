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
INSERT INTO vets(name, age, date_of_graduation)
VALUES 
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- insert data into specializations
INSERT INTO specializations(vet_id, species_id)
VALUES 
    (1, 1),
    (3, 2),
    (3, 1),
    (4, 2);

-- insert data into visit table 
INSERT INTO visits(vet_id, animal_id, date_visited) VALUES 
(1, 1, '2020-05-24'),
(3, 1, '2020-07-22'),
(4, 2, '2021-02-02'),
(2, 3, '2020-01-05'),
(2, 3, '2020-03-08'),
(2, 3, '2020-05-14'),
(3, 4, '2021-05-04'),
(4, 5, '2021-02-24'),
(2, 6, '2019-12-21'),
(1, 6, '2020-08-10'),
(2, 6, '2021-04-07'),
(3, 7, '2019-09-29'),
(4, 8, '2020-10-03'),
(4, 8, '2020-11-04'),
(2, 9, '2019-01-24'),
(2, 9, '2019-05-15'),
(2, 9, '2020-02-27'),
(2, 9, '2020-08-03'),
(3, 10, '2020-05-24'),
(1, 10, '2021-01-11');