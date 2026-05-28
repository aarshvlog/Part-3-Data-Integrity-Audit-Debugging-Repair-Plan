# Before and After Repair Evidence

## Repair 1 – Invalid Difficulty

### Before

| problem_id | difficulty |
| ---------- | ---------- |
| 44         | Moderate   |

### After

| problem_id | difficulty |
| ---------- | ---------- |
| 44         | Medium     |

---

# Repair 2 – Duplicate Enrollments

### Before

| student_id | course_id | count |
| ---------- | --------- | ----- |
| 120        | 14        | 2     |

### After

No duplicate rows returned.

---

# Repair 3 – Invalid Attendance Status

### Before

| attendance_id | status |
| ------------- | ------ |
| 551           | YES    |

### After

| attendance_id | status  |
| ------------- | ------- |
| 551           | Present |

---

# Repair 4 – Negative Scores

### Before

| submission_id | score |
| ------------- | ----- |
| 9001          | -5    |

### After

| submission_id | score |
| ------------- | ----- |
| 9001          | NULL  |

---

# Repair 5 – Orphan Enrollment

### Before

enrollment_id = 3012 referenced missing course_id = 999

### After

Record moved to rejected_enrollments table.
