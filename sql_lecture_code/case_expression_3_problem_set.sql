-- Catergorization of Salary using CASE statement
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High salary'
        WHEN salary_year_avg >= 60000 THEN 'Standard salary'
        WHEN salary_year_Avg < 60000 THEN 'Low salary'
    END AS salary_bucketing
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC;








-- COUNT OF WFH vs On-site jobs using CASE expressions
SELECT
    -- job_work_from_home,
    CASE
        WHEN job_work_from_home IS TRUE THEN 'WFH-Remote'
        WHEN job_work_from_home IS FALSE THEN 'On-Site'
    END AS job_working_type,
    COUNT (DISTINCT company_id) AS job_count
FROM 
    job_postings_fact
GROUP BY
    job_working_type;

/*
Luke Barousse Solution
SELECT 
    COUNT   (DISTINCT 
                CASE 
                    WHEN job_work_from_home = TRUE THEN company_id 
                END
            ) AS wfh_companies,
    COUNT   (DISTINCT 
                CASE 
                    WHEN job_work_from_home = FALSE THEN company_id 
                END
            ) AS non_wfh_companies
FROM job_postings_fact;
*/












-- Case statements using ILIKE FUNCTION
SELECT
    job_id,
    salary_year_avg,

    CASE
        WHEN job_title ILIKE '%Senior%' THEN 'Senior'
        WHEN job_title ILIKE '%Lead%' OR job_title ILIKE '%Manager%' THEN 'Lead/Manager'
        WHEN job_title ILIKE '%Junior%' OR job_title ILIKE'Entry%' THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,

    CASE
        WHEN job_work_from_home IS TRUE THEN 'YES'
        ELSE 'NO'
    END AS remote_option
    
FROM
    job_postings_fact
WHERE
    salary_year_avg is NOT NULL
ORDER BY
    job_id;