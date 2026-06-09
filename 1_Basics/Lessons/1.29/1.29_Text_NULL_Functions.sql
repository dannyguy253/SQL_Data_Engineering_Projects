SELECT LENGTH('SQL');

SELECT CHAR_LENGTH('SQL');

SELECT LOWER('SQL');

SELECT UPPER('SqL');

SELECT LEFT('SQL', 2);

SELECT RIGHT('SQL', 2);

SELECT SUBSTRING('SQL', 1,2);

SELECT CONCAT('SQL', '-', 'Functions');

SELECT REPLACE('SQL', 'Q', '_');

SELECT REGEXP_REPLACE('SQL', '[A-Z]+', 'sql');

SELECT REGEXP_REPLACE('data.nerd@gmail.com', '^.*(@)', '\1'); -- use chatgpt for regexp patterns like this

-- final example for text functions

WITH title_lower AS (
    SELECT 
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT 
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Analyst'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;


SELECT NULLIF(10,10);

SELECT NULLIF(10,20);

SELECT 
    MEDIAN(NULLIF(salary_year_avg,0)),
    MEDIAN(NULLIF(salary_hour_avg,0))
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

SELECT 
    salary_year_avg,
    salary_hour_avg
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
ORDER BY salary_year_avg
LIMIT 10;


SELECT COALESCE(0,1,2);

SELECT COALESCE(NULL,1,2);

SELECT COALESCE(NULL, NULL,2);

SELECT 
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;


-- final example - simplify with coalesce from the case statement example


SELECT 
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
    CASE 
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 75_000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC;
