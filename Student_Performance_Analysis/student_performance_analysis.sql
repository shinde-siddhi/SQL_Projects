-- =====================================================
-- PROJECT: Student Performance Analysis (Beginner SQL)
-- =====================================================
CREATE DATABASE student_info;
USE student_info;
-- CREATE TABLES -------------------------------

CREATE TABLE students (
    student_id  INT PRIMARY KEY,
    full_name   VARCHAR(60) NOT NULL,
    gender      VARCHAR(10),
    section     CHAR(1)
);

CREATE TABLE subjects (
    subject_id    INT PRIMARY KEY,
    subject_name  VARCHAR(40) NOT NULL
);

CREATE TABLE marks (
    mark_id     INT PRIMARY KEY,
    student_id  INT NOT NULL,
    subject_id  INT NOT NULL,
    marks       INT NOT NULL,              -- out of 100
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- INSERT SAMPLE DATA --------------------------

INSERT INTO students VALUES
(1,  'Aarav Patil',      'Male',   'A'),
(2,  'Diya Sharma',      'Female', 'A'),
(3,  'Rohan Jadhav',     'Male',   'A'),
(4,  'Sneha Kulkarni',   'Female', 'A'),
(5,  'Karan Mehta',      'Male',   'A'),
(6,  'Anjali Deshmukh',  'Female', 'B'),
(7,  'Vivek More',       'Male',   'B'),
(8,  'Pooja Shinde',     'Female', 'B'),
(9,  'Arjun Nair',       'Male',   'B'),
(10, 'Isha Gupta',       'Female', 'B');

INSERT INTO subjects VALUES
(1, 'Maths'),
(2, 'Science'),
(3, 'English'),
(4, 'Computer');

INSERT INTO marks VALUES
-- Aarav
(1, 1, 1, 85), (2, 1, 2, 78), (3, 1, 3, 72), (4, 1, 4, 90),
-- Diya
(5, 2, 1, 92), (6, 2, 2, 88), (7, 2, 3, 95), (8, 2, 4, 91),
-- Rohan
(9, 3, 1, 45), (10, 3, 2, 52), (11, 3, 3, 60), (12, 3, 4, 58),
-- Sneha
(13, 4, 1, 78), (14, 4, 2, 82), (15, 4, 3, 88), (16, 4, 4, 75),
-- Karan (fails Maths)
(17, 5, 1, 33), (18, 5, 2, 40), (19, 5, 3, 55), (20, 5, 4, 48),
-- Anjali
(21, 6, 1, 88), (22, 6, 2, 91), (23, 6, 3, 84), (24, 6, 4, 94),
-- Vivek
(25, 7, 1, 65), (26, 7, 2, 58), (27, 7, 3, 70), (28, 7, 4, 62),
-- Pooja
(29, 8, 1, 72), (30, 8, 2, 68), (31, 8, 3, 79), (32, 8, 4, 85),
-- Arjun
(33, 9, 1, 55), (34, 9, 2, 49), (35, 9, 3, 62), (36, 9, 4, 70),
-- Isha
(37, 10, 1, 95), (38, 10, 2, 93), (39, 10, 3, 89), (40, 10, 4, 97);

-- ANALYSIS QUERIES ----------------------------

-- Q1. View all students
SELECT * FROM students;

-- Q2. Marks of each student in each subject
SELECT st.full_name, su.subject_name, m.marks
FROM marks m
JOIN students st ON m.student_id = st.student_id
JOIN subjects su ON m.subject_id = su.subject_id
ORDER BY st.full_name, su.subject_name;

-- Q3. Total marks and percentage of every student
SELECT st.full_name,
       SUM(m.marks)          AS total_marks,
       ROUND(AVG(m.marks),2) AS percentage
FROM marks m
JOIN students st ON m.student_id = st.student_id
GROUP BY st.full_name
ORDER BY total_marks DESC;

-- Q4. Top 3 students (toppers)
SELECT st.full_name, SUM(m.marks) AS total_marks
FROM marks m
JOIN students st ON m.student_id = st.student_id
GROUP BY st.full_name
ORDER BY total_marks DESC
LIMIT 3;

-- Q5. Subject-wise average, highest and lowest marks
SELECT su.subject_name,
       ROUND(AVG(m.marks),2) AS average_marks,
       MAX(m.marks)          AS highest,
       MIN(m.marks)          AS lowest
FROM marks m
JOIN subjects su ON m.subject_id = su.subject_id
GROUP BY su.subject_name
ORDER BY average_marks DESC;

-- Q6. Subject topper
SELECT su.subject_name, st.full_name, m.marks
FROM marks m
JOIN students st ON m.student_id = st.student_id
JOIN subjects su ON m.subject_id = su.subject_id
WHERE m.marks = (SELECT MAX(m2.marks)
                 FROM marks m2
                 WHERE m2.subject_id = m.subject_id);

-- Q7. Pass percentage of each subject
SELECT su.subject_name,
       COUNT(*) AS total_students,
       SUM(CASE WHEN m.marks >= 40 THEN 1 ELSE 0 END) AS passed,
       ROUND(100.0 * SUM(CASE WHEN m.marks >= 40 THEN 1 ELSE 0 END) / COUNT(*), 1) AS pass_percent
FROM marks m
JOIN subjects su ON m.subject_id = su.subject_id
GROUP BY su.subject_name;

-- Q8. Students who failed in at least one subject
SELECT st.full_name, COUNT(*) AS failed_subjects
FROM marks m
JOIN students st ON m.student_id = st.student_id
WHERE m.marks < 40
GROUP BY st.full_name
HAVING COUNT(*) >= 1;

-- Q9. Gender-wise performance comparison
SELECT st.gender,
       COUNT(DISTINCT st.student_id) AS students,
       ROUND(AVG(m.marks),2)         AS average_marks
FROM marks m
JOIN students st ON m.student_id = st.student_id
GROUP BY st.gender;

-- Q10. Section-wise average marks
SELECT st.section, ROUND(AVG(m.marks),2) AS average_marks
FROM marks m
JOIN students st ON m.student_id = st.student_id
GROUP BY st.section;

-- Q11. Assign a grade to each student
SELECT st.full_name,
       ROUND(AVG(m.marks),2) AS percentage,
       CASE
           WHEN AVG(m.marks) >= 90 THEN 'A+'
           WHEN AVG(m.marks) >= 80 THEN 'A'
           WHEN AVG(m.marks) >= 70 THEN 'B'
           WHEN AVG(m.marks) >= 60 THEN 'C'
           WHEN AVG(m.marks) >= 40 THEN 'D'
           ELSE 'Fail'
       END AS grade
FROM marks m
JOIN students st ON m.student_id = st.student_id
GROUP BY st.full_name
ORDER BY percentage DESC;

-- Q12.Rank student
SELECT full_name, total_marks,
       RANK() OVER (ORDER BY total_marks DESC) AS student_rank
FROM (
    SELECT st.full_name, SUM(m.marks) AS total_marks
    FROM marks m
    JOIN students st ON m.student_id = st.student_id
    GROUP BY st.full_name
) AS totals;



