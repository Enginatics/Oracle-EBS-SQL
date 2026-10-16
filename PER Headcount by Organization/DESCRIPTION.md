# Case Study & Technical Analysis: PER Headcount by Organization

## Executive Summary
The PER Headcount by Organization report summarizes the active workforce in Oracle Human Resources by business group, organization, location, job, grade and employment category. It counts employees and contingent workers in each combination, with a male and female breakdown and the average length of service and average age. HR analysts, workforce planners and finance business partners use it to see how the headcount is distributed across the organization structure at a given date, and to prepare headcount and workforce reports for management. The report runs in Excel via Blitz Report, and the summary is built so that users can apply their own pivot tables for further grouping.

## Business Challenge
*   **Organization-level headcount:** Managers need the number of active people in each organization, location and job to plan capacity and review staffing.
*   **Workforce mix:** The split between employees and contingent workers, and between person types, is needed for workforce planning and reporting.
*   **Demographic reporting:** Gender balance, average service and average age are required for diversity and succession analysis.
*   **Point-in-time accuracy:** Headcount must reflect the position at a chosen date, not only the current date.

## The Solution
*   **Active assignments only:** Only primary assignments of employees and contingent workers in the active assignment status are counted.
*   **Aggregated summary:** The result is grouped by business group, organization, location, country, job, grade, employment category and person type, with the counts and averages calculated per group.
*   **Demographic columns:** Male and female counts are derived from the sex code, and average service and age are calculated in years from the hire and birth dates.
*   **Date control:** The Effective Date parameter sets the date on which the person and assignment records are valid, and it defaults to the current date.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_ALL_PEOPLE_F`: the person record, with sex, original date of hire, date of birth and business group, valid on the effective date.
*   `PER_ALL_ASSIGNMENTS_F`: the assignment record, with organization, job, grade, location, employment category, type and status, valid on the effective date.
*   `PER_PERSON_TYPES_V`: the user person type, such as employee or contingent worker.
*   `PER_ASSIGNMENT_STATUS_TYPES`: the system status of each assignment, used to select active assignments.
*   `PER_JOBS_VL`, `PER_GRADES_VL`: the job and grade names.
*   `HR_LOCATIONS_ALL`: the location code and country.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and organization names.

### Logical Relationships
1. `PER_ALL_PEOPLE_F` is joined to the business group organization through the business group identifier.
2. `PER_ALL_PEOPLE_F` is joined to `PER_ALL_ASSIGNMENTS_F` on person identifier, and the person type is joined through `PER_PERSON_TYPES_V`.
3. `PER_ASSIGNMENT_STATUS_TYPES` is joined to the assignment, and the filter keeps only the ACTIVE_ASSIGN system status.
4. The assignment's organization, job, grade and location are outer joined to `HR_ALL_ORGANIZATION_UNITS_VL`, `PER_JOBS_VL`, `PER_GRADES_VL` and `HR_LOCATIONS_ALL`.
5. The output is grouped on the descriptive columns, and the employment category is translated through the EMP_CAT lookup.

## Parameters & Filtering
*   **Business Group:** Restricts the headcount to one business group.
*   **Organization:** Restricts the headcount to one organization.
*   **Location:** Restricts the headcount to one location.
*   **Person Type:** Restricts the headcount to one person type.
*   **Effective Date:** Sets the date on which the person and assignment records are valid. When blank, the current system date is used.

## Performance & Optimization
*   Person and assignment records are restricted to the effective date range inside inline views, so the joins only see the rows valid on that date.
*   The assignment status filter is applied on the status type, which keeps the count to active assignments.
*   Job, grade and location lookups are outer joins on keyed identifiers, so they do not change the number of people counted.
*   Averages use `months_between` divided by twelve, and they are calculated per group in the same aggregation as the counts.

## FAQ
**Q: Does the report count contingent workers?**
A: Yes. Assignments of type E (employee) and C (contingent worker) are included, and the person type column shows which kind each group is.

**Q: How do I see headcount as of a past date?**
A: Enter the date in the Effective Date parameter. The person and assignment records valid on that date are used.

**Q: How are the average service and age calculated?**
A: Service is measured from the original date of hire and age from the date of birth, each in years to one decimal place, relative to the effective date.
