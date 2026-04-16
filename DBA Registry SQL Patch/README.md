---
layout: default
title: 'DBA Registry SQL Patch | Oracle EBS SQL Report'
description: 'DBAREGISTRYSQLPATCH contains information about the SQL patches that have been installed in the database. A SQL patch is a patch that contains SQL scripts…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Registry, SQL, Patch, dba_registry_sqlpatch'
permalink: /DBA%20Registry%20SQL%20Patch/
---

# DBA Registry SQL Patch – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-registry-sql-patch/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
DBA_REGISTRY_SQLPATCH contains information about the SQL patches that have been installed in the database.
A SQL patch is a patch that contains SQL scripts which need to be run after OPatch completes. DBA_REGISTRY_SQLPATCH is updated by the datapatch utility. Each row contains information about an installation attempt (apply or roll back) for a given patch.

## Report Parameters
Applied within x Days, Date From, Date To

## Oracle EBS Tables Used
[dba_registry_sqlpatch](https://www.enginatics.com/library/?pg=1&find=dba_registry_sqlpatch)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Registry SQL Patch 22-Dec-2025 084434.xlsx](https://www.enginatics.com/example/dba-registry-sql-patch/) |
| Blitz Report™ XML Import | [DBA_Registry_SQL_Patch.xml](https://www.enginatics.com/xml/dba-registry-sql-patch/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-registry-sql-patch/](https://www.enginatics.com/reports/dba-registry-sql-patch/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
