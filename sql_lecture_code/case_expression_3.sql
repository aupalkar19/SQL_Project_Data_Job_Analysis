SELECT
    -- job_title_short,
    -- job_location,

    /*
    Label a new column
        - 'Anywhere' as 'Remote'
        -'New York, NY' as 'Local'
        - Otherwise 'Onsite'
    */

    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category,

    -- You can use the case statement column to get count of jobs 
    -- based on new value assigned into location_category
    COUNT(job_id) AS job_count
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;


