-- Subquery
SELECT *
FROM ( 
    SELECT *
    FROM 
        job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
LIMIT 10;

--CTE
WITH valid_salaries AS (
    SELECT *
    FROM 
        job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries;

-- Scenario 1 - Subquery in 'SELECT'
-- Show each job's salary next to the overall market median:

SELECT 
    job_title_short, 
    salary_year_avg,
    (
    SELECT 
        MEDIAN(salary_year_avg)
    FROM 
        job_postings_fact
    ) AS market_median_salary,
    -- 2. Repetes a subquery para subtrair do salário individual
    salary_year_avg - (
        SELECT MEDIAN(salary_year_avg) 
        FROM job_postings_fact
    ) AS salary_diff
FROM 
        job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
ORDER BY salary_diff DESC
LIMIT 10;
    



-- Scenario 2 - Subquery in FROM
-- Stage only jobs that are remote before aggregating:

SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
     SELECT 
        MEDIAN(salary_year_avg)
    FROM 
        job_postings_fact
    WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary,
FROM (
    SELECT 
        job_title_short, 
        salary_year_avg
    FROM
        job_postings_fact
    WHERE 
        job_work_from_home = TRUE
) AS clean_jobs
GROUP BY    
    job_title_short;

-- Scenario 3 - Subquery in HAVING
-- Keep only job titles whose median salary is above the overall median:

SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
     SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary,
FROM (
    SELECT 
        job_title_short, 
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE)
ORDER BY 2 DESC;

/*
Resumo Visual 
Tipo de Subquery        Localização     Função Principal
Escalar                 SELECT          Adicionar um valor fixo a cada linha para comparação.
Tabela Derivada         FROM            Criar uma "sub-tabela" filtrada antes do processamento principal.
Filtro de Grupo         HAVING          Comparar métricas de um grupo com um padrão externo.
*/

--1
SELECT
    job_title,
    company_id
FROM 
    job_postings_fact
WHERE company_id = (SELECT company_id FROM company_dim WHERE name = 'Capital One');

--2
SELECT
    job_title_short,
    salary_year_avg,
        (SELECT 
            MAX(salary_year_avg) 
        FROM job_postings_fact 
        WHERE job_title_short = 'Data Engineer' 
        AND job_work_from_home = TRUE) AS max_salary,
    salary_year_avg - 
        (SELECT 
            MAX(salary_year_avg) 
        FROM job_postings_fact 
        WHERE job_title_short = 'Data Engineer' 
        AND job_work_from_home = TRUE) AS salary_diff
FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Engineer' 
    AND job_work_from_home = TRUE
ORDER BY salary_diff DESC;

--3
SELECT 
    skills,
    COUNT(*) AS skill_count
FROM (
    SELECT 
        skill_id,
        skills
    FROM skills_dim)
WHERE skills LIKE 'p%'
GROUP BY skills;

--4
SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg),2) AS avg_salary,
    (SELECT
        ROUND(AVG(salary_year_avg),1)
    FROM job_postings_fact
    WHERE 
        job_title_short = 'Data Scientist' 
        AND salary_year_avg IS NOT NULL) AS avg_data_scientist_salary
FROM    
    job_postings_fact
GROUP BY job_title_short
HAVING avg_salary > (
    SELECT
        ROUND(AVG(salary_year_avg),1)
    FROM job_postings_fact
    WHERE 
        job_title_short = 'Data Scientist' 
        AND salary_year_avg IS NOT NULL);

-- Luke again!
-- CTE Example

WITH title_median AS (
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg) ::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'Portugal'
    GROUP BY 
        job_title_short,
        job_work_from_home
)

SELECT
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE 
    AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;





-- Final Example
-- Identify job postings  that have no associated skills before loading them into a data mart

SELECT * 
FROM job_postings_fact AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS src
    WHERE tgt.job_id = src.job_id
)
ORDER BY tgt.job_id;
