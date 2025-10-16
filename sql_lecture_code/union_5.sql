/*
UNION
-- Combine tables of associated similar data-types of columns
-- deletes duplicate row

🧠 Result:
All unique job postings from January → March (duplicates removed).
*/

SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION --Combine the table below

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION --Combine the table below

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs


/*
UNION ALL
-- Combine tables of associated similar data-types of columns
-- retains duplicate row

🧠 Result:
All postings from Jan–Mar, duplicates included.
*/

SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL --Combine the table below

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL --Combine the table below

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs