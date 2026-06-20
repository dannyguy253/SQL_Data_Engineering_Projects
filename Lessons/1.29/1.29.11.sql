WITH cleaned AS (
    SELECT 
        job_id, 
        LOWER(TRIM(job_location)) AS job_location_clean
    FROM job_postings_fact)

SELECT 
    job_id,
    job_location_clean,
    CASE 
        WHEN job_location_clean LIKE '%remote%' OR job_location_clean LIKE '%anywhere%' THEN 'Remote'
        WHEN NULLIF(job_location_clean, '') IS NULL THEN 'Global'
        ELSE 'On-site/Hybrid'
    END AS location_category
FROM cleaned;