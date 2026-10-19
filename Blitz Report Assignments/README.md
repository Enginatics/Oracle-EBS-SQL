---
layout: default
last_modified_at: 2026-10-19
title: 'Blitz Report Assignments | Oracle EBS SQL Report'
description: 'Oracle EBS Blitz Report SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Assignments, xxen_reports_v, xxen_report_assignments_v, xxen_report_zoom_param_vals_v'
permalink: /Blitz%20Report%20Assignments/
report_name: 'Blitz Report Assignments'
report_web_name: blitz-report-assignments
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Assignments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Type, Category, Assignment Level, Level Value, Show Form Parameter Defaults

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments), [xxen_report_assignments_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments), [xxen_report_zoom_param_vals_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_zoom_param_vals_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)

## Related Reports
[Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report"), [Blitz Report Parameter Default Values](/Blitz%20Report%20Parameter%20Default%20Values/ "Blitz Report Parameter Default Values Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Report Parameter Table Alias Validation](/Blitz%20Report%20Parameter%20Table%20Alias%20Validation/ "Blitz Report Parameter Table Alias Validation Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Security](/Blitz%20Report%20Security/ "Blitz Report Security Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Assignments/Blitz%20Report%20Assignments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Assignments 26-Dec-2021 185157.xlsx](https://www.enginatics.com/example/blitz-report-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments) |
| Blitz Report™ XML Import | [Blitz_Report_Assignments.xml](https://www.enginatics.com/xml/blitz-report-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments) |
| SQL Source | [Blitz Report Assignments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Assignments/Blitz%20Report%20Assignments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-assignments/](https://www.enginatics.com/reports/blitz-report-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments) |

## Blitz Report Assignments - Case Study & Technical Analysis

### Executive Summary

**Blitz Report Assignments** is a system administration report that provides a comprehensive view of how Blitz Reports are distributed across the organization. It details which reports are assigned to which Users, Responsibilities, Applications, or Operating Units. This visibility is crucial for security auditing, license management, and ensuring that users have access to the necessary reporting tools.

### Business Challenge

As the number of custom reports grows, tracking who has access to what becomes complex.
*   **Security Audits:** Auditors need to verify that sensitive financial reports are only accessible to authorized personnel.
*   **Troubleshooting:** A user complains they cannot see a specific report. Is it assigned to their responsibility? Is the assignment active?
*   **Cleanup:** Identifying reports that are assigned but no longer used or assigned to obsolete responsibilities.

### Solution

The **Blitz Report Assignments** report solves these challenges by listing all active assignments. It allows administrators to:
*   **Filter by User or Responsibility:** Quickly see all reports available to a specific entity.
*   **Filter by Report:** See everyone who has access to a specific sensitive report.
*   **Verify Parameters:** Check if specific assignments have forced default parameters (e.g., restricting a report to a specific Operating Unit).

### Technical Architecture

The report queries the core Blitz Report security tables.

#### Key Tables

*   **`XXEN_REPORTS_V`:** The definition of the report itself.
*   **`XXEN_REPORT_ASSIGNMENTS_V`:** The intersection table linking reports to security levels (User, Responsibility, etc.).
*   **`XXEN_REPORT_ZOOM_PARAM_VALS_V`:** Stores parameter defaults that are specific to an assignment (e.g., "When run from the 'UK General Ledger' responsibility, default the Ledger parameter to 'UK Primary Ledger'").

#### Logic

The query joins the report definitions with the assignment table. It decodes the assignment level (Site, Application, Responsibility, User, Organization, etc.) to provide a human-readable context for each access rule.

### Parameters

*   **Type:** Filter by report type (e.g., SQL, PL/SQL, BI Publisher).
*   **Category:** Filter by report category (e.g., Finance, Supply Chain).
*   **Assignment Level:** Filter by the level of assignment (e.g., show only User-level assignments).
*   **Level Value:** Specific value for the level (e.g., a specific User Name or Responsibility Name).
*   **Show Form Parameter Defaults:** Toggle to display if specific parameter values are enforced for the assignment.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-assignments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
