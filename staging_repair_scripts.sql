-- =====================================================
-- STAGING TABLE CREATION
-- =====================================================

CREATE TABLE staging_submissions AS
SELECT * FROM submissions;

CREATE TABLE staging_enrollments AS
SELECT * FROM enrollments;

CREATE TABLE staging_problems AS
SELECT * FROM problems;

CREATE TABLE staging_attendance AS
SELECT * FROM attendance;

---

## -- REPAIR 1: Fix invalid difficulty

-- BEFORE

SELECT *
FROM staging_problems
WHERE difficulty = 'Moderate';

-- REPAIR

UPDATE staging_problems
SET difficulty = 'Medium'
WHERE difficulty = 'Moderate';

-- AFTER

SELECT *
FROM staging_problems
WHERE difficulty = 'Medium';

-- Decision:
-- Standardized invalid category.

---

## -- REPAIR 2: Remove duplicate enrollments

-- BEFORE

SELECT student_id, course_id, COUNT(*)
FROM staging_enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- REPAIR

DELETE FROM staging_enrollments
WHERE enrollment_id NOT IN (
SELECT MIN(enrollment_id)
FROM staging_enrollments
GROUP BY student_id, course_id
);

-- AFTER

SELECT student_id, course_id, COUNT(*)
FROM staging_enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

---

## -- REPAIR 3: Fix invalid attendance status

-- BEFORE

SELECT *
FROM staging_attendance
WHERE status = 'YES';

-- REPAIR

UPDATE staging_attendance
SET status = 'Present'
WHERE status = 'YES';

-- AFTER

SELECT *
FROM staging_attendance
WHERE status = 'Present';

---

## -- REPAIR 4: Fix negative scores

-- BEFORE

SELECT *
FROM staging_submissions
WHERE score < 0;

-- REPAIR

UPDATE staging_submissions
SET score = NULL
WHERE score < 0;

-- AFTER

SELECT *
FROM staging_submissions
WHERE score < 0;

---

## -- REPAIR 5: Move orphan enrollments

CREATE TABLE rejected_enrollments AS
SELECT e.*
FROM staging_enrollments e
LEFT JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_id IS NULL;

DELETE FROM staging_enrollments
WHERE course_id NOT IN (
SELECT course_id FROM courses
);

-- AFTER

SELECT *
FROM rejected_enrollments;
