-- Subquries and CTE
-- A query nested within the main query
SELECT *
FROM ( -- Subquery starts
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs; -- Subquery ends







-- Another popular way to create temporary result set
-- CTE (Common Table Expressions)
WITH january_jobs AS ( --CTE starts
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)--CTE ends

SELECT *
FROM january_jobs








--Getting a company id for a candidate who doesn't have a degree
SELECT  
    company_id,
    job_no_degree_mention
FROM    
    job_postings_fact
WHERE
    job_no_degree_mention IS TRUE
LIMIT 10;
--Continuing below
--Getting a company name for a candidate who doesn't have a degree
--Using subquery to backtrack the condition (job_no_degree_mention IS TRUE)
    --from foreign company_id in jpc table
        -- to primary company_id in sd table
        -- retriving name
SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention IS TRUE
    ORDER BY
        company_id
)









--CTE example
/*
Find the companies that have the most job openings.
- Get the total number of job postings per company_id (job_postings_fact)
- Return the total number of jobs with the company name (comapnay_dim)
*/

WITH company_job_count AS(
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)

--Checking the CTE that stores the same temporary result set
-- SELECT *
-- FROM job_openings_count

SELECT 
    cd.name AS company_name,
    cjc.total_jobs
FROM 
    company_dim AS cd
    
    LEFT JOIN company_job_count AS cjc
        ON cjc.company_id = cd.company_id
ORDER BY
    total_jobs DESC;