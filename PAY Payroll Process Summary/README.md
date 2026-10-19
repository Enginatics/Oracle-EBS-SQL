---
layout: default
last_modified_at: 2026-10-19
title: 'PAY Payroll Process Summary | Oracle EBS SQL Report'
description: 'Payroll processes (payroll actions) of all action types with their assignment action counts by status, the number of messages and the first message, for…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payroll, Enginatics, PAY, Process, Summary, pay_all_payrolls_f, pay_consolidation_sets, pay_element_sets'
permalink: /PAY%20Payroll%20Process%20Summary/
report_name: 'PAY Payroll Process Summary'
report_web_name: pay-payroll-process-summary
module: 'Payroll'
module_url: /modules/payroll/
---

# PAY Payroll Process Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pay-payroll-process-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary).
**Oracle EBS module:** [Payroll](/modules/payroll/ "Oracle EBS Payroll reports") · [all Payroll reports](/modules/payroll/)  

## Overview
Payroll processes (payroll actions) of all action types with their assignment action counts by status, the number of messages and the first message, for monitoring payroll runs, prepayments, costing, transfers to the ledger and other payroll processes.

Messages counts the process level and assignment action level messages. First Message is the first process level message, or else the first fatal assignment action message.

Use Errors Only to list processes in error or with assignment actions in error, for example as a scheduled alert.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Payroll, Action Type, Action Status, Effective Date From, Effective Date To, Request Id, Errors Only

## Oracle EBS Tables Used
[pay_all_payrolls_f](https://www.enginatics.com/library/?pg=1&find=pay_all_payrolls_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [pay_consolidation_sets](https://www.enginatics.com/library/?pg=1&find=pay_consolidation_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [pay_element_sets](https://www.enginatics.com/library/?pg=1&find=pay_element_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [hr_assignment_sets](https://www.enginatics.com/library/?pg=1&find=hr_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [pay_batch_headers](https://www.enginatics.com/library/?pg=1&find=pay_batch_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [pay_message_lines](https://www.enginatics.com/library/?pg=1&find=pay_message_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [pay_payroll_actions](https://www.enginatics.com/library/?pg=1&find=pay_payroll_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [per_time_periods](https://www.enginatics.com/library/?pg=1&find=per_time_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)

## Related Reports
[PAY Hire to Retire Tracker](/PAY%20Hire%20to%20Retire%20Tracker/ "PAY Hire to Retire Tracker Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PAY Gross to Net Summary](/PAY%20Gross%20to%20Net%20Summary/ "PAY Gross to Net Summary Oracle EBS SQL Report"), [PAY Employee Payroll History](/PAY%20Employee%20Payroll%20History/ "PAY Employee Payroll History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Payroll%20Process%20Summary/PAY%20Payroll%20Process%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PAY Payroll Process Summary 15-Oct-2026 022632.xlsx](https://www.enginatics.com/example/pay-payroll-process-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary) |
| Blitz Report™ XML Import | [PAY_Payroll_Process_Summary.xml](https://www.enginatics.com/xml/pay-payroll-process-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary) |
| SQL Source | [PAY Payroll Process Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Payroll%20Process%20Summary/PAY%20Payroll%20Process%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pay-payroll-process-summary/](https://www.enginatics.com/reports/pay-payroll-process-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary) |

## Case Study & Technical Analysis: PAY Payroll Process Summary

### Executive Summary
The PAY Payroll Process Summary report lists Oracle Payroll processes, which are the payroll actions of every action type, with the number of assignment actions in each status, the count of messages and the first message of each process. It covers payroll runs, prepayments, costing, transfers to the ledger and other payroll processes in one list. Payroll operations teams use it to monitor the progress of payroll runs, to find processes with errors or assignment actions in error, and to diagnose failures from the first message. The Errors Only parameter lets the report run as a scheduled alert. The report runs in Excel via Blitz Report.

### Business Challenge
*   **Run monitoring:** Payroll runs are made up of many assignment actions, and operators need to see how many are complete, in error, skipped or still unprocessed.
*   **Failure diagnosis:** When a process fails, the reason is recorded in message lines, and the first message is the fastest way to start an investigation.
*   **Multiple process types:** Payroll runs, prepayments, costing and ledger transfers are all payroll actions, and they need to be monitored from one list.
*   **Timely alerts:** Failed processes must be found before payments or ledger transfers are delayed.

### The Solution
*   **Status breakdown:** Assignment actions are counted by status: complete, in error, marked for retry, unprocessed and skipped.
*   **Message counts:** Process-level messages and assignment-action-level messages are counted together.
*   **First message logic:** The first process-level message is shown, or, if none exists, the first fatal assignment action message.
*   **Run context:** Each process shows its payroll, consolidation set, element set, assignment set, batch, concurrent request, program, requester and actual start and completion times.
*   **Error filter:** Errors Only lists processes that are in error or have assignment actions in error.

### Technical Architecture (High Level)
#### Primary Tables
*   `PAY_PAYROLL_ACTIONS`: the payroll processes, with action type, status, effective date, time period and request identifier.
*   `PAY_ASSIGNMENT_ACTIONS`: the assignment actions of each process, aggregated here by status.
*   `PAY_MESSAGE_LINES`: the process-level and assignment-action-level messages.
*   `PAY_ALL_PAYROLLS_F`: the payroll name, valid on the effective date.
*   `PAY_CONSOLIDATION_SETS`, `PAY_ELEMENT_SETS`, `HR_ASSIGNMENT_SETS`, `PAY_BATCH_HEADERS`: the set and batch names attached to a process.
*   `PER_TIME_PERIODS`: the period name and date earned.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group.
*   `FND_CONCURRENT_REQUESTS`, `FND_CONCURRENT_PROGRAMS_VL`: the concurrent request and program that ran the process.

#### Logical Relationships
1. `PAY_PAYROLL_ACTIONS` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on business group, and outer joined to `PER_TIME_PERIODS` on time period.
2. An inline view aggregates `PAY_ASSIGNMENT_ACTIONS` by payroll action, counting the assignment actions in each status.
3. `PAY_PAYROLL_ACTIONS` is outer joined to `FND_CONCURRENT_REQUESTS`, and that to `FND_CONCURRENT_PROGRAMS_VL` on application and program identifiers.
4. The payroll, consolidation set, element set, assignment set and batch names are scalar lookups on the process identifiers.
5. Message counts are two scalar subqueries, one on process-level lines and one on assignment action lines through `PAY_ASSIGNMENT_ACTIONS`.

### Parameters & Filtering
*   **Business Group:** Restricts the processes to one business group.
*   **Payroll:** Restricts the processes to one payroll.
*   **Action Type and Action Status:** Restrict the processes by type and by status.
*   **Effective Date From and To:** Restrict the processes by effective date.
*   **Request Id:** Returns the process started by one concurrent request.
*   **Errors Only:** When set, lists only processes in error or with assignment actions in error, suitable for a scheduled alert.

### Performance & Optimization
*   The assignment action counts are pre-aggregated in an inline view per payroll action, so the status breakdown does not require a correlated subquery per process.
*   Message counts and the first message are scalar subqueries on the message lines, so their cost grows with the number of messages on each process.
*   The first message uses `max` with `keep (dense_rank first)` ordered by line sequence, which returns the earliest message in one lookup.
*   The output is ordered by effective date, business group, payroll, action type and request identifier.

### FAQ
**Q: How do I set up an alert for failed payroll processes?**
A: Run the report with Errors Only set to Yes, and schedule it so that processes in error are listed.

**Q: Which message is shown as First Message?**
A: The first process-level message is shown. If there is none, the first fatal assignment action message is shown.

**Q: What does the Messages column count?**
A: It counts the process-level messages and the assignment action-level messages of each process.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-payroll-process-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
