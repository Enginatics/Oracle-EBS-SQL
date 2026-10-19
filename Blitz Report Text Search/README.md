---
layout: default
last_modified_at: 2026-10-19
title: 'Blitz Report Text Search | Oracle EBS SQL Report'
description: 'This report can be used to understand which reports, parameters or LOVs contain a certain SQL Text string, or which reports currently use a specific LOV…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Text, Search, xxen_reports_v, xxen_report_parameters_v, xxen_report_parameter_lovs'
permalink: /Blitz%20Report%20Text%20Search/
report_name: 'Blitz Report Text Search'
report_web_name: blitz-report-text-search
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Text Search – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
This report can be used to understand which reports, parameters or LOVs contain a certain SQL Text string, or which reports currently use a specific LOV.

It is used to preview all records that would be changed through the Blitz Report mass change functionality in Setup Window>Tools>Mass Change

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
SQL Text contains, Category, Record Type, Match case, Regex mode, SQL Text does not contain, Report Name

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search), [xxen_report_parameters_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search), [xxen_report_parameter_lovs](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search), [xxen_upload_columns_v](https://www.enginatics.com/library/?pg=1&find=xxen_upload_columns_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search), [xxen_upload_sqls_v](https://www.enginatics.com/library/?pg=1&find=xxen_upload_sqls_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)

## Related Reports
[Blitz Report LOVs](/Blitz%20Report%20LOVs/ "Blitz Report LOVs Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [Blitz Upload Dependencies](/Blitz%20Upload%20Dependencies/ "Blitz Upload Dependencies Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Report LOV Comparison between environments](/Blitz%20Report%20LOV%20Comparison%20between%20environments/ "Blitz Report LOV Comparison between environments Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [Blitz Report Category Assignment Upload](/Blitz%20Report%20Category%20Assignment%20Upload/ "Blitz Report Category Assignment Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Text%20Search/Blitz%20Report%20Text%20Search.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search) |
| Blitz Report™ XML Import | [Blitz_Report_Text_Search.xml](https://www.enginatics.com/xml/blitz-report-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search) |
| SQL Source | [Blitz Report Text Search.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Text%20Search/Blitz%20Report%20Text%20Search.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-text-search/](https://www.enginatics.com/reports/blitz-report-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search) |

## Executive Summary
The Blitz Report Text Search tool is a powerful utility designed to search for specific SQL text strings across reports, parameters, and Lists of Values (LOVs) within the Oracle E-Business Suite environment. It is particularly useful for identifying dependencies and usage of specific code snippets or LOVs, and for previewing records that would be affected by mass change operations.

## Business Challenge
Managing a large repository of reports and their associated components in Oracle EBS can be challenging. Developers and administrators often need to find where specific SQL logic or LOVs are used to assess the impact of changes, debug issues, or ensure consistency. Manually searching through each report definition is time-consuming and prone to error. Additionally, performing mass updates requires a safe way to preview affected records before committing changes.

## Solution
The Blitz Report Text Search provides a centralized search mechanism that scans the definitions of reports, parameters, and LOVs for a specified text string. It allows users to filter by category, record type, and report name, and supports case-sensitive and regex-based searches. This tool streamlines impact analysis and facilitates safe mass updates by offering a preview capability.

## Key Features
*   **Comprehensive Search:** Searches across reports, parameters, and LOVs for a given SQL text string.
*   **Impact Analysis:** Identifies which reports use a specific LOV or contain specific SQL logic.
*   **Mass Change Preview:** Used to preview records that would be modified by the Blitz Report mass change functionality.
*   **Advanced Filtering:** Supports filtering by category, record type, and report name.
*   **Flexible Search Options:** Includes options for case matching and regular expression (regex) mode.
*   **Exclusion Criteria:** Allows specifying text strings to exclude from the search results.

## Technical Details
The report queries several internal Blitz Report views and tables, including `xxen_reports_v`, `xxen_report_parameters_v`, `xxen_report_parameter_lovs`, `xxen_upload_columns_v`, and `xxen_upload_sqls_v`. It leverages these views to inspect the underlying SQL definitions and configuration details of the reporting environment.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-text-search)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
