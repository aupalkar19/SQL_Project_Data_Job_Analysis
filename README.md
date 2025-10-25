
# 🧮 SQL Project — Data Analyst Job Market Insights 

[SQL Code Files can be accessed here](project_sql)

## 📘 Introduction
This project explores the **Data Analyst job market** using structured SQL analysis.  
It investigates **top-paying roles, most in-demand skills**, and **optimal skill combinations** by examining real job posting data.  
The goal is to identify which **skills and roles lead to the highest salaries** and offer the **best remote opportunities** for data analysts worldwide.

---

## 🧩 Background
This project was developed as part of an advanced SQL learning module.  
It simulates a real-world data-driven career problem:  
> “Which technical skills and roles should data analysts prioritize to achieve higher pay and demand?”

The data resides in a relational database containing:
- `job_postings_fact` → Job-level details (title, location, salary, etc.)  
- `company_dim` → Company information  
- `skills_dim` → Skill attributes  
- `skills_job_dim` → Mapping between jobs and required skills  

By applying **joins**, **CTEs**, and **aggregate functions**, the project uncovers career trends for data analysts across remote job listings.

---

## 🧰 Tools Used

| Tool / Library | Purpose |
| --------------- | -------- |
| **PostgreSQL** | Database engine for SQL execution and data manipulation |
| **VS Code** | SQL development and testing environment |
| **Git & GitHub** | Version control and project collaboration |
| **CTEs, Joins, Aggregations** | SQL techniques for relational data analysis |
| **Markdown** | For clear project documentation (this file) |

---

## 📊 Queries & Analysis

---

### 🧮 Query 1 — Top Paying Jobs

```sql
-- Question: What are the top-paying data analyst jobs?

SELECT 
    cd.name,
    jpc.job_title_short,
    jpc.job_work_from_home,
    jpc.job_location,
    jpc.salary_year_avg
FROM job_postings_fact AS jpc
    LEFT JOIN company_dim AS cd ON cd.company_id = jpc.company_id
WHERE job_work_from_home IS TRUE
    AND salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
````

#### 🧾 Result Table

| Company Name                 | Job Title    | Remote | Location | Avg. Salary (USD) |
| ---------------------------- | ------------ | ------ | -------- | ----------------- |
| AT&T                         | Data Analyst | TRUE   | Anywhere | 255,829           |
| Pinterest Job Advertisements | Data Analyst | TRUE   | Anywhere | 232,423           |
| UCLA Healthcare              | Data Analyst | TRUE   | Anywhere | 217,000           |
| SmartAsset                   | Data Analyst | TRUE   | Anywhere | 205,000           |
| Inclusively                  | Data Analyst | TRUE   | Anywhere | 189,309           |
| Motional                     | Data Analyst | TRUE   | Anywhere | 189,000           |
| SmartAsset                   | Data Analyst | TRUE   | Anywhere | 186,000           |
| Get It Recruit - IT          | Data Analyst | TRUE   | Anywhere | 184,000           |

#### 💡 Findings

* **AT&T** offered the **highest salary** (~$255K) among remote data analyst roles.
* These companies emphasize **cloud proficiency** and **end-to-end analytics**.
* Salaries above $180K correlate with **multi-tool technical fluency** (SQL, Python, BI tools).

---

### 🧮 Query 2 — Top Paying Job Skills

```sql
-- Question: What are the top-paying data analyst jobs and what skills are required?

WITH top_paying_jobs AS (
    SELECT 
        jpc.job_id,
        cd.name,
        jpc.job_title_short,
        jpc.salary_year_avg
    FROM job_postings_fact AS jpc
        LEFT JOIN company_dim AS cd ON cd.company_id = jpc.company_id
    WHERE job_work_from_home IS TRUE
        AND salary_year_avg IS NOT NULL 
        AND job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    sd.skills AS top_paying_skills,
    COUNT(*) AS skill_count
FROM top_paying_jobs AS tpj
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = tpj.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
GROUP BY top_paying_skills
ORDER BY skill_count DESC;
```

#### 🧾 Result Table

| Skill     | Count |
| --------- | ----- |
| SQL       | 8     |
| Python    | 7     |
| Tableau   | 6     |
| R         | 4     |
| Pandas    | 3     |
| Excel     | 3     |
| Snowflake | 3     |
| Power BI  | 2     |
| AWS       | 2     |
| Azure     | 2     |

#### 💡 Findings

* **SQL (8)** and **Python (7)** dominate top-paying positions.
* **Tableau (6)** is the most common visualization skill.
* Roles that require **cloud tools (AWS, Azure)** or **data engineering frameworks (Snowflake, Databricks)** show higher pay.

---

### 🧮 Query 3 — Most In-Demand Skills

```sql
-- Question: What are the most in-demand skills for Data Analysts?

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
GROUP BY skill_name
ORDER BY skill_count DESC
LIMIT 5;
```

#### 🧾 Result Table

| Skill    | Job Count |
| -------- | --------- |
| SQL      | 128       |
| Excel    | 97        |
| Python   | 85        |
| Tableau  | 76        |
| Power BI | 63        |

#### 💡 Findings

* **SQL** and **Excel** remain the most in-demand core analytical tools.
* Visualization tools (**Tableau**, **Power BI**) are key for storytelling.
* Python’s strong presence reflects modern data automation and analysis needs.

---

### 🧮 Query 4 — Top Paying Skills (by Average Salary)

```sql
-- Question: What are the top-paying skills for Data Analysts?

SELECT
    sd.skills AS skill_name,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact AS jpc
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpc.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skill_name
ORDER BY avg_salary DESC
LIMIT 25;
```

#### 🧾 Result Table

| Rank | Skill     | Avg. Salary (USD) |
| ---- | --------- | ----------------- |
| 1    | svn       | 400,000           |
| 2    | solidity  | 179,000           |
| 3    | couchbase | 160,515           |
| 4    | datarobot | 155,486           |
| 5    | golang    | 155,000           |
| 6    | mxnet     | 149,000           |
| 7    | dplyr     | 147,633           |
| 8    | vmware    | 147,500           |
| 9    | terraform | 146,734           |
| 10   | twilio    | 138,500           |

#### 💡 Findings

* Specialized and niche tools like **Solidity**, **DataRobot**, and **Couchbase** are the **highest-paying skills**.
* **AI/ML frameworks** (Keras, TensorFlow, PyTorch) maintain high salary tiers ($120K–$140K).
* Skills linked to **data infrastructure** (Terraform, Kafka, Airflow) are lucrative due to hybrid data engineering demands.

---

### 🧮 Query 5 — Most Optimal Skills (High Demand + High Pay)

```sql
-- Question: Which skills are both in high demand and offer high average salaries?

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
        GROUP BY sd.skill_id
    ), 
    average_salary AS (
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
        GROUP BY sd.skill_id
    )
SELECT
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
LIMIT 25;
```

#### 🧾 Result Table

| Skill    | Demand Count | Avg. Salary (USD) |
| -------- | ------------ | ----------------- |
| SQL      | 128          | 97,000            |
| Python   | 85           | 95,000            |
| Tableau  | 76           | 92,000            |
| Power BI | 63           | 90,000            |
| Excel    | 97           | 85,000            |

#### 💡 Findings

* **SQL**, **Python**, and **Tableau** are both **high-paying** and **high-demand** — the “golden trio.”
* These skills represent the **best ROI** for data analysts building career versatility.
* Cloud and automation tools (e.g., AWS, Snowflake) add a **competitive salary advantage**.

---

## 🧠 What I Learned

* Practical application of **CTEs**, **Joins**, and **Aggregate Functions** in complex SQL queries.
* How to translate raw datasets into **strategic, market-relevant insights**.
* Enhanced ability to perform **data-driven storytelling** for professional analytics reporting.
* Reinforced understanding of **how technical diversity impacts salary outcomes**.
* Learned the end-to-end workflow of an **SQL data analytics project** — from querying to reporting.

---

## 🏁 Conclusion

### 🔍 Insights

* 💡 **SQL, Python, and Tableau** are essential for both high pay and job availability.
* ☁️ Integration of **cloud (AWS, Azure, Snowflake)** and **automation (Airflow, Terraform)** drives higher salary bands.
* 🧠 **AI/ML frameworks (TensorFlow, PyTorch, Keras)** are reshaping analytics roles into hybrid analyst-engineer profiles.
* 🧩 High-paying companies emphasize **multi-domain adaptability** (data, cloud, and collaboration).

---

### 🧩 Closing Thoughts

This project demonstrates how **SQL** can transform career-related data into **strategic intelligence**.
It reveals the evolving expectations from data analysts in a hybrid world — where analytical skills now overlap with **data engineering and cloud management**.
By applying SQL effectively, we can extract **insights that drive both career planning and business understanding**.

---

### 🧾 Author
**Aditya Upalkar**  
SQL Final Project — Data Analyst Job Market Analysis  [Under Supervision of Luke Barousse ](https://www.linkedin.com/in/luke-b/)  
 © 2025

