---
layout: default
title: 'Blitz Report Text Search | Oracle EBS SQL Report'
description: 'This report can be used to understand which reports, parameters or LOVs contain a certain SQL Text string, or which reports currently use a specific LOV…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Text, Search, xxen_reports_v, xxen_report_parameters_v, xxen_report_parameter_lovs'
permalink: /Blitz%20Report%20Text%20Search/
---

# Blitz Report Text Search – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-text-search/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This report can be used to understand which reports, parameters or LOVs contain a certain SQL Text string, or which reports currently use a specific LOV.

It is used to preview all records that would be changed through the Blitz Report mass change functionality in Setup Window>Tools>Mass Change

## Report Parameters
SQL Text contains, Category, Record Type, Match case, Regex mode, SQL Text does not contain, Report Name

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [xxen_report_parameters_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters_v), [xxen_report_parameter_lovs](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs), [xxen_upload_columns_v](https://www.enginatics.com/library/?pg=1&find=xxen_upload_columns_v), [xxen_upload_sqls_v](https://www.enginatics.com/library/?pg=1&find=xxen_upload_sqls_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report LOV Comparison between environments](/Blitz%20Report%20LOV%20Comparison%20between%20environments/ "Blitz Report LOV Comparison between environments Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [Blitz Report LOV SQL Validation](/Blitz%20Report%20LOV%20SQL%20Validation/ "Blitz Report LOV SQL Validation Oracle EBS SQL Report"), [Blitz Report LOVs](/Blitz%20Report%20LOVs/ "Blitz Report LOVs Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Report Comparison between environments](/Blitz%20Report%20Comparison%20between%20environments/ "Blitz Report Comparison between environments Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Upload Dependencies](/Blitz%20Upload%20Dependencies/ "Blitz Upload Dependencies Oracle EBS SQL Report"), [Blitz Report Security](/Blitz%20Report%20Security/ "Blitz Report Security Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/blitz-report-text-search/) |
| Blitz Report™ XML Import | [Blitz_Report_Text_Search.xml](https://www.enginatics.com/xml/blitz-report-text-search/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-text-search/](https://www.enginatics.com/reports/blitz-report-text-search/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
