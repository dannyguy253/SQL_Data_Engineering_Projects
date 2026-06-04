SELECT skills
FROM data_jobs.skills_dim AS sd
WHERE NOT EXISTS (
    SELECT 1
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    WHERE job_title_short = 'Senior Data Engineer' 
    AND sjd.skill_id = sd.skill_id
);