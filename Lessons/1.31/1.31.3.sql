WITH priority_list AS (
    SELECT
        UNNEST(['Data Engineer','Data Scientist', 'Senior Data Engineer']) AS roles
)

SELECT
    job_id,
    job_title_short,
    salary_year_avg
FROM job_postings_fact AS jpf
INNER JOIN priority_list p
ON jpf.job_title_short = p.roles;