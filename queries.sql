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

SELECT animal.name as Name, species.name as Type FROM animal JOIN species ON species.id = species_id WHERE species.id = 1;

SELECT name AS animal, full_name AS Owners FROM animal RIGHT JOIN OWNERS ON animal.owner_id = OWNERS.id;

SELECT COUNT(animal.name) AS animal_count, species.name AS Specie FROM animal JOIN species ON animal.species_id = species.id GROUP BY species.name;

SELECT OWNERS.full_name, animal.name AS name_of_animal, species.name AS name_of_species FROM animal JOIN OWNERS ON OWNERS.id = animal.owner_id JOIN species ON species.id = animal.species_id WHERE OWNERS.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT name, escape_attempts, full_name FROM animal JOIN OWNERS ON OWNERS.id = animal.owner_id WHERE OWNERS.full_name = 'Dean Winchester' AND animal.escape_attempts = 0;

SELECT full_name, COUNT(animal.owner_id) AS Owns FROM OWNERS JOIN animal ON animal.owner_id = OWNERS.id GROUP BY full_name ORDER BY Owns DESC;

-- Write queries to answer the following
SELECT a.name, v.name, date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animal a 
  ON vis.animal_id = a.id 
WHERE v.name LIKE 'William Tatcher'
ORDER BY vis.date_visited DESC
LIMIT (1);

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT COUNT(*) FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animal a 
  ON vis.animal_id = a.id 
WHERE v.name LIKE 'Stephanie Mendez'
GROUP BY v.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name FROM vets v 
LEFT JOIN specializations s 
  ON v.id = s.vet_id
LEFT JOIN species sp 
  ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, vis.date_visited, v.name FROM animal a 
JOIN visits vis 
  ON a.id = vis.animal_id
JOIN vets v 
  ON v.id = vis.vet_id
WHERE vis.date_visited IN ('2020-04-01', '2020-08-30') 
    AND v.name LIKE 'Stephanie Mendez';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(*) AS number_of_visits FROM visits vis 
JOIN animal a 
  ON vis.animal_id = a.id 
GROUP BY a.name
ORDER BY number_of_visits DESC
LIMIT (1);

-- Who was Maisy Smith's first visit?
SELECT a.name, v.name, vis.date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animal a 
  ON vis.animal_id = a.id 
WHERE v.name LIKE 'Maisy Smith'
ORDER BY vis.date_visited
LIMIT (1);

-- Details for most recent visit: 
-- animal information, vet information, and date of visit.
SELECT a.name, v.name, vis.date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animal a 
  ON vis.animal_id = a.id 
ORDER BY vis.date_visited DESC
LIMIT (1);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS number_of_visits_with_not_specialty_vet FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animal a 
  ON vis.animal_id = a.id
LEFT JOIN specializations sp
  ON v.id = sp.vet_id
LEFT JOIN species spe 
  ON spe.id = sp.species_id
WHERE sp.species_id != a.species_id OR spe.name IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT spe.name, COUNT(*) AS most_visited_by_species FROM visits vis 
JOIN animal a 
  ON vis.animal_id = a.id
JOIN species spe 
  ON spe.id = a.species_id
JOIN vets v 
  ON vis.vet_id = v.id 
LEFT JOIN specializations sp
  ON v.id = sp.vet_id
WHERE sp.vet_id IS NULL AND v.name LIKE 'Maisy Smith'
GROUP BY spe.name
ORDER BY most_visited_by_species DESC
LIMIT (1); 