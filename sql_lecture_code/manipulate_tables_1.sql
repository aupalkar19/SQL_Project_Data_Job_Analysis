-- 1. CREATE TABLE: Based on datatypes
CREATE TABLE job_applied    
(
    job_id INT, 
    application_sent_date DATE, 
    custom_resume BOOLEAN, 
    resume_file_name VARCHAR(255), 
    cover_letter_sent BOOLEAN, 
    cover_letter_file_name VARCHAR(255), 
    status VARCHAR(60)
);

SELECT *
FROM job_applied



-- 2. INSERT values into empty table or paritially filled table 
INSERT INTO job_applied 
(
    job_id, 
    application_sent_date, 
    custom_resume, 
    resume_file_name, 
    cover_letter_sent, 
    cover_letter_file_name, 
    status
)
VALUES  
(1, '2024-01-01', true, 'resume_01.pdf', true, 'cover_letter_01.pdf', 'submitted'),
(2, '2024-01-02', false, 'resume_02.pdf', true, NULL, 'interview scheduled'),
(3, '2024-02-03', true, 'resume_03.pdf', true, 'cover_letter_03.pdf', 'ghosted'),
(4, '2024-02-04', true, 'resume_04.pdf', false, NULL, 'submitted'),
(5, '2024-02-05', false, 'resume_05.pdf', true, 'cover_letter_05.pdf', 'rejected');

SELECT *
FROM job_applied;



-- 3a ADD Column on ALTER TABLE
ALTER TABLE job_applied
ADD contact VARCHAR(50);

SELECT *
FROM job_applied



--4 UPDATE VALUES on a table column
UPDATE job_applied
SET contact = 'Aditya Upalkar'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Melwin Matthews'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Shaun Fernandes'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Shreyas Jadhav'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Pranav Sule'
WHERE job_id = 5;

SELECT *
FROM job_applied



--3b RENAME table column with ALTER table
ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

SELECT *
FROM job_applied



--3c ALTER column dataypes in a table
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

SELECT *
FROM job_applied



--3d Delete or drop a column in a table
ALTER TABLE job_applied
DROP COLUMN contact_name;

SELECT *
FROM job_applied


--5 DELETE or drop a table
DROP TABLE job_applied;