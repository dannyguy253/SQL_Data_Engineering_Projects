WITH salary_trends AS (
    SELECT
        job_title_short,
        salary_year_avg,
        job_posted_date,
        LEAD(salary_year_avg) OVER(PARTITION BY job_title_short ORDER BY job_posted_date) AS next_posting_salary
    FROM 
        job_postings_fact
    WHERE salary_year_avg IS NOT NULL)

SELECT 
    *,
    CASE
        WHEN salary_year_avg < next_posting_salary THEN 'Increasing'
        WHEN salary_year_avg > next_posting_salary THEN 'Decreasing'
        ELSE 'Stable'
    END AS trend_direction
FROM salary_trends;