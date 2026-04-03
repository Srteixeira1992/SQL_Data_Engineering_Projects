/* ===============================================================================
SET OPERATORS PRACTICE EXERCISES (LEGO do SQL)
Focus: UNION, UNION ALL, INTERSECT, EXCEPT
===============================================================================
*/

-- 🧩 Exercise 1: The Mega List (UNION)
-- Goal: Get a list of all unique 'job_title_short' that appeared in January 2023 OR January 2024.
-- Hint: Combine two SELECTs with UNION to remove duplicates.

-- WRITE YOUR CODE HERE:

SELECT
    job_title_short
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
    AND EXTRACT(MONTH FROM job_posted_date) = 1
UNION
SELECT
    job_title_short
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2024
    AND EXTRACT(MONTH FROM job_posted_date) = 1;

-- 🧩 Exercise 2: Loyal Companies (INTERSECT)
-- Goal: Find the 'company_id' of companies that posted jobs in 2023 AND also posted in 2024.
-- Hint: Use INTERSECT to find the "common ground" between the two years.

-- WRITE YOUR CODE HERE:

SELECT
    company_id
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
INTERSECT
SELECT
    company_id
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2024;


-- 🧩 Exercise 3: The "Ghost" Titles (EXCEPT)
-- Goal: List 'job_title_short' that were present in 2023 but do NOT appear at all in 2024.
-- Hint: Use EXCEPT to subtract the 2024 titles from the 2023 list.

-- WRITE YOUR CODE HERE:

SELECT
    job_title
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
EXCEPT
SELECT
    job_title
FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2024;


-- 🧩 Exercise 4: The Big Stack (UNION ALL + CTE)
-- Goal: Combine all 'job_title_short' and 'job_location' from both 2023 and 2024 into one giant list.
-- Use UNION ALL because we want to keep every single record (even duplicates).
-- Hint: To make it clean, try putting the UNION ALL inside a CTE and then do a SELECT * FROM that CTE.

-- WRITE YOUR CODE HERE:

WITH big_stack AS (
    SELECT 
        job_title_short,
        job_location
    FROM job_postings_fact
    WHERE
        EXTRACT(YEAR FROM job_posted_date) = 2023
    UNION ALL
  SELECT 
        job_title_short,
        job_location
    FROM job_postings_fact
    WHERE
        EXTRACT(YEAR FROM job_posted_date) = 2024
) 
SELECT * FROM big_stack;