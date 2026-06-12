WITH job_skills_array AS (
    SELECT 
        job_id, 
        ARRAY_AGG(skill_id) AS skill_id_array
    FROM skills_job_dim
    GROUP BY job_id
),

job_skills_unnest AS (
SELECT job_id,
    UNNEST(skill_id_array) AS skill_id
FROM job_skills_array
)

SELECT 
    jsu.job_id,
    sd.skills AS skill_name
FROM skills_dim AS sd
INNER JOIN job_skills_unnest jsu
    ON sd.skill_id = jsu.skill_id;