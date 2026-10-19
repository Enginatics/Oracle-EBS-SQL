---
layout: default
last_modified_at: 2026-10-19
title: 'DBA SYSAUX Occupants | Oracle EBS SQL Report'
description: 'Space used in the SYSAUX tablespace by component. All sizes are shown in MB. The largest occupants are usually the AWR (SM/AWR) and the optimizer…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SYSAUX, Occupants, v$sysaux_occupants'
permalink: /DBA%20SYSAUX%20Occupants/
report_name: 'DBA SYSAUX Occupants'
report_web_name: dba-sysaux-occupants
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SYSAUX Occupants – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sysaux-occupants/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Space used in the SYSAUX tablespace by component.

All sizes are shown in MB.

The largest occupants are usually the AWR (SM/AWR) and the optimizer statistics history (SM/OPTSTAT). The SM/OPTSTAT row shows the statistics history retention in days and the oldest statistics still available. A lower retention, set with dbms_stats.alter_stats_history_retention, reduces the SYSAUX space used.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[v$sysaux_occupants](https://www.enginatics.com/library/?pg=1&find=v%24sysaux_occupants&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SYSAUX%20Occupants/DBA%20SYSAUX%20Occupants.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SYSAUX Occupants 12-Oct-2026 061636.xlsx](https://www.enginatics.com/example/dba-sysaux-occupants/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants) |
| Blitz Report™ XML Import | [DBA_SYSAUX_Occupants.xml](https://www.enginatics.com/xml/dba-sysaux-occupants/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants) |
| SQL Source | [DBA SYSAUX Occupants.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SYSAUX%20Occupants/DBA%20SYSAUX%20Occupants.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sysaux-occupants/](https://www.enginatics.com/reports/dba-sysaux-occupants/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants) |

## Case Study & Technical Analysis: DBA SYSAUX Occupants

### Executive Summary
The DBA SYSAUX Occupants report shows how the SYSAUX tablespace space is used, broken down by component. Each row is an occupant, such as the Automatic Workload Repository or the optimizer statistics history, with its schema, space used in MB, and its share of the total. Database administrators use it when SYSAUX grows unexpectedly, when planning storage, or when deciding whether to reduce a retention period. The report has no parameters, and its rows are sorted by space used, so the largest consumers appear first.

### Business Challenge
*   **Unexplained SYSAUX growth:** SYSAUX holds the auxiliary data of many database features, and its growth is often attributed to the wrong component without a breakdown.
*   **Retention decisions:** Components such as workload repository snapshots and statistics history grow with their retention settings, and the cost of a longer retention needs to be seen in MB.
*   **Capacity planning:** Storage teams need the share each component takes, so they can plan space for SYSAUX and the instance as a whole.
*   **Relocation options:** Some occupants can be moved to another tablespace, and their move procedures need to be identified before a change is made.

### The Solution
*   **Component inventory:** Every occupant of SYSAUX is listed with its name, description and owning schema.
*   **Space and share:** Space used is shown in MB, and a percentage column shows each occupant's share of total SYSAUX usage.
*   **Statistics history retention:** For the optimizer statistics history occupant, the report shows the configured retention in days and the oldest statistics still available.
*   **Move guidance:** The move procedure and its description are shown for each occupant that supports relocation.

### Technical Architecture (High Level)
#### Primary Tables
*   `V$SYSAUX_OCCUPANTS`: the dynamic view that lists each SYSAUX occupant with its schema, space usage in kilobytes and move procedure.

#### Logical Relationships
1.  The report reads `V$SYSAUX_OCCUPANTS` as a single source. No joins are used.
2.  The share of total usage is calculated with a ratio-to-report analytic function over all occupant rows.
3.  For the statistics history occupant only, the report calls the statistics history retention and availability functions, and converts the availability date for display.
4.  The result is sorted by space usage in descending order.

### Parameters & Filtering
This report has no user parameters. It always returns every occupant of SYSAUX, so filtering is done by reading the sorted output rather than by changing the query.

### Performance & Optimization
*   **Single dynamic view:** The report reads one dynamic performance view with no joins, so the query is a single read of the occupant list.
*   **Analytic share calculation:** The percentage column uses a ratio-to-report function, so each occupant's share is computed in the same pass without a separate total query.
*   **Conditional function calls:** The statistics retention and availability functions are called only for the optimizer statistics history row, so the other rows do not trigger them.
*   **Sorted at source:** Ordering by space usage lets the largest occupants be read first.

### FAQ
**Q: Which SYSAUX occupants usually take the most space?**
A: The description notes that the largest occupants are usually the AWR (SM/AWR) and the optimizer statistics history (SM/OPTSTAT), and the report sorts them to the top.
**Q: How do I reduce the space used by optimizer statistics history?**
A: The description says a lower retention, set with the DBMS_STATS alter statistics history retention procedure, reduces SYSAUX space used. The SM/OPTSTAT row shows the current retention in days.
**Q: Why does the report have no parameters?**
A: It lists every occupant of SYSAUX, so there is no selection to make, and the output is already sorted by space used.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sysaux-occupants)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
