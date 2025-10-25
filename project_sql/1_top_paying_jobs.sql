/*
**Question: What are the top-paying data analyst jobs?**

- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries.
- Why? Aims to highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT 
    -- jpc.job_id,
    -- jpc.company_id,
    -- cd.company_id,
    cd.name,
    jpc.job_title_short,
    jpc.job_work_from_home,
    jpc.job_location,
    jpc.salary_year_avg
FROM job_postings_fact AS jpc
    LEFT JOIN company_dim AS cd ON cd.company_id = jpc.company_id
WHERE job_work_from_home IS TRUE
        AND salary_year_avg is NOT NULL 
        AND job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10