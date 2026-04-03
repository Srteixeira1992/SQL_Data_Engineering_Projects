/* ===============================================================================
DATE FUNCTIONS PRACTICE EXERCISES
Focus: EXTRACT, DATE_TRUNC, and AT TIME ZONE
===============================================================================
*/

-- 🧩 Exercise 1: The "Month of the Year" Extract
-- Goal: List the job title and the specific month (as a number) when the job was posted.
-- Hint: Use EXTRACT(MONTH FROM column_name).

-- WRITE YOUR CODE HERE:
SELECT
    job_title_short,
    EXTRACT(MONTH FROM job_posted_date) AS Month
FROM job_postings_fact
LIMIT 100;



-- 🧩 Exercise 2: Monthly Trends with Truncation
-- Goal: Count how many jobs were posted per month, rounding every date to the first of the month.
-- Hint: Use DATE_TRUNC('month', column_name) and remember to GROUP BY.

-- WRITE YOUR CODE HERE:

SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_date,
    COUNT(job_id) AS job_count
FROM job_postings_fact
GROUP BY    
    DATE_TRUNC('month', job_posted_date)
ORDER BY
    job_posted_date;



-- 🧩 Exercise 3: Time Zone Shift (New York Time)
-- Goal: The 'job_posted_date' is in UTC. Show the title and the original date, 
-- but add a column with the date converted to 'EST' (Eastern Standard Time).
-- Hint: Use column_name AT TIME ZONE 'UTC' AT TIME ZONE 'EST'.

-- WRITE YOUR CODE HERE:

SELECT
    job_posted_date,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_converted
FROM job_postings_fact
LIMIT 200;




-- 🧩 Exercise 4: Filtering by specific time
-- Goal: Find only the jobs that were posted in the year 2023, specifically in the month of June.
-- Hint: You can use EXTRACT twice in the WHERE clause with an AND.

-- WRITE YOUR CODE HERE:


SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_date,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE
    EXTRACT (MONTH FROM job_posted_date) = 06
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY    
    DATE_TRUNC('month', job_posted_date)
ORDER BY
    job_posted_date;