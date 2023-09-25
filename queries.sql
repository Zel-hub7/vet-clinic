-- Find all animals whose name ends in "mon":
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019:
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts:
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg:
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered:
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon:
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including animals with weights equal to 10.4kg or 17.3kg):
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--Inside a transaction update the animals table by setting the species column to unspecified.

BEGIN;
UPDATE animals
SET species = 'unspecified';

-- Check if the column named species is updated.
SELECT * from animals;

--Undo all the changes you have made before.

ROLLBACK;

--Check if the table become as it was before the changes were made.

SELECT * FROM animals;


-- Begin a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT weight_update_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = -weight_kg;

-- Rollback to the savepoint
ROLLBACK TO weight_update_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = -weight_kg
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

--Verify that changes were made.
SELECT * FROM animals;

--COMMIT CHANGES

COMMIT;

--VERIFY IF THE CHANGES ARE PERMANENT

SELECT * FROM animals;

--Total counts of animals;

SELECT COUNT(*) AS total_animals
FROM animals;

--How many animals have never tried to escape?

SELECT COUNT(*) AS animals_never_tried_to_escape
FROM animals
WHERE escape_attemts = 0;

--What is the average weight of animals?

SELECT AVG(weight_kg) AS average_weight
FROM animals;

--Who escapes the most, neutered or not neutered animals?

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC
LIMIT 1;

--What is the minimum and maximum weight of each type of animal?
SELECT species,
  MIN(weight_kg) AS min_weight,
  MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species,
AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).

SELECT a.name AS animal_name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT o.full_name AS owner_name, COALESCE(json_agg(a.name) FILTER (WHERE a.name IS NOT NULL), '[]') AS owned_animals
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name;

--How many animals are there per species?

SELECT s.name AS species_name, COUNT(a.id) AS num_animals
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

--List all Digimon owned by Jennifer Orwell.

SELECT a.name AS digimon_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

--Who owns the most animals?

SELECT o.full_name AS owner_name, COUNT(a.id) AS num_animals
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY num_animals DESC
LIMIT 1;






















