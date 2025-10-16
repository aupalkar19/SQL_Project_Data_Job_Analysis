-- Creating tables for january, febuary and march
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- Verifying individually by one line of code at a time
SELECT COUNT(*) FROM january_jobs;
SELECT COUNT(*) FROM february_jobs;
SELECT COUNT(*) FROM march_jobs;


