-- SELECT *
-- FROM job_postings_fact
-- WHERE TRIM(job_title) != '' AND 
--     UPPER(job_location) != 'N/A'; 

SELECT *
FROM job_postings_fact
WHERE NULLIF(TRIM(job_title), '') IS NOT NULL AND 
    NULLIF(UPPER(TRIM(job_location)), 'N/A') IS NOT NULL; 


SELECT NULLIF(1, NULL);
SELECT 1 = NULL;

SELECT NULLIF(1,1);
SELECT 1 = 1;

SELECT NULLIF(NULL, 1);
SELECT NULL = 1;