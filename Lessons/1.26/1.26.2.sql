-- count total number of companies that offers wfh positions and non-wfh positions

SELECT 
    COUNT(DISTINCT CASE WHEN jpf.job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT CASE WHEN jpf.job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM 
    job_postings_fact AS jpf;