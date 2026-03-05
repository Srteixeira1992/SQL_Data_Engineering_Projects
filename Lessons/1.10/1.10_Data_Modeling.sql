SELECT 
  job_id, 
  job_title_short,
  job_location,
  salary_year_avg
FROM 
  job_postings_fact
WHERE
  job_title_short = 'Data Engineer'
ORDER BY
  salary_year_avg DESC
LIMIT 10;

SELECT *
FROM information_schema.tables
WHERE table_catalog ='data_jobs';