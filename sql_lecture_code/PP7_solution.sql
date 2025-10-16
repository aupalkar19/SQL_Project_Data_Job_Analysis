/*
Find the count for the number of remote job_postings per skill for data analyst
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_job_skills AS(
SELECT
    -- jpc.job_id,
    skills_to_job.skill_id,
    COUNT(*) AS skill_count

FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS jpc
    ON skills_to_job.job_id = jpc.job_id

WHERE jpc.job_work_from_home IS TRUE
        AND jpc.job_title_short = 'Data Analyst'

GROUP BY skill_id
)

SELECT 
    sd.skill_id,
    sd.skills AS skill_name,
    remote_job_skills.skill_count

FROM remote_job_skills

INNER JOIN skills_dim AS sd 
    ON remote_job_skills.skill_id = sd.skill_id

ORDER BY
    skill_count DESC

LIMIT 5;