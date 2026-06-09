SELECT 
    job_id,
    job_title_short,
    job_location,
    job_posted_date,
    EXTRACT('year' FROM job_posted_date) AS job_posted_year,
    EXTRACT('month' FROM job_posted_date) AS job_posted_month,
    EXTRACT('day' FROM job_posted_date) AS job_posted_day,
    EXTRACT('quarter' FROM job_posted_date) AS job_posted_quarter,
FROM job_postings_fact
WHERE job_posted_date::DATE BETWEEN '2023-01-01' AND '2024-12-31';