---
layout: default
last_modified_at: 2026-10-16
title: 'INV Physical Inventory Tag Count Upload | Oracle EBS SQL Report'
description: 'INV Physical Inventory Tag Count Upload ================================= This upload enables the user to upload counts against the Physical Inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Physical, Inventory, Tag, mtl_physical_subinventories, gl_code_combinations_kfv, per_all_people_f'
permalink: /INV%20Physical%20Inventory%20Tag%20Count%20Upload/
report_name: 'INV Physical Inventory Tag Count Upload'
report_web_name: inv-physical-inventory-tag-count-upload
---

# INV Physical Inventory Tag Count Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-tag-count-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload).

## Overview
INV Physical Inventory Tag Count Upload
=================================
This upload enables the user to upload counts against the Physical Inventory Tags defined against the specified Physical Inventory.

The upload supports
- the update of counts against existing Tags
- the generation of new tags.
  For clients on R12.2.14 or later, creation of manually entered tag numbers is supported 
  For clients on earlier releases, to generate a new tag leave the tag number blank. The tag number will be automatically generated when the tag is created

For clients on R12.2.3 or later
- the upload also supports the voiding/unvoiding of existing tags as well

Note:
There is currently a bug in the R12.2.3+ API that will reject the creation/update of tags for items which do not require Locators in Subinvnetories where the Locator Control is set to 'Check Item Level'. The API is only checking the Locator control level at the subinventory level, and if it is not set to 'Locators not required' will reject any tags for items where no locator is specified. For this reason, if the physical inventory being uploaded includes any subinventories with Locator Control set to 'Check Item Level', the upload will revert to using the older API.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Physical Inventory, Counted By, Subinventory, Category Set, Category From, Category To, Item, Item From, Item To, Item Type, Locator, Locator From, Locator To, Tag Number From, Tag Number To, Void Status

## Oracle EBS Tables Used
[mtl_physical_subinventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_subinventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_physical_inventories_v](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_physical_inventory_tags](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventory_tags&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_physical_adjustments](https://www.enginatics.com/library/?pg=1&find=mtl_physical_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Tag%20Count%20Upload/INV%20Physical%20Inventory%20Tag%20Count%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-physical-inventory-tag-count-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload) |
| Blitz Report™ XML Import | [INV_Physical_Inventory_Tag_Count_Upload.xml](https://www.enginatics.com/xml/inv-physical-inventory-tag-count-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload) |
| SQL Source | [INV Physical Inventory Tag Count Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Tag%20Count%20Upload/INV%20Physical%20Inventory%20Tag%20Count%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-tag-count-upload/](https://www.enginatics.com/reports/inv-physical-inventory-tag-count-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload) |

## INV Physical Inventory Tag Count Upload - Case Study & Technical Analysis

### Executive Summary
The **INV Physical Inventory Tag Count Upload** is a productivity tool that replaces manual data entry. In a typical physical inventory, thousands of tags are written by hand and then manually keyed into Oracle. This tool allows the counts to be entered into Excel (or captured via scanners into Excel) and then uploaded in bulk.

### Business Challenge
Manual data entry of tag counts is:
-   **Slow:** Typing thousands of numbers takes days.
-   **Error-Prone:** Typographical errors (e.g., entering 100 instead of 10) lead to false variances.
-   **Resource Intensive:** Requires a team of data entry clerks during the critical count weekend.

### Solution
The **INV Physical Inventory Tag Count Upload** streamlines the process. Counters can record data electronically, or data entry clerks can type into a spreadsheet (which is faster than the Oracle Forms UI). The sheet is then uploaded directly to the database.

**Key Features:**
-   **Bulk Entry:** Upload thousands of counts in seconds.
-   **Validation:** Checks for valid Item, Subinventory, Locator, and Lot numbers during upload.
-   **New Tag Creation:** Can create "Dynamic Tags" for items found in locations where they weren't expected.
-   **Void/Unvoid:** Supports voiding tags that were not used.

### Technical Architecture
The tool uses an API or interface table approach to insert data into the physical inventory tag tables.

#### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORY_TAGS`**: The table where the counts are stored.
-   **`MTL_PHYSICAL_INVENTORIES`**: The parent inventory record.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item validation.
-   **`MTL_ITEM_LOCATIONS_KFV`**: Locator validation.

#### Core Logic
1.  **Data Parsing:** Reads the Excel rows containing Tag Number, Quantity, and Attributes.
2.  **Validation:** Verifies that the tag belongs to the specified physical inventory.
3.  **Update/Insert:** Updates the count on existing tags or inserts new tags if they don't exist (and dynamic tags are allowed).

### Business Impact
-   **Speed:** Reduces the "Data Entry" phase of the physical inventory from days to minutes.
-   **Accuracy:** Eliminates transcription errors if data is captured via barcode scanners into Excel.
-   **Cost Savings:** Reduces overtime costs for data entry staff.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-tag-count-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
