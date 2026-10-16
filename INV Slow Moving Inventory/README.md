---
layout: default
last_modified_at: 2026-10-16
title: 'INV Slow Moving Inventory | Oracle EBS SQL Report'
description: 'Slow moving, excess and obsolete inventory. Lists items still holding stock as of a chosen date that have had no material movement over a chosen period…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Slow, Moving, mtl_onhand_quantities_detail, mtl_parameters, org_access_view'
permalink: /INV%20Slow%20Moving%20Inventory/
report_name: 'INV Slow Moving Inventory'
report_web_name: inv-slow-moving-inventory
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Slow Moving Inventory – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-slow-moving-inventory/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Slow moving, excess and obsolete inventory. Lists items still holding stock as of a chosen date that have had no material movement over a chosen period, with their value, usage rate and months of supply, for obsolescence provisioning.

On Hand is the quantity as of the As of Date, not the current quantity. It is rolled back like Oracle's Transaction Historical Summary report, by reversing every material transaction posted after that date. Values use the item cost of the organization's primary cost method.

The no activity test is made per item, so an item is dropped as a whole as soon as any of its subinventories moved. Ignore Adjustment Transactions excludes cycle count adjustments, physical inventory adjustments and cost updates from that test and from Last Transaction Date. Logical transactions never count as activity.

Usage Quantity is the quantity issued out of stock over the Usage Months preceding the As of Date. Months of Supply stays empty where there was no usage at all, which identifies the items that have not moved once in the whole window.

Rows are per subinventory; Item On Hand and Item On Hand Value are the item totals across subinventories.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, As of Date, No Activity Since, Usage Months, Ignore Adjustment Transactions, Subinventory, Item, Category Set 1, Category Set 2, Category Set 3

## Oracle EBS Tables Used
[mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [CAC Zero Item Costs](/CAC%20Zero%20Item%20Costs/ "CAC Zero Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Slow%20Moving%20Inventory/INV%20Slow%20Moving%20Inventory.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Slow Moving Inventory 16-Aug-2026 153453.xlsx](https://www.enginatics.com/example/inv-slow-moving-inventory/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory) |
| Blitz Report™ XML Import | [INV_Slow_Moving_Inventory.xml](https://www.enginatics.com/xml/inv-slow-moving-inventory/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory) |
| SQL Source | [INV Slow Moving Inventory.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Slow%20Moving%20Inventory/INV%20Slow%20Moving%20Inventory.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-slow-moving-inventory/](https://www.enginatics.com/reports/inv-slow-moving-inventory/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory) |

## Case Study & Technical Analysis: INV Slow Moving Inventory

### Executive Summary
The INV Slow Moving Inventory report identifies slow moving, excess and obsolete stock in Oracle Inventory. It lists items that still hold on-hand quantity at a chosen as-of date but have had no material movement over a chosen period, and shows their value, usage rate and months of supply. Inventory controllers and finance teams use it to size obsolescence provisions and to decide which stock should be reviewed, written down or redeployed. The on-hand position is rebuilt as at the as-of date, so the figures are historical rather than current. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Obsolescence provisioning:** Finance must estimate the value of stock that has not moved, supported by item-level values as at the reporting date.
*   **Excess inventory review:** Planners need the months of supply each item represents at its recent usage, to decide where to reduce purchasing.
*   **Historical accuracy:** Closing inventory for a past date must be rebuilt, because current balances change with every transaction since that date.
*   **Adjustment noise:** Cycle count and physical inventory adjustments can make an item look active when it has not been used.

### The Solution
*   **Historical on-hand:** On-hand is rebuilt as at the as-of date by reversing every material transaction posted after that date against the current on-hand detail.
*   **No-activity test:** An item is dropped as a whole if any of its subinventories had a qualifying transaction in the no-activity window.
*   **Usage and supply:** Issue quantities in the usage window give the usage quantity, average monthly usage and months of supply.
*   **Valuation:** Quantities are valued at the item cost of the organization's primary cost method.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the current on-hand per organization, item and subinventory, the starting point of the rollback.
*   `MTL_MATERIAL_TRANSACTIONS`: the material transactions used to reverse post-as-of activity and to measure usage and last activity.
*   `MTL_TRANSACTION_TYPES`: the name of the last transaction type.
*   `MTL_SECONDARY_INVENTORIES`: the subinventory description, type and asset flag.
*   `MTL_SYSTEM_ITEMS_VL`: the item, status, type, make-buy code, planner and unit of measure.
*   `CST_ITEM_COSTS` and `CST_COST_TYPES`: the item cost of the primary cost method.
*   `MTL_PARAMETERS`: the organization, its cost organization and primary cost method.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the organization name.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

#### Logical Relationships
1.  The innermost query unions current on-hand rows with material transactions of the accessible organizations, excluding logical transactions.
2.  Each transaction contributes its reversal to on-hand when dated after the as-of date, usage when in the usage window and of an issue action, and a last transaction date when it falls before the as-of date.
3.  Rows are aggregated by organization, item and subinventory, then by organization and item with analytic sums.
4.  The item-level result joins to the organization, subinventory, item master, item cost and transaction type.
5.  Only rows with on-hand not equal to zero and no activity in the window are returned, ordered by organization, item value descending, item and subinventory.

### Parameters & Filtering
*   **Organization Code:** selects the inventory organization.
*   **As of Date:** the date at which the on-hand is rebuilt.
*   **No Activity Since:** the start of the window in which any material movement excludes the item.
*   **Usage Months:** the number of months before the as-of date over which usage is measured.
*   **Ignore Adjustment Transactions:** when Y, cycle count, physical inventory and cost update transactions are excluded from the activity test and from the last transaction date.
*   **Subinventory** and **Item:** narrow the output.
*   **Category Set 1** to **Category Set 3:** restrict the items by category and add category columns.

### Performance & Optimization
*   The rollback is a single pass over the material transactions, so each transaction is read once and classified by date and action in the same row.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied before both the on-hand and transaction branches.
*   Analytic sums and `KEEP (DENSE_RANK LAST)` aggregates compute item totals and the last transaction without a second join.
*   Cost is joined only through the primary cost method, so a single cost row per item is used.

### FAQ
**Q: Why are the on-hand quantities different from the current balances?**
A: On-hand is rebuilt as at the As of Date by reversing every material transaction posted after that date, so it matches the historical position.

**Q: What does an empty Months of Supply value mean?**
A: It means the item had no usage in the usage window, so months of supply cannot be calculated.

**Q: How do adjustments affect whether an item is reported as slow moving?**
A: When Ignore Adjustment Transactions is Y, cycle count, physical inventory and cost update transactions do not count as activity, so an item with only adjustments can still be reported.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-slow-moving-inventory)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
