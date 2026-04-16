---
layout: default
title: 'Blitz Upload Data | Oracle EBS SQL Report'
description: 'History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Upload, Data, xxen_upload_data, xxen_report_runs, xxen_reports_v'
permalink: /Blitz%20Upload%20Data/
---

# Blitz Upload Data – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-upload-data/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.

## Report Parameters
Upload Name, User Name, Started within Days, Upload Request Id, Report Request Id, Run Id, Maximum rows per upload

## Oracle EBS Tables Used
[xxen_upload_data](https://www.enginatics.com/library/?pg=1&find=xxen_upload_data), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report License Users](/Blitz%20Report%20License%20Users/ "Blitz Report License Users Oracle EBS SQL Report"), [Blitz Report License User History](/Blitz%20Report%20License%20User%20History/ "Blitz Report License User History Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Upload Data 19-Jun-2025 063352.xlsx](https://www.enginatics.com/example/blitz-upload-data/) |
| Blitz Report™ XML Import | [Blitz_Upload_Data.xml](https://www.enginatics.com/xml/blitz-upload-data/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-upload-data/](https://www.enginatics.com/reports/blitz-upload-data/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
