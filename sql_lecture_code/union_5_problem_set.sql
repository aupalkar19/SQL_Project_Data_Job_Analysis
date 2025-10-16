-- UNION and UNION ALL
/*
Problem Statement 1:
Create a unified query that categorizes job postings into two groups: those with salary information (salary_year_avg or salary_hour_avg is not null) and those without it. Each job posting should be listed with its job_id, job_title, and an indicator of whether salary information is provided.

Hint
Use UNION ALL to merge results from two separate queries.
For the first query, filter job postings where either salary field is not null to identify postings with salary information.
For the second query, filter for postings where both salary fields are null to identify postings without salary information.
Include a custom field to indicate the presence or absence of salary information in the output.
When categorizing data, you can create a custom label directly in your query using string literals, such as 'With Salary Info' or 'Without Salary Info'. These literals are manually inserted values that indicate specific characteristics of each record. An example of this is as a new column in the query that doesn’t have salary information, put: 'Without Salary Info' AS salary_info. As the last column in the SELECT statement.
*/
(
SELECT
    jpc.job_id,
    jpc.job_title,
    jpc.salary_year_avg,
    jpc.salary_hour_avg,
    'With salary info' AS salary_info
FROM
    job_postings_fact AS jpc
WHERE
    salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
)
UNION ALL --Combining tables, with duplicate rows
(
SELECT
    jpc.job_id,
    jpc.job_title,
    jpc.salary_year_avg,
    jpc.salary_hour_avg,
    'Without salary info' AS salary_info
FROM
    job_postings_fact AS jpc
WHERE
    salary_year_avg IS NULL AND salary_hour_avg IS NULL
)
ORDER BY
    salary_info DESC,
    job_id;













/*
Problem Statement 2:
Retrieve the job id, job title short, job location, job via, skill and skill type for each job posting from the first quarter (January to March). Using a subquery to combine job postings from the first quarter (these tables were created in the Advanced Section - Practice Problem 6 Video) Only include postings with an average yearly salary greater than $70,000.

Hint
Use UNION ALL to combine job postings from January, February, and March into a single dataset.
Apply a LEFT JOIN to include skills information, allowing for job postings without associated skills to be included.
Filter the results to only include job postings with an average yearly salary above $70,000.
*/

WITH first_quarter_jobs AS (
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs
)

SELECT
    fqj.job_id,
    fqj.job_title_short,
    fqj.job_location,
    fqj.job_via,
    sd.skills,
    sd.type
FROM skills_dim AS sd
    RIGHT JOIN skills_job_dim AS sjd ON sjd.skill_id = sd.skill_id
    RIGHT JOIN first_quarter_jobs AS fqj ON fqj.job_id = sjd.job_id
WHERE fqj.salary_year_avg > 70000
ORDER BY fqj.job_id;













/*
Problem Statement 3
Analyze the monthly demand for skills by counting the number of job postings for each skill in the first quarter (January to March), utilizing data from separate tables for each month. Ensure to include skills from all job postings across these months. The tables for the first quarter job postings were created in Practice Problem 6.

Hint
Use UNION ALL to combine job postings from January, February, and March into a consolidated dataset.
Apply the EXTRACT function to obtain the year and month from job posting dates, even though the month will be implicitly known from the source table.
Group the combined results by skill to summarize the total postings for each skill across the first quarter.
Join with the skills dimension table to match skill IDs with skill names.
*/

WITH first_quarter_jobs_monthly_skill_count AS (
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs
)

SELECT
    sd.skills AS skill_name,
    EXTRACT (YEAR FROM job_posted_date) job_year,
    EXTRACT (MONTH FROM job_posted_date) job_month,
    COUNT(sjd.job_id) As skill_count

FROM first_quarter_jobs_monthly_skill_count AS fqjmsk 
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = fqjmsk.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id

GROUP BY 
    sd.skills,
    job_year,
    job_month