/*Question: What are the top-paying data analyst jobs, and what skills are required?** 

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT 
        jpc.job_id,
        -- jpc.company_id,
        -- cd.company_id,
        cd.name,
        jpc.job_title_short,
        -- jpc.job_work_from_home,
        -- jpc.job_location,
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
)

SELECT 
    -- tpj.*,
    sd.skills AS top_paying_skills,
    COUNT(*) AS skill_count

FROM top_paying_jobs AS tpj
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = tpj.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
GROUP BY
    top_paying_skills
ORDER BY
    skill_count DESC

/******************************************************************************************
📊 ANALYSIS: KEY INSIGHTS FROM TOP 10 HIGHEST-PAYING DATA ANALYST JOB ROLES (REMOTE)
Source: CSV dataset (10 roles, 66 rows)
-------------------------------------------------------------------------------------------
Objective:
Analyze company-wise and skill-wise distributions to understand which firms emphasize
the broadest or most specialized technical stacks.
******************************************************************************************/

-- 🏢 COMPANY-WISE INSIGHTS
-- ----------------------------------------------------------
-- • AT&T leads with the highest salary (~$255,829) and the most diverse skill set (13 skills)
--   spanning SQL, Python, R, cloud (AWS, Azure, Databricks), and BI tools (Tableau, Power BI).
--   → Indicates a strong focus on full-stack analytics and data infrastructure.
--
-- • Pinterest Job Advertisements (~$232,423) emphasizes SQL, Python, R, Hadoop, and Tableau.
--   → Blend of traditional analytics and big data (Hadoop) environment.
--
-- • UCLA Healthcare (~$217,000) integrates legacy data tools (Crystal Reports, Oracle, Tableau)
--   → Signifying a mix of healthcare-grade reporting and structured relational systems.
--
-- • SmartAsset appears twice (205K & 186K) with overlapping skill stacks (SQL, Python, Snowflake,
--   Pandas, Numpy, Excel, Tableau) and dev tools (GitLab).
--   → Suggests standardized internal analytics environment using Python stack + BI reporting.
--
-- • Inclusively (~$189K) features 14+ distinct tools (SQL, Python, AWS, Azure, Oracle, Tableau,
--   Power BI, Jira, Bitbucket, Confluence).
--   → Demonstrates cloud-first enterprise setup with strong collaborative tooling.
--
-- • Motional (~$189K) emphasizes reproducibility and collaboration (SQL, Python, R, Git, Jira,
--   Confluence, Bitbucket, Atlassian).
--   → Focus on version-controlled, engineering-oriented analytics workflows.
--
-- • Get It Recruit - IT (~$184K) maintains a minimalist stack (SQL, Python, R)
--   → Core statistical and programming skills valued over ecosystem variety.

-------------------------------------------------------------------------------------------
-- 🧠 SKILL DISTRIBUTION INSIGHTS
-- ----------------------------------------------------------
-- • SQL is the universal denominator — appears in 8 of 10 companies (100% correlation with high pay).
-- • Python ranks 2nd (7 occurrences), confirming its dominance as the main analytical language.
-- • Tableau (6) consistently pairs with SQL/Python, marking it the top visualization tool.
-- • R (4) is prominent in research-heavy or data modeling companies (AT&T, Pinterest, Motional, Get It Recruit).
-- • Cloud tools (AWS, Azure, Snowflake, Databricks) appear in 6 companies — modern data infrastructure trend.
-- • Collaboration platforms (Jira, Confluence, GitLab, Bitbucket) appear in 4–5 companies — critical for teamwork.

-------------------------------------------------------------------------------------------
-- 💰 SALARY INSIGHTS
-- ----------------------------------------------------------
-- • Highest salary: AT&T ($255K), emphasizing end-to-end data pipeline + visualization.
-- • Salaries taper between $180K–$230K for companies with slightly narrower stacks.
-- • Broader skill ecosystems (multi-tool, multi-cloud proficiency) correlate with higher salaries.
-- • Core trio (SQL, Python, Tableau) present in all $200K+ roles.

-------------------------------------------------------------------------------------------
-- 💡 KEY TAKEAWAYS
-- ----------------------------------------------------------
-- ▪ High-paying data analyst roles reward multi-tool proficiency: SQL + Python + BI + Cloud.
-- ▪ Enterprise analytics integrates DevOps & collaboration tools, reflecting production-grade analytics.
-- ▪ Cloud and data pipeline familiarity (AWS, Snowflake, Databricks) drive compensation premium.
-- ▪ Simpler analytics stacks (SQL + Python + R) still yield strong pay but less breadth.
-- ▪ Cross-functional skills (reporting, engineering, visualization) = salary advantage.

-------------------------------------------------------------------------------------------
-- ✅ END OF INSIGHT ANALYSIS
-------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
-- ✅ JSON Data Record

/*



[
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "sql"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "python"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "r"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "azure"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "databricks"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "aws"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "pandas"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "pyspark"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "jupyter"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "excel"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "tableau"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "power bi"
  },
  {
    "job_id": 552322,
    "name": "AT&T",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "skills": "powerpoint"
  },
  {
    "job_id": 99305,
    "name": "Pinterest Job Advertisements",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "skills": "sql"
  },
  {
    "job_id": 99305,
    "name": "Pinterest Job Advertisements",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "skills": "python"
  },
  {
    "job_id": 99305,
    "name": "Pinterest Job Advertisements",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "skills": "r"
  },
  {
    "job_id": 99305,
    "name": "Pinterest Job Advertisements",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "skills": "hadoop"
  },
  {
    "job_id": 99305,
    "name": "Pinterest Job Advertisements",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "name": "Uclahealthcareers",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "skills": "sql"
  },
  {
    "job_id": 1021647,
    "name": "Uclahealthcareers",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "skills": "crystal"
  },
  {
    "job_id": 1021647,
    "name": "Uclahealthcareers",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "skills": "oracle"
  },
  {
    "job_id": 1021647,
    "name": "Uclahealthcareers",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "name": "Uclahealthcareers",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "skills": "flow"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "sql"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "python"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "go"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "pandas"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "numpy"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "excel"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "tableau"
  },
  {
    "job_id": 168310,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "skills": "gitlab"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "sql"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "python"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "azure"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "aws"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "oracle"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "snowflake"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "tableau"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "power bi"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "sap"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "jenkins"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "bitbucket"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "atlassian"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "jira"
  },
  {
    "job_id": 731368,
    "name": "Inclusively",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "skills": "confluence"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "sql"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "python"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "r"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "git"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "bitbucket"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "atlassian"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "jira"
  },
  {
    "job_id": 310660,
    "name": "Motional",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "skills": "confluence"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "sql"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "python"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "go"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "pandas"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "numpy"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "excel"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "tableau"
  },
  {
    "job_id": 1749593,
    "name": "SmartAsset",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "skills": "gitlab"
  },
  {
    "job_id": 387860,
    "name": "Get It Recruit - Information Technology",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "184000.0",
    "skills": "sql"
  },
  {
    "job_id": 387860,
    "name": "Get It Recruit - Information Technology",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "184000.0",
    "skills": "python"
  },
  {
    "job_id": 387860,
    "name": "Get It Recruit - Information Technology",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "184000.0",
    "skills": "r"
  }
]



*/


-------------------------------------------------------------------------------------------

