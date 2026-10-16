---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Registry | Oracle EBS SQL Report'
description: 'Database components installed, such as Oracle Text, JServer or XML Database, with their version and status. A component with a status other than VALID can…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Registry, dba_registry'
permalink: /DBA%20Registry/
report_name: 'DBA Registry'
report_web_name: dba-registry
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Registry – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-registry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database components installed, such as Oracle Text, JServer or XML Database, with their version and status.

A component with a status other than VALID can cause errors in the Oracle EBS functionality that depends on it and is usually fixed by running utlrp.sql or the component's validation procedure.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Invalid only

## Oracle EBS Tables Used
[dba_registry](https://www.enginatics.com/library/?pg=1&find=dba_registry&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)

## Related Reports
[DBA Registry SQL Patch](/DBA%20Registry%20SQL%20Patch/ "DBA Registry SQL Patch Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Registry/DBA%20Registry.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Registry 12-Oct-2026 061634.xlsx](https://www.enginatics.com/example/dba-registry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry) |
| Blitz Report™ XML Import | [DBA_Registry.xml](https://www.enginatics.com/xml/dba-registry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry) |
| SQL Source | [DBA Registry.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Registry/DBA%20Registry.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-registry/](https://www.enginatics.com/reports/dba-registry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry) |

## Case Study & Technical Analysis: DBA Registry

### Executive Summary
The DBA Registry report lists the database components installed in the Oracle database, such as Oracle Text, JServer and XML Database, with the version, status, schema and validation procedure of each. It is built on the `DBA_REGISTRY` dictionary view. Database administrators run it during installation, patching and health checks to confirm that every component is at the expected version and in the VALID state. A component that is not valid can break Oracle E-Business Suite functions that depend on it, so the report is the first check after a database upgrade or patch. It runs in Excel through Blitz Report.

### Business Challenge
*   **Post-patch verification:** After a database patch or upgrade, the DBA must confirm that every component reports the expected version and status.
*   **Hidden dependency failures:** A component with an invalid status can cause errors in Oracle E-Business Suite functions without an obvious error message at the application level.
*   **Remediation:** The DBA needs to know which procedure validates a component, so the component can be repaired.
*   **Audit evidence:** Change records require a dated list of installed components and their versions.

### The Solution
*   Lists every component in `DBA_REGISTRY` with its name, identifier, version and status, sorted by component name.
*   Shows when each component was last modified, and the schema that owns it together with any other schemas it uses.
*   Shows the control and namespace of each component and the validation procedure to run for it.
*   Filters the list to invalid components when the Invalid only parameter is set, so the report can be used as an alert check.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_REGISTRY`: one row per database component, with the component name, id, version, status, modification time, schema, other schemas, control, namespace and validation procedure.

#### Logical Relationships
1.  The report reads only `DBA_REGISTRY`, so no joins are needed. Each row is one installed component.
2.  The validation procedure column is returned under the name validation_procedure, which is the procedure to run when a component must be checked again.
3.  Ordering by component name gives a stable list for comparison between two databases or two dates.

### Parameters & Filtering
*   **Invalid only:** when set, the output is limited to components whose status is not VALID. The status column shows the state of each remaining row.

### Performance & Optimization
*   The report reads a single dictionary view with a small number of rows, one per component, so it completes immediately even on a busy database.
*   There are no joins, subqueries or aggregate functions, so the query has no costly steps.
*   The Invalid only filter removes the valid rows before the sort, which keeps an alert check short.
*   Because the report reads a dictionary view, it needs the privileges that the view requires; it is intended for DBA users.

### FAQ
**Q: How do I check whether all database components are valid?**
A: Run the report with Invalid only set. If no rows are returned, every component in DBA_REGISTRY has a VALID status.

**Q: What should I do with a component whose status is not VALID?**
A: Use the validation procedure shown for that component, or run utlrp.sql to recompile invalid objects, as the description of the report states.

**Q: Which database components are listed?**
A: Every component recorded in DBA_REGISTRY, such as Oracle Text, JServer and XML Database, with its version, status and owning schema.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-registry)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
