SELECT name 
FROM company_dim cd
WHERE EXISTS (
    SELECT 1
    FROM job_postings_fact jpf
    WHERE cd.company_id = jpf.company_id
);