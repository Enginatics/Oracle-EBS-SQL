---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Dependencies (used by) | Oracle EBS SQL Report'
description: 'Hierarchical report showing all database objects using the specified object, e.g. a certain table and the report shows all the views or packages that are…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Dependencies, (used, by), dba_objects, dba_dependencies'
permalink: /DBA%20Dependencies%20%28used%20by%29/
report_name: 'DBA Dependencies (used by)'
report_web_name: dba-dependencies-used-by
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Dependencies (used by) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-dependencies-used-by/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Hierarchical report showing all database objects using the specified object, e.g. a certain table and the report shows all the views or packages that are refrencing or depending on the specified table (bottom to top)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Owner, Object Type, Object Name

## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by), [dba_dependencies](https://www.enginatics.com/library/?pg=1&find=dba_dependencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)

## Related Reports
[DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DBA Dependencies (uses)](/DBA%20Dependencies%20%28uses%29/ "DBA Dependencies (uses) Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA Segments](/DBA%20Segments/ "DBA Segments Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Dependencies%20%28used%20by%29/DBA%20Dependencies%20%28used%20by%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Dependencies (used by) 12-Dec-2020 224509.xlsx](https://www.enginatics.com/example/dba-dependencies-used-by/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by) |
| Blitz Report™ XML Import | [DBA_Dependencies_used_by.xml](https://www.enginatics.com/xml/dba-dependencies-used-by/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by) |
| SQL Source | [DBA Dependencies (used by).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Dependencies%20%28used%20by%29/DBA%20Dependencies%20%28used%20by%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-dependencies-used-by/](https://www.enginatics.com/reports/dba-dependencies-used-by/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by) |

## Executive Summary
The **DBA Dependencies (used by)** report performs a "Bottom-Up" impact analysis. It answers the critical question: "If I change this object (e.g., a table or view), what else will break?" This is essential for Change Management and risk assessment before applying patches or deploying custom code.

## Business Challenge
*   **Impact Analysis**: "We need to alter the `XX_CUSTOM_ORDERS` table. Which reports and packages use it?"
*   **Regression Prevention**: "Did we forget to recompile a view that depends on the table we just dropped?"
*   **Cleanup**: "Can we safely drop this old table, or is it still referenced by a forgotten legacy procedure?"

## Solution
This report queries the Oracle Data Dictionary to find all objects that depend on the input object.

**Key Features:**
*   **Recursive Search**: Can show direct dependencies (Level 1) and indirect dependencies (Level 2+).
*   **Object Types**: Covers Tables, Views, Packages, Synonyms, and more.
*   **Status Check**: Shows whether the dependent object is currently `VALID` or `INVALID`.

## Architecture
The report queries `DBA_DEPENDENCIES`.

**Key Tables:**
*   `DBA_DEPENDENCIES`: The system catalog of object relationships.
*   `DBA_OBJECTS`: Object metadata.

## Impact
*   **Risk Mitigation**: Prevents production outages caused by "breaking changes".
*   **Change Confidence**: Gives developers and DBAs confidence that they understand the scope of their changes.
*   **Maintenance**: Helps identify and remove obsolete code that depends on deprecated objects.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-dependencies-used-by)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
