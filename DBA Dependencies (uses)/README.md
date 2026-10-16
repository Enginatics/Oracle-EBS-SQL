---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Dependencies (uses) | Oracle EBS SQL Report'
description: 'Hierarchical report showing all dependent database objects that a specified object, e.g. a view or package name uses or depends on (top to bottom)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Dependencies, (uses), dba_objects, dba_dependencies'
permalink: /DBA%20Dependencies%20%28uses%29/
report_name: 'DBA Dependencies (uses)'
report_web_name: dba-dependencies-uses
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Dependencies (uses) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-dependencies-uses/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Hierarchical report showing all dependent database objects that a specified object, e.g. a view or package name uses or depends on (top to bottom)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Owner, Object Type, Object Name

## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses), [dba_dependencies](https://www.enginatics.com/library/?pg=1&find=dba_dependencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)

## Related Reports
[DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DBA Dependencies (used by)](/DBA%20Dependencies%20%28used%20by%29/ "DBA Dependencies (used by) Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA Segments](/DBA%20Segments/ "DBA Segments Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Dependencies%20%28uses%29/DBA%20Dependencies%20%28uses%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Dependencies (uses) 12-Dec-2020 231856.xlsx](https://www.enginatics.com/example/dba-dependencies-uses/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses) |
| Blitz Report™ XML Import | [DBA_Dependencies_uses.xml](https://www.enginatics.com/xml/dba-dependencies-uses/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses) |
| SQL Source | [DBA Dependencies (uses).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Dependencies%20%28uses%29/DBA%20Dependencies%20%28uses%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-dependencies-uses/](https://www.enginatics.com/reports/dba-dependencies-uses/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses) |

## Executive Summary
The **DBA Dependencies (uses)** report performs a "Top-Down" dependency analysis. It answers the question: "What does this object rely on?" This is crucial for understanding the complexity of a view or package, or for migrating code between environments (ensuring all prerequisites are moved).

## Business Challenge
*   **Code Understanding**: "This view is complex. What underlying tables does it pull data from?"
*   **Migration Planning**: "I want to move this package to the QA environment. What other objects do I need to move with it?"
*   **Architecture Review**: "Is this report accessing raw tables directly, or is it going through the secured views?"

## Solution
This report lists all objects that are referenced by the input object.

**Key Features:**
*   **Source Tracing**: Traces a view back to its base tables.
*   **External Dependencies**: Identifies dependencies on objects in other schemas.
*   **Link Analysis**: Can identify dependencies over database links.

## Architecture
The report queries `DBA_DEPENDENCIES`.

**Key Tables:**
*   `DBA_DEPENDENCIES`: The system catalog of object relationships.

## Impact
*   **Deployment Success**: Ensures that code migrations don't fail due to missing prerequisites.
*   **Security Auditing**: Verifies that code is accessing data through the approved security layer (e.g., Views vs. Tables).
*   **Documentation**: Automatically documents the data lineage of complex reports.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-uses)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
