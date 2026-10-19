---
layout: default
last_modified_at: 2026-10-19
title: 'DBA ASM Disk Groups | Oracle EBS SQL Report'
description: 'Automatic Storage Management disk groups used by the database, with their redundancy, total and free space. All sizes are shown in MB. Usable File Mb is…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, ASM, Disk, Groups, v$asm_diskgroup'
permalink: /DBA%20ASM%20Disk%20Groups/
report_name: 'DBA ASM Disk Groups'
report_web_name: dba-asm-disk-groups
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA ASM Disk Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-asm-disk-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Automatic Storage Management disk groups used by the database, with their redundancy, total and free space.

All sizes are shown in MB.

Usable File Mb is the space available for new files after mirroring. A negative value means that the disk group cannot restore full redundancy after a disk failure.

The report returns no rows when the database does not use ASM.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Used Percent From

## Oracle EBS Tables Used
[v$asm_diskgroup](https://www.enginatics.com/library/?pg=1&find=v%24asm_diskgroup&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)

## Related Reports
[CST Historical WIP Standard Cost Adjustment](/CST%20Historical%20WIP%20Standard%20Cost%20Adjustment/ "CST Historical WIP Standard Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20ASM%20Disk%20Groups/DBA%20ASM%20Disk%20Groups.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/dba-asm-disk-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups) |
| Blitz Report™ XML Import | [DBA_ASM_Disk_Groups.xml](https://www.enginatics.com/xml/dba-asm-disk-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups) |
| SQL Source | [DBA ASM Disk Groups.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20ASM%20Disk%20Groups/DBA%20ASM%20Disk%20Groups.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-asm-disk-groups/](https://www.enginatics.com/reports/dba-asm-disk-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups) |

## Case Study & Technical Analysis: DBA ASM Disk Groups

### Executive Summary
This report lists the Automatic Storage Management (ASM) disk groups used by an Oracle database, with their redundancy, state and space figures in MB. Database administrators use it to check how full each disk group is, whether it can restore full redundancy after a disk failure and how much space remains for new files. The report returns no rows when the database does not use ASM. It runs in Excel through Blitz Report™, and the Used Percent From parameter is the threshold for spotting groups that are filling up.

### Business Challenge
*   **Storage exhaustion:** A full disk group stops datafile growth and can halt transactions, so administrators need to see used space per group before it becomes critical.
*   **Redundancy headroom:** A disk group that cannot restore its mirroring after a disk failure is exposed, and the cause is often a shortage of free space.
*   **Usable capacity:** The raw free space of a group is not the space that can be allocated to new files once mirroring is taken into account.
*   **Disk failure readiness:** Offline disks reduce capacity and must be visible in the same view as the space figures.

### The Solution
*   Shows the total, used and free space of each disk group in MB, with the used percentage calculated from the total.
*   Returns the required mirror free space and the usable file space, so the space available for new files after mirroring is visible.
*   Lists the number of offline disks, the allocation unit size and the compatibility settings of each group.
*   Presents the groups in name order, so the same groups appear in the same place across repeated runs.

### Technical Architecture (High Level)
#### Primary Tables
*   `V$ASM_DISKGROUP`: the dynamic performance view that holds one row for each mounted ASM disk group, with its size, free space, redundancy type and compatibility attributes.

#### Logical Relationships
1.  The report reads a single view, so there are no joins; each row is one disk group.
2.  The used space is calculated as total space less free space.
3.  The used percentage is the used space divided by the total space, with a null-safe divisor so that a group reporting no total space does not cause an error.
4.  The allocation unit size is converted from bytes to MB by dividing by 1,048,576.
5.  The results are ordered by disk group name.

### Parameters & Filtering
*   **Used Percent From:** sets the lower bound for the used percentage that the report is filtered on, so that only groups above the chosen fill level are listed.

### Performance & Optimization
*   The query reads one small dynamic view with no joins, so its cost is negligible and it can be run at any time without affecting the database workload.
*   All space figures are returned by the view itself, so no calculation requires access to the disk or file catalogue.
*   The divisor in the used percentage is wrapped in a null-safe function, which avoids a division error for any group that reports zero total space.
*   Because the view returns one row for each disk group, the output size is proportional to the number of disk groups and not to the number of files or disks.

### FAQ
**Q: Why is the usable file space negative for a disk group?**
A: A negative Usable File MB value means the disk group cannot restore full redundancy after a disk failure, so it has to be given more free space before it is considered safe.

**Q: How is the used percentage of an ASM disk group calculated?**
A: The report divides the used space, which is total MB less free MB, by the total MB and multiplies by 100.

**Q: Why does the report return no rows?**
A: The report returns no rows when the database does not use ASM, because the disk group view is then empty.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-asm-disk-groups)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
