---
layout: default
title: 'PER Employee Salary Change | Oracle EBS SQL Report'
description: 'Query to get the last Salary change details for employees. Can add: whether to look at just the recent salary change? or salary change history.... If yes…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, PER, Employee, Salary, Change, per_all_people_f, per_business_groups, per_all_assignments_f'
permalink: /PER%20Employee%20Salary%20Change/
---

# PER Employee Salary Change – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-employee-salary-change/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Query to get the last Salary change details for employees.

Can add:
whether to look at just the recent salary change?
or salary change history.... If yes, then the last condition in where clause to be dynamically added/removed

## Report Parameters
Business Group, Effective Date

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f), [per_jobs](https://www.enginatics.com/library/?pg=1&find=per_jobs), [per_grades](https://www.enginatics.com/library/?pg=1&find=per_grades), [per_all_positions](https://www.enginatics.com/library/?pg=1&find=per_all_positions), [fnd_currencies_tl](https://www.enginatics.com/library/?pg=1&find=fnd_currencies_tl), [per_pay_proposals](https://www.enginatics.com/library/?pg=1&find=per_pay_proposals)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [PER Terminations and Separations](/PER%20Terminations%20and%20Separations/ "PER Terminations and Separations Oracle EBS SQL Report"), [PER New Hires](/PER%20New%20Hires/ "PER New Hires Oracle EBS SQL Report"), [PER Employee Grade Changes](/PER%20Employee%20Grade%20Changes/ "PER Employee Grade Changes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/per-employee-salary-change/) |
| Blitz Report™ XML Import | [PER_Employee_Salary_Change.xml](https://www.enginatics.com/xml/per-employee-salary-change/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-employee-salary-change/](https://www.enginatics.com/reports/per-employee-salary-change/) |

## Case Study & Technical Analysis: PER Employee Salary Change Report

### Executive Summary

The PER Employee Salary Change report is a vital Human Resources and Compensation audit tool that provides a detailed, date-effective history of salary changes for employees within Oracle HR and Payroll. It presents critical information on previous and new salaries, effective dates, and the associated currency. This report is essential for HR managers, compensation analysts, and auditors to track compensation adjustments, ensure pay equity, analyze salary trends, and maintain accurate historical pay records for compliance and strategic workforce planning.

### Business Challenge

Managing employee compensation, particularly tracking salary changes, is a critical function for HR and finance. The process often presents several challenges:

-   **Lack of Historical Pay Visibility:** Obtaining a consolidated historical view of all salary changes for an individual employee or across the organization is often difficult through standard Oracle forms, requiring manual data extraction and compilation.
-   **Auditing Compensation Decisions:** HR and compensation teams need to audit salary adjustments to ensure fairness, consistency, and compliance with company policies, budget constraints, and labor laws. Manual auditing is prone to errors and very time-consuming.
-   **Analyzing Salary Trends:** Understanding how salaries have changed over time, identifying patterns in pay increases (e.g., annual reviews, promotions), and assessing the impact of these changes on overall labor costs is difficult without a robust reporting tool.
-   **Responding to Employee Inquiries:** Employees often have questions about their historical pay. Providing accurate, detailed responses quickly requires easy access to their salary history.

### The Solution

This report offers a clear, date-effective, and auditable solution for monitoring and analyzing employee salary changes, transforming how organizations manage compensation data.

-   **Comprehensive Salary History:** It provides a detailed, chronological list of all salary changes for employees, including the effective dates, old and new salaries, and currency. This offers a precise historical record of compensation adjustments.
-   **Simplified Audit Trail:** The report serves as an excellent audit trail, providing objective data on salary changes that can be used to validate compensation decisions, ensure compliance, and support internal and external financial audits.
-   **Supports Compensation Analysis:** Compensation analysts can use this report to analyze the frequency and magnitude of salary changes, identify employees who have or have not received adjustments, and assess the overall impact on the organization's payroll budget.
-   **Enhanced Responsiveness:** HR and payroll staff can quickly retrieve specific employee salary histories, verify adjustments, and provide accurate information, significantly improving responsiveness to employee and management inquiries.

### Technical Architecture (High Level)

The report queries Oracle HR's date-effective compensation tables to extract historical salary change information.

-   **Primary Tables Involved:**
    -   `per_all_people_f` (for core employee demographic data).
    -   `per_all_assignments_f` (for employee assignment details).
    -   `per_pay_proposals` (the central table storing salary proposals and adjustments).
    -   `per_business_groups` (for organizational context).
    -   `fnd_currencies_tl` (to display the currency name).
-   **Logical Relationships:** The report leverages the date-effective nature of `per_all_people_f` and `per_all_assignments_f` to identify the employee and their assignment as of the `Effective Date`. It then joins to `per_pay_proposals` to retrieve the salary proposals that define the salary changes, linking them to the employee's assignment to show the historical compensation adjustments.

### Parameters & Filtering

The report includes flexible parameters for targeted analysis of salary changes:

-   **Effective Date:** This crucial parameter allows users to specify a point in time to view salary changes up to or on that date. It is key for historical accuracy and for comparing changes across different periods.
-   **Business Group:** Filters the report to a specific legal entity or organizational grouping, allowing for focused analysis within different parts of the enterprise.
-   **Employee Filters:** Although not explicitly listed in the `README.md` as parameters, such a report typically allows filtering by employee name or number to drill down into individual compensation histories.

### Performance & Optimization

As a master data report dealing with date-effective tables, it is optimized for efficient historical data retrieval.

-   **Date-Effective Table Querying:** The core tables (`_F` tables and `per_pay_proposals`) are designed and indexed by Oracle to efficiently retrieve historical versions of records based on the `Effective Date`, ensuring fast performance even when analyzing changes over long periods.
-   **Primary Key Joins:** The queries utilize primary keys (`person_id`, `assignment_id`, `pay_proposal_id`) for optimal join performance across the HR and Payroll tables.

### FAQ

**1. How does this report identify a 'salary change'?**
   The report identifies a salary change by examining the historical records within the `per_pay_proposals` table, which stores details of all approved salary proposals and their effective dates. Each new proposal typically represents a salary change.

**2. Can this report also show the reason for a salary change (e.g., merit increase, promotion)?**
   The `per_pay_proposals` table often includes fields or descriptive flexfields that capture the reason for a salary change. If configured and populated, this report could be extended to display these reasons, providing richer context for each adjustment.

**3. How is this report different from the 'PER Employee Grade Changes' report?**
   This report focuses specifically on changes to an employee's *monetary compensation* (salary). The 'PER Employee Grade Changes' report, while often related, tracks changes to an employee's *grade*, which is a classification of their job level. While a promotion (grade change) often triggers a salary change, these are distinct pieces of information tracked separately within Oracle HR.


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
