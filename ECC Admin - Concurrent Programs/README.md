---
layout: default
title: 'ECC Admin - Concurrent Programs | Oracle EBS SQL Report'
description: 'List of all concurrent programs required to synchronize Oracle EBS data to the Enterprise Command Centers (ECC) Weblogic server, based on Oracle note…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, ECC, Admin, Concurrent, Programs, fnd_concurrent_requests, fnd_responsibility_vl, dual'
permalink: /ECC%20Admin%20-%20Concurrent%20Programs/
---

# ECC Admin - Concurrent Programs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-concurrent-programs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
List of all concurrent programs required to synchronize Oracle EBS data to the Enterprise Command Centers (ECC) Weblogic server, based on Oracle note KA980 <a href="https://support.oracle.com/support/?kmContentId=11154162" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=11154162</a>

The report includes all currently scheduled request_ids and responsibilities for incremental and full loads, to check which ones are already scheduled.
The short code can be used as multiple parameter value entry in other reports, e.g. <a href="https://www.enginatics.com/reports/fnd-access-control/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/fnd-access-control/</a> to see which responsibilities or users have access to schedule them, or <a href="https://www.enginatics.com/reports/fnd-concurrent-requests/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/fnd-concurrent-requests/</a> to look at past execution and schedule times.

ECC data is defined by dataset codes, which have a related DB package procedure containing the SQL for each dataset, see:
<a href="https://www.enginatics.com/reports/ecc-data-sets/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/ecc-data-sets/</a>

The individual load progams are all calling child program 'ECC Run Data Load' either for specific datasets or by application, and the program's java executable ECCRUNDL then executes the dataset SQL and transfers the data to the Weblogic server where it is stored in a file structure using Apache Lucene technology <a href="https://en.wikipedia.org/wiki/Apache_Lucene" rel="nofollow" target="_blank">https://en.wikipedia.org/wiki/Apache_Lucene</a>

## Report Parameters


## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report"), [FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [Blitz Report RDF Import Validation](/Blitz%20Report%20RDF%20Import%20Validation/ "Blitz Report RDF Import Validation Oracle EBS SQL Report"), [FND Concurrent Request Conflicts](/FND%20Concurrent%20Request%20Conflicts/ "FND Concurrent Request Conflicts Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Concurrent Programs 15-Jun-2020 192701.xlsx](https://www.enginatics.com/example/ecc-admin-concurrent-programs/) |
| Blitz Report™ XML Import | [ECC_Admin_Concurrent_Programs.xml](https://www.enginatics.com/xml/ecc-admin-concurrent-programs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ecc-admin-concurrent-programs/](https://www.enginatics.com/reports/ecc-admin-concurrent-programs/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
