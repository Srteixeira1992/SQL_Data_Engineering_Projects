SELECT
    EXTRACT (YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT (MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(*)
FROM job_postings_fact
GROUP BY 
    EXTRACT (YEAR FROM job_posted_date), 
    EXTRACT (MONTH FROM job_posted_date)
ORDER BY
    job_posted_year,
    job_posted_month;


SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_date,
    COUNT(job_id) AS job_count´
FROM job_postings_fact
WHERE
    job_title_short = 'Data Engineer'
    AND EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY    
    DATE_TRUNC('month', job_posted_date)
ORDER BY
    job_posted_date;