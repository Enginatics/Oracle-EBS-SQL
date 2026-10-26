---
layout: default
last_modified_at: 2026-10-26
title: 'INV Item Upload | Oracle EBS SQL Report'
description: 'INV Inventory Item Upload ====================== This upload can be used to create and update Inventory Items. It supports creation of Inventory Items: …'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Item, mtl_item_catalog_groups_b_kfv, mtl_item_status, mtl_units_of_measure_tl'
permalink: /INV%20Item%20Upload/
report_name: 'INV Item Upload'
report_web_name: inv-item-upload
---

# INV Item Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload).

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

Additionally
- supports creation and update of item revisions
- supports manufacturer part numbers, ABC classes, catalog elements and translations

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Create Empty File, Update on Create Null Handling, Number of Item Import Workers, Organization Code, Category Set, Category, Category Set 2, Category 2, Item, Item Like, Item Description, Item Type, Item Status, BOM Item Type, Contract Item Type, Make or Buy, Buyer, Planner, Manufacturer, Inventory Planning Method, Cross Reference Type, Cross Reference, Revision Effective Date, Last Update Date From, Last Update Date To, Last Updated By, Creation Date From, Creation Date To, Created By

## Oracle EBS Tables Used
[mtl_item_catalog_groups_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_catalog_groups_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_item_status](https://www.enginatics.com/library/?pg=1&find=mtl_item_status&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_actions](https://www.enginatics.com/library/?pg=1&find=mtl_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_grades](https://www.enginatics.com/library/?pg=1&find=mtl_grades&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_material_statuses](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [po_un_numbers](https://www.enginatics.com/library/?pg=1&find=po_un_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [po_hazard_classes](https://www.enginatics.com/library/?pg=1&find=po_hazard_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_atp_rules](https://www.enginatics.com/library/?pg=1&find=mtl_atp_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [wms_rules_vl](https://www.enginatics.com/library/?pg=1&find=wms_rules_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [MTL_UOM_CONVERSIONS](https://www.enginatics.com/library/?pg=1&find=MTL_UOM_CONVERSIONS&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [oks_coverage_templts_v](https://www.enginatics.com/library/?pg=1&find=oks_coverage_templts_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_manufacturers](https://www.enginatics.com/library/?pg=1&find=mtl_manufacturers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_mfg_part_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_mfg_part_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_item_revisions_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_abc_assignments](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_abc_assignment_groups](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignment_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_descr_element_values](https://www.enginatics.com/library/?pg=1&find=mtl_descr_element_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [mtl_system_items_tl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Upload/INV%20Item%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-item-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload) |
| Blitz Report™ XML Import | [INV_Item_Upload.xml](https://www.enginatics.com/xml/inv-item-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload) |
| SQL Source | [INV Item Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Upload/INV%20Item%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-upload/](https://www.enginatics.com/reports/inv-item-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload) |

## Case Study & Technical Analysis: INV Item Upload

### Executive Summary

The INV Item Upload tool is a comprehensive and flexible solution for managing the entire lifecycle of an inventory item master in Oracle E-Business Suite. It provides robust functionality for mass creation, update, and assignment of items, supporting various methods including creation from templates, copying from existing items, or assigning master items to child organizations. This tool is indispensable for any organization looking to streamline item master data management, ensure data integrity, and significantly reduce the manual effort associated with item setup and maintenance.

### Business Challenge

The item master is the cornerstone of any supply chain and financial system, yet its management in a standard Oracle EBS environment is fraught with challenges:

-   **Inefficient Mass Creation:** Creating hundreds or thousands of new items for a new product line or data migration using the standard Oracle forms is prohibitively slow and requires immense manual effort.
-   **Inconsistent Data Entry:** Manual item creation often leads to inconsistent attribute settings, which can cause downstream problems in planning, purchasing, costing, and sales.
-   **Difficult Mass Updates:** Performing mass updates, such as changing the planner code, buyer, or a key attribute for a whole product family, is complex and often requires custom development or risky direct data manipulation.
-   **Complex Category Management:** Assigning a single item to multiple category sets is a tedious, repetitive task through the user interface.

### The Solution

The INV Item Upload tool provides a powerful, Excel-based interface to solve these challenges, bringing efficiency, control, and accuracy to item master management.

-   **Versatile Item Creation:** The tool supports multiple methods for item creation, allowing users to copy from an existing item, apply a pre-defined template, or assign a master organization item to a child organization, which drastically speeds up the process and ensures consistency.
-   **Streamlined Mass Updates:** Users can download existing items based on a wide range of filter criteria, make the necessary changes in Excel, and then upload the modifications. This "download-modify-upload" workflow is ideal for mass data corrections and updates.
-   **Multi-Category Assignment:** The tool simplifies the process of assigning items to multiple category sets by allowing these assignments to be specified as separate rows in the upload spreadsheet.
-   **High-Performance Loading:** By utilizing the underlying Oracle Item Import concurrent program and allowing for parallel workers, the tool can process very large volumes of data in a fraction of the time required for manual entry.

### Technical Architecture (High Level)

The tool leverages Oracle's standard and robust Item Import process to ensure data integrity and full validation.

-   **Primary Tables Involved:**
    -   The upload process populates Oracle's standard interface tables: `mtl_system_items_interface`, `mtl_item_revisions_interface`, and `mtl_item_categories_interface`.
    -   It then launches the standard "Item Import" concurrent program to validate and process the data from the interface tables into the base item master tables like `mtl_system_items_b`.
-   **Logical Relationships:** The tool acts as a user-friendly front-end to the powerful back-end Oracle Item Import engine. It validates data and then passes it to the interface tables. The Item Import program then applies Oracle's own business logic to create or update the items, ensuring all required attributes and relationships are correctly handled.

### Parameters & Filtering

The tool provides a rich set of parameters for precise control over the upload and download process:

-   **Upload Mode:** Controls whether the operation is for creating new items, updating existing ones, or both.
-   **Create Empty File:** Allows users to start with a blank template for pasting in data, rather than downloading existing items first.
-   **Number of Item Import Workers:** A critical performance parameter that specifies how many parallel concurrent requests should be run to process the data, enabling high-throughput uploads.
-   **Filtering Criteria:** A wide range of parameters (Item Status, Buyer, Planner, etc.) allow for precise selection of items to be downloaded for updates.

### Performance & Optimization

The design of this tool incorporates key features for high-performance data loading:

-   **Parallel Processing:** The "Number of Item Import Workers" parameter is the most significant optimization feature. By allowing the import process to be split across multiple parallel workers, the tool can handle massive data volumes much more quickly than a single-threaded process.
-   **Bulk Processing:** Instead of the one-at-a-time processing of the user interface, this tool loads data in bulk via the efficient Item Import interface.

### FAQ

**1. How are errors handled during the upload?**
   Since the tool uses the standard Oracle Item Import process, any records that fail validation will be left in the interface tables with an error status. Users can then run the standard "Item Import Error" reports to view the specific reason for failure for each rejected row, correct the data in their spreadsheet, and re-upload.

**2. When creating a child organization item, what happens if I provide a value for a master-controlled attribute?**
   As noted in the description, the upload process correctly gives precedence to the master organization's value for master-controlled attributes. Any value for such an attribute in the upload file for a child item will be ignored, ensuring data integrity between master and child organizations.

**3. Can I use this upload to add a new revision to an existing item?**
   Yes, the underlying Item Import process supports the creation of new item revisions. By providing the item number and the new revision number in the upload template, you can mass-create new revisions for multiple items at once.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
