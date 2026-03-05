/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT    
    sd.skills,
    COUNT(sd.skills),
    ROUND(MEDIAN(salary_year_avg))
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_work_from_home = TRUE 
    AND job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(sd.skills) > 100
ORDER BY 3 DESC
LIMIT 25;

/*
┌────────────┬──────────────────┬────────────────────────────────┐
│   skills   │ count(sd.skills) │ round(median(salary_year_avg)) │
│  varchar   │      int64       │             double             │
├────────────┼──────────────────┼────────────────────────────────┤
│ terraform  │              193 │                       184000.0 │
│ kubernetes │              147 │                       150500.0 │
│ airflow    │              386 │                       150000.0 │
│ kafka      │              292 │                       145000.0 │
│ go         │              113 │                       140000.0 │
│ pyspark    │              152 │                       140000.0 │
│ git        │              208 │                       140000.0 │
│ spark      │              503 │                       140000.0 │
│ aws        │              783 │                       137320.0 │
│ scala      │              247 │                       137290.0 │
│ gcp        │              196 │                       136000.0 │
│ mongodb    │              136 │                       135750.0 │
│ snowflake  │              438 │                       135500.0 │
│ github     │              127 │                       135000.0 │
│ hadoop     │              198 │                       135000.0 │
│ python     │             1133 │                       135000.0 │
│ bigquery   │              123 │                       135000.0 │
│ java       │              303 │                       135000.0 │
│ docker     │              144 │                       135000.0 │
│ r          │              133 │                       134775.0 │
│ nosql      │              193 │                       134415.0 │
│ databricks │              266 │                       132750.0 │
│ mysql      │              101 │                       130500.0 │
│ sql        │             1128 │                       130000.0 │
│ redshift   │              274 │                       130000.0 │
├────────────┴──────────────────┴────────────────────────────────┤
│ 25 rows                                              3 columns │
└────────────────────────────────────────────────────────────────┘
*/
