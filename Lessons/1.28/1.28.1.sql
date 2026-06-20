-- SELECT *
-- FROM information_schema.tables;

USE company_jobs;

CREATE SCHEMA IF NOT EXISTS work_mode_mart;

CREATE OR REPLACE TABLE work_mode_mart.remote_jobs AS 
SELECT 
    job_title,
    company_id,
    job_location
FROM data_jobs.job_postings_fact
WHERE job_work_from_home = TRUE AND job_location = 'Anywhere';

SELECT COUNT(*)
FROM work_mode_mart.remote_jobs;

SELECT *
FROM information_schema.tables;