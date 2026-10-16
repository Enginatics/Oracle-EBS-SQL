---
layout: default
last_modified_at: 2026-10-16
title: 'ECC Admin - Concurrent Programs | Oracle EBS SQL Report'
description: 'List of all concurrent programs required to synchronize Oracle EBS data to the Enterprise Command Centers (ECC) Weblogic server, based on Oracle note…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enterprise Command Center, Enginatics, ECC, Admin, Concurrent, Programs, fnd_concurrent_requests, fnd_responsibility_vl, dual'
permalink: /ECC%20Admin%20-%20Concurrent%20Programs/
report_name: 'ECC Admin - Concurrent Programs'
report_web_name: ecc-admin-concurrent-programs
module: 'Enterprise Command Center'
module_url: /modules/enterprise-command-center/
---

# ECC Admin - Concurrent Programs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-concurrent-programs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs).
**Oracle EBS module:** [Enterprise Command Center](/modules/enterprise-command-center/ "Oracle EBS Enterprise Command Center reports") · [all Enterprise Command Center reports](/modules/enterprise-command-center/)  

## Overview
List of all concurrent programs required to synchronize Oracle EBS data to the Enterprise Command Centers (ECC) Weblogic server, based on Oracle note KA980 <a href="https://support.oracle.com/support/?kmContentId=11154162" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=11154162</a>

The report includes all currently scheduled request_ids and responsibilities for incremental and full loads, to check which ones are already scheduled.
The short code can be used as multiple parameter value entry in other reports, e.g. <a href="https://www.enginatics.com/reports/fnd-access-control/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs" rel="nofollow" target="_blank">https://www.enginatics.com/reports/fnd-access-control/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs</a> to see which responsibilities or users have access to schedule them, or <a href="https://www.enginatics.com/reports/fnd-concurrent-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs" rel="nofollow" target="_blank">https://www.enginatics.com/reports/fnd-concurrent-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs</a> to look at past execution and schedule times.

ECC data is defined by dataset codes, which have a related DB package procedure containing the SQL for each dataset, see:
<a href="https://www.enginatics.com/reports/ecc-data-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs" rel="nofollow" target="_blank">https://www.enginatics.com/reports/ecc-data-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs</a>

The individual load progams are all calling child program 'ECC Run Data Load' either for specific datasets or by application, and the program's java executable ECCRUNDL then executes the dataset SQL and transfers the data to the Weblogic server where it is stored in a file structure using Apache Lucene technology <a href="https://en.wikipedia.org/wiki/Apache_Lucene" rel="nofollow" target="_blank">https://en.wikipedia.org/wiki/Apache_Lucene</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)

## Related Reports
[FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [Blitz Report RDF Import Validation](/Blitz%20Report%20RDF%20Import%20Validation/ "Blitz Report RDF Import Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ECC%20Admin%20-%20Concurrent%20Programs/ECC%20Admin%20-%20Concurrent%20Programs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Concurrent Programs 15-Jun-2020 192701.xlsx](https://www.enginatics.com/example/ecc-admin-concurrent-programs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs) |
| Blitz Report™ XML Import | [ECC_Admin_Concurrent_Programs.xml](https://www.enginatics.com/xml/ecc-admin-concurrent-programs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs) |
| SQL Source | [ECC Admin - Concurrent Programs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ECC%20Admin%20-%20Concurrent%20Programs/ECC%20Admin%20-%20Concurrent%20Programs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ecc-admin-concurrent-programs/](https://www.enginatics.com/reports/ecc-admin-concurrent-programs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs) |

## ECC Admin - Concurrent Programs

### Description
This report lists all concurrent programs required to synchronize Oracle E-Business Suite data with the Enterprise Command Centers (ECC) WebLogic server. It is based on Oracle Note 2495053.1 and is essential for administering ECC data loads.

The report helps administrators:
- **Identify Programs**: List all data load programs for various ECC datasets.
- **Check Schedules**: View currently scheduled request IDs and responsibilities for incremental and full loads.
- **Manage Access**: Use the program short codes to cross-reference with other reports (like `FND Access Control`) to determine who can schedule these loads.

ECC data loads are critical for keeping the command center dashboards up-to-date. This report simplifies the management of these background processes.

### Parameters
None.

### Used Tables
- `fnd_concurrent_requests`: Concurrent request history and status.
- `fnd_responsibility_vl`: Responsibility definitions.
- `dual`: System table.
- `fnd_concurrent_programs_vl`: Concurrent program definitions.
- `fnd_executables_vl`: Executable definitions.

### Categories
- **Enginatics**: System administration for Enterprise Command Centers.

### Related Reports
- [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/)
- [ECC Data Sets](/ECC%20Data%20Sets/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-concurrent-programs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
