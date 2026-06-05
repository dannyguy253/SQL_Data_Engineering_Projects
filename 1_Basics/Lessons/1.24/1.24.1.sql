USE company_jobs;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE OR REPLACE TABLE staging.priority_skills (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR,
    priority_lvl INT
);

INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl)
VALUES 
    (1, 'python', 1),
    (0, 'sql', 1),
    (183, 'tableau', 2);


SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_catalog = 'company_jobs' AND table_schema = 'staging';

SELECT *
FROM staging.priority_skills;

-- SELECT * FROM information_schema.schemata;