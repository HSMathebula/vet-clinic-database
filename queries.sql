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