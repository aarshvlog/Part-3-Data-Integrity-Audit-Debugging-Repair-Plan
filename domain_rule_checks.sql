-- =====================================================
-- DOMAIN AND RULE VALIDATION
-- =====================================================

-- 1. Negative scores

SELECT *
FROM submissions
WHERE score < 0;

---

-- 2. Scores greater than maximum

SELECT *
FROM submissions
WHERE score > 100;

---

-- 3. Invalid difficulty levels

SELECT *
FROM problems
WHERE difficulty NOT IN ('Easy', 'Medium', 'Hard');

---

-- 4. Invalid submission statuses

SELECT *
FROM submissions
WHERE status NOT IN (
'Accepted',
'Wrong Answer',
'Compilation Error',
'Runtime Error',
'Time Limit Exceeded'
);

---

-- 5. Invalid programming languages

SELECT *
FROM submissions
WHERE language NOT IN (
'Python',
'Java',
'C++',
'JavaScript'
);

---

-- 6. Invalid attendance statuses

SELECT *
FROM attendance
WHERE status NOT IN (
'Present',
'Absent',
'Late'
);

---

-- 7. Contest end time before start time

SELECT *
FROM contests
WHERE end_time < start_time;

---

-- 8. Submission before enrollment

SELECT s.submission_id,
s.student_id,
s.submitted_at,
e.enrolled_on
FROM submissions s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE s.submitted_at < e.enrolled_on;

---

-- 9. NULL mandatory columns

SELECT *
FROM students
WHERE name IS NULL
OR TRIM(name) = '';

---

-- 10. Resolved time before request time

SELECT *
FROM regrade_requests
WHERE resolved_at < requested_at;
