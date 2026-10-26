---
layout: default
last_modified_at: 2026-10-26
title: 'DIS Import Performance | Oracle EBS SQL Report'
description: 'Query to review Discoverer to Blitz Report import performance, after running the ''Blitz Report Discoverer Import'' concurrent program or mass migration…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Import, Performance, xxen_reports_v'
permalink: /DIS%20Import%20Performance/
report_name: 'DIS Import Performance'
report_web_name: dis-import-performance
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Import Performance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Query to review Discoverer to Blitz Report import performance, after running the 'Blitz Report Discoverer Import' concurrent program or mass migration script.
<a href="https://www.enginatics.com/user-guide/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance#Discoverer_Worksheet" rel="nofollow" target="_blank">https://www.enginatics.com/user-guide/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance#Discoverer_Worksheet</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Creation Time From, Report Creation Time To, Category

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)

## Related Reports
[Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [Blitz Report Assignment Validation](/Blitz%20Report%20Assignment%20Validation/ "Blitz Report Assignment Validation Oracle EBS SQL Report"), [Blitz Report LOVs](/Blitz%20Report%20LOVs/ "Blitz Report LOVs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Import%20Performance/DIS%20Import%20Performance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Import Performance 17-Jun-2019 131540.xlsx](https://www.enginatics.com/example/dis-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance) |
| Blitz Report™ XML Import | [DIS_Import_Performance.xml](https://www.enginatics.com/xml/dis-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance) |
| SQL Source | [DIS Import Performance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Import%20Performance/DIS%20Import%20Performance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-import-performance/](https://www.enginatics.com/reports/dis-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance) |

## Case Study & Technical Analysis

### Abstract
The **DIS Import Performance** report is a diagnostic tool used during the automated migration of Oracle Discoverer workbooks to Blitz Report. It tracks the execution time and status of the import process, allowing administrators to identify bottlenecks or failures when processing thousands of legacy reports.

### Technical Analysis

#### Core Logic
*   **Source**: Queries `XXEN_REPORTS_V` (the Blitz Report metadata view) filtering for reports created by the migration tool.
*   **Metrics**: Tracks creation time and potentially execution time of the newly created reports to ensure they perform well in the new environment.

#### Operational Use Cases
*   **Migration Monitoring**: "We started the import of 5,000 workbooks last night. How many are done, and did any hang?"
*   **Performance Tuning**: Identifying specific report categories that are taking longer to import/convert than others.
*   **Validation**: Verifying that the count of imported reports matches the count of exported `.eex` files.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-import-performance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
