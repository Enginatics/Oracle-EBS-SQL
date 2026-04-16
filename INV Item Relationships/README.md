---
layout: default
title: 'INV Item Relationships | Oracle EBS SQL Report'
description: 'Master listing for Inventory item relationships – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Relationships, mtl_parameters, mtl_related_items, mtl_system_items_vl'
permalink: /INV%20Item%20Relationships/
---

# INV Item Relationships – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-relationships/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master listing for Inventory item relationships

## Report Parameters
Item, Last Update Date From, Last Update Date To, Last Updated By, Creation Date From, Creation Date To, Created By, Organization Code

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_related_items](https://www.enginatics.com/library/?pg=1&find=mtl_related_items), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Relationships 18-Jan-2018 221121.xlsx](https://www.enginatics.com/example/inv-item-relationships/) |
| Blitz Report™ XML Import | [INV_Item_Relationships.xml](https://www.enginatics.com/xml/inv-item-relationships/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-relationships/](https://www.enginatics.com/reports/inv-item-relationships/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
