---
layout: default
title: 'DBA Dependencies (used by) | Oracle EBS SQL Report'
description: 'Hierarchical report showing all database objects using the specified object, e.g. a certain table and the report shows all the views or packages that are…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Dependencies, (used, by), dba_objects, dba_dependencies'
permalink: /DBA%20Dependencies%20%28used%20by%29/
---

# DBA Dependencies (used by) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-dependencies-used-by/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Hierarchical report showing all database objects using the specified object, e.g. a certain table and the report shows all the views or packages that are refrencing or depending on the specified table (bottom to top)

## Report Parameters
Owner, Object Type, Object Name

## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects), [dba_dependencies](https://www.enginatics.com/library/?pg=1&find=dba_dependencies)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA Dependencies (uses)](/DBA%20Dependencies%20%28uses%29/ "DBA Dependencies (uses) Oracle EBS SQL Report"), [DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DBA Index Columns](/DBA%20Index%20Columns/ "DBA Index Columns Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA Objects](/DBA%20Objects/ "DBA Objects Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Dependencies (used by) 12-Dec-2020 224509.xlsx](https://www.enginatics.com/example/dba-dependencies-used-by/) |
| Blitz Report™ XML Import | [DBA_Dependencies_used_by.xml](https://www.enginatics.com/xml/dba-dependencies-used-by/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-dependencies-used-by/](https://www.enginatics.com/reports/dba-dependencies-used-by/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
