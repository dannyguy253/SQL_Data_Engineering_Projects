SELECT 
    jpf.job_id,
    jpf.job_title_short
FROM
    job_postings_fact jpf
WHERE 
    jpf.job_title_short = 'Data Engineer'
AND EXISTS (
    SELECT 1
    FROM skills_job_dim sjd
    INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
    WHERE sjd.job_id = jpf.job_id AND
    sd.skills = 'python'
);