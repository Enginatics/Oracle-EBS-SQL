---
layout: default
last_modified_at: 2026-10-26
title: 'INV Physical Inventory Locator Count Sheet | Oracle EBS SQL Report'
description: 'Count sheet listing every active stock locator of the quantity tracked subinventories, as an alternative to printed physical inventory tags. One row per…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Physical, Locator, mtl_parameters, mtl_secondary_inventories, mtl_item_locations_kfv'
permalink: /INV%20Physical%20Inventory%20Locator%20Count%20Sheet/
report_name: 'INV Physical Inventory Locator Count Sheet'
report_web_name: inv-physical-inventory-locator-count-sheet
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Physical Inventory Locator Count Sheet – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-locator-count-sheet/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Count sheet listing every active stock locator of the quantity tracked subinventories, as an alternative to printed physical inventory tags.

One row per item, revision, lot and LPN on hand in the locator. A locator without on hand stock is listed once with a blank item, so counters can record stock found in locations the system considers empty.

On hand held in project and task logical locators is shown against its physical locator, with the project and task.

System Quantity is the live on hand at run time, not the physical inventory snapshot. Leave Show System Quantity empty for a blind count.

Count Quantity, Counted By and Count Comments are blank for entry. Counts can be loaded with INV Physical Inventory Tag Count Upload with a blank tag number, which requires a physical inventory allowing dynamic tags.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Physical Inventory, Subinventory, Locator, Show System Quantity

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_item_locations](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Serial Numbers](/INV%20Serial%20Numbers/ "INV Serial Numbers Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [INV Transaction Upload](/INV%20Transaction%20Upload/ "INV Transaction Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Locator%20Count%20Sheet/INV%20Physical%20Inventory%20Locator%20Count%20Sheet.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Physical Inventory Locator Count Sheet 15-Sep-2026 170732.xlsx](https://www.enginatics.com/example/inv-physical-inventory-locator-count-sheet/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet) |
| Blitz Report™ XML Import | [INV_Physical_Inventory_Locator_Count_Sheet.xml](https://www.enginatics.com/xml/inv-physical-inventory-locator-count-sheet/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet) |
| SQL Source | [INV Physical Inventory Locator Count Sheet.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Locator%20Count%20Sheet/INV%20Physical%20Inventory%20Locator%20Count%20Sheet.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-locator-count-sheet/](https://www.enginatics.com/reports/inv-physical-inventory-locator-count-sheet/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet) |

## Case Study & Technical Analysis: INV Physical Inventory Locator Count Sheet

### Executive Summary
This report produces a locator-based count sheet for a physical inventory in Oracle Inventory. It lists every active stock locator of the subinventories that are quantity tracked, with the items, revisions, lots and license plate numbers on hand in each locator, and leaves blank columns for the counted quantity, the counter and comments. It is an alternative to printed physical inventory tags, and it is used by warehouse supervisors and inventory controllers who want their counters to walk the stores by locator. A locator without stock is listed once with a blank item, so stock found in a location the system considers empty can be recorded.

### Business Challenge
*   **Counting by location:** Counters need a sheet that follows the physical layout of the warehouse, locator by locator, rather than a list of items.
*   **Finding unexpected stock:** Stock can be present in locators that the system shows as empty, and these locations must be on the sheet.
*   **Project and task stock:** Material held in project and task logical locators must be counted against the physical locator where it sits.
*   **Blind counts:** Some organizations do not want counters to see the system quantity, because it can influence the count.

### The Solution
*   Lists each active stock locator of the quantity tracked subinventories of the chosen organization, with its subinventory, locator description and status.
*   Shows one row per item, revision, lot and license plate number on hand in the locator, with the lot expiration date, serial control indicator and primary unit of measure.
*   Shows the project and task of the stock where it is held in a project or task logical locator, against the physical locator.
*   Includes the live system quantity only when Show System Quantity is set, so the sheet can be produced as a blind count.
*   Leaves the Count Quantity, Counted By and Count Comments columns blank for the counter to complete.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_PARAMETERS`: the inventory organizations.
*   `MTL_SECONDARY_INVENTORIES`: the subinventories, with the quantity tracked flag and disable date.
*   `MTL_ITEM_LOCATIONS_KFV` and `MTL_ITEM_LOCATIONS`: the locators, with their concatenated segments, status and project and task.
*   `MTL_MATERIAL_STATUSES_VL`: the locator status.
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the on hand quantities by locator, item, revision, lot and license plate.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its primary unit of measure and serial control.
*   `MTL_LOT_NUMBERS`: the lot expiration date.
*   `WMS_LICENSE_PLATE_NUMBERS`: the license plate number.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. `MTL_PARAMETERS` is joined to `MTL_SECONDARY_INVENTORIES` on organization, and restricted to subinventories that are quantity tracked and not disabled.
2. The subinventory is joined to its active locators in `MTL_ITEM_LOCATIONS_KFV`, and the locator status is outer joined.
3. The locator is joined to `MTL_ITEM_LOCATIONS` to obtain its project and task.
4. The on hand detail is outer joined to the locator, so empty locators remain on the sheet.
5. The item, lot and license plate are outer joined from the on hand detail, giving one row per on hand combination.

### Parameters & Filtering
*   **Organization Code:** selects the organization, limited to organizations the responsibility can access.
*   **Physical Inventory:** selects the physical inventory that the count sheet belongs to.
*   **Subinventory** and **Locator:** limit the count sheet to a subinventory or a locator.
*   **Show System Quantity:** when set, shows the live on hand quantity of each row. When blank, the sheet is a blind count.

### Performance & Optimization
*   The organization restriction uses `ORG_ACCESS_VIEW` for the responsibility, so only the organizations the user can access are read.
*   Locators are restricted to active subinventories and to active locators, through their disable dates, which reduces the number of rows before the on hand join.
*   The on hand detail is aggregated by locator, item, revision, lot, license plate and unit of measure, which gives one count line for each combination.
*   The sort is by organization, subinventory, locator, item, revision, lot and license plate, so the counters can follow the warehouse walk.

### FAQ
**Q: How do I produce a blind count sheet?**
A: Leave the Show System Quantity parameter blank. The sheet then shows no system quantity for the counter to compare.

**Q: What happens to stock held in a project or task locator?**
A: It is shown against its physical locator, with the project and task columns filled in.

**Q: How are the counts loaded back?**
A: The completed counts can be loaded with the INV Physical Inventory Tag Count Upload with a blank tag number, which needs a physical inventory that allows dynamic tags.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-locator-count-sheet)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
