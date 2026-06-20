WITH salary_arrays AS (
    SELECT 
        company_id,
        AVG(salary_year_avg) AS avg_salary,
        ARRAY_AGG(salary_year_avg) AS salary_array
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY company_id
),

unnest_salary_arrays AS (
    SELECT
        company_id,
        avg_salary,
        UNNEST(salary_array) AS salaries
    FROM salary_arrays
)

SELECT 
    company_id,
    salaries AS specific_salary,
    avg_salary AS avg_company_salary
FROM unnest_salary_arrays
WHERE salaries > avg_salary * 1.5;