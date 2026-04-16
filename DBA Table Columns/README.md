---
layout: default
title: 'DBA Table Columns | Oracle EBS SQL Report'
description: 'Report with all table column names based on dbatabcolumns, as finding tables by column names is a frequent task during SQL development'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Table, Columns, dba_tab_columns'
permalink: /DBA%20Table%20Columns/
---

# DBA Table Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-table-columns/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report with all table column names based on dba_tab_columns, as finding tables by column names is a frequent task during SQL development

## Report Parameters
Column Name contains, Table Name starts with, Exclude Views

## Oracle EBS Tables Used
[dba_tab_columns](https://www.enginatics.com/library/?pg=1&find=dba_tab_columns)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [Blitz Report VPD Policy Setup](/Blitz%20Report%20VPD%20Policy%20Setup/ "Blitz Report VPD Policy Setup Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA Table Modifications](/DBA%20Table%20Modifications/ "DBA Table Modifications Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Table Columns 22-Dec-2025 084853.xlsx](https://www.enginatics.com/example/dba-table-columns/) |
| Blitz Report™ XML Import | [DBA_Table_Columns.xml](https://www.enginatics.com/xml/dba-table-columns/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-table-columns/](https://www.enginatics.com/reports/dba-table-columns/) |

## Case Study & Technical Analysis

### Abstract
The **DBA Table Columns** report is a fundamental metadata discovery tool for developers and DBAs. It allows users to search the entire database schema for tables containing specific column names. This is particularly valuable in large ERP systems like Oracle E-Business Suite, where data models are complex and relationships are not always enforced by foreign keys.

### Technical Analysis

#### Core Logic
*   **Search Scope**: Queries `DBA_TAB_COLUMNS` to find matches across all schemas.
*   **Filtering**: Supports wildcard searches (e.g., `Column Name contains 'ATTRIBUTE'`) and can exclude views to focus purely on physical storage tables.

#### Key View
*   `DBA_TAB_COLUMNS`: The data dictionary view describing the columns of all tables, views, and clusters in the database.

#### Operational Use Cases
*   **Impact Analysis**: "I need to change the data type of `PO_HEADER_ID`. Which tables use this column name?"
*   **Data Discovery**: "I'm looking for a table that stores 'tracking numbers', so I'll search for columns like `%TRACK%`."
*   **Schema Auditing**: Verifying that standard columns (like `WHO` columns: `CREATED_BY`, `CREATION_DATE`) are present on custom tables.


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
