SELECT 
    job_id,
    UPPER(COALESCE(cd.name, 'Unknown')) AS company_name
FROM job_postings_fact jpf
LEFT JOIN company_dim cd
    ON jpf.company_id = cd.company_id
WHERE cd.name IS NULL;