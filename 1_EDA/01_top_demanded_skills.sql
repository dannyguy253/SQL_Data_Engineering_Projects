/*
What are the most in-demand skills for data engineers?
* Identify the top 10 in-demand skills for data engineers
* Focus on job postings in United States
Why?
* Retrieves the top 10 skills with highest demand in the U.S. job market, providing insights into most 
valuable skills for data engineers seeking work in U.S.
*/


/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/
SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'United States'
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*

Here's a breakdown of the most demanded skills for Data Engineers in the U.S.:
SQL and Python are by far the most in-demand skills, with over 55,000 job postings each, 
reinforcing their importance as foundational data engineering skills.

Cloud platforms rank highly in demand, with AWS leading at nearly 36,000 postings, 
followed by Azure at over 29,000 postings.

Apache Spark rounds out the top 5 most requested skills, 
highlighting the growing importance of big data and distributed processing technologies.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering roles
- Big data tools like Spark continue to be highly valued
- Modern data platform tools such as Snowflake and Databricks show strong industry demand
- Java, Scala, and Kafka remain important technologies within large-scale and distributed data engineering systems

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        56933 │
│ python     │        55159 │
│ aws        │        35698 │
│ azure      │        29236 │
│ spark      │        26768 │
│ snowflake  │        19996 │
│ java       │        19405 │
│ databricks │        15430 │
│ scala      │        14921 │
│ kafka      │        14688 │
└────────────┴──────────────┘
  10 rows         2 columns
*/

