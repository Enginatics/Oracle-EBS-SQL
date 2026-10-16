---
layout: default
last_modified_at: 2026-10-16
title: 'PAY Hire to Retire Tracker | Oracle EBS SQL Report'
description: 'One row per employee period of service that overlaps the period from Date From to Date To: new hires, leavers and everyone employed in between, with the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payroll, Enginatics, R12 only, PAY, Hire, Retire, Tracker, per_all_assignments_f, per_assignment_status_types, hr_all_organization_units_vl'
permalink: /PAY%20Hire%20to%20Retire%20Tracker/
report_name: 'PAY Hire to Retire Tracker'
report_web_name: pay-hire-to-retire-tracker
module: 'Payroll'
module_url: /modules/payroll/
---

# PAY Hire to Retire Tracker – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pay-hire-to-retire-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker).
**Oracle EBS module:** [Payroll](/modules/payroll/ "Oracle EBS Payroll reports") · [all Payroll reports](/modules/payroll/)  

## Overview
One row per employee period of service that overlaps the period from Date From to Date To: new hires, leavers and everyone employed in between, with the date of each step from hire to the first payment, the termination dates, and the payroll processing exceptions of the period.

Assignment columns are those of the primary assignment on Date To, or on the termination date for a leaver. New Hire and Leaver mark a hire or termination date within the period.

Payroll Ready Date is the later of the hire date and the dates the payroll and the first approved salary were entered. First Period Cut Off and First Period Pay Date are the cut-off and the regular payment date of the first pay period whose cut-off is on or after the hire date. Payment dates are those of completed cheque, magnetic transfer, cash or manual payments.

Missed Run Date is the date of the payroll's last run in the period when the assignment was processable on that payroll but was not processed in that pay period or later. Unpaid Prepayment Date and Unpaid Amount are prepayments of the period that no completed payment pays. Process Errors counts payroll processes in error or marked for retry in the period; Error Date, Error Process and Error Message describe the latest.

Retro Pending Date is the earliest reprocess date of a retropay request not yet processed. Run After Termination is the last run date when that run was for a pay period starting after the last standard process date, or after the termination date when there is none.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Payroll, Date From, Date To

## Oracle EBS Tables Used
[per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_assignment_status_types](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [hr_locations_all_vl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_all_payrolls_f](https://www.enginatics.com/library/?pg=1&find=pay_all_payrolls_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_pay_bases](https://www.enginatics.com/library/?pg=1&find=per_pay_bases&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_pay_proposals](https://www.enginatics.com/library/?pg=1&find=per_pay_proposals&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_assignment_status_types_v](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [hr_soft_coding_keyflex](https://www.enginatics.com/library/?pg=1&find=hr_soft_coding_keyflex&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_personal_payment_methods_f](https://www.enginatics.com/library/?pg=1&find=pay_personal_payment_methods_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_org_payment_methods_f_tl](https://www.enginatics.com/library/?pg=1&find=pay_org_payment_methods_f_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_time_periods](https://www.enginatics.com/library/?pg=1&find=per_time_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_message_lines](https://www.enginatics.com/library/?pg=1&find=pay_message_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_retro_assignments](https://www.enginatics.com/library/?pg=1&find=pay_retro_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [per_periods_of_service](https://www.enginatics.com/library/?pg=1&find=per_periods_of_service&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_pre_payments](https://www.enginatics.com/library/?pg=1&find=pay_pre_payments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [pay_payroll_actions](https://www.enginatics.com/library/?pg=1&find=pay_payroll_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)

## Related Reports
[PER Person Assignment Upload](/PER%20Person%20Assignment%20Upload/ "PER Person Assignment Upload Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [PAY Gross to Net Summary](/PAY%20Gross%20to%20Net%20Summary/ "PAY Gross to Net Summary Oracle EBS SQL Report"), [PER New Hires](/PER%20New%20Hires/ "PER New Hires Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Hire%20to%20Retire%20Tracker/PAY%20Hire%20to%20Retire%20Tracker.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pay-hire-to-retire-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker) |
| Blitz Report™ XML Import | [PAY_Hire_to_Retire_Tracker.xml](https://www.enginatics.com/xml/pay-hire-to-retire-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker) |
| SQL Source | [PAY Hire to Retire Tracker.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Hire%20to%20Retire%20Tracker/PAY%20Hire%20to%20Retire%20Tracker.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pay-hire-to-retire-tracker/](https://www.enginatics.com/reports/pay-hire-to-retire-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker) |

## Case Study & Technical Analysis: PAY Hire to Retire Tracker

### Executive Summary
PAY Hire to Retire Tracker follows each employee period of service that overlaps a chosen date range, from the hire date through the first payroll run and payment, and to the termination and any payroll processing exceptions. It returns one row per employee, with the primary assignment details and the dates of each step in the payroll journey. HR and payroll administrators use it to confirm that new hires were paid on time, to find leavers who were processed after termination, and to investigate payroll errors that affect a particular period of service.

### Business Challenge
*   **First Pay Delays:** New hires who miss the first payroll run, or whose salary was entered late, create complaints and pay corrections.
*   **Leaver Processing:** Payments made after a termination date must be identified and recovered, and runs processed after termination need review.
*   **Missed Runs:** An assignment that was processable on a payroll but was not processed in a pay period causes underpayment that must be corrected.
*   **Error Resolution:** Payroll process errors and retropay requests need to be visible by employee and period.

### The Solution
*   **Journey Dates:** The report shows the payroll ready date, first period cut-off and pay date, first run, first payment and last payment for each new hire.
*   **Exception Columns:** Missed run dates, unpaid prepayment dates and amounts, process error counts and the latest error message are provided for the period.
*   **Retro Visibility:** The earliest pending retropay reprocess date is shown, so pending retropay can be scheduled.
*   **Leaver Detail:** Termination date, leaving reason, last standard process date and any run after termination are shown together.

### Technical Architecture (High Level)
#### Primary Tables
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

#### Logical Relationships
1.  Periods of service in `PER_PERIODS_OF_SERVICE` that overlap the date range are joined to their person in `PER_ALL_PEOPLE_F` and to their business group.
2.  The primary employee assignment in `PER_ALL_ASSIGNMENTS_F` is joined to each period of service on the period identifier.
3.  Payroll actions and assignment actions in the range are aggregated per assignment into first and last run dates, first and last payment dates, unpaid prepayments and errors.
4.  Each payroll's last run in the range is aggregated per payroll identifier.
5.  Pay period cut-off and payment dates are found from the time periods of the assignment's payroll for the first period on or after the hire date.
6.  Error message lines are read from `PAY_MESSAGE_LINES` for the latest error action.

### Parameters & Filtering
*   **Business Group:** Restricts the output to one business group.
*   **Payroll:** Restricts the output to one payroll.
*   **Date From and Date To:** Define the window. Periods of service that overlap the window are included, and new hire columns apply to hires on or after Date From.

### Performance & Optimization
*   **Date Window First:** The periods of service are filtered by the date window before the assignment, person and payroll joins, so the rest of the report works on the affected employees only.
*   **Aggregated Action History:** Payroll and assignment actions are aggregated once per assignment, rather than read row by row for each output column.
*   **Dense Rank Selection:** First and last run, payment and error values use keep-dense-rank aggregates, which select the required row in one pass.
*   **Hint Control:** Hints disable predicate pushing into the aggregated inline views, so each inline view is evaluated once.

### FAQ
**Q: What does Missed Run Date show?**
A: It is the date of the payroll's last run in the period when the assignment was processable on that payroll but was not processed in that pay period or later.

**Q: How is Payroll Ready Date calculated?**
A: For a new hire it is the latest of the hire date, the date the payroll was entered, and the date the approved salary was entered when a salary basis exists.

**Q: Which assignment does the report show for a leaver?**
A: It shows the primary assignment on the termination date, as stated in the report description.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-hire-to-retire-tracker)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
