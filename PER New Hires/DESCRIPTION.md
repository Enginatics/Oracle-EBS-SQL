# Case Study & Technical Analysis: PER New Hires

## Executive Summary
The PER New Hires report lists the employees hired within a chosen date range, with their hire date, organization, job, position, grade, location, supervisor, employment category and probation details. HR administrators and onboarding teams use it to track new starters through their first weeks, to confirm that probation periods and working hours were recorded correctly and to analyze hiring by department, location and person type. The report runs in Excel through Blitz Report, and is restricted to employee and applicant person types through the person type system codes.

## Business Challenge
*   **Onboarding tracking:** HR needs a list of who joined in a period, with the details needed to set up their access, equipment and induction.
*   **Probation management:** The probation period and its end date must be known for each new hire, so that reviews take place on time.
*   **Hiring analysis:** Recruitment reporting requires the number of hires by organization, job and location for a period.
*   **Payroll alignment:** The payroll and the working hours of a new employee must match the assignment before the first pay run.

## The Solution
*   Selects the people hired in the date range entered, with the original date of hire and the service start date, and the adjusted service date.
*   Shows the assignment details of each hire: organization, job, position, grade, location, supervisor and assignment status.
*   Shows the employment category, frequency, normal hours, payroll name, probation period, probation unit and probation end date.
*   Shows the user who created the person record and the creation date, so that data entry can be checked.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_ALL_PEOPLE_F`: the person record, with the employee number, name, sex, e-mail and original date of hire.
*   `PER_PERSON_TYPES_V`: the person type of the record, restricted to the employee and applicant system types.
*   `PER_PERIODS_OF_SERVICE`: the period of service, with the service start and adjusted service dates.
*   `PER_ALL_ASSIGNMENTS_F`: the primary assignment, with the organization, job, position, grade, location, payroll, hours, probation and frequency fields.
*   `PER_ASSIGNMENT_STATUS_TYPES_V`: the assignment status.
*   `PAY_ALL_PAYROLLS_F`: the payroll name of the assignment.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `PER_JOBS_VL`, `HR_ALL_POSITIONS_F_TL`, `PER_GRADES_VL` and `HR_LOCATIONS_ALL`: the organization, job, position, grade and location names.

### Logical Relationships
1.  `PER_ALL_PEOPLE_F` is restricted to the rows valid today, and joined to the person type view on the person type id, where the system person type is EMP or EMP_APL.
2.  The person is joined to `PER_PERIODS_OF_SERVICE` on the person id, where the actual termination date is empty.
3.  The primary assignment of type E is joined on the person id, and its status is decoded through `PER_ASSIGNMENT_STATUS_TYPES_V`.
4.  The supervisor, job, position, grade, location and payroll are outer joins, so an assignment without one of them still appears.
5.  The business group is joined from the person record to `HR_ALL_ORGANIZATION_UNITS_VL`.

## Parameters & Filtering
*   **Business Group:** the business group whose hires are listed.
*   **Organization:** limits the hires to one assignment organization.
*   **Hire Date From** and **Hire Date To:** bound the original date of hire of the people listed.
*   **Location:** limits the hires to one work location.

## Performance & Optimization
*   The people and assignment tables are restricted to their current effective rows in inline views, so each person returns one row.
*   The person type condition is applied in the WHERE clause, which removes other person types before the assignment joins.
*   Probation and payroll columns are outer joins, which keep every hire even when the optional data is missing.
*   Setting Hire Date From and Hire Date To narrows the people read, and is the most effective parameter combination for a large workforce.

## FAQ
**Q: How do I list the employees hired in a month?**
A: Set Hire Date From to the first day of the month and Hire Date To to the last day. The report lists each person with the original date of hire in that range.

**Q: Which person types are included?**
A: Employees and employee applicants, as the person type system codes EMP and EMP_APL define them.

**Q: Where are the probation details taken from?**
A: From the primary assignment: Probation Period, Probation Unit and the Probation End Date.
