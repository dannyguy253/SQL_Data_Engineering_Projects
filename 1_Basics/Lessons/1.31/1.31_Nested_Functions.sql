-- Array Intro
SELECT [1,2,3];

SELECT ['python','sql','r'] AS skills_array;

WITH skills AS (
    SELECT 'python' AS skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
),

skills_array AS (

    SELECT ARRAY_AGG(skill ORDER BY skill) AS skills -- must include ORDER BY if you want array put in consistent order
    FROM skills)

SELECT 
    skills[1] AS first_skill,
    skills[2] AS second_skill,
    skills[3] AS third_skill
FROM skills_array;

-- STRUCT
SELECT { skill: 'python', type: 'programming'} AS skill_struct;

WITH skill_struct AS (
SELECT 
    STRUCT_PACK(
        skill := 'python',
        type := 'programming'
    ) AS s
)

SELECT 
    s.skill,
    s.type
FROM skill_struct;


WITH skill_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT
    STRUCT_PACK(
        skill := skills,
        type := types
    )
FROM skill_table;