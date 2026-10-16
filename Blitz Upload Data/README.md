---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Upload Data | Oracle EBS SQL Report'
description: 'History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Upload, Data, xxen_upload_data, xxen_report_runs, xxen_reports_v'
permalink: /Blitz%20Upload%20Data/
report_name: 'Blitz Upload Data'
report_web_name: blitz-upload-data
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Upload Data – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-upload-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Name, User Name, Started within Days, Upload Request Id, Report Request Id, Run Id, Maximum rows per upload

## Oracle EBS Tables Used
[xxen_upload_data](https://www.enginatics.com/library/?pg=1&find=xxen_upload_data&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)

## Related Reports
[Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Upload%20Data/Blitz%20Upload%20Data.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Upload Data 19-Jun-2025 063352.xlsx](https://www.enginatics.com/example/blitz-upload-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data) |
| Blitz Report™ XML Import | [Blitz_Upload_Data.xml](https://www.enginatics.com/xml/blitz-upload-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data) |
| SQL Source | [Blitz Upload Data.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Upload%20Data/Blitz%20Upload%20Data.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-upload-data/](https://www.enginatics.com/reports/blitz-upload-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data) |

## Executive Summary
The Blitz Upload Data report provides a historical record of data uploaded via Blitz Report. It tracks upload events, including user details, request IDs, and the volume of data processed, serving as an audit trail for data import activities.

## Business Challenge
Organizations using Blitz Report for data uploads need visibility into what data is being imported, by whom, and when. Without a log of upload activities, it is difficult to troubleshoot issues, audit changes, or monitor system usage related to data imports.

## Solution
This report offers a detailed history of data uploads, retained for a configurable period (defined by the "Blitz Upload Data Retention Days" profile option). It allows administrators to review past uploads, verify successful processing, and analyze usage patterns.

## Key Features
*   **Upload History:** Lists historical data uploads with timestamps and user information.
*   **Detailed Tracking:** Captures Upload Name, User Name, Request IDs, and Run IDs.
*   **Volume Monitoring:** Shows the number of rows processed per upload.
*   **Retention Management:** Respects the configured data retention policy.

## Technical Details
The report queries the `xxen_upload_data` table, which stores the actual uploaded data, and joins it with `xxen_report_runs` and `xxen_reports_v` to provide context about the report execution. It also references `fnd_responsibility_tl` for responsibility information.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-data)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
