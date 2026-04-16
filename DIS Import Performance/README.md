---
layout: default
title: 'DIS Import Performance | Oracle EBS SQL Report'
description: 'Query to review Discoverer to Blitz Report import performance, after running the ''Blitz Report Discoverer Import'' concurrent program or mass migration…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Import, Performance, xxen_reports_v'
permalink: /DIS%20Import%20Performance/
---

# DIS Import Performance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-import-performance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Query to review Discoverer to Blitz Report import performance, after running the 'Blitz Report Discoverer Import' concurrent program or mass migration script.
<a href="https://www.enginatics.com/user-guide/#Discoverer_Worksheet" rel="nofollow" target="_blank">https://www.enginatics.com/user-guide/#Discoverer_Worksheet</a>

## Report Parameters
Report Creation Time From, Report Creation Time To, Category

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Import Performance 17-Jun-2019 131540.xlsx](https://www.enginatics.com/example/dis-import-performance/) |
| Blitz Report™ XML Import | [DIS_Import_Performance.xml](https://www.enginatics.com/xml/dis-import-performance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-import-performance/](https://www.enginatics.com/reports/dis-import-performance/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
