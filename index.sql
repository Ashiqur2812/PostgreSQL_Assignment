CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);


CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers (ranger_id),
    species_id INT REFERENCES species (species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);


INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
);

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

-- problems - 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');


-- problems - 2
SELECT COUNT(DISTINCT species_id) AS unique_species
FROM sightings;


-- problems - 3
SELECT *
FROM sightings
WHERE
    location LIKE '%Pass%';


-- problems - 4
SELECT name, COUNT(*) AS total_sightings
FROM sightings AS s
    JOIN rangers ON s.ranger_id = s.ranger_id
GROUP BY name
ORDER BY name ASC;

-- problems - 5
SELECT common_name FROM species AS s
    LEFT JOIN sightings AS i ON s.species_id = i.species_id
WHERE
    i.sighting_id is NULL;

SELECT common_name, sighting_time, name FROM sightings AS i
JOIN rangers AS r ON i.ranger_id = r.ranger_id
JOIN species AS p ON i.species_id = p.species_id
ORDER BY sighting_time DESC
LIMIT 2;

SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;
