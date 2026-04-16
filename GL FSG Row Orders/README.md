---
layout: default
title: 'GL FSG Row Orders | Oracle EBS SQL Report'
description: 'Financial Statement Generator row order listing – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, FSG, Row, Orders, rg_row_orders, fnd_id_flex_structures_vl, rg_row_segment_sequences_v'
permalink: /GL%20FSG%20Row%20Orders/
---

# GL FSG Row Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-fsg-row-orders/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Financial Statement Generator row order listing

## Report Parameters
Structure Name

## Oracle EBS Tables Used
[rg_row_orders](https://www.enginatics.com/library/?pg=1&find=rg_row_orders), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [rg_row_segment_sequences_v](https://www.enginatics.com/library/?pg=1&find=rg_row_segment_sequences_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL FSG Reports](/GL%20FSG%20Reports/ "GL FSG Reports Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL FSG Row Orders 09-Jan-2022 110120.xlsx](https://www.enginatics.com/example/gl-fsg-row-orders/) |
| Blitz Report™ XML Import | [GL_FSG_Row_Orders.xml](https://www.enginatics.com/xml/gl-fsg-row-orders/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-fsg-row-orders/](https://www.enginatics.com/reports/gl-fsg-row-orders/) |

## GL FSG Row Orders - Case Study & Technical Analysis

### Executive Summary
The **GL FSG Row Orders** report provides a detailed technical view of the "Row Order" components used within the Financial Statement Generator (FSG). Row Orders control the sorting and display sequence of account segments in financial reports, as well as page break logic. This report is used by report developers and system administrators to troubleshoot formatting issues and verify that financial statements are presenting data in the correct hierarchical sequence.

### Business Use Cases
*   **Report Formatting**: Ensures that financial reports display accounts in the desired order (e.g., Assets before Liabilities, or specific sorting of Cost Centers) rather than the default alphanumeric sort.
*   **Page Break Control**: Verifies the setup of page breaks, which is critical for generating departmental reports where each department needs to start on a new page.
*   **Troubleshooting**: Assists in diagnosing why a report is not sorting correctly or why certain accounts are appearing out of sequence.
*   **Standardization**: Helps ensure that consistent row ordering logic is applied across multiple related financial reports.

### Technical Analysis

#### Core Tables
*   `RG_ROW_ORDERS`: Stores the header information for the Row Order definition.
*   `RG_ROW_SEGMENT_SEQUENCES_V`: Contains the detail lines that define the sort sequence for each segment.
*   `FND_ID_FLEX_STRUCTURES_VL`: Identifies the Chart of Accounts structure.

#### Key Joins & Logic
*   **Header to Detail**: The report joins `RG_ROW_ORDERS` to `RG_ROW_SEGMENT_SEQUENCES_V` via `ROW_ORDER_ID` to list the specific sorting rules defined for each segment.
*   **Structure Context**: Links to `FND_ID_FLEX_STRUCTURES_VL` to ensure the row order is being analyzed in the context of the correct Chart of Accounts.
*   **Sequence Logic**: The query exposes the `SEQUENCE` number and the `SEGMENT_NAME` (e.g., Company, Department) to show the priority of sorting. It also displays flags for `ASC_DESC_FLAG` (Ascending/Descending) and `PAGE_BREAK_FLAG`.

#### Key Parameters
*   **Structure Name**: The Chart of Accounts structure to filter the row orders.


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
