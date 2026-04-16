---
layout: default
title: 'INV Item Statuses | Oracle EBS SQL Report'
description: 'Master data report of inventory items with the various status attributes, such as: is BOM allowed, Build in WIP, customer orders enabled, internal orders…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Statuses, mtl_item_status_vl, mtl_stat_attrib_values_all_v'
permalink: /INV%20Item%20Statuses/
---

# INV Item Statuses – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-statuses(14)/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report of inventory items with the various status attributes, such as: is BOM allowed, Build in WIP, customer orders enabled, internal orders enabled and Invoice enabled, etc.

## Report Parameters
Display Style

## Oracle EBS Tables Used
[mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_stat_attrib_values_all_v](https://www.enginatics.com/library/?pg=1&find=mtl_stat_attrib_values_all_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Statuses 07-Apr-2018 130703.xlsx](https://www.enginatics.com/example/inv-item-statuses(14)/) |
| Blitz Report™ XML Import | [INV_Item_Statuses.xml](https://www.enginatics.com/xml/inv-item-statuses(14)/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-statuses(14)/](https://www.enginatics.com/reports/inv-item-statuses(14)/) |

## INV Item Statuses - Case Study & Technical Analysis

### Executive Summary
The **INV Item Statuses** report is a configuration audit document for the "Item Status" codes (e.g., Active, Inactive, Obsolete, Prototype). In Oracle, the Status controls a set of functional flags (Is it Stockable? Is it Purchasable? Is it Orderable?). This report lists these definitions, ensuring that an "Obsolete" item, for example, is correctly blocked from being purchased or sold.

### Business Use Cases
*   **Lifecycle Management**: Verifies that the "End of Life" status correctly disables all transaction flags to prevent accidental use.
*   **New Product Introduction (NPI)**: Ensures that "Prototype" items are transactable in Engineering but not visible to Sales.
*   **Master Data Governance**: Audits the consistency of status rules across the enterprise.

### Technical Analysis

#### Core Tables
*   `MTL_ITEM_STATUS_VL`: The header definition of the status code.
*   `MTL_STAT_ATTRIB_VALUES_ALL_V`: The values of the individual attributes (flags) for that status.

#### Key Joins & Logic
*   **Attribute Control**: The report shows the state of key attributes like `STOCK_ENABLED_FLAG`, `PURCHASING_ENABLED_FLAG`, `CUSTOMER_ORDER_ENABLED_FLAG`.
*   **Pending Changes**: Some versions of this report may show pending status changes (future dated).

#### Key Parameters
*   **Display Style**: How to format the output.


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
