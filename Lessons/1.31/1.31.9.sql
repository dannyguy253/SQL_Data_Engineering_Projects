WITH skill_counts AS (
    SELECT 
        jpf.company_id,
        jpf.job_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS unique_skill_count
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    GROUP BY 
        jpf.company_id,
        jpf.job_id
),

avg_skills AS (
    SELECT 
        company_id,
        AVG(unique_skill_count) AS avg_skills_per_company
    FROM skill_counts
    GROUP BY company_id
)

SELECT 
    job_id, 
    unique_skill_count,
    avg_skills_per_company
FROM skill_counts AS s
INNER JOIN avg_skills AS a
    ON s.company_id = a.company_id
WHERE unique_skill_count > avg_skills_per_company
ORDER BY unique_skill_count DESC
LIMIT 100;
    
SELECT *
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';