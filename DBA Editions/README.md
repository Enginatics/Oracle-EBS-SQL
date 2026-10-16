---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Editions | Oracle EBS SQL Report'
description: 'Database editions, their type and status – Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, Editions, dba_editions'
permalink: /DBA%20Editions/
report_name: 'DBA Editions'
report_web_name: dba-editions
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Editions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-editions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database editions, their type and status

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[dba_editions](https://www.enginatics.com/library/?pg=1&find=dba_editions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Users](/DBA%20Users/ "DBA Users Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [DBA Editioned Object Summary](/DBA%20Editioned%20Object%20Summary/ "DBA Editioned Object Summary Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Segments](/DBA%20Segments/ "DBA Segments Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Editions/DBA%20Editions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Editions 22-Dec-2025 083921.xlsx](https://www.enginatics.com/example/dba-editions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions) |
| Blitz Report™ XML Import | [DBA_Editions.xml](https://www.enginatics.com/xml/dba-editions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions) |
| SQL Source | [DBA Editions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Editions/DBA%20Editions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-editions/](https://www.enginatics.com/reports/dba-editions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions) |

## Executive Summary
The **DBA Editions** report provides a high-level view of the Edition-Based Redefinition (EBR) landscape in the database. In Oracle E-Business Suite 12.2+, "Editions" are used to allow online patching. This report lists all existing editions, their parent-child relationships, and their status.

## Business Challenge
*   **Patching Status**: "Is the system currently in a patching cycle?"
*   **Cleanup Verification**: "Do we still have the 'V_2020...' edition from 3 years ago?"
*   **Hierarchy Analysis**: "Which edition is the parent of the current run edition?"

## Solution
This report lists the editions from the data dictionary.

**Key Features:**
*   **Edition Name**: The unique identifier for the edition.
*   **Parent Edition**: Shows the lineage of changes.
*   **Usable**: Indicates if the edition can be used by sessions.

## Architecture
The report queries `DBA_EDITIONS`.

**Key Tables:**
*   `DBA_EDITIONS`: The catalog of database editions.

## Impact
*   **Operational Awareness**: Helps DBAs understand the current state of the patching lifecycle.
*   **Troubleshooting**: Essential for diagnosing issues where a user might be connected to the wrong edition.
*   **Capacity Planning**: Identifying an excessive number of editions signals a need for cleanup to prevent performance degradation.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
