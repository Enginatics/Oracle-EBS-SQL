---
layout: default
title: 'INV Slow Moving Inventory | Oracle EBS SQL Report'
description: 'Slow moving, excess and obsolete inventory. Lists items still holding stock as of a chosen date that have had no material movement over a chosen period…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Slow, Moving, Inventory, mtl_onhand_quantities_detail, mtl_parameters, org_access_view'
permalink: /INV%20Slow%20Moving%20Inventory/
---

# INV Slow Moving Inventory – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-slow-moving-inventory/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Slow moving, excess and obsolete inventory. Lists items still holding stock as of a chosen date that have had no material movement over a chosen period, with their value, usage rate and months of supply, for obsolescence provisioning.

On Hand is the quantity as of the As of Date, not the current quantity. It is rolled back like Oracle's Transaction Historical Summary report, by reversing every material transaction posted after that date. Values use the item cost of the organization's primary cost method.

The no activity test is made per item, so an item is dropped as a whole as soon as any of its subinventories moved. Ignore Adjustment Transactions excludes cycle count adjustments, physical inventory adjustments and cost updates from that test and from Last Transaction Date. Logical transactions never count as activity.

Usage Quantity is the quantity issued out of stock over the Usage Months preceding the As of Date. Months of Supply stays empty where there was no usage at all, which identifies the items that have not moved once in the whole window.

Rows are per subinventory; Item On Hand and Item On Hand Value are the item totals across subinventories.

## Report Parameters
Organization Code, As of Date, No Activity Since, Usage Months, Ignore Adjustment Transactions, Subinventory, Item, Category Set 1, Category Set 2, Category Set 3

## Oracle EBS Tables Used
[mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [CAC Zero Item Costs](/CAC%20Zero%20Item%20Costs/ "CAC Zero Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Slow Moving Inventory 16-Aug-2026 153453.xlsx](https://www.enginatics.com/example/inv-slow-moving-inventory/) |
| Blitz Report™ XML Import | [INV_Slow_Moving_Inventory.xml](https://www.enginatics.com/xml/inv-slow-moving-inventory/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-slow-moving-inventory/](https://www.enginatics.com/reports/inv-slow-moving-inventory/) |



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
