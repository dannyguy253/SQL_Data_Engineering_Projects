USE company_jobs;

SELECT *
FROM staging.priority_skills;

-- updating source table

UPDATE staging.priority_skills
SET priority_lvl = 1
WHERE skill_id = 0;

UPDATE staging.priority_skills
SET priority_lvl = 2
WHERE skill_id = 1;

-- merge changes onto target table with new status v1

MERGE INTO main.job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON tgt.skill_id = src.skill_id

-- WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
-- WHEN MATCHED AND ((tgt.priority_lvl <> src.priority_lvl) OR (tgt.priority_lvl IS NULL)) THEN
WHEN MATCHED AND (tgt.priority_lvl <> src.priority_lvl) THEN
UPDATE SET 
    priority_lvl = src.priority_lvl,
    status = 'PRIORITY_CHANGE';


SELECT *
FROM staging.priority_skills;

    
SELECT DISTINCT status
FROM job_skill_priorities;

SELECT *
FROM job_skill_priorities;

