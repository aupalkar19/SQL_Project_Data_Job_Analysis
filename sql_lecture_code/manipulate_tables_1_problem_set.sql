-- 1. CREATE NEW TABLE
CREATE TABLE data_science_jobs
(
    job_id INT PRIMARY KEY,
    job_title TEXT,
    company_name TEXT,
    post_date TEXT
);



--2. INSERT DATA
INSERT INTO data_science_jobs
(
    job_id,
    job_title,
    company_name,
    post_date
)

VALUES
(1,'Data Scientist', 'Tech Innovations', 'January 1, 2023'),
(2, 'Machine Learning Engineer', 'Data Driven Co', 'January 15, 2023'),
(3, 'AI Specialist', 'Future Tech', 'Febuary 1, 2023');



--3. Add new BOOLEAN COLUMN 
ALTER TABLE data_science_jobs
ADD COLUMN remote BOOLEAN;



--4. Rename Column
ALTER TABLE data_science_jobs
RENAME COLUMN post_date TO posted_on;



--5. Set default values into a column
ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;

SELECT * FROM data_science_jobs
-- The remote column values will not be set, but any new entry beyond this will be set to FALSE.

INSERT INTO data_science_jobs(job_id, job_title, company_name, posted_on)
    VALUES (4,'Data Scientist','Google','5 Febuary, 2023');
    -- Now even if you don't mention remote column, it is defualt created and set value to FALSE
    SELECT * FROM data_science_jobs



--6. DROP COLUMN
ALTER TABLE data_science_jobs
DROP COLUMN company_name;

SELECT * FROM data_science_jobs



--7. UPDATE VALUES on a table column
UPDATE data_science_jobs
SET remote = TRUE
WHERE job_id = 2;

SELECT * FROM data_science_jobs;



--8. Delete/drop the table
DROP TABLE data_science_jobs;