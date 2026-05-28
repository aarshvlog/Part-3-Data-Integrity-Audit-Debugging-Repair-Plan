# Repair Plan

## Strategy

The database contains several integrity issues discovered during auditing.

Repairs will be applied only on staging tables.

---

# Issue 1: Duplicate Emails

### Example

student_id = 102 and student_id = 587 share same email.

### Action

Manual verification required.

### Reason

Cannot safely determine correct ownership automatically.

---

# Issue 2: Invalid Difficulty

### Example

problem_id = 44 has difficulty = 'Moderate'

### Action

UPDATE to 'Medium'

### Reason

Clearly intended equivalent value.

---

# Issue 3: Negative Score

### Example

submission_id = 9001 has score = -5

### Action

Set score to NULL and flag for review.

---

# Issue 4: Missing Course Reference

### Example

enrollment_id = 3012 references course_id = 999

### Action

Move record to rejected_enrollments table.

---

# Issue 5: Duplicate Enrollment

### Example

(student_id = 120, course_id = 14) appears twice.

### Action

Delete duplicate keeping earliest enrollment.

---

# Issue 6: Invalid Attendance Status

### Example

attendance_id = 551 has status = 'YES'

### Action

Convert to 'Present'

---

# Issue 7: Contest End Time Error

### Example

contest_id = 88 has end_time earlier than start_time.

### Action

Manual verification required.

---

# Issue 8: Submission Linked to Missing Student

### Example

submission_id = 7300 references student_id = 9999.

### Action

Move to orphan_submissions staging table.

---

# Repair Philosophy

| Problem Type             | Action                 |
| ------------------------ | ---------------------- |
| Clearly fixable typo     | UPDATE                 |
| Duplicate rows           | DELETE duplicate       |
| Missing FK               | Move to rejected table |
| Ambiguous ownership      | Manual verification    |
| Historical inconsistency | Preserve with note     |
