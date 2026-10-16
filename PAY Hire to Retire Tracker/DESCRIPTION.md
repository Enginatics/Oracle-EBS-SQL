# Case Study & Technical Analysis: PAY Hire to Retire Tracker

## Executive Summary
PAY Hire to Retire Tracker follows each employee period of service that overlaps a chosen date range, from the hire date through the first payroll run and payment, and to the termination and any payroll processing exceptions. It returns one row per employee, with the primary assignment details and the dates of each step in the payroll journey. HR and payroll administrators use it to confirm that new hires were paid on time, to find leavers who were processed after termination, and to investigate payroll errors that affect a particular period of service.

## Business Challenge
*   **First Pay Delays:** New hires who miss the first payroll run, or whose salary was entered late, create complaints and pay corrections.
*   **Leaver Processing:** Payments made after a termination date must be identified and recovered, and runs processed after termination need review.
*   **Missed Runs:** An assignment that was processable on a payroll but was not processed in a pay period causes underpayment that must be corrected.
*   **Error Resolution:** Payroll process errors and retropay requests need to be visible by employee and period.

## The Solution
*   **Journey Dates:** The report shows the payroll ready date, first period cut-off and pay date, first run, first payment and last payment for each new hire.
*   **Exception Columns:** Missed run dates, unpaid prepayment dates and amounts, process error counts and the latest error message are provided for the period.
*   **Retro Visibility:** The earliest pending retropay reprocess date is shown, so pending retropay can be scheduled.
*   **Leaver Detail:** Termination date, leaving reason, last standard process date and any run after termination are shown together.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_PERIODS_OF_SERVICE`: the periods of service, with the hire date, the actual termination date, leaving reason and last process dates.
*   `PER_ALL_PEOPLE_F`: the employee records, with the employee number and full name.
*   `PER_ALL_ASSIGNMENTS_F`: the assignments, with the primary flag, payroll, organization, job, location and supervisor.
*   `PAY_PAYROLL_ACTIONS`: the payroll runs and prepayment actions, with action type, status and effective date.
*   `PAY_ASSIGNMENT_ACTIONS`: the assignment-level results of each payroll action.
*   `PAY_PRE_PAYMENTS`: the prepayments and their values.
*   `PAY_ALL_PAYROLLS_F`: the payroll definitions.
*   `PER_TIME_PERIODS`: the pay periods, with cut-off, end, start and regular payment dates.
*   `PAY_PERSONAL_PAYMENT_METHODS_F` and `PAY_ORG_PAYMENT_METHODS_F_TL`: the payment methods of each assignment.
*   `PER_PAY_PROPOSALS` and `PER_PAY_BASES`: the approved salary and the salary basis.
*   `PAY_MESSAGE_LINES`: the text of payroll error messages.
*   `PAY_RETRO_ASSIGNMENTS`: the pending retropay requests.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `HR_LOCATIONS_ALL_VL`, `PER_JOBS_VL`, `PER_ASSIGNMENT_STATUS_TYPES` and `HR_SOFT_CODING_KEYFLEX`: the organization, location, job, status and statutory information attributes.

### Logical Relationships
1.  Periods of service in `PER_PERIODS_OF_SERVICE` that overlap the date range are joined to their person in `PER_ALL_PEOPLE_F` and to their business group.
2.  The primary employee assignment in `PER_ALL_ASSIGNMENTS_F` is joined to each period of service on the period identifier.
3.  Payroll actions and assignment actions in the range are aggregated per assignment into first and last run dates, first and last payment dates, unpaid prepayments and errors.
4.  Each payroll's last run in the range is aggregated per payroll identifier.
5.  Pay period cut-off and payment dates are found from the time periods of the assignment's payroll for the first period on or after the hire date.
6.  Error message lines are read from `PAY_MESSAGE_LINES` for the latest error action.

## Parameters & Filtering
*   **Business Group:** Restricts the output to one business group.
*   **Payroll:** Restricts the output to one payroll.
*   **Date From and Date To:** Define the window. Periods of service that overlap the window are included, and new hire columns apply to hires on or after Date From.

## Performance & Optimization
*   **Date Window First:** The periods of service are filtered by the date window before the assignment, person and payroll joins, so the rest of the report works on the affected employees only.
*   **Aggregated Action History:** Payroll and assignment actions are aggregated once per assignment, rather than read row by row for each output column.
*   **Dense Rank Selection:** First and last run, payment and error values use keep-dense-rank aggregates, which select the required row in one pass.
*   **Hint Control:** Hints disable predicate pushing into the aggregated inline views, so each inline view is evaluated once.

## FAQ
**Q: What does Missed Run Date show?**
A: It is the date of the payroll's last run in the period when the assignment was processable on that payroll but was not processed in that pay period or later.

**Q: How is Payroll Ready Date calculated?**
A: For a new hire it is the latest of the hire date, the date the payroll was entered, and the date the approved salary was entered when a salary basis exists.

**Q: Which assignment does the report show for a leaver?**
A: It shows the primary assignment on the termination date, as stated in the report description.
