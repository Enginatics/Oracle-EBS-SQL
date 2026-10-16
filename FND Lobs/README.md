---
layout: default
last_modified_at: 2026-10-16
title: 'FND Lobs | Oracle EBS SQL Report'
description: 'Generic file manager lob data, such as attachments, help files, imported and exported Blitz Report files etc.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Lobs, fnd_lobs'
permalink: /FND%20Lobs/
report_name: 'FND Lobs'
report_web_name: fnd-lobs
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Lobs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Generic file manager lob data, such as attachments, help files, imported and exported Blitz Report files etc.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
File Name like, File Content Type, Program Name, File Format, Language, Include File Data, Uploaded within x days, Non expiring only

## Oracle EBS Tables Used
[fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)

## Related Reports
[GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [FND Attached Documents (Operating Unit Secured)](/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29/ "FND Attached Documents (Operating Unit Secured) Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Lobs/FND%20Lobs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-lobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs) |
| Blitz Report™ XML Import | [FND_Lobs.xml](https://www.enginatics.com/xml/fnd-lobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs) |
| SQL Source | [FND Lobs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Lobs/FND%20Lobs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-lobs/](https://www.enginatics.com/reports/fnd-lobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs) |

## Executive Summary
The **FND Lobs** report allows you to search and extract files stored in the database as Large Objects (LOBs). This includes attachments, help files, and Blitz Report templates.

## Business Challenge
*   **Attachment Search:** Finding a specific document attached to a transaction when you only know the filename.
*   **Space Management:** Identifying large files that are consuming database storage.
*   **Data Extraction:** Downloading binary files (PDFs, Images) directly from the database for archiving.

## The Solution
This Blitz Report queries the `FND_LOBS` table:
*   **Metadata:** File Name, Content Type (MIME), and Upload Date.
*   **Program:** The program or entity that owns the file.
*   **Content:** Can optionally extract the binary data (BLOB).

## Technical Architecture
The report queries `FND_LOBS`.

## Parameters & Filtering
*   **File Name like:** Search by partial filename.
*   **Include File Data:** Toggle to include the actual file content.
*   **Uploaded within x days:** Filter for recent uploads.

## Performance & Optimization
*   **Caution:** Do not run with "Include File Data" without filters, as extracting gigabytes of BLOB data will impact performance.

## FAQ
*   **Q: Can I delete files from here?**
    *   A: No, this is a read-only report. To delete files, you should use the "Purge Obsolete Generic File Manager Data" concurrent program.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lobs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
