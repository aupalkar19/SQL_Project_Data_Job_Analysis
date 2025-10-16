/*Job_type grouping by based on year and hour salary avg*/
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS year_salary,
    AVG(salary_hour_avg) AS hour_salary
FROM job_postings_fact
WHERE job_posted_date::date > '2023-06-01 23:59:59'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;






/* Grouping extracted month based on 'America/New_York' against job_count*/
SELECT 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS extracted_month,
    COUNT(*) AS job_count
FROM 
    job_postings_fact
GROUP BY
    extracted_month
ORDER BY
    extracted_month;







/*Grouping company_name to get job_count WHERE Health Insurance TRUE and only for second quarter*/
SELECT 
    cd.name AS company_name,
    COUNT(jpc.job_id) AS job_count

    --jpc.company_id,
    --cd.company_id

FROM
    job_postings_fact AS jpc
    INNER JOIN company_dim AS cd 
        ON jpc.company_id = cd.company_id

WHERE 
    job_health_insurance is TRUE 
    AND (EXTRACT(QUARTER FROM jpc.job_posted_date::DATE) = 2)

GROUP BY 
    cd.name

HAVING
    COUNT(jpc.job_id) > 0

ORDER BY
    job_count DESC;

