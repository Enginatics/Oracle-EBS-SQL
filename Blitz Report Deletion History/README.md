---
layout: default
title: 'Blitz Report Deletion History | Oracle EBS SQL Report'
description: 'Shows deleted Blitz Reports and can be used to recover accidentally deleted reports. The history of deleted reports can be purged completely by running…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Deletion, History, xxen_reports_h, xxen_reports'
permalink: /Blitz%20Report%20Deletion%20History/
---

# Blitz Report Deletion History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-deletion-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows deleted Blitz Reports and can be used to recover accidentally deleted reports.
The history of deleted reports can be purged completely by running concurrent 'Blitz Report Monitor' with parameter 'Purge delete reports SQL history' set to Yes

## Report Parameters


## Oracle EBS Tables Used
[xxen_reports_h](https://www.enginatics.com/library/?pg=1&find=xxen_reports_h), [xxen_reports](https://www.enginatics.com/library/?pg=1&find=xxen_reports)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [DIS Import Performance](/DIS%20Import%20Performance/ "DIS Import Performance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Deletion History 03-Apr-2018 095214.xlsx](https://www.enginatics.com/example/blitz-report-deletion-history/) |
| Blitz Report™ XML Import | [Blitz_Report_Deletion_History.xml](https://www.enginatics.com/xml/blitz-report-deletion-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-deletion-history/](https://www.enginatics.com/reports/blitz-report-deletion-history/) |

## Blitz Report Deletion History - Case Study & Technical Analysis

### Executive Summary

**Blitz Report Deletion History** is an audit and recovery tool. It tracks reports that have been deleted from the system. Crucially, it can be used to recover accidentally deleted reports because Blitz Report often performs a "soft delete" or archives the definition before removal.

### Business Challenge

*   **Accidental Deletion:** A developer intends to delete a test report but accidentally deletes the production version.
*   **Audit Trail:** Security requires a log of who deleted a critical financial report and when.
*   **Recovery:** Restoring the SQL logic of a deleted report without having to rewrite it from scratch.

### Solution

This report queries the history tables (`XXEN_REPORTS_H`) to find records where the report status indicates deletion.

*   **Recovery:** The SQL text and parameters are preserved in the history table, allowing them to be copied back into a new report definition.
*   **Purge:** The description notes that this history can be permanently purged using the 'Blitz Report Monitor' concurrent program.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORTS`:** The active report table.
*   **`XXEN_REPORTS_H`:** The history table that stores version changes and deleted records.

#### Logic

The report filters the history table for records that represent a deletion event.

### Parameters

*   (None listed in the README, but likely supports standard filters like Date or User if customized).


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
