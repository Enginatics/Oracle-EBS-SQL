---
layout: default
last_modified_at: 2026-10-26
title: 'INV Item Relationships | Oracle EBS SQL Report'
description: 'Master listing for Inventory item relationships – Oracle EBS Inventory SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Item, Relationships, mtl_parameters, mtl_related_items, mtl_system_items_vl'
permalink: /INV%20Item%20Relationships/
report_name: 'INV Item Relationships'
report_web_name: inv-item-relationships
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Item Relationships – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Master listing for Inventory item relationships

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Item, Last Update Date From, Last Update Date To, Last Updated By, Creation Date From, Creation Date To, Created By, Organization Code

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships), [mtl_related_items](https://www.enginatics.com/library/?pg=1&find=mtl_related_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)

## Related Reports
[CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [INV Item Default Transaction Subinventories](/INV%20Item%20Default%20Transaction%20Subinventories/ "INV Item Default Transaction Subinventories Oracle EBS SQL Report"), [INV Item Default Transaction Locators](/INV%20Item%20Default%20Transaction%20Locators/ "INV Item Default Transaction Locators Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Safety Stocks](/INV%20Safety%20Stocks/ "INV Safety Stocks Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Relationships/INV%20Item%20Relationships.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Relationships 18-Jan-2018 221121.xlsx](https://www.enginatics.com/example/inv-item-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships) |
| Blitz Report™ XML Import | [INV_Item_Relationships.xml](https://www.enginatics.com/xml/inv-item-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships) |
| SQL Source | [INV Item Relationships.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Relationships/INV%20Item%20Relationships.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-relationships/](https://www.enginatics.com/reports/inv-item-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships) |

## INV Item Relationships - Case Study & Technical Analysis

### Executive Summary
The **INV Item Relationships** report documents the functional links between items. In Oracle Inventory, items can be related for various purposes: Substitutes (if A is out, ship B), Cross-Sells (if buying A, suggest B), Up-Sells, or Service Items (Warranty for Item A). This report is crucial for validating these setups, which directly impact Order Management and Planning.

### Business Use Cases
*   **Substitute Management**: Verifies that discontinued items have valid substitutes defined so orders don't get stuck.
*   **Sales Effectiveness**: Audits the "Cross-Sell" and "Up-Sell" relationships used by the telesales team.
*   **Spare Parts Mapping**: Documents which service parts belong to which finished goods.

### Technical Analysis

#### Core Tables
*   `MTL_RELATED_ITEMS`: The table storing the relationship (Item A -> Item B, Relationship Type).
*   `MTL_SYSTEM_ITEMS_VL`: Item details for both the "From" and "To" items.

#### Key Joins & Logic
*   **Directionality**: Relationships can be one-way or reciprocal. The report typically shows the "From" item and the "To" item.
*   **Effectiveness**: Relationships have start and end dates; the report can filter for currently active links.

#### Key Parameters
*   **Item**: Filter for a specific item.
*   **Organization Code**: Relationships are organization-specific.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-relationships)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
