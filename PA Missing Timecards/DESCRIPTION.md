# Case Study & Technical Analysis: PA Missing Timecards

## Executive Summary
The PA Missing Timecards report lists the active employees who have not submitted a timecard for a chosen week ending date. Each row shows the employee, job, organization, business group, supervisor and e-mail address, so that the gap can be followed up with the right manager. Project accounting and time administration teams use it on the weekly close to chase missing timesheets before project costs and billing are closed. The report supports two timecard sources: project expenditures recorded in Oracle Projects, and time cards held in Oracle Time and Labor. It runs in Excel through Blitz Report.

## Business Challenge
*   **Weekly timesheet completeness:** Project costs cannot be closed for a week until every chargeable employee has entered time, and the list of missing employees must be produced quickly each week.
*   **Supervisor follow-up:** Each missing timecard must be routed to the supervisor who approves the employee's time, so the list shows the supervisor and contact details.
*   **Non-project employees:** Employees who do not charge projects still need an OTL timecard in some organizations, and they must be checked separately from project time.
*   **Accurate population:** Only active employees in an employee assignment should be chased, so terminated staff and non-employee assignments are removed.

## The Solution
*   **Active employee population:** The report takes primary employee assignments that are effective on the current date, so the population is the current workforce.
*   **Project expenditure test:** When the Timecard Source is PA, an employee is listed if there is no project expenditure ending on the week ending date.
*   **OTL timecard test:** When the Timecard Source is OTL, an employee is listed if no timecard summary covers the week ending date.
*   **Contact and hierarchy details:** The job name, organization, business group, supervisor full name and e-mail address are added to each employee.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_PEOPLE_X`: the employee's name, employee number and e-mail address.
*   `PER_ASSIGNMENTS_F`: the primary employee assignment, with its job, organization, supervisor and business group.
*   `PER_JOBS`: the job name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the assignment organization names.
*   `PA_EXPENDITURES_ALL`: the project expenditure headers, used to test whether time was entered for the week.
*   `HXC_TIMECARD_SUMMARY`: the OTL timecard summary, with the start and stop time of each card.

### Logical Relationships
1.  `PER_PEOPLE_X` joins to `PER_ASSIGNMENTS_F` on the person ID, restricted to primary employee assignments effective today.
2.  The assignment joins to `HR_ALL_ORGANIZATION_UNITS_VL` twice, once for the business group and once for the organization.
3.  The assignment joins to `PER_JOBS` on the job ID, and to the supervisor's name in `PER_PEOPLE_X` through the supervisor ID.
4.  The PA test is a `NOT EXISTS` on `PA_EXPENDITURES_ALL` by the incurring person and the expenditure ending date.
5.  The OTL test is a `NOT IN` on `HXC_TIMECARD_SUMMARY` by resource ID, where the week ending date falls between the trunc of the start and stop times.

## Parameters & Filtering
*   **Business Group:** the business group whose employees are reported.
*   **Operating Unit:** the operating unit that the employee is assigned to.
*   **Week Ending Date:** the date that the timecard must cover.
*   **Organization:** limits the output to one organization.
*   **Timecard Source:** PA tests project expenditures, and OTL tests OTL timecards. OTL also lists employees who do not charge projects.

## Performance & Optimization
*   The project expenditure test is a `NOT EXISTS` subquery, which stops at the first matching expenditure for each employee.
*   The OTL test is a `NOT IN` subquery on the timecard summary, which is limited by the week ending date range.
*   The source condition is written with the timecard source parameter, so the OTL branch skips the project expenditure test entirely.
*   The assignment filter uses the current effective date range, which limits the assignment rows to the current workforce.

## FAQ
**Q: Why does the OTL source list employees who do not charge projects?**
A: The OTL test checks only for an OTL timecard covering the week ending date, so employees with no project expenditures are included if they have no timecard.

**Q: Which employees are excluded from the list?**
A: Only primary employee assignments that are active on the current date are considered, so terminated staff and non-employee assignments do not appear.

**Q: How is the supervisor shown?**
A: The supervisor is the person linked to the assignment, and their full name is shown in the Supervisor column.
