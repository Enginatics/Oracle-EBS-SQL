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
[Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [Blitz Report SQL Validation](/Blitz%20Report%20SQL%20Validation/ "Blitz Report SQL Validation Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [Enginatics Blitz Reports and Uploads](/Enginatics%20Blitz%20Reports%20and%20Uploads/ "Enginatics Blitz Reports and Uploads Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [Blitz Report License User History](/Blitz%20Report%20License%20User%20History/ "Blitz Report License User History Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [GL Oracle FSG Converter](/GL%20Oracle%20FSG%20Converter/ "GL Oracle FSG Converter Oracle EBS SQL Report"), [Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report")

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
