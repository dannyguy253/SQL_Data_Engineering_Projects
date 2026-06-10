SELECT 
    job_id,
    NULLIF(job_via, 'Unknown') AS job_source_cleaned
FROM 
    job_postings_fact;

SELECT 
    job_id,
    NULLIF(job_via, 'Unknown') AS job_source_cleaned
FROM 
    job_postings_fact
WHERE 
    job_via = 'Unknown';