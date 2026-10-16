# Case Study & Technical Analysis: PER Jobs and Positions

## Executive Summary
This report shows the jobs and positions of an Oracle Human Resources business group as they stand on an effective date. For each position it gives the job, organization, location, status, entry grade and valid grades, FTE, maximum persons, headcount, incumbent FTE and vacancies. It also lists jobs that have no position valid on that date, for enterprises that use jobs without positions. HR planning and workforce management teams use it to see where vacancies exist, how full each position is, and which grades can be filled, and HR analysts use the extra information option to see the additional position and job data that the business group records. Blitz Report™ runs the report in Excel, where the headcount figures can be sorted and summed.

## Business Challenge
*   **Vacancy control:** Managers need to know how many places in a position are still open, and that count must reflect the people currently assigned to it.
*   **Headcount and FTE:** Budgeted headcount, FTE and the FTE that is actually filled must be compared position by position.
*   **Grade eligibility:** A vacancy can be filled only by a grade that is valid for the position, so the valid grades must be visible.

## The Solution
*   Lists each position valid on the effective date, with its job, organization, location, position type and status, entry grade and valid grades.
*   Counts the headcount of each position as the active and suspended employee and contingent worker assignments, and sums the FTE assignment budget of those assignments as the incumbent FTE.
*   Calculates Vacancies as the maximum persons of the position, treated as one if blank, minus the headcount, and not allowed below zero.
*   Adds the jobs that have no position on the effective date, with their valid grades, and counts their assignments in the same way.
*   Optionally adds one row per incumbent assignment, or one row per position or job extra information record, with the information type segments shown as columns.

## Technical Architecture (High Level)
### Primary Tables
*   `HR_ALL_POSITIONS_F_VL` and `HR_ALL_POSITIONS_F`: the position record for the effective date, with job, organization, FTE, maximum persons, hire dates and supervisor position.
*   `PER_JOBS_VL`: the job name and the job dates.
*   `PER_SHARED_TYPES_VL`: the position status, from the availability status.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the organization of the position.
*   `HR_LOCATIONS_ALL`: the location of the position.
*   `PER_GRADES_VL` and `PER_VALID_GRADES`: the grades that are valid for a position or a job.
*   `PER_ALL_ASSIGNMENTS_F` and `PER_ASSIGNMENT_STATUS_TYPES`: the assignments and their system status, used for the headcount.
*   `PER_ASSIGNMENT_BUDGET_VALUES_F`: the FTE budget value of each assignment.

### Logical Relationships
1. The position record is selected for the effective date and joined to the business group, the job, the status and the organization.
2. The valid grades of a position are aggregated into one text value, and grades longer than the limit are left out.
3. An inline view counts the active assignments and sums their FTE by position key, which is the position identifier or the job identifier.
4. The position and the assignment counts are joined on that key, so a position with no assignments still appears with zero headcount.
5. Jobs with no position on the date are added with a UNION ALL, so every job appears either through a position or on its own.

## Parameters & Filtering
*   **Effective Date:** the date on which positions and jobs are valid and assignments are counted.
*   **Business Group**, **Organization**, **Job** and **Position:** limit the list to one business group, organization, job or position.
*   **Record Type:** selects positions, jobs without positions, or both.
*   **Vacant Only:** shows only positions with vacancies.
*   **Detail Level:** adds one row per incumbent assignment, or one row per extra information record.
*   **Information Type:** selects an extra information type whose segments are shown as columns.

## Performance & Optimization
*   Headcount and incumbent FTE are computed once per position key in an inline view, rather than for each position row.
*   The jobs without positions are found with a NOT IN test on the effective date, so the job list does not repeat the positions.

## FAQ
**Q: How are vacancies calculated?**
A: Vacancies is the maximum persons of the position, or one if that is blank, minus its headcount. It is zero where the headcount is above the maximum.

**Q: Which assignments count as headcount?**
A: Employee and contingent worker assignments with an active or suspended status are counted, as well as the job-level assignments of a job without a position.

