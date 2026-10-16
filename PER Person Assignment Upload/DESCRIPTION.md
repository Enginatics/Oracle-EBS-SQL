# Case Study & Technical Analysis: PER Person Assignment Upload

## Executive Summary
This upload creates and updates employee assignments in Oracle Human Resources, covering the same fields as the Assignment window of the People form. HR administrators and HR operations teams use it to change the organization, job, position, grade, payroll, location, status, supervisor and conditions of many employees as of one effective date, with changes made through the standard assignment APIs. It is an R12 upload that runs in Excel through Blitz Report™.

## Business Challenge
*   **Mass changes:** Reorganizations, grade and pay changes, and relocations affect many assignments at the same time, and entering them one at a time is slow and error-prone.
*   **Effective dating:** Each change takes effect on a date, and it must correctly correct, insert or end the existing assignment record for that date.
*   **Reference data:** Organizations, jobs, positions, grades, payrolls, locations and people groups must all be valid as of the effective date.
*   **Statutory and status data:** Assignment status, statutory information and category codes must be consistent with the employee's current position in the organization.

## The Solution
*   Downloads the current assignments of the business group as of the effective date, with the employee, assignment number, organization, job, position, grade, payroll, location and status of each.
*   Shows the supervisor, probation and notice periods, working hours, frequency, salary basis, bargaining unit and union membership of each assignment.
*   Changes the assignment as of the effective date when Datetrack Mode is blank, correcting the record where the date is its start date and inserting a change otherwise.
*   Creates a secondary assignment when a row has no existing assignment number, using the secondary assignment creation API.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_ALL_ASSIGNMENTS_F`: the effective-dated assignments, with organization, job, position, grade, payroll, location, status, supervisor and conditions.
*   `PER_ALL_PEOPLE_F`: the employee, with employee number, full name and current employee flag.
*   `PER_BUSINESS_GROUPS`: the business group that restricts the people and assignments.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the organization name.
*   `PER_JOBS_VL` and `PER_GRADES_VL`: the job and grade names.
*   `HR_POSITIONS_F`: the position name, valid on the effective date.
*   `PAY_ALL_PAYROLLS_F`: the payroll name, valid on the effective date.
*   `HR_LOCATIONS_ALL_VL`: the location code.
*   `PAY_PEOPLE_GROUPS`: the people group name.
*   `PER_ASSIGNMENT_STATUS_TYPES_V`: the user status of the assignment.
*   `HR_SOFT_CODING_KEYFLEX`: the statutory information key flexfield combination.
*   `PER_PAY_BASES`: the salary basis name.

### Logical Relationships
1.  The business group identifier restricts the people, which are joined to their assignments on the person identifier.
2.  Only current employees, and only assignments of type E, are kept, and both the person and the assignment must be effective on the effective date.
3.  Organization, job, grade, people group, location, status and salary basis are each resolved by a lookup on their identifier.
4.  Position and payroll are resolved only where they are effective on the effective date.
5.  Supervisor number and name are taken from the supervisor's person record effective on the effective date.
6.  The additional assignment details flexfield is displayed under the assignment flexfield context, and the upload row is held at zero for each downloaded row.

## Parameters & Filtering
*   **Upload Mode:** sets whether existing assignments are changed or new ones are created.
*   **Business Group:** the business group whose employees are listed.
*   **Effective Date:** the date on which the changes take effect and the date of the reference lookups.
*   **Employee Number:** limits the output to one employee.
*   **Organization**, **Job**, **Location** and **Payroll:** restrict the assignments by those values.
*   **Primary Assignments Only:** restricts the output to primary assignments.

## Performance & Optimization
*   The effective date is a single bound value used in every lookup, so each reference is resolved as of one date.
*   The lookups are scalar subqueries, one per reference per assignment, so the number of assignments in the business group drives the run time.
*   Restricting the business group and effective date keeps the assignment set to the population effective on that date.

## FAQ
**Q: How is a change made as of the effective date?**
A: When Datetrack Mode is blank, an assignment is corrected if the effective date is its start date, otherwise a change is inserted from the effective date.

**Q: How is a secondary assignment created?**
A: A new row without an existing assignment number creates a secondary assignment, and the primary assignment is created at hire with the PER Person Upload.

**Q: What does a Status of another system status do?**
A: A status of another system status suspends, reactivates or terminates the assignment according to that status.
