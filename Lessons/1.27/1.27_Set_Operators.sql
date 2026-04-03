SELECT UNNEST ([1, 1, 1, 2])
UNION
SELECT UNNEST ([1, 1, 3]);

CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2024;

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

-- Which unique job postings appeard in either 2023 and 2024?

SELECT DISTINCT(*)
FROM jobs_2023
UNION
SELECT DISTINCT(*)
FROM jobs_2024;

-- Which job postings appeard across both years, counting duplicates? 

SELECT *
FROM jobs_2023
UNION ALL
SELECT *
FROM jobs_2024;

-- Which job postings appeard in 2023 but not in 2024? 

SELECT *
FROM jobs_2023
EXCEPT
SELECT *
FROM jobs_2024;

-- Which job postings from 2023 remain after substracting matching 2024 postings, one-for-one? 

SELECT *
FROM jobs_2023
EXCEPT ALL
SELECT *
FROM jobs_2024;

-- Which job postings appeard in 2023 and in 2024?

SELECT *
FROM jobs_2023
INTERSECT
SELECT *
FROM jobs_2024;

-- Which job postings appeard in both years, perserving duplicate counts?

SELECT *
FROM jobs_2023
INTERSECT ALL
SELECT *
FROM jobs_2024;