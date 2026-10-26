---
layout: default
last_modified_at: 2026-10-26
title: 'INV Item Statuses | Oracle EBS SQL Report'
description: 'Master data report of inventory items with the various status attributes, such as: is BOM allowed, Build in WIP, customer orders enabled, internal orders…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Item, Statuses, mtl_item_status_vl, mtl_stat_attrib_values_all_v'
permalink: /INV%20Item%20Statuses/
report_name: 'INV Item Statuses'
report_web_name: inv-item-statuses(14)
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Item Statuses – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-statuses(14?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Master data report of inventory items with the various status attributes, such as: is BOM allowed, Build in WIP, customer orders enabled, internal orders enabled and Invoice enabled, etc.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Display Style

## Oracle EBS Tables Used
[mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29), [mtl_stat_attrib_values_all_v](https://www.enginatics.com/library/?pg=1&find=mtl_stat_attrib_values_all_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [BOM Standard Operations Upload](/BOM%20Standard%20Operations%20Upload/ "BOM Standard Operations Upload Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Statuses/INV%20Item%20Statuses.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Statuses 07-Apr-2018 130703.xlsx](https://www.enginatics.com/example/inv-item-statuses(14?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)/) |
| Blitz Report™ XML Import | [INV_Item_Statuses.xml](https://www.enginatics.com/xml/inv-item-statuses(14?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)/) |
| SQL Source | [INV Item Statuses.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Statuses/INV%20Item%20Statuses.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-statuses(14)/](https://www.enginatics.com/reports/inv-item-statuses(14?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-statuses%2814%29)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
