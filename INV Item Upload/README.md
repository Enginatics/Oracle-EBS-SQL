---
layout: default
title: 'INV Item Upload | Oracle EBS SQL Report'
description: 'INV Inventory Item Upload ====================== This upload can be used to create and update Inventory Items. It supports creation of Inventory Items: -…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Item, mtl_item_catalog_groups_b_kfv, mtl_item_status, mtl_units_of_measure_tl'
permalink: /INV%20Item%20Upload/
---

# INV Item Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
INV Inventory Item Upload
======================
This upload can be used to create and update Inventory Items.

It supports creation of Inventory Items:
- by manually entering the Item details.
- from the same item in the Master Organization (equivalent to Assigning the item to a child organization)
- from an item template (Copy from Template)
- from an existing item in the same Organization (Copy from Item)

It supports update of existing Inventory Items either by:
- update the details of an existing inventory items by downloading the items to be updated. Use the report parameters to select and download the items to be updated.
- pasting the details of the items to be updated into an empty upload excel.

It also supports the item category assignment to multiple Inventory Category Sets
-  to assign an item to another category set, repeat the Organization Code and Item Number on a separate row in the excel and add the details of the additional category set and item category to which the item is to be assigned.
- for child organizations, only the category sets controlled at the organization level can be selected.   

Upload Mode parameter:
Create - allows creation of new items only
Update - allows updates to existing items only
Create, Update – allows the creation of new items and the updating of existing items

Create Empty File parameter
Setting the Create Empty File parameter to Yes will open an empty upload excel. 
This parameter is only applicable to the 'Update' and 'Create, Update' upload modes and suppresses the download of existing item details. ‘Create’ upload mode always opens an empty upload excel regardless of the setting of this parameter.
This is useful for users who want to paste the details of the items to be updated into an empty upload excel file from another source.

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


## Report Parameters
Upload Mode, Create Empty File, Number of Item Import Workers, Organization Code, Category Set, Category, Item, Item Like, Item Description, Item Type, Item Status, BOM Item Type, Contract Item Type, Make or Buy, Buyer, Planner, Manufacturer, Inventory Planning Method, Last Update Date From, Last Update Date To, Last Updated By, Creation Date From, Creation Date To, Created By, Cross Reference Type, Cross Reference

## Oracle EBS Tables Used
[mtl_item_catalog_groups_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_catalog_groups_b_kfv), [mtl_item_status](https://www.enginatics.com/library/?pg=1&find=mtl_item_status), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl), [mtl_actions](https://www.enginatics.com/library/?pg=1&find=mtl_actions), [mtl_grades](https://www.enginatics.com/library/?pg=1&find=mtl_grades), [mtl_material_statuses](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [po_un_numbers](https://www.enginatics.com/library/?pg=1&find=po_un_numbers), [po_hazard_classes](https://www.enginatics.com/library/?pg=1&find=po_hazard_classes), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-item-upload/) |
| Blitz Report™ XML Import | [INV_Item_Upload.xml](https://www.enginatics.com/xml/inv-item-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-upload/](https://www.enginatics.com/reports/inv-item-upload/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
