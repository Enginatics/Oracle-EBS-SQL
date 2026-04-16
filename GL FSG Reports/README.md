---
layout: default
title: 'GL FSG Reports | Oracle EBS SQL Report'
description: 'Financial Statement Generator reports – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, FSG, Reports, rg_reports_v, fnd_id_flex_structures_vl'
permalink: /GL%20FSG%20Reports/
---

# GL FSG Reports – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-fsg-reports/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Financial Statement Generator reports

## Report Parameters
Structure Name, Row Order

## Oracle EBS Tables Used
[rg_reports_v](https://www.enginatics.com/library/?pg=1&find=rg_reports_v), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL FSG Row Orders](/GL%20FSG%20Row%20Orders/ "GL FSG Row Orders Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [GL Ledgers and Legal Entities](/GL%20Ledgers%20and%20Legal%20Entities/ "GL Ledgers and Legal Entities Oracle EBS SQL Report"), [ZX Tax Accounts](/ZX%20Tax%20Accounts/ "ZX Tax Accounts Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL FSG Reports 09-Jan-2022 110407.xlsx](https://www.enginatics.com/example/gl-fsg-reports/) |
| Blitz Report™ XML Import | [GL_FSG_Reports.xml](https://www.enginatics.com/xml/gl-fsg-reports/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-fsg-reports/](https://www.enginatics.com/reports/gl-fsg-reports/) |

## GL FSG Reports - Case Study & Technical Analysis

### Executive Summary
The **GL FSG Reports** report is a system administration and documentation tool that lists the definitions of Financial Statement Generator (FSG) reports defined in the system. It provides a catalog of existing financial reports, including their associated row sets, column sets, and content sets. This report is essential for maintaining the financial reporting library, identifying obsolete reports, and auditing report definitions during upgrades or re-implementations.

### Business Use Cases
*   **Report Inventory**: Creates a master list of all financial reports (Balance Sheets, P&L, Cash Flow) configured in the system.
*   **Change Management**: Helps track changes to report definitions and ensures that the correct versions of row and column sets are being used.
*   **Cleanup and Optimization**: Identifies unused or duplicate reports that can be retired to declutter the request submission screens.
*   **Migration Planning**: Critical during system upgrades or migrations to document which FSG reports need to be moved or re-tested.
*   **Security Auditing**: Can be used to verify which reports are enabled and available for specific responsibilities (if joined with security data).

### Technical Analysis

#### Core Tables
*   `RG_REPORTS_V`: A view containing the header-level definition of FSG reports (Report Name, Title, Row Set ID, Column Set ID).
*   `RG_REPORT_AXIS_SETS`: Stores the definitions of Row Sets and Column Sets.
*   `FND_ID_FLEX_STRUCTURES_VL`: Provides the Chart of Accounts structure name associated with the report.

#### Key Joins & Logic
*   **Report Definition**: The query selects from `RG_REPORTS_V` to get the main report attributes.
*   **Structure Association**: Joins to `FND_ID_FLEX_STRUCTURES_VL` via `ID_FLEX_NUM` (Chart of Accounts ID) to indicate which accounting structure the report is built for.
*   **Component Resolution**: While this specific query might focus on the report header, it logically links to `RG_REPORT_AXIS_SETS` to resolve the names of the Row and Column sets used by the report.

#### Key Parameters
*   **Structure Name**: Filters the list of reports by the Chart of Accounts structure (e.g., "Corporate Accounting Flexfield").
*   **Row Order**: (Optional) Filters by the specific Row Order definition used in the report.


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
