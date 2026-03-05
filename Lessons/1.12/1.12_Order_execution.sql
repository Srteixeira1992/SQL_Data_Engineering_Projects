EXPLAIN
SELECT
    name,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
GROUP BY 1
HAVING
    ROUND(AVG(salary_year_avg)) > 150000
ORDER BY 2 DESC;