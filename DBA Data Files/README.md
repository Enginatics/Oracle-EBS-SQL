---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Data Files | Oracle EBS SQL Report'
description: 'Data and temp files per tablespace with their size, free space, autoextend settings and the space still available up to the maximum size. All sizes are…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Data, Files, dba_data_files, dba_tablespaces, v$backup'
permalink: /DBA%20Data%20Files/
report_name: 'DBA Data Files'
report_web_name: dba-data-files
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Data Files – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-data-files/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Data and temp files per tablespace with their size, free space, autoextend settings and the space still available up to the maximum size.

All sizes are shown in MB.

Available Size and Max Used Percent take autoextend into account, so they show how close a file is to its real limit. Used and free space of temp files are shown by DBA Tablespace Usage.

In Backup Mode flags data files left in hot backup mode (alter tablespace ... begin backup).

Schedule the report with Max Used Percent From, for example 90, to get an email only when a data file is close to full.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Tablespace, Max Used Percent From

## Oracle EBS Tables Used
[dba_data_files](https://www.enginatics.com/library/?pg=1&find=dba_data_files&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files), [dba_tablespaces](https://www.enginatics.com/library/?pg=1&find=dba_tablespaces&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files), [v$backup](https://www.enginatics.com/library/?pg=1&find=v%24backup&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files), [dba_free_space](https://www.enginatics.com/library/?pg=1&find=dba_free_space&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files), [dba_temp_files](https://www.enginatics.com/library/?pg=1&find=dba_temp_files&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)

## Related Reports
[DBA Tablespace Usage](/DBA%20Tablespace%20Usage/ "DBA Tablespace Usage Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Data%20Files/DBA%20Data%20Files.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Data Files 12-Oct-2026 061632.xlsx](https://www.enginatics.com/example/dba-data-files/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files) |
| Blitz Report™ XML Import | [DBA_Data_Files.xml](https://www.enginatics.com/xml/dba-data-files/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files) |
| SQL Source | [DBA Data Files.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Data%20Files/DBA%20Data%20Files.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-data-files/](https://www.enginatics.com/reports/dba-data-files/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files) |

## Case Study & Technical Analysis: DBA Data Files

### Executive Summary
The DBA Data Files report lists every data file and temp file in the database, grouped by tablespace, with its size, free space, autoextend settings and the space still available up to its maximum size. All sizes are shown in MB. Database administrators use it to see how close each file is to its real limit, which is the figure that matters for autoextend files, and to find files left in backup mode. It can also be scheduled with a Max Used Percent threshold so that an email is sent only when a data file is close to full.

### Business Challenge
*   **Hidden capacity limits:** An autoextensible file can look small while still having room to grow, and an un-extended file with no headroom can stop a batch job. Administrators need the real limit, not the current size.
*   **Early warning of full tablespaces:** Tablespaces that fill up stop transactions and concurrent requests, so usage must be watched before it reaches capacity.
*   **Backup hygiene:** Data files left in hot backup mode need to be spotted quickly, so that the backup state can be ended.
*   **Temp space visibility:** Temp files are sized and used differently from data files, and they need their own capacity view.

### The Solution
*   **File-level sizing:** Each data file shows its total size, used size, free size and used percentage, computed from the free-space dictionary view.
*   **Autoextend-aware capacity:** Available Size and Max Used Percent are calculated against the larger of the current size and the autoextend maximum, so the figures reflect the real ceiling.
*   **Backup status flag:** The In Backup Mode column shows whether a data file is in hot backup mode and, if so, since when.
*   **Temp file coverage:** Temp files appear in the same list, with their size and available space, while usage columns are left blank because they are shown by DBA Tablespace Usage.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_DATA_FILES`: the data files, with their size, autoextend flag, maximum size, increment and status.
*   `DBA_TABLESPACES`: the tablespace contents type and block size, used for the increment calculation and for classifying files.
*   `V$BACKUP`: the backup status of each file, used for the hot backup flag.
*   `DBA_FREE_SPACE`: free extents, summed per file to give the free size.
*   `DBA_TEMP_FILES`: the temp files, which are reported in a second branch of the query.

#### Logical Relationships
1.  `DBA_DATA_FILES` is joined to `DBA_TABLESPACES` on tablespace name, and to `V$BACKUP` on file number, which is an outer join so files not in backup still appear.
2.  An inline view sums `DBA_FREE_SPACE` by file ID, and this result is outer joined to the data files, so a file with no free space still returns its full size as used.
3.  A second query branch reads `DBA_TEMP_FILES` joined to `DBA_TABLESPACES`, and returns the temp file size and available size, with the usage columns set to null.
4.  The two branches are combined with UNION ALL and ordered by tablespace name and file name.

### Parameters & Filtering
*   **Tablespace:** Limits the output to one tablespace, including its data and temp files.
*   **Max Used Percent From:** Returns only files whose maximum used percentage is at or above the threshold. Setting it to 90 gives an alert-style list of files close to full.

### Performance & Optimization
*   **Hinted inline views:** The data file and free space inputs are kept as no-merge inline views, so the optimizer does not fold them into the main query.
*   **Free space aggregated per file:** `DBA_FREE_SPACE` is summed by file ID before the join, so each data file is matched to a single free-space row.
*   **Backup status outer joined:** `V$BACKUP` is outer joined by file number, so the backup check does not remove files that are not in backup.
*   **Threshold filtering on the outer query:** The Max Used Percent filter is applied to the combined result, so it is evaluated once per file, including temp files.

### FAQ
**Q: Why is Available Size different from Free Size?**
A: Available Size adds the space still available through autoextend up to the maximum size, while Free Size only counts free space inside the current file size.
**Q: How do I get an alert only for files that are nearly full?**
A: Set Max Used Percent From to a threshold such as 90 and schedule the report, so only files at or above that level are returned.
**Q: Why are the usage columns blank for temp files?**
A: Temp file usage is reported by DBA Tablespace Usage, so this report shows only the size and available space for temp files.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-data-files)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
