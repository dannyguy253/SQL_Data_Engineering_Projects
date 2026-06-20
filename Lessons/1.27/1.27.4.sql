SELECT
    EXTRACT('quarter' FROM job_posted_date) AS job_posted_quarter,
    EXTRACT('year' FROM job_posted_date) AS job_posted_year,
    EXTRACT('year' FROM job_posted_date) || '-' || EXTRACT('quarter' FROM job_posted_date) AS job_posted_year_quarter,
    COUNT(job_id) AS job_posts
FROM 
    job_postings_fact
WHERE EXTRACT('year' FROM job_posted_date) BETWEEN 2023 AND 2024
GROUP BY 
    EXTRACT('quarter' FROM job_posted_date),
    EXTRACT('year' FROM job_posted_date),
    EXTRACT('year' FROM job_posted_date) || '-' || EXTRACT('quarter' FROM job_posted_date)
ORDER BY job_posted_year_quarter;