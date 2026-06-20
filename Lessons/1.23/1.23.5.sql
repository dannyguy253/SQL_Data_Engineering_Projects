SELECT 
    job_id,
    job_title_short,
    job_location
FROM 
    data_jobs.job_postings_fact
WHERE 
    job_country IN (
        SELECT job_country
        FROM data_jobs.job_postings_fact
        GROUP BY job_country
        HAVING 
            COUNT(job_id) > (
                SELECT AVG(job_count) 
                FROM 
                    (SELECT job_country, COUNT(job_id) AS job_count
                    FROM data_jobs.job_postings_fact
                    GROUP BY job_country) job_counts_per_country
            )
    )
ORDER BY 
    job_country,
    job_id;