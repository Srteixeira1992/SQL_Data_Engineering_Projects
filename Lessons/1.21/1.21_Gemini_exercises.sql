-- .read "Lessons/1.21/1.21_Gemini_exercises.sql"
USE jobs_mart;

DROP TABLE IF EXISTS archive_applications;
DROP SCHEMA IF EXISTS recruitment;


SELECT *
FROM
    information_schema.schemata;

CREATE SCHEMA IF NOT EXISTS recruitment;

CREATE TABLE IF NOT EXISTS job_applications (
    app_id INT PRIMARY KEY,
    candidate_name VARCHAR,
    application_date DATE
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

INSERT INTO job_applications (app_id, candidate_name, application_date)
VALUES 
    (1, 'Tomás Araújo', '2025-11-25'),
    (2, 'Gonçalo Ramos', '2025-12-14'),
    (3, 'João Neves', '2026-01-26');

SELECT *
FROM job_applications;

ALTER TABLE job_applications
ADD COLUMN interview_score FLOAT;

ALTER TABLE job_applications
RENAME COLUMN candidate_name TO full_name;

UPDATE job_applications
SET interview_score = 8.5
WHERE app_id = 1;

UPDATE job_applications
SET interview_score = 0.0
WHERE interview_score IS NULL;

SELECT *
FROM information_schema.columns
WHERE table_name = 'job_application';

ALTER TABLE job_applications
DROP COLUMN application_date;

ALTER TABLE job_applications
RENAME TO archive_applications;

SELECT *
FROM archive_applications;
