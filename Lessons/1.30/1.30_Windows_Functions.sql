-- Find Hourly Salary

SELECT  
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short, company_id
    )
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 100;

-- Ranking hourly salary

SELECT  
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER(
        ORDER BY
            salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER BY 
    salary_hour_avg DESC
LIMIT 100;

-- PARTITION BY & ORDER BY - Running avg hourly salary

SELECT  
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short, company_id
    )
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 100;