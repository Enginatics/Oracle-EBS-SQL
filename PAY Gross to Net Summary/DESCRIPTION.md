# Case Study & Technical Analysis: PAY Gross to Net Summary

## Executive Summary
The PAY Gross to Net Summary report shows, for each employee and pay period, how gross pay converts into net pay in Oracle Payroll. It groups completed payroll run results into gross pay from earnings, pre-tax deductions, involuntary deductions such as tax, voluntary deductions, and net pay, and it also reports employer charges. Payroll reconciliation teams use it to check that payroll runs agree with the amounts expected for each employee, and compensation analysts use it to compare pay components across jobs, locations and organizations. The report runs in Excel via Blitz Report, and it reads only payroll actions that have completed.

## Business Challenge
*   **Payroll reconciliation:** Totals from payroll runs must be checked against the figures supported by the payroll team before they are passed to the ledger and the bank.
*   **Classification of pay elements:** Each element belongs to a classification, such as earnings, pre-tax deduction or tax deduction, and the totals must place each element in the right category.
*   **Compensation analysis:** Compensation teams need gross pay and deductions by job, location and organization, not only at the total level.
*   **Employer cost visibility:** Employer charges and liabilities sit alongside employee pay, and they must be seen together with pay for a true labor cost view.

## The Solution
*   **Classification-based totals:** Run result values are summed into gross pay, pre-tax deductions, involuntary deductions, voluntary deductions and employer charges using the element classification names.
*   **Net pay derivation:** Net pay is calculated in the outer query as gross pay less involuntary deductions, voluntary deductions and pre-tax deductions.
*   **Employee and assignment context:** Each row shows the business group, employee number and name, organization, job and location, taken from the primary employee assignment.
*   **Completed runs only:** Only payroll actions with a completed status and the run, quick pay, balance and void action types are included.

## Technical Architecture (High Level)
### Primary Tables
*   `PAY_PAYROLL_ACTIONS`: the payroll processes, with action type, status, time period and payroll.
*   `PAY_ASSIGNMENT_ACTIONS`: the assignment-level actions of each process, linking an assignment to a payroll action.
*   `PAY_RUN_RESULTS`: the element results for each assignment action.
*   `PAY_RUN_RESULT_VALUES`: the individual input values of each run result, from which the pay value is taken.
*   `PAY_INPUT_VALUES_F`: the input value definitions, filtered to the Pay Value input.
*   `PAY_ELEMENT_TYPES_F`, `PAY_ELEMENT_CLASSIFICATIONS`: the element types and their classification names.
*   `PAY_ALL_PAYROLLS_F`: the payroll name, valid on the time period start date.
*   `PER_TIME_PERIODS`: the pay period name and dates.
*   `PER_ALL_PEOPLE_F`, `PER_ALL_ASSIGNMENTS_F`: the employee and the primary employee assignment.
*   `PER_JOBS_VL`, `HR_LOCATIONS_ALL`, `HR_ALL_ORGANIZATION_UNITS_VL`: job, location, organization and business group names.

### Logical Relationships
1. The people and assignment blocks are restricted to the current effective dates, and the assignment is the primary employee assignment.
2. `PER_ALL_ASSIGNMENTS_F` is joined to `PAY_ASSIGNMENT_ACTIONS`, which joins to `PAY_PAYROLL_ACTIONS` on payroll action identifier.
3. `PAY_PAYROLL_ACTIONS` is joined to `PER_TIME_PERIODS` and to `PAY_ALL_PAYROLLS_F` on payroll identifier, with the period start date inside the payroll validity range.
4. `PAY_ASSIGNMENT_ACTIONS` is joined to `PAY_RUN_RESULTS`, then to `PAY_RUN_RESULT_VALUES` on run result identifier.
5. The result value is joined to `PAY_INPUT_VALUES_F` for the Pay Value input, and the run result to `PAY_ELEMENT_TYPES_F` and `PAY_ELEMENT_CLASSIFICATIONS` for the classification.
6. The output is grouped by business group, employee, organization, job, location, payroll, period and period dates.

## Parameters & Filtering
*   **Business Group:** Restricts the output to one business group.
*   **Payroll Name:** Restricts the output to one payroll.
*   **Period Date From and To:** Restrict the pay periods by their start date.
*   **Person Full Name:** Restricts the output to matching employee names.
*   **Organization:** Restricts the output to one organization.

The SQL text does not reference these parameters through bind variables. The rows are determined by the joins, the current effective dates and the completed payroll action filter described above.

## Performance & Optimization
*   The people and assignment blocks are filtered to rows valid on the current date before the main join, which limits the employees read.
*   Payroll actions are filtered to completed status and four action types, which excludes incomplete and other process types early in the query.
*   Pay values are summed with conditional aggregation in a single pass, so each classification total is produced without a separate query.
*   The query groups at employee and period level, so the number of output rows equals the number of employee and period combinations with completed runs.

## FAQ
**Q: Which element classifications are counted as gross pay?**
A: Earnings, Supplemental Earnings, Imputed Earnings and Non-payroll Payments are summed into gross pay.

**Q: How is net pay calculated?**
A: Net pay is gross pay less pre-tax deductions, involuntary deductions and voluntary deductions.

**Q: Are employer charges included in net pay?**
A: No. Employer Charges and Employer Liabilities are shown in their own column and are not deducted from gross pay.
