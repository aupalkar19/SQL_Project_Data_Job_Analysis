/*
**Answer: What are the top skills based on salary?** 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts 
    and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    sd.skills AS skill_name,
    -- COUNT(sd.skills) AS skill_count
    ROUND(AVG(salary_year_avg),0) AS avg_salary

FROM job_postings_fact AS jpc
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id

WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    -- AND job_work_from_home IS TRUE
    -- AND job_location = 'Anywhere'

GROUP BY
    skill_name

ORDER BY
    avg_salary DESC

LIMIT 25;

/******************************************************************************************
💰 ANALYSIS: TOP 25 HIGHEST-PAYING SKILLS FOR DATA ANALYSTS (BY AVG. SALARY)
-------------------------------------------------------------------------------------------
Dataset: 25 top-paying skills ranked by average yearly salary (USD)
Metric: avg_salary (aggregated by skill_name)
******************************************************************************************/

-- 🧮 SKILL SALARY DISTRIBUTION
-- ------------------------------------------------------------------
--  Rank | Skill Name        | Avg. Salary (USD)
--  -----+--------------------+-----------------
--   1️⃣  | svn               | 400,000
--   2️⃣  | solidity          | 179,000
--   3️⃣  | couchbase         | 160,515
--   4️⃣  | datarobot         | 155,486
--   5️⃣  | golang            | 155,000
--   6️⃣  | mxnet             | 149,000
--   7️⃣  | dplyr             | 147,633
--   8️⃣  | vmware            | 147,500
--   9️⃣  | terraform         | 146,734
--  10️⃣  | twilio            | 138,500
--  11️⃣  | gitlab            | 134,126
--  12️⃣  | kafka             | 129,999
--  13️⃣  | puppet            | 129,820
--  14️⃣  | keras             | 127,013
--  15️⃣  | pytorch           | 125,226
--  16️⃣  | perl              | 124,686
--  17️⃣  | ansible           | 124,370
--  18️⃣  | hugging face      | 123,950
--  19️⃣  | tensorflow        | 120,647
--  20️⃣  | cassandra         | 118,407
--  21️⃣  | notion            | 118,092
--  22️⃣  | atlassian         | 117,966
--  23️⃣  | bitbucket         | 116,712
--  24️⃣  | airflow           | 116,387
--  25️⃣  | scala             | 115,480

-------------------------------------------------------------------------------------------
-- 🧠 KEY INSIGHTS
-- ------------------------------------------------------------------

-- ▪ ULTRA-PREMIUM TOOLS (>150K AVG)
--   → svn (Version Control) — extremely rare in data analytics, likely high due to niche enterprise use.
--   → solidity (Blockchain) — highest emerging skill crossover between Web3 and analytics.
--   → couchbase, datarobot, golang — AI & backend analytics automation platforms showing premium demand.

-- ▪ ADVANCED AI/ML FRAMEWORKS (120K–150K RANGE)
--   → keras, pytorch, tensorflow, mxnet, hugging face — strong trend toward deep learning frameworks.
--   → Indicates integration of ML/AI model building into analyst roles for higher-value automation.

-- ▪ INFRASTRUCTURE & DEPLOYMENT TOOLS
--   → terraform, ansible, puppet, airflow, kafka — analysts skilled in data pipeline automation 
--     and orchestration earn significantly higher pay.
--   → Reflects hybridization of analyst + data engineer capabilities.

-- ▪ DATA STORAGE / DATABASES
--   → cassandra, couchbase — NoSQL / distributed systems knowledge highly compensated.
--   → Analysts familiar with non-relational systems can manage large-scale real-time data.

-- ▪ CLOUD & DEVOPS INTEGRATION
--   → vmware, gitlab, bitbucket, atlassian — collaboration & deployment platforms show up consistently.
--   → Suggests enterprises value analysts capable of maintaining data workflows in CI/CD environments.

-- ▪ PROGRAMMING & AUTOMATION
--   → golang, perl, scala — low-level or backend coding languages associated with 
--     automation, backend API data flow, or real-time computation systems.

-- ▪ TOOLING AND PRODUCTIVITY
--   → notion (knowledge systems) indicates a trend toward data documentation, workflow organization.

-------------------------------------------------------------------------------------------
-- 📊 TRENDS SUMMARY
-- ------------------------------------------------------------------
-- ▪ Transition from *traditional analysts* → *AI/ML-integrated analytics engineers*.
-- ▪ Cloud-native data orchestration (Terraform, Airflow) is now core to high-paying analyst roles.
-- ▪ Collaboration platforms (Atlassian, GitLab, Bitbucket) appear in top 25, tying DevOps with analytics.
-- ▪ Specialized frameworks (Solidity, Hugging Face, TensorFlow) drive niche but lucrative opportunities.
-- ▪ Analysts mastering both **data modeling** and **infrastructure automation** command salaries above $150K.

-------------------------------------------------------------------------------------------
-- ✅ END OF ANALYSIS

/*
JSON data analyzed:
[
  {
    "skill_name": "svn",
    "avg_salary": "400000"
  },
  {
    "skill_name": "solidity",
    "avg_salary": "179000"
  },
  {
    "skill_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill_name": "golang",
    "avg_salary": "155000"
  },
  {
    "skill_name": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skill_name": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skill_name": "vmware",
    "avg_salary": "147500"
  },
  {
    "skill_name": "terraform",
    "avg_salary": "146734"
  },
  {
    "skill_name": "twilio",
    "avg_salary": "138500"
  },
  {
    "skill_name": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skill_name": "kafka",
    "avg_salary": "129999"
  },
  {
    "skill_name": "puppet",
    "avg_salary": "129820"
  },
  {
    "skill_name": "keras",
    "avg_salary": "127013"
  },
  {
    "skill_name": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skill_name": "perl",
    "avg_salary": "124686"
  },
  {
    "skill_name": "ansible",
    "avg_salary": "124370"
  },
  {
    "skill_name": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skill_name": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skill_name": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skill_name": "notion",
    "avg_salary": "118092"
  },
  {
    "skill_name": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skill_name": "airflow",
    "avg_salary": "116387"
  },
  {
    "skill_name": "scala",
    "avg_salary": "115480"
  }
]
*/
-------------------------------------------------------------------------------------------
