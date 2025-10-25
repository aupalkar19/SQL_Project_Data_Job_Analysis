/*
🧑‍💻 **Scenario:** 

**Question: What are the most in-demand skills for data analysts?**

- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    sd.skills AS skill_name,
    COUNT(sd.skills) AS skill_count

FROM job_postings_fact AS jpc
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id

WHERE 
    job_title_short = 'Data Analyst'
    AND job_work_from_home IS TRUE
    AND job_location = 'Anywhere'

GROUP BY
    skill_name

ORDER BY
    skill_count DESC

LIMIT 5;