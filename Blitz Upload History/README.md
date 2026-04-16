---
layout: default
title: 'Blitz Upload History | Oracle EBS SQL Report'
description: 'History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Upload, History, xxen_upload_data, xxen_report_runs, xxen_reports_v'
permalink: /Blitz%20Upload%20History/
---

# Blitz Upload History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-upload-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.

## Report Parameters
Upload Name, Started within Days, Uploaded By

## Oracle EBS Tables Used
[xxen_upload_data](https://www.enginatics.com/library/?pg=1&find=xxen_upload_data), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Upload History 19-Jun-2025 063454.xlsx](https://www.enginatics.com/example/blitz-upload-history/) |
| Blitz Report™ XML Import | [Blitz_Upload_History.xml](https://www.enginatics.com/xml/blitz-upload-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-upload-history/](https://www.enginatics.com/reports/blitz-upload-history/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
