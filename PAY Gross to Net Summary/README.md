---
layout: default
last_modified_at: 2026-10-16
title: 'PAY Gross to Net Summary | Oracle EBS SQL Report'
description: 'Payroll gross-to-net summary per employee and pay period, showing gross pay (earnings), pre-tax deductions, involuntary deductions (tax), voluntary…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payroll, Enginatics, PAY, Gross, Net, Summary, hr_all_organization_units_vl, per_all_people_f, per_all_assignments_f'
permalink: /PAY%20Gross%20to%20Net%20Summary/
report_name: 'PAY Gross to Net Summary'
report_web_name: pay-gross-to-net-summary
module: 'Payroll'
module_url: /modules/payroll/
---

# PAY Gross to Net Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pay-gross-to-net-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary).
**Oracle EBS module:** [Payroll](/modules/payroll/ "Oracle EBS Payroll reports") · [all Payroll reports](/modules/payroll/)  

## Overview
Payroll gross-to-net summary per employee and pay period, showing gross pay (earnings), pre-tax deductions, involuntary deductions (tax), voluntary deductions, employer charges, and calculated net pay. Based on completed payroll run results. Useful for payroll reconciliation and compensation analysis.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Payroll Name, Period Date From, Period Date To, Person Full Name, Organization

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_payroll_actions](https://www.enginatics.com/library/?pg=1&find=pay_payroll_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [per_time_periods](https://www.enginatics.com/library/?pg=1&find=per_time_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_all_payrolls_f](https://www.enginatics.com/library/?pg=1&find=pay_all_payrolls_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_run_results](https://www.enginatics.com/library/?pg=1&find=pay_run_results&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_run_result_values](https://www.enginatics.com/library/?pg=1&find=pay_run_result_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_input_values_f](https://www.enginatics.com/library/?pg=1&find=pay_input_values_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_element_types_f](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary), [pay_element_classifications](https://www.enginatics.com/library/?pg=1&find=pay_element_classifications&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)

## Related Reports
[PAY Hire to Retire Tracker](/PAY%20Hire%20to%20Retire%20Tracker/ "PAY Hire to Retire Tracker Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PAY Employee Payroll History](/PAY%20Employee%20Payroll%20History/ "PAY Employee Payroll History Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Gross%20to%20Net%20Summary/PAY%20Gross%20to%20Net%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pay-gross-to-net-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary) |
| Blitz Report™ XML Import | [PAY_Gross_to_Net_Summary.xml](https://www.enginatics.com/xml/pay-gross-to-net-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary) |
| SQL Source | [PAY Gross to Net Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Gross%20to%20Net%20Summary/PAY%20Gross%20to%20Net%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pay-gross-to-net-summary/](https://www.enginatics.com/reports/pay-gross-to-net-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary) |

## Case Study & Technical Analysis: PAY Gross to Net Summary

### Executive Summary
The PAY Gross to Net Summary report shows, for each employee and pay period, how gross pay converts into net pay in Oracle Payroll. It groups completed payroll run results into gross pay from earnings, pre-tax deductions, involuntary deductions such as tax, voluntary deductions, and net pay, and it also reports employer charges. Payroll reconciliation teams use it to check that payroll runs agree with the amounts expected for each employee, and compensation analysts use it to compare pay components across jobs, locations and organizations. The report runs in Excel via Blitz Report, and it reads only payroll actions that have completed.

### Business Challenge
*   **Payroll reconciliation:** Totals from payroll runs must be checked against the figures supported by the payroll team before they are passed to the ledger and the bank.
*   **Classification of pay elements:** Each element belongs to a classification, such as earnings, pre-tax deduction or tax deduction, and the totals must place each element in the right category.
*   **Compensation analysis:** Compensation teams need gross pay and deductions by job, location and organization, not only at the total level.
*   **Employer cost visibility:** Employer charges and liabilities sit alongside employee pay, and they must be seen together with pay for a true labor cost view.

### The Solution
*   **Classification-based totals:** Run result values are summed into gross pay, pre-tax deductions, involuntary deductions, voluntary deductions and employer charges using the element classification names.
*   **Net pay derivation:** Net pay is calculated in the outer query as gross pay less involuntary deductions, voluntary deductions and pre-tax deductions.
*   **Employee and assignment context:** Each row shows the business group, employee number and name, organization, job and location, taken from the primary employee assignment.
*   **Completed runs only:** Only payroll actions with a completed status and the run, quick pay, balance and void action types are included.

### Technical Architecture (High Level)
#### Primary Tables
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

#### Logical Relationships
1. The people and assignment blocks are restricted to the current effective dates, and the assignment is the primary employee assignment.
2. `PER_ALL_ASSIGNMENTS_F` is joined to `PAY_ASSIGNMENT_ACTIONS`, which joins to `PAY_PAYROLL_ACTIONS` on payroll action identifier.
3. `PAY_PAYROLL_ACTIONS` is joined to `PER_TIME_PERIODS` and to `PAY_ALL_PAYROLLS_F` on payroll identifier, with the period start date inside the payroll validity range.
4. `PAY_ASSIGNMENT_ACTIONS` is joined to `PAY_RUN_RESULTS`, then to `PAY_RUN_RESULT_VALUES` on run result identifier.
5. The result value is joined to `PAY_INPUT_VALUES_F` for the Pay Value input, and the run result to `PAY_ELEMENT_TYPES_F` and `PAY_ELEMENT_CLASSIFICATIONS` for the classification.
6. The output is grouped by business group, employee, organization, job, location, payroll, period and period dates.

### Parameters & Filtering
*   **Business Group:** Restricts the output to one business group.
*   **Payroll Name:** Restricts the output to one payroll.
*   **Period Date From and To:** Restrict the pay periods by their start date.
*   **Person Full Name:** Restricts the output to matching employee names.
*   **Organization:** Restricts the output to one organization.

The SQL text does not reference these parameters through bind variables. The rows are determined by the joins, the current effective dates and the completed payroll action filter described above.

### Performance & Optimization
*   The people and assignment blocks are filtered to rows valid on the current date before the main join, which limits the employees read.
*   Payroll actions are filtered to completed status and four action types, which excludes incomplete and other process types early in the query.
*   Pay values are summed with conditional aggregation in a single pass, so each classification total is produced without a separate query.
*   The query groups at employee and period level, so the number of output rows equals the number of employee and period combinations with completed runs.

### FAQ
**Q: Which element classifications are counted as gross pay?**
A: Earnings, Supplemental Earnings, Imputed Earnings and Non-payroll Payments are summed into gross pay.

**Q: How is net pay calculated?**
A: Net pay is gross pay less pre-tax deductions, involuntary deductions and voluntary deductions.

**Q: Are employer charges included in net pay?**
A: No. Employer Charges and Employer Liabilities are shown in their own column and are not deducted from gross pay.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-gross-to-net-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
