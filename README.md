# CodeJudge Database Integrity Audit – Part 3

## Objective

This project audits the imported CodeJudge relational database for:

* data integrity problems
* duplicate records
* missing foreign-key relationships
* invalid domain values
* inconsistent timestamps
* repairable data quality issues

The project also demonstrates safe repair strategies using staging tables instead of modifying original imported data.

---

# Repository Contents

| File                       | Purpose                                      |
| -------------------------- | -------------------------------------------- |
| import_validation.sql      | Row counts, NULL checks, import validation   |
| integrity_audit.sql        | PK/FK/uniqueness audits                      |
| domain_rule_checks.sql     | Invalid values and rule validation           |
| repair_plan.md             | Dataset-specific repair strategy             |
| staging_repair_scripts.sql | Safe repair operations on staging tables     |
| before_after_evidence.md   | Validation evidence before and after repairs |

---

# Main Audit Areas

## Import Validation

* row counts
* duplicate primary keys
* NULL checks
* empty table checks

## Relationship Integrity

* broken foreign keys
* orphan records
* invalid mappings

## Domain Validation

* invalid statuses
* invalid scores
* incorrect timestamps
* invalid enum values

## Safe Repairs

Repairs are performed only on staging copies:

* UPDATE corrections
* DELETE invalid duplicates
* manual verification flags
* rejected-record handling

---

# Important Design Decision

Original imported tables are never directly modified.

All repair operations are applied on:

* staging_students
* staging_submissions
* staging_enrollments
* staging_attendance
* staging_test_results
  etc.

This ensures auditability and rollback safety.
