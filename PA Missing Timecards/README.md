---
layout: default
last_modified_at: 2026-10-19
title: 'PA Missing Timecards | Oracle EBS SQL Report'
description: 'Active employees who have not submitted timecards for a given week ending date, showing employee details, job, organization, and supervisor. Timecard…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, Missing, Timecards, per_jobs, per_people_x, per_assignments_f'
permalink: /PA%20Missing%20Timecards/
report_name: 'PA Missing Timecards'
report_web_name: pa-missing-timecards
module: 'Projects'
module_url: /modules/projects/
---

# PA Missing Timecards – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-missing-timecards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
Active employees who have not submitted timecards for a given week ending date, showing employee details, job, organization, and supervisor.

Timecard Source Project Expenditures lists employees without a project expenditure for the week ending date. OTL Timecards lists employees without an OTL timecard whose period contains the week ending date, including employees who do not charge projects.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Operating Unit, Week Ending Date, Organization, Timecard Source

## Oracle EBS Tables Used
[per_jobs](https://www.enginatics.com/library/?pg=1&find=per_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards), [per_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards), [hxc_timecard_summary](https://www.enginatics.com/library/?pg=1&find=hxc_timecard_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [PA Project Expenditure Items with WIP and INV Detail](/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/ "PA Project Expenditure Items with WIP and INV Detail Oracle EBS SQL Report"), [OTL Timecard Upload 11i](/OTL%20Timecard%20Upload%2011i/ "OTL Timecard Upload 11i Oracle EBS SQL Report"), [OTL Timecard Upload](/OTL%20Timecard%20Upload/ "OTL Timecard Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Missing%20Timecards/PA%20Missing%20Timecards.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-missing-timecards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards) |
| Blitz Report™ XML Import | [PA_Missing_Timecards.xml](https://www.enginatics.com/xml/pa-missing-timecards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards) |
| SQL Source | [PA Missing Timecards.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Missing%20Timecards/PA%20Missing%20Timecards.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-missing-timecards/](https://www.enginatics.com/reports/pa-missing-timecards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards) |

## Case Study & Technical Analysis: PA Missing Timecards

### Executive Summary
The PA Missing Timecards report lists the active employees who have not submitted a timecard for a chosen week ending date. Each row shows the employee, job, organization, business group, supervisor and e-mail address, so that the gap can be followed up with the right manager. Project accounting and time administration teams use it on the weekly close to chase missing timesheets before project costs and billing are closed. The report supports two timecard sources: project expenditures recorded in Oracle Projects, and time cards held in Oracle Time and Labor. It runs in Excel through Blitz Report.

### Business Challenge
*   **Weekly timesheet completeness:** Project costs cannot be closed for a week until every chargeable employee has entered time, and the list of missing employees must be produced quickly each week.
*   **Supervisor follow-up:** Each missing timecard must be routed to the supervisor who approves the employee's time, so the list shows the supervisor and contact details.
*   **Non-project employees:** Employees who do not charge projects still need an OTL timecard in some organizations, and they must be checked separately from project time.
*   **Accurate population:** Only active employees in an employee assignment should be chased, so terminated staff and non-employee assignments are removed.

### The Solution
*   **Active employee population:** The report takes primary employee assignments that are effective on the current date, so the population is the current workforce.
*   **Project expenditure test:** When the Timecard Source is PA, an employee is listed if there is no project expenditure ending on the week ending date.
*   **OTL timecard test:** When the Timecard Source is OTL, an employee is listed if no timecard summary covers the week ending date.
*   **Contact and hierarchy details:** The job name, organization, business group, supervisor full name and e-mail address are added to each employee.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_PEOPLE_X`: the employee's name, employee number and e-mail address.
*   `PER_ASSIGNMENTS_F`: the primary employee assignment, with its job, organization, supervisor and business group.
*   `PER_JOBS`: the job name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the assignment organization names.
*   `PA_EXPENDITURES_ALL`: the project expenditure headers, used to test whether time was entered for the week.
*   `HXC_TIMECARD_SUMMARY`: the OTL timecard summary, with the start and stop time of each card.

#### Logical Relationships
1.  `PER_PEOPLE_X` joins to `PER_ASSIGNMENTS_F` on the person ID, restricted to primary employee assignments effective today.
2.  The assignment joins to `HR_ALL_ORGANIZATION_UNITS_VL` twice, once for the business group and once for the organization.
3.  The assignment joins to `PER_JOBS` on the job ID, and to the supervisor's name in `PER_PEOPLE_X` through the supervisor ID.
4.  The PA test is a `NOT EXISTS` on `PA_EXPENDITURES_ALL` by the incurring person and the expenditure ending date.
5.  The OTL test is a `NOT IN` on `HXC_TIMECARD_SUMMARY` by resource ID, where the week ending date falls between the trunc of the start and stop times.

### Parameters & Filtering
*   **Business Group:** the business group whose employees are reported.
*   **Operating Unit:** the operating unit that the employee is assigned to.
*   **Week Ending Date:** the date that the timecard must cover.
*   **Organization:** limits the output to one organization.
*   **Timecard Source:** PA tests project expenditures, and OTL tests OTL timecards. OTL also lists employees who do not charge projects.

### Performance & Optimization
*   The project expenditure test is a `NOT EXISTS` subquery, which stops at the first matching expenditure for each employee.
*   The OTL test is a `NOT IN` subquery on the timecard summary, which is limited by the week ending date range.
*   The source condition is written with the timecard source parameter, so the OTL branch skips the project expenditure test entirely.
*   The assignment filter uses the current effective date range, which limits the assignment rows to the current workforce.

### FAQ
**Q: Why does the OTL source list employees who do not charge projects?**
A: The OTL test checks only for an OTL timecard covering the week ending date, so employees with no project expenditures are included if they have no timecard.

**Q: Which employees are excluded from the list?**
A: Only primary employee assignments that are active on the current date are considered, so terminated staff and non-employee assignments do not appear.

**Q: How is the supervisor shown?**
A: The supervisor is the person linked to the assignment, and their full name is shown in the Supervisor column.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-missing-timecards)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
