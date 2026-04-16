---
layout: default
title: 'JTF Grid Datasources | Oracle EBS SQL Report'
description: 'JTF grid (CRM spreadtable) datasource and column definition – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, JTF, Grid, Datasources, jtf_grid_datasources_vl, jtf_grid_cols_vl'
permalink: /JTF%20Grid%20Datasources/
---

# JTF Grid Datasources – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/jtf-grid-datasources/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
JTF grid (CRM spreadtable) datasource and column definition

## Report Parameters
Datasource Name

## Oracle EBS Tables Used
[jtf_grid_datasources_vl](https://www.enginatics.com/library/?pg=1&find=jtf_grid_datasources_vl), [jtf_grid_cols_vl](https://www.enginatics.com/library/?pg=1&find=jtf_grid_cols_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report Security](/Blitz%20Report%20Security/ "Blitz Report Security Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [JTF Grid Datasources 23-May-2018 140447.xlsx](https://www.enginatics.com/example/jtf-grid-datasources/) |
| Blitz Report™ XML Import | [JTF_Grid_Datasources.xml](https://www.enginatics.com/xml/jtf-grid-datasources/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/jtf-grid-datasources/](https://www.enginatics.com/reports/jtf-grid-datasources/) |

## JTF Grid Datasources - Case Study & Technical Analysis

### Executive Summary
The **JTF Grid Datasources** report is a technical configuration report for the Oracle CRM Foundation (JTF) framework. It documents the setup of "JTF Grids" (also known as Spreadtables), which are the dynamic, spreadsheet-like tables used in many Oracle CRM web applications (like Sales Online, Service Online).

### Business Challenge
Customizing or debugging Oracle CRM web pages requires understanding the underlying data structures.
-   **UI Customization:** "We want to add a new column to the 'My Opportunities' table. Which datasource controls that grid?"
-   **Performance Tuning:** "The 'Service Request' list is loading slowly. What SQL query is behind it?"
-   **Hidden Columns:** "Is there a 'Profit Margin' column available in the grid that is just hidden by default?"

### Solution
The **JTF Grid Datasources** report lists the definition of these grids. It exposes the SQL query, column definitions, and data types.

**Key Features:**
-   **Datasource Definition:** Shows the underlying SQL or View used by the grid.
-   **Column Metadata:** Lists every available column, its data type, and whether it is sortable or filterable.
-   **Customization Visibility:** Shows if the grid has been customized by the user or administrator.

### Technical Architecture
The report queries the JTF Grid metadata tables.

#### Key Tables and Views
-   **`JTF_GRID_DATASOURCES_VL`**: The header definition of the grid datasource.
-   **`JTF_GRID_COLS_VL`**: The definition of columns within the grid.

#### Core Logic
1.  **Retrieval:** Selects the datasource definition based on the name.
2.  **Detailing:** Joins to the column table to list all fields.
3.  **Analysis:** Can be used to compare the standard seeded definition against any custom overrides.

### Business Impact
-   **Development Efficiency:** Accelerates the customization of CRM UIs by providing a map of the backend data.
-   **Troubleshooting:** Helps identify why data is not appearing correctly in the web interface.
-   **Upgrade Analysis:** Helps identify customizations that might be overwritten during an upgrade.


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
