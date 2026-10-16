---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Index Columns | Oracle EBS SQL Report'
description: 'Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Index, Columns, dba_objects, dba_indexes, dba_ind_columns'
permalink: /DBA%20Index%20Columns/
report_name: 'DBA Index Columns'
report_web_name: dba-index-columns
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Index Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-index-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Table Name starts with

## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns), [dba_indexes](https://www.enginatics.com/library/?pg=1&find=dba_indexes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns), [dba_ind_columns](https://www.enginatics.com/library/?pg=1&find=dba_ind_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)

## Related Reports
[DBA Segments](/DBA%20Segments/ "DBA Segments Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Index%20Columns/DBA%20Index%20Columns.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Index Columns 22-Dec-2025 084146.xlsx](https://www.enginatics.com/example/dba-index-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns) |
| Blitz Report™ XML Import | [DBA_Index_Columns.xml](https://www.enginatics.com/xml/dba-index-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns) |
| SQL Source | [DBA Index Columns.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Index%20Columns/DBA%20Index%20Columns.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-index-columns/](https://www.enginatics.com/reports/dba-index-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns) |

## Executive Summary
The **DBA Index Columns** report provides a detailed view of database indexes, specifically focusing on the column order. The order of columns in a composite index is critical for performance: an index on `(A, B)` is very different from an index on `(B, A)`. This report helps DBAs and developers verify that indexes support their query patterns.

## Business Challenge
*   **Query Tuning**: "I have an index on `(STATUS, CREATION_DATE)`, but the query on `CREATION_DATE` is still doing a full table scan. Why?" (Because `STATUS` is the leading column).
*   **Redundancy Check**: "Do we have duplicate indexes? (e.g., one on `A` and another on `(A, B)`)".
*   **Design Verification**: "Did the migration tool preserve the correct column ordering?"

## Solution
This report joins `DBA_INDEXES` with `DBA_IND_COLUMNS`.

**Key Features:**
*   **Column Position**: Shows the exact order of columns (1, 2, 3...).
*   **Uniqueness**: Indicates if the index enforces a unique constraint.
*   **Function-Based Indexes**: Shows the expression used (e.g., `UPPER(USER_NAME)`).

## Architecture
The report queries `DBA_INDEXES` and `DBA_IND_COLUMNS`.

**Key Tables:**
*   `DBA_INDEXES`: Index header information.
*   `DBA_IND_COLUMNS`: Column details.

## Impact
*   **Performance Optimization**: Ensuring the "leading column" matches the query predicates is the #1 rule of indexing.
*   **Storage Savings**: Identifying and dropping redundant indexes saves disk space and reduces overhead on INSERT/UPDATE.
*   **Schema Integrity**: Verifies that unique constraints are properly backed by indexes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-index-columns)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
