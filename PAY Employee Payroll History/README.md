---
layout: default
last_modified_at: 2026-10-16
title: 'PAY Employee Payroll History | Oracle EBS SQL Report'
description: 'Payroll results per employee and payroll run date: run result Pay Values summed by element classification. Net Pay is Earnings plus Supplemental Earnings…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payroll, Enginatics, PAY, Employee, History, hr_all_organization_units_vl, per_all_people_f, per_all_assignments_f'
permalink: /PAY%20Employee%20Payroll%20History/
report_name: 'PAY Employee Payroll History'
report_web_name: pay-employee-payroll-history
module: 'Payroll'
module_url: /modules/payroll/
---

# PAY Employee Payroll History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pay-employee-payroll-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history).
**Oracle EBS module:** [Payroll](/modules/payroll/ "Oracle EBS Payroll reports") · [all Payroll reports](/modules/payroll/)  

## Overview
Payroll results per employee and payroll run date: run result Pay Values summed by element classification.

Net Pay is Earnings plus Supplemental Earnings minus Pre-Tax, Tax, Voluntary and Involuntary Deductions, which equals the prepayment amount of the US payroll. Imputed Earnings and Information elements do not count towards it.

Previous Net Pay is the employee's net pay of the preceding payroll run date within the selected run date range, so the first run date of an employee has no variance. Use Variance % Over to list only changes above a percentage.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Last Name starts with, Full name, Business Group, Payroll Run Date From, Payroll Run Date To, Effective Date, Variance % Over

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_payroll_actions](https://www.enginatics.com/library/?pg=1&find=pay_payroll_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_run_results](https://www.enginatics.com/library/?pg=1&find=pay_run_results&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_run_result_values](https://www.enginatics.com/library/?pg=1&find=pay_run_result_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_element_types_f](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_input_values_f](https://www.enginatics.com/library/?pg=1&find=pay_input_values_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [per_time_periods](https://www.enginatics.com/library/?pg=1&find=per_time_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history), [pay_element_classifications_vl](https://www.enginatics.com/library/?pg=1&find=pay_element_classifications_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)

## Related Reports
[PAY Gross to Net Summary](/PAY%20Gross%20to%20Net%20Summary/ "PAY Gross to Net Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Employee%20Payroll%20History/PAY%20Employee%20Payroll%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pay-employee-payroll-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history) |
| Blitz Report™ XML Import | [PAY_Employee_Payroll_History.xml](https://www.enginatics.com/xml/pay-employee-payroll-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history) |
| SQL Source | [PAY Employee Payroll History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Employee%20Payroll%20History/PAY%20Employee%20Payroll%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pay-employee-payroll-history/](https://www.enginatics.com/reports/pay-employee-payroll-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history) |

## Case Study & Technical Analysis: PAY Employee Payroll History Report

### Executive Summary

The PAY Employee Payroll History report is a comprehensive master data report that provides a detailed history of payroll earnings and deductions for each employee within Oracle Payroll. It consolidates critical information such as employee number, name, payroll period, and a breakdown of earnings elements. This report is an indispensable tool for human resources, payroll administrators, and financial auditors who require a clear, auditable trail of an employee's compensation over time, ensuring accuracy in financial records and supporting employee inquiries.

### Business Challenge

Managing and verifying employee payroll history in a large organization can be a complex and time-consuming task. Standard Oracle forms provide transactional details but often lack a consolidated, easily accessible historical view. Key challenges include:

-   **Fragmented Data Access:** Information about an employee's earnings and deductions over multiple payroll periods is typically scattered across various screens and reports, making it difficult to get a holistic historical view.
-   **Manual Reconciliation and Verification:** Responding to employee inquiries about past pay, verifying historical earnings for loan applications, or auditing payroll calculations often involves manually piecing together data from different sources, which is inefficient and prone to errors.
-   **Compliance and Audit Readiness:** For internal and external audits, a clear and comprehensive record of employee payroll history is mandatory. Generating this information in an easily consumable format can be a significant challenge.
-   **Trend Analysis Limitations:** Without a consolidated historical view, identifying trends in employee compensation (e.g., changes in overtime, bonuses) or analyzing the impact of pay raises over time is difficult.

### The Solution

This report provides a consolidated, detailed, and easily accessible view of employee payroll history, transforming how organizations manage and audit compensation data.

-   **Comprehensive Historical View:** It presents a single line per employee for each payroll period, detailing all earnings and, if configured, deductions. This offers an immediate and complete picture of an employee's compensation over any selected timeframe.
-   **Streamlined Query and Audit:** With intuitive filtering parameters, HR and payroll staff can quickly retrieve specific employee histories, verify calculations, and provide accurate responses to inquiries, significantly reducing response times and improving service.
-   **Enhanced Compliance:** The report generates an auditable record of payroll data, making it easier for organizations to demonstrate compliance with labor laws, tax regulations, and internal policies.
-   **Supports Compensation Analysis:** By providing historical earnings data, the report serves as a valuable input for HR analysts to perform compensation trend analysis, evaluate the effectiveness of pay structures, and support workforce planning.

### Technical Architecture (High Level)

The report queries core Oracle HR and Payroll tables, joining historical payroll run results with employee and assignment details.

-   **Primary Tables Involved:**
    -   `per_all_people_f` (for core employee demographic data like name and employee number).
    -   `per_all_assignments_f` (for employee assignment details, including business group).
    -   `pay_payroll_actions` (the header for each payroll run).
    -   `pay_assignment_actions` (links specific assignments to payroll runs).
    -   `pay_run_results` and `pay_run_result_values` (contain the detailed earnings and deduction values for each payroll element).
    -   `pay_element_types_f` and `pay_input_values_f` (for defining payroll elements).
    -   `per_time_periods` (for payroll period details).
-   **Logical Relationships:** The report starts by identifying employees and their assignments. It then links these to completed payroll actions and subsequently drills down to the `pay_run_results` and `pay_run_result_values` tables to extract the actual calculated amounts for each earning and deduction element processed during a specific payroll period.

### Parameters & Filtering

The report offers flexible parameters for targeted historical analysis:

-   **Employee Identification:** `Last Name starts with` provides a wildcard search capability, and specific `Employee` numbers can be entered.
-   **Organizational Context:** `Business Group` allows filtering for specific legal entities or organizations.
-   **Date Ranges:** `Payroll Run Date From` and `Payroll Run Date To` are crucial for specifying the historical period to be analyzed. An `Effective Date` parameter may also be used for point-in-time analysis.

### Performance & Optimization

As a report dealing with potentially large volumes of historical payroll data, it is optimized through efficient filtering.

-   **Date and Employee Filters:** The primary filters (`Payroll Run Date From/To`, `Last Name starts with`) are critical for narrowing the data set. Effective use of these parameters allows the database to quickly access relevant payroll history using existing indexes.
-   **Targeted Data Retrieval:** The report focuses on extracting summarized earnings information per employee per period, avoiding the need to process excessively granular data unless explicitly required.

### FAQ

**1. Can this report show details of specific deductions, not just earnings?**
   Yes, if configured, the report can be extended to include details of specific deduction elements, such as health insurance premiums or 401k contributions, by joining to the relevant tables that store these run results.

**2. How does the report handle employees with multiple assignments?**
   The report is typically designed to show one line per employee assignment per payroll period. If an employee has multiple active assignments within the same payroll period, there would be a separate line for each assignment's earnings and deductions.

**3. Is this report suitable for generating year-to-date (YTD) earnings statements?**
   While this report provides historical detail, its primary purpose is usually for analysis and auditing rather than generating official YTD statements. For official statements, standard Oracle statutory reports or customized pay slips are generally used, as they often include specific formatting and aggregated YTD totals.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-employee-payroll-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
