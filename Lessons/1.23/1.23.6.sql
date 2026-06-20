WITH core_skills AS (
    SELECT 
        skill_id,
        type AS skill_type
    FROM
        skills_dim
    WHERE 
        type IN ('programming', 'databases')
)

SELECT 
    cs.skill_type,
    COUNT(DISTINCT job_id) AS unique_job_count
FROM core_skills cs
INNER JOIN skills_job_dim sjd
ON cs.skill_id = sjd.skill_id
GROUP BY cs.skill_type
ORDER BY unique_job_count DESC;

