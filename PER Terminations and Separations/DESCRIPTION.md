# Case Study & Technical Analysis: PER Terminations and Separations

## Executive Summary
The PER Terminations and Separations report lists the employees who were terminated within a chosen date range in Oracle Human Resources. For each leaver it shows the termination date, the leaving reason, the length of service, the last organization, job, position, grade, location, payroll and supervisor. HR business partners and turnover analysts use it to measure attrition, to study the reasons people leave, and to run exit reviews. The report runs in Excel through Blitz Report, so the separations can be grouped by organization, reason or length of service.

## Business Challenge
*   **Turnover measurement:** HR leaders need the number and timing of separations by business group and organization to calculate attrition rates.
*   **Leaving reasons:** Retention programs depend on knowing why people left, and the leaving reason must be read consistently for every leaver.
*   **Exit tracking:** Exit reviews need the last job, position, grade and supervisor of each leaver, as they were at separation.
*   **Service profile:** The length of service at exit shows whether losses fall among new starters or long-serving staff.

## The Solution
*   **Termination base:** The report starts from the employee service periods that have an actual termination date, so only completed separations are listed.
*   **Assignment at termination:** The primary employee assignment that is effective on the termination date supplies the organization, job, position, grade, location, payroll and supervisor.
*   **Service length:** Service is calculated from the original date of hire to the actual termination date, shown as whole years and remaining months.
*   **Termination detail:** The accepted, projected and notified termination dates, the last standard process date and the final process date are shown beside the reason.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_PERIODS_OF_SERVICE`: the employee service period, with the actual termination date, final process date, leaving reason and notification dates.
*   `PER_ALL_PEOPLE_F`: the person record, with the name, employee number, e-mail address, sex and original date of hire.
*   `PER_ALL_ASSIGNMENTS_F`: the primary employee assignment at the termination date.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the assignment organization.
*   `PER_JOBS_VL`: the job name.
*   `HR_ALL_POSITIONS_F_TL`: the position name.
*   `PER_GRADES_VL`: the grade name.
*   `HR_LOCATIONS_ALL`: the location code.
*   `PAY_ALL_PAYROLLS_F`: the payroll name.

### Logical Relationships
1.  `PER_PERIODS_OF_SERVICE` is filtered to rows with an actual termination date, and joins to `PER_ALL_PEOPLE_F` where the termination date falls within the person's effective dates.
2.  The same service rows join to `PER_ALL_ASSIGNMENTS_F` where the termination date falls within the assignment's effective dates, restricted to the primary employee assignment.
3.  The assignment joins to the organization, job, position, grade, location and payroll, with outer joins on each.
4.  The supervisor is an outer join to the current person record, limited to records effective today.
5.  Output is ordered by business group, termination date descending and full name.

## Parameters & Filtering
*   **Business Group:** the business group whose employees are reported.
*   **Organization:** limits the leavers to one organization.
*   **Termination Date From** and **Termination Date To:** bound the actual termination date.
*   **Leaving Reason:** restricts the output to one leaving reason.

## Performance & Optimization
*   The driving filter is the non-null actual termination date on the service table, so only separations are read from the person and assignment tables.
*   The supervisor and payroll views are limited to records effective today or to the termination date, which keeps the joins to one row each.
*   The position translation join is restricted to the user's language, so each position name is returned once.
*   Outer joins on job, grade, location and payroll keep leavers whose assignment has no such value.

## FAQ
**Q: How is length of service calculated?**
A: It is the number of months between the original date of hire and the actual termination date, shown as whole years and the remaining months.

**Q: Which job and organization are shown for a leaver?**
A: The values of the primary employee assignment that was effective on the actual termination date.

**Q: Can I limit the report to one leaving reason?**
A: Yes, the Leaving Reason parameter restricts the output to that reason.
