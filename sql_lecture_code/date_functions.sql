SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

/*
:: - This is called casting.
        You can cast a string from one datatype to another 
        Usually used in a SELECT statement

*/

SELECT 
    '13-10-2025':: DATE,
    '123'::INT,
    'true'::BOOLEAN,
    '3.14'::REAL;


-- Getting back to executing SQL 
-- :: - This is called casting.
SELECT
    job_title_short AS title,
    job_location AS location,

    -- Converting the datatype to DATE to strictly get just dates (excluding the time).
     job_posted_date::DATE date

FROM
    job_postings_fact AS jpc
LIMIT 5;





-- AT TIME ZONE
SELECT
    job_title_short AS title,
    job_location AS location,

    -- AT TIME ZONE
    -- We have an issue that our job_posted_date column adheres to date + time 
    -- but doesn't adhere to timezones like mostly the data is in US time and not e.g. IST
    -- We fixed that (FROM what time zone) to (what time zone you want to go to)
    -- The time will go -5:00 hours
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'

FROM
    job_postings_fact AS jpc
LIMIT 5;






--EXTRACT gets field (e.g. year, month, day)from date/time value.
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',

    -- Extracting month and year 
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year

FROM
    job_postings_fact AS jpc
LIMIT 5;








--Use case: How job posting for a data analyst vary 
--          from month to month
SELECT
    COUNT(job_id) AS job_posted_count,
    -- job_posted_date,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month

FROM 
    job_postings_fact

WHERE job_title_short = 'Data Analyst'

GROUP BY
    job_posted_month

ORDER BY 
    job_posted_count DESC;
--LIMIT 5;