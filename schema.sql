CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(8, 2)
);

--Add a column species of type string to your animals table. 

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);


-- Create a table named owners

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INTEGER
);


-- Create table named species.

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name TEXT
);


-- Make sure that id is set as autoincremented PRIMARY KEY

-- CREATE new Table named temp_animals;
CREATE TABLE temp_animals (
    id SERIAL PRIMARY KEY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(5, 2),
    species TEXT
);


-- Copy all the datas from the animals table to temp_animals;

INSERT INTO temp_animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;


-- Drom the existing animals table

DROP animals;

-- Rename the temp_animals table to animals.

ALTER TABLE temp_animals RENAME TO animals;

-- Remove the species column.

ALTER TABLE animals drop column species;

-- Create a new column named species_id

ALTER TABLE animals
ADD COLUMN species_id INTEGER;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals
 ADD CONSTRAINT fk_species
 FOREIGN KEY (species_id)
 REFERENCES species(id);


-- Add column owner_id;
 Alter table animals
 ADD column owner_id INTEGER;

-- make this column foreign key.
ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);






















