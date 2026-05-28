-- =====================================================
-- PRIMARY KEY AND UNIQUENESS AUDIT
-- =====================================================

-- 1. Duplicate student IDs

SELECT student_id, COUNT(*)
FROM students
GROUP BY student_id
HAVING COUNT(*) > 1;

---

-- 2. Duplicate student emails

SELECT email, COUNT(*)
FROM students
GROUP BY email
HAVING COUNT(*) > 1;

---

-- 3. Duplicate enrollment records

SELECT student_id, course_id, COUNT(*)
FROM enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

---

-- 4. Duplicate contest-problem mappings

SELECT contest_id, problem_id, COUNT(*)
FROM contest_problems
GROUP BY contest_id, problem_id
HAVING COUNT(*) > 1;

---

-- 5. Duplicate attendance records

SELECT student_id, session_id, COUNT(*)
FROM attendance
GROUP BY student_id, session_id
HAVING COUNT(*) > 1;

---

## -- FOREIGN KEY RELATIONSHIP AUDIT

-- 6. Students linked to missing batches

SELECT s.student_id, s.batch_id
FROM students s
LEFT JOIN batches b
ON s.batch_id = b.batch_id
WHERE b.batch_id IS NULL;

---

-- 7. Enrollments linked to missing students

SELECT e.*
FROM enrollments e
LEFT JOIN students s
ON e.student_id = s.student_id
WHERE s.student_id IS NULL;

---

-- 8. Enrollments linked to missing courses

SELECT e.*
FROM enrollments e
LEFT JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_id IS NULL;

---

-- 9. Test cases linked to missing problems

SELECT tc.*
FROM test_cases tc
LEFT JOIN problems p
ON tc.problem_id = p.problem_id
WHERE p.problem_id IS NULL;

---

-- 10. Submissions linked to missing students

SELECT sub.*
FROM submissions sub
LEFT JOIN students s
ON sub.student_id = s.student_id
WHERE s.student_id IS NULL;

---

-- 11. Submissions linked to missing problems

SELECT sub.*
FROM submissions sub
LEFT JOIN problems p
ON sub.problem_id = p.problem_id
WHERE p.problem_id IS NULL;

---

-- 12. Attendance linked to missing sessions

SELECT a.*
FROM attendance a
LEFT JOIN sessions s
ON a.session_id = s.session_id
WHERE s.session_id IS NULL;

---

-- 13. Plagiarism flags linked to missing submissions

SELECT pf.*
FROM plagiarism_flags pf
LEFT JOIN submissions s
ON pf.submission_id = s.submission_id
WHERE s.submission_id IS NULL;
