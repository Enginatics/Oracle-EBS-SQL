---
layout: default
last_modified_at: 2026-10-19
title: 'Blitz Upload History | Oracle EBS SQL Report'
description: 'History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Upload, History, xxen_upload_data, xxen_report_runs, xxen_reports_v'
permalink: /Blitz%20Upload%20History/
report_name: 'Blitz Upload History'
report_web_name: blitz-upload-history
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Upload History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-upload-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Name, Started within Days, Uploaded By

## Oracle EBS Tables Used
[xxen_upload_data](https://www.enginatics.com/library/?pg=1&find=xxen_upload_data&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)

## Related Reports
[Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Upload%20History/Blitz%20Upload%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Upload History 19-Jun-2025 063454.xlsx](https://www.enginatics.com/example/blitz-upload-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history) |
| Blitz Report™ XML Import | [Blitz_Upload_History.xml](https://www.enginatics.com/xml/blitz-upload-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history) |
| SQL Source | [Blitz Upload History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Upload%20History/Blitz%20Upload%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-upload-history/](https://www.enginatics.com/reports/blitz-upload-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history) |

## Case Study & Technical Analysis: Blitz Upload History

### Executive Summary
The **Blitz Upload History** report is a critical governance and auditing tool for organizations utilizing Blitz Report™ for data uploads. It provides a comprehensive audit trail of all data upload activities, ensuring transparency and accountability. By tracking who uploaded what data and when, this report supports compliance requirements and helps system administrators monitor system usage and data lineage.

### Business Challenge
As organizations democratize data entry and updates through Excel-based uploads, maintaining control and visibility becomes paramount. Common challenges include:
*   **Lack of Traceability**: Identifying the source of data changes when multiple users have upload privileges.
*   **Compliance Risks**: Auditors require proof of who authorized and executed data changes in the ERP system.
*   **Data Retention Management**: Managing the growth of upload history data to prevent unnecessary storage consumption.

Without a centralized history, organizations risk losing oversight of bulk data changes, leading to potential security and data integrity issues.

### Solution
The **Blitz Upload History** report addresses these challenges by offering a detailed view of the upload log.
*   **Full Audit Trail**: Captures the Upload Name, User, Date, and Status for every transaction.
*   **Retention Policy Support**: Works in conjunction with the profile option `Blitz Upload Data Retention Days` to manage how long history is kept, balancing audit needs with storage optimization.
*   **Searchability**: Allows administrators to quickly find specific uploads by name, date range, or user.

### Technical Architecture
This report queries the internal metadata tables of the Blitz Report™ framework:
*   **Core Tables**: Joins `xxen_upload_data`, `xxen_report_runs`, and `xxen_reports_v` to reconstruct the upload event context.
*   **Security Integration**: Links with `fnd_responsibility_tl` and `fnd_concurrent_requests` to provide context on the responsibility and concurrent request ID associated with each upload.
*   **LOB Handling**: References `fnd_lobs` to potentially link back to the original uploaded file content if configured.

### Parameters
*   **Upload Name**: Filter by the specific name of the upload definition.
*   **Started within Days**: Limits the report to recent uploads (e.g., last 30 days) for focused auditing.
*   **Uploaded By**: Filter by the specific user ID or name who performed the upload.

### Performance
Designed for administrative oversight, the report is highly efficient:
*   **Indexed Queries**: Utilizes standard indexes on the `xxen_` tables to ensure fast retrieval even with large history logs.
*   **Optimized Joins**: Efficiently joins with FND tables to resolve user and responsibility names without performance drag.

### FAQ
**Q: How long is upload history kept?**
A: The retention period is controlled by the system profile option `Blitz Upload Data Retention Days`. Records older than this setting are automatically purged.

**Q: Can I see the actual data that was uploaded?**
A: Yes, if the system is configured to retain the file, the history can link back to the specific data set processed.

**Q: Does this report show failed uploads?**
A: Yes, the status column indicates whether an upload was successful, failed, or completed with warnings.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-upload-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
