/*
🧑‍💻 **Scenario:** 

**Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst?** 

- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) 
  and financial benefits (high salaries), offering strategic insights for career development in data analysis
*/

WITH 
    
    skills_demand AS (
        SELECT
            sd.skill_id,
            sd.skills AS skill_name,
            COUNT(sd.skills) AS skill_count

        FROM job_postings_fact AS jpc
            INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id
            INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id

        WHERE 
            job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
            AND job_work_from_home IS TRUE
            AND job_location = 'Anywhere'

        GROUP BY
        sd.skill_id
    ), 
    
    average_salary AS   (
        SELECT
            sd.skill_id,
            sd.skills AS skill_name,
            ROUND(AVG(salary_year_avg),0) AS avgofavg_salary

        FROM job_postings_fact AS jpc
            INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id
            INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id

        WHERE 
            job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
            AND job_work_from_home IS TRUE
            AND job_location = 'Anywhere'

        GROUP BY
            sd.skill_id
    )

SELECT
    skills_demand.skill_id,
    skills_demand.skill_name,
    skills_demand.skill_count AS high_skill_demand_count,
    average_salary.avgofavg_salary AS high_avg_salary

FROM
    skills_demand
    INNER JOIN average_salary ON average_salary.skill_id = skills_demand.skill_id

HAVING
    high_skill_demand_count >= 10

ORDER BY
    high_avg_salary DESC,
    high_skill_demand_count DESC

LIMIT 25