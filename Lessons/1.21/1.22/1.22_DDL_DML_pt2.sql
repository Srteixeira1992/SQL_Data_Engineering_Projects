SELECT
    jpf.*,
    cd.*
FROM 
    job_postings_fact as jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id;
