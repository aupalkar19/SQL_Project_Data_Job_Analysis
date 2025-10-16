/*

Problem 1:Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.

Hint
Focus on creating a subquery that identifies and ranks (ORDER BY in descending order) the top 5 skill IDs by their frequency (COUNT) of mention in job postings.
Then join this subquery with the skills table (skills_dim) to match IDs to skill names.

*/
SELECT
    sd.skill_id,
    sd.skills,
    top_5_skills_on_count.skill_count
FROM skills_dim AS sd

INNER JOIN 
        (SELECT
            sjd.skill_id,
            COUNT (*) AS skill_count
        FROM skills_job_dim AS sjd
        GROUP BY
            sjd.skill_id 
        ORDER BY
            skill_count DESC
        LIMIT 5)
    AS top_5_skills_on_count
    ON sd.skill_id = top_5_skills_on_count.skill_id

ORDER BY top_5_skills_on_count.skill_count DESC;

/* Coded this first to be sub-querred onto INNER JOIN
-- Grouping top skill_count in desc order for each skill i.e. skill_id
SELECT
    sjd.skill_id,
    COUNT (*) AS skill_count
FROM skills_job_dim AS sjd
GROUP BY
    sjd.skill_id 
ORDER BY
    skill_count DESC
LIMIT 5;
*/


















/*

Problem 2: Problem Statement 
Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings they have. Use a subquery to calculate the total job postings per company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings. Implement a subquery to aggregate job counts per company before classifying them based on size.

Hint
Aggregate job counts per company in the subquery. This involves grouping by company and counting job postings.
Use this subquery in the FROM clause of your main query.
In the main query, categorize companies based on the aggregated job counts from the subquery with a CASE statement.
The subquery prepares data (counts jobs per company), and the outer query classifies companies based on these counts.

*/


SELECT
    company_id,
    name,
    job_count,

    CASE
        WHEN job_count < 10 THEN 'Small'
        WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
        WHEN job_count > 50 THEN 'Large'
    END AS company_category

FROM (
   SELECT
       cd.company_id,
       cd.name,
       COUNT(jpc.job_id) AS job_count
   FROM company_dim AS cd
   INNER JOIN job_postings_fact AS jpc
       ON cd.company_id = jpc.company_id
   GROUP BY
       cd.company_id
       -- company_dim.name
) AS company_job_count

/* Sub-querred into FROM statement
   SELECT
       cd.company_id,
       cd.name,
       COUNT(jpc.job_id) AS job_count
   FROM company_dim AS cd
   INNER JOIN job_postings_fact AS jpc
       ON cd.company_id = jpc.company_id
   GROUP BY
       cd.company_id,
       -- company_dim.name
*/















/*
Problem Statement 3 
Your goal is to find the names of companies that have an average salary greater than the overall average salary across all job postings.

You'll need to use two tables: company_dim (for company names) and job_postings_fact (for salary data). The solution requires using subqueries.


Hint:
Think of it as needing three pieces of information:

- The average salary for each company.

- The single overall average salary across all jobs.

- The names of the companies.



You'll build this query from the inside out.



Part 1️⃣ (Inner Subquery): Overall Average.

Goal: Get the single, overall average salary from all job postings.

Action: Write a subquery: SELECT AVG(salary_year_avg) FROM job_postings_fact.

Use: This will go inside your WHERE clause at the very end for comparison.



Part 2️⃣ (Subquery for JOIN): Average Salary Per Company.

Goal: Get the average salary for each company.

Action: Write a subquery that selects company_id and calculates AVG(salary_year_avg). You must GROUP BY company_id here.

Use: This subquery will be treated like a temporary table that you JOIN to company_dim.



Part 3️⃣ (Main Query): Putting It All Together.

Goal: Select company names and filter them based on the averages you calculated.

Action:

Start with SELECT name FROM company_dim.

JOIN your subquery from Part 2 to the company_dim table using company_id. This connects company names to their specific average salaries.

Use a WHERE clause to filter the results, keeping only rows where the company's average salary (from your Part 2 subquery) is greater than the overall average salary (your Part 1 subquery).
*/


/* 
-- Query 1: Job postings salary offered average
SELECT AVG(salary_year_avg) 
FROM job_postings_fact
WHERE salary_year_avg is NOT NULL

-- Query 2: Company average
SELECT 
    company_id, 
    AVG(salary_year_avg)
FROM job_postings_fact
WHERE salary_year_avg is NOT NULL
GROUP BY company_id
ORDER BY company_id
*/

-- Main Query
SELECT 
    cd.name,
    company_avg_salary_result.company_avg_salary 
FROM company_dim AS cd
    INNER JOIN (
        SELECT 
            company_id, 
            AVG(salary_year_avg) AS company_avg_salary
        FROM job_postings_fact
        WHERE salary_year_avg is NOT NULL
        GROUP BY company_id
        ORDER BY company_id
    ) AS company_avg_salary_result ON cd.company_id = company_avg_salary_result.company_id

WHERE
    company_avg_salary_result.company_avg_salary > (
                                                    SELECT AVG(salary_year_avg) 
                                                    FROM job_postings_fact 
                                                    WHERE salary_year_avg is NOT NULL
                                                    )











--CTE
/*
Problem Statement: Identify companies with the most diverse (unique) job titles. Use a CTE to count the number of unique job titles per company, then select companies with the highest diversity in job titles.

Hint
- Use a CTE to count the distinct number of job titles for each company.
- After identifying the number of unique job titles per company, join this result with the company_dim table to get the company names.
- Order your final results by the number of unique job titles in descending order to highlight the companies with the highest diversity.
- Limit your results to the top 10 companies. This limit helps focus on the companies with the most significant diversity in job roles. Think about how SQL determines which companies make it into the top 10 when there are ties in the number of unique job titles.
*/
--Created A CTE temporay table for get unique count of job titles for company_id
WITH unique_job_openings AS (
SELECT
    company_id,
    COUNT(DISTINCT jpc.job_title) AS job_count

FROM job_postings_fact AS jpc
GROUP BY company_id
) 

--Main query to associate comapny_id to comapny_name to get unique distinct counts of job_titles
SELECT
    cd.name,
    ujo.job_count
FROM company_dim AS cd
    INNER JOIN unique_job_openings AS ujo 
    ON cd.company_id = ujo.company_id
ORDER BY ujo.job_count DESC
LIMIT 10;







/*
Problem Statement 2
Explore job postings by listing job id, job titles, company names, and their average salary rates, while categorizing these salaries relative to the average in their respective countries. Include the month of the job posted date. Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages.
*/

--Define a CTE to calculate the average salary for each country.
WITH avg_salary_per_country AS (
    SELECT
        job_country,
        AVG(salary_year_avg) AS avg_salary_rates
    FROM job_postings_fact
    GROUP BY job_country
)


SELECT
    jpc.job_id,
    jpc.job_title,
    cd.name AS company_name,
    jpc.salary_year_avg,

    /*Within the main query, use a CASE WHEN statement to categorize each salary as 'Above Average' or 'Below Average' based on its comparison (>) to the country's average salary calculated in the CTE.*/
    CASE
        WHEN jpc.salary_year_avg > aspc.avg_salary_rates THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_stature,

    /*To include the month of the job posting, use the EXTRACT function on the job posting date within your SELECT statement.*/
    EXTRACT(MONTH FROM jpc.job_posted_date) AS job_month

/*Join the job postings data (job_postings_fact) with the CTE to compare individual salaries to the average. Additionally, join with the company dimension (company_dim) table to get company names linked to each job posting.*/
FROM job_postings_fact AS jpc
    INNER JOIN 
    avg_salary_per_country as aspc ON jpc.job_country = aspc.job_country
    
    INNER JOIN 
    company_dim AS cd ON jpc.company_id = cd.company_id 

ORDER BY job_month DESC;












/*
Problem Statement 3
Your goal is to calculate two metrics for each company:

The number of unique skills required for their job postings.

The highest average annual salary among job postings that require at least one skill.

Your final query should return the company name, the count of unique skills, and the highest salary. For companies with no skill-related job postings, the skill count should be 0 and the salary should be null.

Hint
Use two Common Table Expressions (CTEs) to organize your query.

#️⃣ required_skills - 1st CTE:

Goal: To count the distinct skill_id for each company.

Method: Use LEFT JOIN starting from company_dim. This ensures all companies are included in your result, even if they have no job postings or required skills.

💰 max_salary - 2nd CTE:

Goal: To find the highest salary_year_avg for each company.

Constraint: This calculation must only include jobs that have at least one skill associated with them. You can achieve this by using INNER JOINs or filtering with a WHERE clause.

Combine the company_dim table with your two CTEs using LEFT JOINs. This will bring together the skill count for all companies and the salary data for those that have skilled positions.
*/

-- The number of unique skills required for their job postings that require at least one skill.
WITH required_skills AS (
SELECT
    cd.company_id,
    cd.name,
    COUNT (DISTINCT sjd.skill_id) AS unique_number_of_skills

FROM company_dim AS cd
    LEFT JOIN job_postings_fact AS jpc ON jpc.company_id = cd.company_id
    LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id

GROUP BY
    cd.company_id
-- HAVING COUNT (DISTINCT sjd.skill_id) >= 1
),

--The highest average annual salary among job postings where avg_year_salary IS NOT NULL
max_salary AS (
SELECT
    cd.company_id,
    cd.name,
    MAX(salary_year_avg) AS highest_avg_salary
FROM company_dim AS cd
    LEFT JOIN job_postings_fact AS jpc ON jpc.company_id = cd.company_id
    LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id
GROUP BY
    cd.company_id
-- HAVING MAX(salary_year_avg) IS NOT NULL
)

SELECT
    rs.company_id,
    rs.name,
    rs.unique_number_of_skills,
    ms.highest_avg_salary
FROM required_skills As rs
    INNER JOIN max_salary AS ms ON ms.company_id = rs.company_id