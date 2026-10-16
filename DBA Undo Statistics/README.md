---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Undo Statistics | Oracle EBS SQL Report'
description: 'Undo generation, longest running query and undo errors per 10-minute interval from gv$undostat, which keeps about four days of history. All sizes are…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Undo, Statistics, gv$tablespace, dba_tablespaces, gv$parameter'
permalink: /DBA%20Undo%20Statistics/
report_name: 'DBA Undo Statistics'
report_web_name: dba-undo-statistics
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Undo Statistics – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-undo-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Undo generation, longest running query and undo errors per 10-minute interval from gv$undostat, which keeps about four days of history.

All sizes are shown in MB, Undo Per Second in MB per second.

ORA-01555 snapshot too old occurs when a query needs undo that has already been overwritten. Compare the Longest Query Seconds with the Tuned Undo Retention Seconds: unexpired steal attempts and blocks show undo that was overwritten before its retention expired because the undo tablespace was too small.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Errors only, Hours Back, Instance Id

## Oracle EBS Tables Used
[gv$tablespace](https://www.enginatics.com/library/?pg=1&find=gv%24tablespace&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics), [dba_tablespaces](https://www.enginatics.com/library/?pg=1&find=dba_tablespaces&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics), [gv$parameter](https://www.enginatics.com/library/?pg=1&find=gv%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics), [gv$undostat](https://www.enginatics.com/library/?pg=1&find=gv%24undostat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)

## Related Reports
[DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Undo%20Statistics/DBA%20Undo%20Statistics.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Undo Statistics 12-Oct-2026 061638.xlsx](https://www.enginatics.com/example/dba-undo-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics) |
| Blitz Report™ XML Import | [DBA_Undo_Statistics.xml](https://www.enginatics.com/xml/dba-undo-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics) |
| SQL Source | [DBA Undo Statistics.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Undo%20Statistics/DBA%20Undo%20Statistics.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-undo-statistics/](https://www.enginatics.com/reports/dba-undo-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics) |

## Case Study & Technical Analysis: DBA Undo Statistics

### Executive Summary
This report shows undo generation, the longest running query and undo-related errors for each 10-minute interval, taken from the instance undo statistics view. Database administrators use it to diagnose ORA-01555 "snapshot too old" errors and to decide whether the undo tablespace is large enough for the workload. Because the source view keeps about four days of history, the report is a retrospective review tool. It runs in Excel through Blitz Report™, with the Hours Back parameter limiting the window examined.

### Business Challenge
*   **Snapshot too old errors:** A long query fails with ORA-01555 when the undo it needs has already been overwritten, which interrupts reports and batch jobs.
*   **Undersized undo tablespace:** When the undo tablespace is too small, undo is overwritten before its tuned retention has expired, and administrators need evidence of this.
*   **Workload correlation:** Undo generation spikes must be matched with the transactions and the longest running query active at the time.
*   **Multi-instance systems:** On Real Application Clusters each instance has its own undo, so the figures must be separated by instance.

### The Solution
*   Reports undo generated, undo generated per second and the number of transactions and concurrent transactions for each interval.
*   Shows the longest query in seconds and its SQL identifier, next to the tuned undo retention, so that the two can be compared directly.
*   Splits undo into active, unexpired and expired blocks, and counts ORA-01555 errors, out-of-space errors and unexpired steal attempts.
*   Filters by Errors only, Hours Back and Instance Id, so the view can be focused on the intervals that matter.

### Technical Architecture (High Level)
#### Primary Tables
*   `GV$UNDOSTAT`: the undo statistics for each 10-minute interval, with undo blocks, transaction counts, query length and error counters per instance.
*   `GV$TABLESPACE`: maps the undo tablespace number of each instance to the tablespace name.
*   `DBA_TABLESPACES`: supplies the block size of the undo tablespace.
*   `GV$PARAMETER`: supplies the value of the UNDO_RETENTION parameter for each instance.

#### Logical Relationships
1.  Each `GV$UNDOSTAT` row is linked to its undo tablespace through the instance identifier and the undo tablespace number.
2.  The block size is found by matching that tablespace name to `DBA_TABLESPACES`.
3.  The UNDO_RETENTION parameter is matched on the same instance identifier.
4.  Undo volumes are calculated as blocks multiplied by block size, and divided by the interval length in seconds to give undo per second.
5.  Error and steal counters are passed through a zero-to-null function, so that intervals without events show blank rather than zero.
6.  The result is ordered by begin time, most recent first, and then by instance.

### Parameters & Filtering
*   **Errors only:** restricts the output to intervals with at least one error or steal event.
*   **Hours Back:** limits the look-back window measured from the current time, within the four days kept by the source view.
*   **Instance Id:** restricts the output to one instance in a cluster.

### Performance & Optimization
*   The three lookups for tablespace name, block size and retention are correlated subqueries that run once per `GV$UNDOSTAT` row, so the number of intervals retained drives their cost.
*   The source view holds a bounded history of about four days, so the row count is capped without any extra archiving.
*   Zero-to-null handling of the error and steal counters leaves intervals without events blank, so intervals with events stand out when the results are scanned.
*   Converting blocks to MB with the block size is a plain arithmetic step on the view values, so no further lookup is needed for the sizes.

### FAQ
**Q: What causes an ORA-01555 snapshot too old error?**
A: The error occurs when a query needs undo that has already been overwritten, and the Longest Query Seconds column can be compared with the Tuned Undo Retention Seconds to see whether that is the case.

**Q: What do unexpired steal attempts show?**
A: Unexpired steal attempts show that undo still within its retention period was overwritten, which indicates the undo tablespace is too small for the workload.

**Q: How far back does the report go?**
A: The source view keeps about four days of history, so the Hours Back parameter can look back no further than that.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-undo-statistics)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
