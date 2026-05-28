-- =====================================================
-- IMPORT VALIDATION QUERIES
-- =====================================================

-- 1. Row count of each table

SELECT 'students' AS table_name, COUNT(*) AS row_count
FROM students

UNION ALL

SELECT 'courses', COUNT(*)
FROM courses

UNION ALL

SELECT 'enrollments', COUNT(*)
FROM enrollments

UNION ALL

SELECT 'problems', COUNT(*)
FROM problems

UNION ALL

SELECT 'submissions', COUNT(*)
FROM submissions;

-- Purpose:
-- Verify successful import of all major tables.

---

-- 2. Distinct primary key validation

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT student_id) AS distinct_student_ids
FROM students;

-- Validation:
-- Counts should match if no duplicate PK exists.

---

-- 3. NULL email check

SELECT *
FROM students
WHERE email IS NULL
OR TRIM(email) = '';

-- Purpose:
-- Detect missing mandatory emails.

---

-- 4. Empty table detection

SELECT table_name
FROM (
SELECT 'students' AS table_name, COUNT(*) AS cnt FROM students
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'submissions', COUNT(*) FROM submissions
) t
WHERE cnt = 0;

-- Validation:
-- No important production table should be empty.

---

-- 5. Compare imported rows with CSV expectations

SELECT
'students' AS table_name,
COUNT(*) AS imported_rows,
2500 AS expected_csv_rows
FROM students;

-- Replace expected_csv_rows using actual CSV counts.
