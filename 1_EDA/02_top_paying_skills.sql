/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on U.S. positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/


SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'United States'
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY MEDIAN(jpf.salary_year_avg) DESC
LIMIT 25;

SELECT *
FROM job_postings_fact
LIMIT 10;

/* 
Here's a breakdown of the highest-paying skills for Data Engineers:

Key Insights:

- MongoDB is the top-paying skill at $207K median salary, while also maintaining relatively strong demand with 2,097 postings.
- Rust continues to command high salaries at $175K median salary, though demand remains more limited with 282 postings.
- Atlassian and Golang both offer strong salaries above $158K median salary, with moderate market demand.
- Other notable skills with both high pay and moderate-to-high demand include:
  - Ansible: $157.5K median salary (1,169 postings)
  - Kafka: $150K median salary (14,688 postings)
  - Kubernetes: $150K median salary (6,384 postings)
  - Cassandra: $150K median salary (4,296 postings)
  - Airflow: $147.5K median salary (11,337 postings)
  - Terraform: $145K median salary (4,955 postings)
- Kafka, Airflow, Kubernetes, and Terraform stand out for combining high salaries with strong market demand.
- Many of the highest-paying skills are related to infrastructure, distributed systems, and large-scale data processing technologies.

Takeaway: While some of the highest-paying skills like Rust and Groovy remain relatively niche, 
many infrastructure and distributed system technologies such as Kafka, Airflow, Kubernetes, Cassandra, and Terraform 
offer both strong compensation and high demand. 
This suggests that focusing on scalable data infrastructure and pipeline technologies provides a strong balance 
between salary potential and marketability in data engineering.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ mongo      │      207000.0 │         2097 │
│ rust       │      175000.0 │          282 │
│ atlassian  │      165000.0 │          506 │
│ golang     │      158500.0 │          537 │
│ groovy     │      157500.0 │          173 │
│ ansible    │      157500.0 │         1169 │
│ puppet     │      157500.0 │          260 │
│ zoom       │      155000.0 │          215 │
│ typescript │      155000.0 │          565 │
│ plotly     │      155000.0 │          149 │
│ kafka      │      150000.0 │        14688 │
│ pytorch    │      150000.0 │          982 │
│ redis      │      150000.0 │          735 │
│ kubernetes │      150000.0 │         6384 │
│ node       │      150000.0 │          388 │
│ cassandra  │      150000.0 │         4296 │
│ ruby       │      150000.0 │         1298 │
│ airflow    │      147500.0 │        11337 │
│ graphql    │      146500.0 │          665 │
│ c          │      146325.0 │         1578 │
│ centos     │      145500.0 │          154 │
│ terraform  │      145000.0 │         4955 │
│ fastapi    │      145000.0 │          295 │
│ vmware     │      143798.0 │          241 │
│ slack      │      142500.0 │          203 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
*/