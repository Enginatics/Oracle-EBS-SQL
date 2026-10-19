---
layout: default
last_modified_at: 2026-10-19
title: 'DBA Registry SQL Patch | Oracle EBS SQL Report'
description: 'DBAREGISTRYSQLPATCH contains information about the SQL patches that have been installed in the database. A SQL patch is a patch that contains SQL scripts…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, Registry, SQL, Patch, dba_registry_sqlpatch'
permalink: /DBA%20Registry%20SQL%20Patch/
report_name: 'DBA Registry SQL Patch'
report_web_name: dba-registry-sql-patch
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Registry SQL Patch – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-registry-sql-patch/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
DBA_REGISTRY_SQLPATCH contains information about the SQL patches that have been installed in the database.
A SQL patch is a patch that contains SQL scripts which need to be run after OPatch completes. DBA_REGISTRY_SQLPATCH is updated by the datapatch utility. Each row contains information about an installation attempt (apply or roll back) for a given patch.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Applied within x Days, Date From, Date To

## Oracle EBS Tables Used
[dba_registry_sqlpatch](https://www.enginatics.com/library/?pg=1&find=dba_registry_sqlpatch&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)

## Related Reports
[DBA Registry](/DBA%20Registry/ "DBA Registry Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Registry%20SQL%20Patch/DBA%20Registry%20SQL%20Patch.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Registry SQL Patch 22-Dec-2025 084434.xlsx](https://www.enginatics.com/example/dba-registry-sql-patch/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch) |
| Blitz Report™ XML Import | [DBA_Registry_SQL_Patch.xml](https://www.enginatics.com/xml/dba-registry-sql-patch/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch) |
| SQL Source | [DBA Registry SQL Patch.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Registry%20SQL%20Patch/DBA%20Registry%20SQL%20Patch.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-registry-sql-patch/](https://www.enginatics.com/reports/dba-registry-sql-patch/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch) |

## Executive Summary
The **DBA Registry SQL Patch** report tracks the history of SQL patches applied to the database. In modern Oracle versions (12c+), binary patches (applied via `opatch`) often require a post-install SQL step (applied via `datapatch`). This report confirms that the SQL portion of the patch was applied successfully.

## Business Challenge
*   **Patch Verification**: "The binary patch is installed, but did the `datapatch` utility run successfully?"
*   **Audit Trail**: "When was the 'Release Update 19.18' applied to this database?"
*   **Troubleshooting**: "Why are we seeing errors related to a patch that was supposed to be fixed?" (Maybe the SQL step failed).

## Solution
This report queries `DBA_REGISTRY_SQLPATCH`.

**Key Features:**
*   **Patch ID**: The Oracle bug number associated with the patch.
*   **Action**: `APPLY` or `ROLLBACK`.
*   **Status**: `SUCCESS` or `WITH ERRORS`.
*   **Description**: A brief description of what the patch fixes.

## Architecture
The report queries `DBA_REGISTRY_SQLPATCH`.

**Key Tables:**
*   `DBA_REGISTRY_SQLPATCH`: The inventory of SQL patches.

## Impact
*   **Compliance**: Proves that security patches have been fully implemented (both binary and SQL).
*   **Stability**: Prevents "half-patched" states where the binaries are new but the data dictionary is old.
*   **Version Control**: Provides a clear timeline of database software changes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry-sql-patch)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
