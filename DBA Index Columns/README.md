---
layout: default
title: 'DBA Index Columns | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Index, Columns, dba_indexes, dba_ind_columns, dba_objects'
permalink: /DBA%20Index%20Columns/
---

# DBA Index Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-index-columns/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Table Name starts with

## Oracle EBS Tables Used
[dba_indexes](https://www.enginatics.com/library/?pg=1&find=dba_indexes), [dba_ind_columns](https://www.enginatics.com/library/?pg=1&find=dba_ind_columns), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA Segments](/DBA%20Segments/ "DBA Segments Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA Dependencies (uses)](/DBA%20Dependencies%20%28uses%29/ "DBA Dependencies (uses) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Index Columns 22-Dec-2025 084146.xlsx](https://www.enginatics.com/example/dba-index-columns/) |
| Blitz Report™ XML Import | [DBA_Index_Columns.xml](https://www.enginatics.com/xml/dba-index-columns/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-index-columns/](https://www.enginatics.com/reports/dba-index-columns/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
