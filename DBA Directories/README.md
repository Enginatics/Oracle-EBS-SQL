---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Directories | Oracle EBS SQL Report'
description: 'Database directory objects with their operating system path and the users granted read, write or execute access to them.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Directories, dba_tab_privs, dba_directories'
permalink: /DBA%20Directories/
report_name: 'DBA Directories'
report_web_name: dba-directories
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Directories – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-directories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database directory objects with their operating system path and the users granted read, write or execute access to them.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Directory Path like

## Oracle EBS Tables Used
[dba_tab_privs](https://www.enginatics.com/library/?pg=1&find=dba_tab_privs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories), [dba_directories](https://www.enginatics.com/library/?pg=1&find=dba_directories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)

## Related Reports
[DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA Table Modifications](/DBA%20Table%20Modifications/ "DBA Table Modifications Oracle EBS SQL Report"), [Blitz Report VPD Policy Setup](/Blitz%20Report%20VPD%20Policy%20Setup/ "Blitz Report VPD Policy Setup Oracle EBS SQL Report"), [DBA Table Columns](/DBA%20Table%20Columns/ "DBA Table Columns Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [DBA Text Search](/DBA%20Text%20Search/ "DBA Text Search Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Directories/DBA%20Directories.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Directories 12-Oct-2026 061633.xlsx](https://www.enginatics.com/example/dba-directories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories) |
| Blitz Report™ XML Import | [DBA_Directories.xml](https://www.enginatics.com/xml/dba-directories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories) |
| SQL Source | [DBA Directories.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Directories/DBA%20Directories.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-directories/](https://www.enginatics.com/reports/dba-directories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories) |

## Case Study & Technical Analysis: DBA Directories

### Executive Summary
DBA Directories lists the database directory objects defined in an Oracle instance, with the operating system path each one points to and the database users granted access to it. It is built for DBAs and EBS technical consultants who must confirm that file exchange locations used by interfaces, data loads and report outputs are defined correctly and are accessible only to the intended accounts. The output supports directory audits and security reviews of file-based integrations.

### Business Challenge
*   **Path Governance:** Directory objects map a database name to an operating system path, and an incorrect or overly broad path can expose server files.
*   **Access Review:** Read, write and execute grants on directories are granted over time by different administrators, and the current set is rarely documented.
*   **Integration Troubleshooting:** When a file interface fails, the DBA needs to confirm which directory an interface uses and who can access it.
*   **Audit Evidence:** Security reviews need a dated, exportable list of directory objects and their grants.

### The Solution
*   **Directory Inventory:** The report lists every directory object with its name, its path and the schema that owns it.
*   **Grant Consolidation:** A correlated subquery aggregates all grants on each directory into one text value, so each directory appears on one row.
*   **Readable Privileges:** Each grant is shown as grantee and privilege in lower case, for example a read or write privilege beside the grantee name.
*   **Path Search:** A pattern filter on the directory path finds directories that point to a given server location.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_DIRECTORIES`: the dictionary view of directory objects, with the name, the path and the owner.
*   `DBA_TAB_PRIVS`: the dictionary view of object privileges, from which the grants on each directory are read.

#### Logical Relationships
1.  Each row of `DBA_DIRECTORIES` is one directory object.
2.  A correlated subquery selects `DBA_TAB_PRIVS` rows where the owner and the table name equal the owner and the directory name of the current directory.
3.  The grantee and privilege of each matching row are concatenated and combined with LISTAGG, ordered by grantee and privilege.
4.  The result is ordered by directory name.

### Parameters & Filtering
*   **Directory Path like:** Applies a pattern match to the operating system path, so a search such as a server mount point returns the directories that use it.

### Performance & Optimization
*   **Small Dictionary Scope:** Directory objects are few in a typical EBS database, so the outer query returns a short list.
*   **Correlated Aggregation:** The grants are gathered in a single correlated LISTAGG per directory, which avoids a separate report row for each grant.
*   **Owner and Name Match:** The subquery matches on both owner and name, which keeps grants on a directory with the same name in another schema from being mixed in.
*   **No Joins to Application Tables:** The report reads only dictionary views, so it does not touch EBS transaction data.

### FAQ
**Q: How do I see which users can write to a database directory?**
A: The Grants column lists each grantee with the privilege in brackets, for example write. Read the entries for that privilege on the row for the directory.

**Q: Can I search for directories that point to a specific server path?**
A: Yes. Enter part of the path in the Directory Path like parameter to return the directories whose path matches.

**Q: Does the report show privileges granted through roles?**
A: The Grants column reads direct object privileges on each directory. Role-based access is shown in the DBA Object Access Privileges report for a given user.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-directories)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
