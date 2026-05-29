SELECT *
FROM 
    job_postings_fact
LIMIT 20;

-- this is to highlight all unique job titles in the fact table
SELECT DISTINCT job_title_short
FROM job_postings_fact;

-- this is to highlight all countries in the fact table
SELECT DISTINCT job_country
FROM job_postings_fact;

-- this is a change to practice git pull
