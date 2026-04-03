SELECT CHAR_LENGTH('SQL');

SELECT LOWER('SQL');

SELECT UPPER('sql');

SELECT LEFT('SQL', 2);

SELECT RIGHT('SQL', 2);

SELECT SUBSTRING('SQL', 2, 2);

SELECT CONCAT('SQL', '-', 'Functions');

SELECT TRIM(' sql ');

SELECT REPLACE('swl', 'w', 'q');


-- Cleanup this using Text Functions

WITH title_lower AS (
    SELECT 
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean -- Para apanhar melhor os titulos
    FROM job_postings_fact
)
SELECT  
    job_title,
    CASE    
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 100;

-- NULLIF, neste caso conseguimos transformar os valores 0 em NULL

SELECT  
    NULLIF(salary_year_avg, 0),
    NULLIF(salary_hour_avg, 0)
FROM 
    job_postings_fact
WHERE salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
LIMIT 100;

-- COALESCE

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080)
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
LIMIT 100;

-- Simplify with COALESCE <-


SELECT 
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080) AS standardize_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) IS NULL THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) < 75_000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) < 150_000THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardize_salary DESC;