SELECT
    job_id,
    job_title,
    job_location
FROM job_postings_fact
WHERE NULLIF(LOWER(TRIM(job_title)), LOWER(TRIM(job_location))) IS NULL;
-- WHERE LOWER(TRIM(job_title)) = LOWER(TRIM(job_location));



SELECT job_id, job_title, job_location FROM job_postings_fact WHERE NULLIF(TRIM(job_title), TRIM(job_location)) IS NULL;