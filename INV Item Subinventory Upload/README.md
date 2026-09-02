---
layout: default
title: 'INV Item Subinventory Upload | Oracle EBS SQL Report'
description: 'Create, update and delete item-to-subinventory assignments (plus their optional item-subinventory-locator ties) across accessible inventory organizations…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Item, Subinventory, mtl_item_sub_inventories, mtl_parameters, mtl_system_items_vl'
permalink: /INV%20Item%20Subinventory%20Upload/
---

# INV Item Subinventory Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-subinventory-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Create, update and delete item-to-subinventory assignments (plus their optional item-subinventory-locator ties) across accessible inventory organizations.

Each row is one (Organization, Item, Subinventory, Locator?) combination. When the Locator column is blank, only the item-subinventory header is processed. When the Locator column is populated, the item-subinventory header (if not already processed in this run) AND the locator tie are processed. When multiple rows share the same Organization/Item/Subinventory triple, the header is processed only on the first row of the triple (siblings contribute only their locator portion); header cells on subsequent rows are silently ignored. Order data by Organization, Item, Subinventory, Locator to make sibling grouping deterministic.

Subinventory selection is restricted to Storage subinventories (Receiving subinventories cannot hold item assignments).

Download Locator Assignments controls whether the template pulls in existing locator ties. Choose Yes (the default) to see the current locator ties alongside each item-subinventory assignment. Leave blank to suppress them — useful when you only want to update item-subinventory header data without duplicated rows for each existing locator.

Min-Max Planning is a Yes/No flag matching the form's Min-Max checkbox: Yes enables Min-Max planning (and makes Min Qty / Max Qty required); blank means Not Planned. This choice is independent of the subinventory's own planning level.

PAR Level is only meaningful when the parent Subinventory has PAR Level planning enabled. If the Subinventory is not PAR-enabled, any PAR Level value supplied on the row is silently ignored on create, and any legacy stored value is cleared on update.

Source Type drives the conditional requirement on Source Organization and Source Subinventory. Inventory and Subinventory source types require Source Organization; Subinventory source type additionally restricts Source Organization to the row's own organization (same-org self-sourcing only). Supplier and blank source types must leave both source fields blank.

Delete Option lets you specify what to delete. Choose Subinventory to delete the item-subinventory assignment (cascades to all locator ties for that item-subinventory). Choose Locator to delete just the locator assignment on this row (only offered when Locator is populated). Once a row deletes an item-subinventory, any subsequent rows for the same Organization/Item/Subinventory triple are rejected with a clear error to prevent orphaned inserts on the deleted parent.

Organization, Item, Subinventory and Locator are read-only on existing rows — to change a key column, delete the row and create a new one.

Stock locators referenced here must already exist in the chosen Subinventory (use the INV Stock Locator Upload to create them).

## Report Parameters
Upload Mode, Organization Code, Subinventory, Item, Download Locators

## Oracle EBS Tables Used
[mtl_item_sub_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_item_sub_inventories), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_secondary_locators](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_locators), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/inv-item-subinventory-upload/) |
| Blitz Report™ XML Import | [INV_Item_Subinventory_Upload.xml](https://www.enginatics.com/xml/inv-item-subinventory-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-subinventory-upload/](https://www.enginatics.com/reports/inv-item-subinventory-upload/) |



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
