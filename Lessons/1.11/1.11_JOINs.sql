SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
RIGHT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;

--1
SELECT
    jpf.job_title_short,
    cd.name
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;

SELECT *
FROM company_dim;

--2
SELECT
    MONTH(job_posted_date),
    COUNT(MONTH(job_posted_date))
FROM job_postings_fact
GROUP BY MONTH(job_posted_date)
ORDER BY 1 ASC;

--3
SELECT
    COUNT(name) AS numOfJobs,
    cd.name AS company_name
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
GROUP BY 2, job_work_from_home
HAVING job_work_from_home = TRUE
ORDER BY 1 DESC
LIMIT 5;

--3.2
SELECT
    COUNT(name) AS numOfJobs,
    cd.name AS company_name
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    job_work_from_home = TRUE
GROUP BY 2, job_work_from_home
ORDER BY 1 DESC
LIMIT 5;

--4
SELECT
    MONTH(job_posted_date),
    ROUND(AVG(salary_year_avg),2)
FROM job_postings_fact
GROUP BY MONTH(job_posted_date)
ORDER BY 1 ASC;

--5
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