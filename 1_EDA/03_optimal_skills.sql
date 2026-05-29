/*
What are the most optimal skills for data engineers -- balancing both demand and salary?
* Create a ranking column that combines demand count and salary to identify the most valuable skills.
* Focus only on remote Data Engineer positions with specified annual salaries.
WHY?
* This approach highlights skills that balance market demand and financial reward.
It weights core skills appropriately, rather than letting rare, outlier skills distort the results.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_200_000, 2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' 
    AND jpf.job_country = 'United States'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY optimal_score DESC
LIMIT 25;

/*
Here's a breakdown of the most optimal skills for Data Engineers in the U.S., 
based on both high demand and high salaries:

Top Skills by Optimal Score:

- Python leads the list with over 5,200 postings and a $135K median salary, resulting in the highest overall optimal score.
- SQL closely follows with more than 5,300 postings and a $130K median salary, reinforcing its role as a core data engineering skill.
- AWS combines strong demand (3,292 postings) with a competitive $137.5K median salary, making it one of the most strategic cloud skills.
- MongoDB stands out with the highest median salary at $207K, though demand is more limited at 203 postings.
- Spark and Kafka both offer an excellent balance of compensation and demand, with salaries between $140K–$150K and over 1,400 postings each.

Cloud & Big Data Technologies:

- Snowflake, Azure, Databricks, and Redshift all rank highly due to their strong mix of salary potential and market demand.
- Hadoop, Spark, Kafka, and Cassandra continue to highlight the importance of distributed systems and large-scale data processing.

DevOps & Infrastructure Tools:

- Airflow ($147.5K), Kubernetes ($150K), Docker ($140K), and Terraform ($145K) stand out for combining infrastructure knowledge with strong compensation.
- Git also remains a valuable foundational engineering tool with broad industry demand.

Programming Languages & Databases:

- Java and Scala remain strong choices for well-paid data engineering roles, each pairing solid salaries with significant demand.
- NoSQL, MySQL, Oracle, and MongoDB all appear as valuable database technologies within modern data engineering stacks.

Summary:
The most optimal data engineering skills in the U.S. tend to combine strong salaries with high market demand. 
Python, SQL, AWS, Spark, Kafka, Airflow, and Snowflake consistently rank near the top, 
making them some of the most strategic skills for long-term career growth and job opportunities 
in data engineering.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python     │      135000.0 │         5238 │             8.6 │          0.96 │
│ sql        │      130000.0 │         5324 │             8.6 │          0.93 │
│ aws        │      137500.0 │         3292 │             8.1 │          0.93 │
│ mongo      │      207000.0 │          203 │             5.3 │          0.92 │
│ spark      │      140000.0 │         2544 │             7.8 │          0.91 │
│ kafka      │      150000.0 │         1492 │             7.3 │          0.91 │
│ airflow    │      147500.0 │         1159 │             7.1 │          0.87 │
│ snowflake  │      136000.0 │         1943 │             7.6 │          0.86 │
│ azure      │      130000.0 │         2738 │             7.9 │          0.86 │
│ java       │      138100.0 │         1789 │             7.5 │          0.86 │
│ scala      │      140500.0 │         1473 │             7.3 │          0.85 │
│ hadoop     │      140000.0 │         1419 │             7.3 │          0.85 │
│ redshift   │      138100.0 │         1348 │             7.2 │          0.83 │
│ kubernetes │      150000.0 │          669 │             6.5 │          0.81 │
│ nosql      │      137500.0 │         1211 │             7.1 │          0.81 │
│ databricks │      133400.0 │         1383 │             7.2 │           0.8 │
│ cassandra  │      150000.0 │          421 │             6.0 │          0.76 │
│ flow       │      135000.0 │          757 │             6.6 │          0.75 │
│ pyspark    │      139000.0 │          657 │             6.5 │          0.75 │
│ docker     │      140000.0 │          641 │             6.5 │          0.75 │
│ gcp        │      135000.0 │          811 │             6.7 │          0.75 │
│ terraform  │      145000.0 │          487 │             6.2 │          0.75 │
│ mysql      │      137500.0 │          664 │             6.5 │          0.74 │
│ oracle     │      128825.0 │          894 │             6.8 │          0.73 │
│ git        │      130000.0 │          823 │             6.7 │          0.73 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  25 rows                                                           5 columns

*/