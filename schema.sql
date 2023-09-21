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
