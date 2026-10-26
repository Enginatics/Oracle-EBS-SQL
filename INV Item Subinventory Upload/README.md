---
layout: default
last_modified_at: 2026-10-26
title: 'INV Item Subinventory Upload | Oracle EBS SQL Report'
description: 'Create, update and delete item-to-subinventory assignments (plus their optional item-subinventory-locator ties) across accessible inventory organizations…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Item, Subinventory, mtl_item_sub_inventories, mtl_onhand_quantities_detail, mtl_parameters'
permalink: /INV%20Item%20Subinventory%20Upload/
report_name: 'INV Item Subinventory Upload'
report_web_name: inv-item-subinventory-upload
---

# INV Item Subinventory Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Subinventory, Item, Download Locators, Min-Max Planned Only

## Oracle EBS Tables Used
[mtl_item_sub_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_item_sub_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [mtl_secondary_locators](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_locators&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Physical Inventory Locator Count Sheet](/INV%20Physical%20Inventory%20Locator%20Count%20Sheet/ "INV Physical Inventory Locator Count Sheet Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report"), [INV Aging](/INV%20Aging/ "INV Aging Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [INV Slow Moving Inventory](/INV%20Slow%20Moving%20Inventory/ "INV Slow Moving Inventory Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Subinventory%20Upload/INV%20Item%20Subinventory%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-item-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload) |
| Blitz Report™ XML Import | [INV_Item_Subinventory_Upload.xml](https://www.enginatics.com/xml/inv-item-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload) |
| SQL Source | [INV Item Subinventory Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Subinventory%20Upload/INV%20Item%20Subinventory%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-subinventory-upload/](https://www.enginatics.com/reports/inv-item-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload) |

## Case Study & Technical Analysis: INV Item Subinventory Upload

### Executive Summary
The INV Item Subinventory Upload is a Blitz Report upload for the item-to-subinventory assignments in Oracle Inventory. It creates, updates and deletes the assignment of an item to a storage subinventory, together with the optional tie of that item-subinventory to a stock locator. Inventory and supply chain planners use it to maintain min-max planning parameters, lot sizing, lead times, sourcing and PAR levels for many items at once, across all accessible inventory organizations. Rows are applied through the same rules as the Item Subinventories form, so the validations of the form apply to each change. The workflow runs in Excel through Blitz Report.

### Business Challenge
*   **Bulk setup of item subinventories:** Each item must be assigned to the storage subinventories where it is stocked, and the planning values of each assignment must be set consistently, which is slow to do form by form.
*   **Min-max replenishment:** Planners need Min-Max planning enabled, with minimum and maximum quantities, on the right subinventories, and the change must be reviewable before it is loaded.
*   **Locator control:** Stock locators must be tied to the item-subinventory so that picking and put-away can target a physical location.
*   **Sourcing and lead times:** Source type, source organization, source subinventory and processing lead times determine replenishment, and they must be maintained together.

### The Solution
*   **Keyed rows:** Each row is one organization, item, subinventory and optional locator combination. Existing rows are downloaded with their current values, and the upload processes only the cells that have changed.
*   **Header once per triple:** When several rows share the same organization, item and subinventory, the header is processed on the first row only, and the following rows contribute only their locator tie.
*   **Locator handling:** A blank Locator column processes only the header. A populated Locator column processes the header, if not already processed in the run, and the locator tie.
*   **Controlled deletion:** A Delete Option chooses between deleting the whole item-subinventory assignment, which cascades to its locator ties, and deleting only the locator assignment.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_ITEM_SUB_INVENTORIES`: the item-subinventory assignment, with its min-max quantities, lot sizing, lead times, source fields and flexfield attributes.
*   `MTL_SECONDARY_INVENTORIES`: the subinventory master, supplying its description and the storage subinventory filter.
*   `MTL_SECONDARY_LOCATORS`: the locator ties of the subinventory, with the PAR level (maximum quantity) of each locator.
*   `MTL_ITEM_LOCATIONS_KFV`: the stock locator concatenated name and description.
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the on-hand quantity of the item in the subinventory, shown for reference.
*   `MTL_SYSTEM_ITEMS_VL`: the item number, description and primary unit of measure.
*   `MTL_PARAMETERS`: the organization code of the item and of the source organization.
*   `ORG_ACCESS_VIEW`: the inventory organizations available to the current responsibility.

#### Logical Relationships
1.  `MTL_ITEM_SUB_INVENTORIES` joins to `MTL_PARAMETERS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  The assignment joins to `MTL_SYSTEM_ITEMS_VL` on the item and organization, and to `MTL_SECONDARY_INVENTORIES` on the organization and subinventory name.
3.  The source organization is an outer join to `MTL_PARAMETERS`, so assignments without a source organization are kept.
4.  Locator ties come from `MTL_SECONDARY_LOCATORS` on the item, organization and subinventory, and their names come from `MTL_ITEM_LOCATIONS_KFV`. These are included only when Download Locators is Y.
5.  The on-hand value is a correlated sum over `MTL_ONHAND_QUANTITIES_DETAIL` for the same item and subinventory.

### Parameters & Filtering
*   **Upload Mode:** sets the download or upload action.
*   **Organization Code:** selects the inventory organization.
*   **Subinventory:** limits the rows to one subinventory.
*   **Item:** limits the rows to one item.
*   **Download Locators:** when Y, the locator ties of each assignment are included, and when blank they are suppressed to avoid duplicate header rows.
*   **Min-Max Planned Only:** limits the output to assignments with Min-Max planning enabled, which is the planning code 2 in the item-subinventory record.

### Performance & Optimization
*   The locator join is conditional on the Download Locators parameter, so the locator tables are read only when they are needed.
*   The on-hand quantity is a scalar subquery keyed on organization, item and subinventory, so it returns one value per assignment.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, which limits the rows that reach the item and subinventory joins.
*   Outer joins to the source organization and locator tables keep assignments that have no source or locator, so the upload file is complete.

### FAQ
**Q: Why does a row sometimes show no changes to header cells?**
A: When several rows share an organization, item and subinventory, header cells on the second and later rows are ignored, so only the locator cells on those rows are processed.

**Q: How do I change an organization, item, subinventory or locator on an existing row?**
A: Those key columns are read-only on existing rows. Delete the row and create a new one with the new key values.

**Q: Which subinventories can be assigned?**
A: The description states that only storage subinventories can hold item assignments, so receiving subinventories are not selectable.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-subinventory-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
