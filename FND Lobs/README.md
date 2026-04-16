---
layout: default
title: 'FND Lobs | Oracle EBS SQL Report'
description: 'Generic file manager lob data, such as attachments, help files, imported and exported Blitz Report files etc.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Lobs, fnd_lobs'
permalink: /FND%20Lobs/
---

# FND Lobs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lobs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Generic file manager lob data, such as attachments, help files, imported and exported Blitz Report files etc.

## Report Parameters
File Name like, File Content Type, Program Name, File Format, Language, Include File Data, Uploaded within x days, Non expiring only

## Oracle EBS Tables Used
[fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-lobs/) |
| Blitz Report™ XML Import | [FND_Lobs.xml](https://www.enginatics.com/xml/fnd-lobs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-lobs/](https://www.enginatics.com/reports/fnd-lobs/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
