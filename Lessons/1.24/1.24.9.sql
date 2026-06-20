USE company_jobs;

-- make a deletion in source data (removed python record)
DELETE FROM staging.priority_skills AS src
WHERE skill_id = 1;

SELECT *
FROM staging.priority_skills;

MERGE INTO company_jobs.job_skill_priorities AS tgt
USING (
    SELECT 
        sjd.job_id, 
        ps.skill_id,
        ps.skill_name,
        ps.priority_lvl
    FROM data_jobs.skills_job_dim sjd
    INNER JOIN staging.priority_skills ps
        ON sjd.skill_id = ps.skill_id
) AS src
ON tgt.job_id = src.job_id AND tgt.skill_id = src.skill_id

-- update existing records
WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
UPDATE SET
    priority_lvl = src.priority_lvl,
    status = 'PRIORITY_CHANGE'

-- insert rows into tgt from src table
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        job_id,
        skill_id,
        skill_name,
        priority_lvl,
        status
    )
    VALUES (
        src.job_id,
        src.skill_id,
        src.skill_name,
        src.priority_lvl,
        'NEW_SKILL'
    )

-- delete rows in tgt table no longer existing in src table
WHEN NOT MATCHED BY SOURCE THEN DELETE;



-- target table
SELECT *
FROM company_jobs.job_skill_priorities;

-- verify target table where skill_id = 1
SELECT *
FROM company_jobs.job_skill_priorities
WHERE skill_id = 1;

