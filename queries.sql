/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animal WHERE name LIKE '%mon';
SELECT name FROM animal WHERE date_of_birth >='2016-01-01' and date_of_birth<='2019-12-31';
SELECT  name FROM animal WHERE  neutered = 'true' and escape_attempts < 3 ;
SELECT date_of_birth FROM animal WHERE name = 'Agumon' or name = 'Pikachu' ;
SELECT name, escape_attempts FROM animal WHERE  weight_kg > 10.5;
SELECT * FROM animal WHERE neutered = 'true';
SELECT * FROM animal WHERE name != 'Gabumon' ; 
SELECT * FROM animal WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animal SET species = 'unspecified';
SELECT * FROM animal;
ROLLBACK;

BEGIN;
 UPDATE animal SET species = 'digimon' WHERE name LIKE '%mon';

 UPDATE animal SET species = 'pokemon' WHERE species IS null;
 SELECT * FROM animal;
COMMIT;

BEGIN;
DELETE FROM animal;
SELECT * FROM animal;
ROLLBACK;
SELECT * FROM animal;

BEGIN;
DELETE FROM animal
WHERE date_of_birth > '2022-01-01';

SAVEPOINT saved_point;
UPDATE animal
SET weight_kg = weight_kg * (-1);
ROLLBACK TO saved_point;
UPDATE animal
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animal;

/*How many animals are there*/
SELECT COUNT(*) FROM animal;

/*How many animals have never tried to escape*/
SELECT COUNT(*) FROM animal WHERE escape_attempts = 0;

/*What is the average weight of animals*/
SELECT AVG(weight_kg) FROM animal;

/*Who escapes the most, neutered or not neutered animals*/
SELECT neutered, MAX(escape_attempts) FROM animal GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal*/
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animal GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000*/
SELECT species, AVG(escape_attempts) FROM animal WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*JOINS*/
SELECT name, full_name FROM animal JOIN OWNERS ON animal.owner_id = OWNERS.id WHERE full_name = 'Melody Pond';

SELECT animal.name as Name, SPECIES.name as Type FROM animal JOIN SPECIES ON SPECIES.id = species_id WHERE SPECIES.id = 1;

SELECT name AS animal, full_name AS Owners FROM animal RIGHT JOIN OWNERS ON animal.owner_id = OWNERS.id;

SELECT COUNT(animal.name) AS animal_count, SPECIES.name AS Specie FROM animal JOIN SPECIES ON animal.species_id = SPECIES.id GROUP BY SPECIES.name;

SELECT OWNERS.full_name, animal.name AS name_of_animal, SPECIES.name AS name_of_species FROM animal JOIN OWNERS ON OWNERS.id = animal.owner_id JOIN SPECIES ON SPECIES.id = animal.species_id WHERE OWNERS.full_name = 'Jennifer Orwell' AND SPECIES.name = 'Digimon';

SELECT name, escape_attempts, full_name FROM animal JOIN OWNERS ON OWNERS.id = animal.owner_id WHERE OWNERS.full_name = 'Dean Winchester' AND animal.escape_attempts = 0;

SELECT full_name, COUNT(animal.owner_id) AS Owns FROM OWNERS JOIN animal ON animal.owner_id = OWNERS.id GROUP BY full_name ORDER BY Owns DESC;

-- Write queries to answer the following
SELECT animal.name, visits.date_of_visit FROM animal
    JOIN visits ON animal.id = visits.animal_id
    JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT COUNT(DISTINCT animal.name)
FROM animal
    JOIN visits ON animal.id = visits.animal_id
    JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

SELECT vets.name,
    species.name as specialties
FROM vets
    FULL JOIN specializations ON vets.id = specializations.vets_id
    FULL JOIN species ON species.id = specializations.species_id;

SELECT animal.name,
    visits.date_of_visit
FROM animal
    JOIN visits ON animal.id = visits.animal_id
    JOIN vets ON vets.id = visits.vets_id
WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-09-30'
    AND vets.name = 'Stephanie Mendez';

SELECT COUNT(animal.name) AS nb_of_visit,
    animal.name
FROM animal
    JOIN visits ON animal.id = visits.animal_id
GROUP BY animal.name
ORDER BY nb_of_visit DESC
LIMIT 1;

SELECT animal.name,
    visits.date_of_visit
FROM animal
    JOIN visits ON animal.id = visits.animal_id
    JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

SELECT visits.date_of_visit,
    animal.name AS ANIMALS_NAME,
    animal.date_of_birth AS ANIMALS_BITH,
    animal.escape_attempts,
    animal.weight_kg,
    species.name AS ANIMALS_SPECIES,
    owners.full_name AS OWNERS,
    vets.name AS VET_NAME,
    vets.age AS VET_age,
    vets.date_of_graduation AS VET_DATE_OF_GRAD
FROM animal
    JOIN visits ON animal.id = visits.animal_id
    JOIN vets ON vets.id = visits.vets_id
    JOIN species ON animal.species_id = species.id
    JOIN owners ON animal.owner_id = owners.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT COUNT(visits.animal_id)
FROM visits
    JOIN vets ON vets.id = visits.vets_id
    JOIN animal ON animal.id = visits.animal_id
    JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id != animal.species_id;

SELECT COUNT(animal.species_id) as count_visit,
    species.name
FROM animal
    JOIN visits ON animal.id = visits.animal_id
    JOIN vets ON vets.id = visits.vets_id
    JOIN species ON animal.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY count_visit DESC
LIMIT 1; 