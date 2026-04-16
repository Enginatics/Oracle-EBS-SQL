---
layout: default
title: 'DBA Dependencies (uses) | Oracle EBS SQL Report'
description: 'Hierarchical report showing all dependent database objects that a specified object, e.g. a view or package name uses or depends on (top to bottom)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Dependencies, (uses), dba_objects, dba_dependencies'
permalink: /DBA%20Dependencies%20%28uses%29/
---

# DBA Dependencies (uses) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-dependencies-uses/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Hierarchical report showing all dependent database objects that a specified object, e.g. a view or package name uses or depends on (top to bottom)

## Report Parameters
Owner, Object Type, Object Name

## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects), [dba_dependencies](https://www.enginatics.com/library/?pg=1&find=dba_dependencies)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA Dependencies (used by)](/DBA%20Dependencies%20%28used%20by%29/ "DBA Dependencies (used by) Oracle EBS SQL Report"), [DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DBA Index Columns](/DBA%20Index%20Columns/ "DBA Index Columns Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA Objects](/DBA%20Objects/ "DBA Objects Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Dependencies (uses) 12-Dec-2020 231856.xlsx](https://www.enginatics.com/example/dba-dependencies-uses/) |
| Blitz Report™ XML Import | [DBA_Dependencies_uses.xml](https://www.enginatics.com/xml/dba-dependencies-uses/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-dependencies-uses/](https://www.enginatics.com/reports/dba-dependencies-uses/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
