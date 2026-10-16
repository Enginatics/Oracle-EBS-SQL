---
layout: default
last_modified_at: 2026-10-16
title: 'INV Item Upload 11i | Oracle EBS SQL Report'
description: 'INV Inventory Item Upload ====================== This upload can be used to create and update Inventory Items. It supports creation of Inventory Items: …'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Item, 11i, mtl_item_catalog_groups_b_kfv, mtl_item_status, mtl_units_of_measure_tl'
permalink: /INV%20Item%20Upload%2011i/
report_name: 'INV Item Upload 11i'
report_web_name: inv-item-upload-11i
---

# INV Item Upload 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i).

## Overview
INV Inventory Item Upload
======================
This upload can be used to create and update Inventory Items.

It supports creation of Inventory Items:
- by manually entering the Item details.
- from a master row, with optional semicolon-separated child organization assignments
- from an item template (Copy from Template)
- from an existing item in the same Organization (Copy from Item)

It supports update of existing Inventory Items either by:
- update the details of an existing inventory items by downloading the items to be updated. Use the report parameters to select and download the items to be updated.
- pasting the details of the items to be updated into an empty upload excel.

It also supports the item category assignment to multiple Inventory Category Sets
-  to assign an item to another category set, repeat the Organization Code and Item Number on a separate row in the excel and add the details of the additional category set and item category to which the item is to be assigned.
- for child organizations, only the category sets controlled at the organization level can be selected.
- to remove an existing category assignment, download the item first, then set the Delete Category column to Yes on the row showing the Category Set and Item Category to be removed. Deletion is not permitted for mandatory category sets that require the item to remain assigned.

Upload Mode parameter:
Create - allows creation of new items only
Update - allows updates to existing items only
Create, Update – allows the creation of new items and the updating of existing items

Create Empty File parameter
Setting the Create Empty File parameter to Yes will open an empty upload excel. 
This parameter is only applicable to the 'Update' and 'Create, Update' upload modes and suppresses the download of existing item details. ‘Create’ upload mode always opens an empty upload excel regardless of the setting of this parameter.
This is useful for users who want to paste the details of the items to be updated into an empty upload excel file from another source.

Update on Create Null Handling
In Create, Update mode the upload allows a Create action to update an existing item if it already exists. This parameter determines how null values are handled when a create action results in an update to an existing item.
'Null means Clear' - the upload will clear the data from the corresponding column (set it to null).
'Null means No Change' - the upload will leave the data in the corresponding column unchanged.

Number of Import Workers parameter
This parameter determines the number of Item Import worker concurrent requests that will be submitted in parallel to import the uploaded items into Oracle Inventory. The number of workers can be increased to improve the throughput of the process when uploading a larger number of item changes.
Remaining parameters
The remaining parameters are used to restrict the items to be downloaded for update in ‘Update’ or ‘Create, Update’ mode, and only when the ‘Create Empty File’ parameter is not set to Yes.  
 
Available Templates
Use the pre-defined templates to restrict the Item Attributes to be displayed and updated in the report. Alternatively, users can define their own custom template containing the Item Attributes of interest.

NOTE:
When creating new child items, the master-controlled item attributes are not passed to the Import API so they are defaulted from the Master Org. 
When updating existing child items, the master-controlled item attributes are copied directly from the Master Org, in case there is any pre-existing inconsistency between the Child Org and Master Org values. 
Effectively this means, for creation/updates to items in child organizations, the uploaded values for Master Controlled Item attributes are not considered by upload.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Create Empty File, Update on Create Null Handling, Number of Item Import Workers, Organization Code, Category Set, Category, Item, Item Like, Item Description, Item Type, Item Status, BOM Item Type, Contract Item Type, Make or Buy, Buyer, Planner, Manufacturer, Inventory Planning Method, Last Update Date From, Last Update Date To, Last Updated By, Creation Date From, Creation Date To, Created By, Cross Reference Type, Cross Reference

## Oracle EBS Tables Used
[mtl_item_catalog_groups_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_catalog_groups_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_item_status](https://www.enginatics.com/library/?pg=1&find=mtl_item_status&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_material_statuses](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [po_un_numbers](https://www.enginatics.com/library/?pg=1&find=po_un_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [po_hazard_classes](https://www.enginatics.com/library/?pg=1&find=po_hazard_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_atp_rules](https://www.enginatics.com/library/?pg=1&find=mtl_atp_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_picking_rules](https://www.enginatics.com/library/?pg=1&find=mtl_picking_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [MTL_UOM_CONVERSIONS](https://www.enginatics.com/library/?pg=1&find=MTL_UOM_CONVERSIONS&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [oks_coverage_templts_v](https://www.enginatics.com/library/?pg=1&find=oks_coverage_templts_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_manufacturers](https://www.enginatics.com/library/?pg=1&find=mtl_manufacturers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_mfg_part_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_mfg_part_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Default Category Sets](/INV%20Default%20Category%20Sets/ "INV Default Category Sets Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Upload%2011i/INV%20Item%20Upload%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-item-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i) |
| Blitz Report™ XML Import | [INV_Item_Upload_11i.xml](https://www.enginatics.com/xml/inv-item-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i) |
| SQL Source | [INV Item Upload 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Upload%2011i/INV%20Item%20Upload%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-upload-11i/](https://www.enginatics.com/reports/inv-item-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i) |

## Case Study & Technical Analysis: INV Item Upload 11i

### Executive Summary
The INV Item Upload 11i creates and updates Inventory Items in Oracle Inventory from an Excel spreadsheet. Each row describes one item in one organization, covering main attributes, inventory controls, costing, purchasing, planning, order management, service and the item's descriptive flexfield values, with optional manufacturer part numbers and category assignments. Item masters, supply chain planners and implementation teams use it to set up new items, copy items from a template or an existing item, and maintain attributes in bulk across master and child organizations. The report runs in Excel via Blitz Report, and changes are loaded through the Item Import process.

### Business Challenge
*   **Item master setup at scale:** Creating items one at a time in the Master Items form is slow when a product launch or an acquisition adds hundreds of items.
*   **Attribute consistency:** Items need the same attribute values across many organizations, and inconsistent setup causes planning, costing and shipping errors.
*   **Category assignments:** Items must be assigned to several category sets, and each category set has its own rules for which organizations may use it.

### The Solution
*   **Multiple creation routes:** Items can be entered manually, created from a master row with child organization assignments, copied from a template, or copied from an existing item in the same organization.
*   **Update from download or paste:** Existing items are downloaded with the report parameters, or details can be pasted into an empty upload file.
*   **Category and manufacturer rows:** Additional category set assignments and manufacturer part numbers are entered as extra rows, and a category can be deleted by setting the Delete Category column.
*   **Null handling control:** When a create action updates an existing item, Null Means Clear or Null Means No Change determines how blank values are treated.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_SYSTEM_ITEMS_VL`: the item attributes for each organization, including all the item flags, codes and values the upload covers.
*   `MTL_PARAMETERS`: the organization codes, and the master organization of each organization.
*   `MTL_ITEM_CATEGORIES`, `MTL_CATEGORY_SETS_VL`, `MTL_CATEGORIES_KFV`: item category assignments, their category sets and category values.
*   `MTL_MFG_PART_NUMBERS`, `MTL_MANUFACTURERS`: manufacturer part numbers and manufacturer names.
*   `MTL_ITEM_STATUS`, `MTL_MATERIAL_STATUSES`, `MTL_UNITS_OF_MEASURE_TL`, `MTL_UOM_CONVERSIONS`: status, lot and serial status, and unit of measure descriptions.
*   `MTL_ITEM_CATALOG_GROUPS_B_KFV`, `MTL_ITEM_LOCATIONS_KFV`, `MTL_ATP_RULES`, `MTL_PICKING_RULES`: catalog group, locator, ATP and picking rule names.
*   `GL_CODE_COMBINATIONS_KFV`, `FA_CATEGORIES_B_KFV`, `RCV_ROUTING_HEADERS`, `PO_UN_NUMBERS`, `PO_HAZARD_CLASSES`: accounts, asset category, receiving routing and hazard references.
*   `PER_PEOPLE_X`, `RA_RULES`, `RA_TERMS_VL`, `OKS_COVERAGE_TEMPLTS_V`: buyer, accounting and invoicing rule, payment term and coverage template names.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

#### Logical Relationships
1. `MTL_SYSTEM_ITEMS_VL` is joined to `MTL_PARAMETERS` to obtain the master organization of each item's organization.
2. `MTL_ITEM_CATEGORIES` is joined to the category set and category tables, and is included only when the template includes category columns.
3. `MTL_MFG_PART_NUMBERS` is joined on the master organization or the item, depending on whether the template includes manufacturer part numbers.
4. Many attribute values are resolved through `XXEN_UTIL.MEANING` lookups on the item's codes, and the remaining names through single-row scalar subqueries on their master tables.

### Parameters & Filtering
*   **Upload Mode:** Create creates new items only, Update changes existing items only, and Create, Update does both; an update download is included only when the mode contains the update action.
*   **Create Empty File:** When Yes, the update download is suppressed and an empty upload file is opened. Create mode always opens an empty file.
*   **Update on Create Null Handling:** Null Means Clear removes values from the matching columns, and Null Means No Change leaves them unchanged.
*   **Number of Item Import Workers:** Sets the number of parallel Item Import requests.
*   **Organization Code, Category Set, Category:** Restrict the downloaded items to an organization, category set or category value.
*   **Item, Item Like, Item Description, Item Type, Item Status:** Restrict the items by identifier, pattern, description, type or status.

### Performance & Optimization
*   The download is suppressed entirely when the create empty file flag is set or the mode excludes updates, so no item rows are read in those cases.
*   Category and manufacturer part joins are included only when the template requires them, using template flags substituted into the SQL.
*   Organizations are restricted by an `IN` subquery on `ORG_ACCESS_VIEW`, limiting the item scan to the responsibility's organizations.

### FAQ
**Q: How do I assign an item to a second category set?**
A: Repeat the Organization Code and Item Number on a separate row, and enter the new Category Set and Item Category on that row before uploading.

**Q: Why are master-controlled attributes of child items not taken from my spreadsheet?**
A: The Import API defaults them from the master organization for new child items, and copies them for existing ones.

**Q: How do I delete an item category assignment?**
A: Download the item, then set the Delete Category column to Yes on the row for the category set and category to remove; mandatory category sets cannot be deleted.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
