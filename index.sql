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

-- problem - 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem - 2
SELECT COUNT(DISTINCT species_id) AS unique_species FROM sightings;

-- problem - 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- problem - 4
SELECT name, COUNT(*) AS total_sightings
FROM sightings AS s
    JOIN rangers ON s.ranger_id = s.ranger_id
GROUP BY
    name
ORDER BY name ASC;

-- problem - 5
SELECT common_name
FROM species AS s
    LEFT JOIN sightings AS i ON s.species_id = i.species_id
WHERE
    i.sighting_id is NULL;

-- problem - 6
SELECT common_name, sighting_time, name
FROM
    sightings AS i
    JOIN rangers AS r ON i.ranger_id = r.ranger_id
    JOIN species AS p ON i.species_id = p.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-- problem - 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;
    
-- problem - 8
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 0 AND 11  THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 18 AND 23  THEN 'Evening'
    END AS time_of_day
FROM sightings;

-- problem - 9
DELETE FROM rangers AS r
WHERE
    ranger_id IN (
        SELECT r.ranger_id
        FROM rangers
            LEFT JOIN sightings AS s ON r.ranger_id = s.ranger_id
        WHERE
            s.ranger_id IS NULL
    );

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;