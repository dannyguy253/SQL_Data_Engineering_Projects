WITH skill_counts AS (
    SELECT 
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS unique_skill_count
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    GROUP BY jpf.company_id
),

company_names AS (
    SELECT 
        cd.name AS company_name,
        -- cd.company_id,
        unique_skill_count,
        DENSE_RANK() OVER(ORDER BY unique_skill_count DESC) AS diversity_rank
    FROM skill_counts AS sc
    INNER JOIN company_dim AS cd
        ON sc.company_id = cd.company_id
)

SELECT *
FROM company_names
WHERE diversity_rank <= 10;
