---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Resource Limits | Oracle EBS SQL Report'
description: 'Current and highest utilization since instance startup of database resources such as processes, sessions and transactions, compared to their limits. A Max…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Resource, Limits, gv$resource_limit, gv$process, gv$session'
permalink: /DBA%20Resource%20Limits/
report_name: 'DBA Resource Limits'
report_web_name: dba-resource-limits
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Resource Limits – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-resource-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Current and highest utilization since instance startup of database resources such as processes, sessions and transactions, compared to their limits.

A Max Percent close to 100 shows that the instance reached the limit since startup. Reaching the processes or sessions limit causes ORA-00020 or ORA-00018 for new connections.

In a pluggable database, the database shows resource limits only in the container root. There the report shows the current number of processes and sessions against their parameter limits instead, without the highest utilization.

Schedule the report with Max Percent From, for example 90, to get an email only when a limit is nearly reached.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Max Percent From, Instance Id

## Oracle EBS Tables Used
[gv$resource_limit](https://www.enginatics.com/library/?pg=1&find=gv%24resource_limit&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits), [gv$process](https://www.enginatics.com/library/?pg=1&find=gv%24process&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits), [gv$parameter](https://www.enginatics.com/library/?pg=1&find=gv%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)

## Related Reports
[DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Resource%20Limits/DBA%20Resource%20Limits.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Resource Limits 12-Oct-2026 061635.xlsx](https://www.enginatics.com/example/dba-resource-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits) |
| Blitz Report™ XML Import | [DBA_Resource_Limits.xml](https://www.enginatics.com/xml/dba-resource-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits) |
| SQL Source | [DBA Resource Limits.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Resource%20Limits/DBA%20Resource%20Limits.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-resource-limits/](https://www.enginatics.com/reports/dba-resource-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits) |

## Case Study & Technical Analysis: DBA Resource Limits

### Executive Summary
DBA Resource Limits shows the current and highest utilization, since instance startup, of the database resources that cap connections and transactions, such as processes, sessions and transactions, against their configured limits. It helps DBAs of Oracle E-Business Suite databases detect when the instance is approaching or has reached a limit, the point at which new connections fail. The report is intended for DBA operations teams who monitor capacity and for administrators who want a scheduled warning before users are affected.

### Business Challenge
*   **Connection Failures:** When the processes or sessions limit is reached, new logons fail with ORA-00020 or ORA-00018, which stops users from working.
*   **Hidden Peak Usage:** Current utilization shows the load at one moment, but the highest value since startup shows whether the limit was reached earlier.
*   **Capacity Planning:** Without a comparison against the configured limits, the team cannot judge how much headroom remains.
*   **Pluggable Database Differences:** In a container database the resource views differ between the root and the pluggable databases, so the same check needs different handling.

### The Solution
*   **Limit Comparison:** Each resource is shown with its current utilization, its maximum utilization and its configured limit, and the two percentages are calculated against the limit.
*   **Sorting by Pressure:** Rows are ordered by the highest percentage, so the resources closest to their limits appear first.
*   **Fallback For Containers:** Where the resource limit view is empty, as in the container root, the report compares current processes and sessions with their parameter values.
*   **Alert Scheduling:** The Max Percent From parameter lets the report be scheduled so that output is produced only when a limit is nearly reached.

### Technical Architecture (High Level)
#### Primary Tables
*   `GV$RESOURCE_LIMIT`: the cluster-wide view of resource usage, with current and maximum utilization and the limit values.
*   `GV$PROCESS`: used to count current processes for each instance in the fallback branch.
*   `GV$SESSION`: used to count current sessions for each instance in the fallback branch.
*   `GV$PARAMETER`: supplies the processes and sessions parameter values for the fallback branch.

#### Logical Relationships
1.  The first branch reads every row of `GV$RESOURCE_LIMIT` for each instance, trimming the initial allocation and limit text.
2.  The second branch, combined with UNION ALL, reads the processes and sessions parameters from `GV$PARAMETER` and only runs when `GV$RESOURCE_LIMIT` returns no rows for the instance.
3.  For processes, the current count is taken from `GV$PROCESS`; for sessions, it is taken from `GV$SESSION`.
4.  An outer query calculates the current and maximum percentages against the numeric limit, leaving them empty where the limit is UNLIMITED or zero.
5.  Rows are ordered by the larger of the two percentages, then by instance and resource name.

### Parameters & Filtering
*   **Max Percent From:** Returns only resources whose maximum percentage is at or above the entered value, for example 90. This is the parameter used for scheduled alerts.
*   **Instance Id:** Restricts the output to one instance of a RAC cluster.

### Performance & Optimization
*   **Small Resource Set:** The resource list is short, so the aggregation over sessions and processes is the main cost and is bounded by the number of connections.
*   **Correlated Count Per Instance:** Process and session counts are computed per instance with correlated subqueries, which keeps the counts aligned with each instance.
*   **Conditional Fallback:** The second branch is guarded by a NOT EXISTS test, so it adds work only when the resource limit view is unavailable.
*   **Ordering on the Computed Percentage:** Sorting by the larger percentage places the most constrained resources first without any additional query.

### FAQ
**Q: What does a Max Percent close to 100 mean?**
A: The instance reached that percentage of the configured limit at some point since startup. For processes or sessions, reaching 100 means new connections were refused at that point.

**Q: Why does my pluggable database show only processes and sessions?**
A: In a pluggable database the resource limit view shows data only in the container root. The report then compares current processes and sessions with their parameter values, without the highest utilization.

**Q: How can the report warn me before users are affected?**
A: Schedule the report with Max Percent From set to 90. The scheduled run then sends output only when a resource has reached that share of its limit.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-resource-limits)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
