---
layout: default
last_modified_at: 2026-10-26
title: 'PO Approved Supplier List Upload | Oracle EBS SQL Report'
description: 'This upload supports the creation and update of Approved Supplier Lists (ASL) in Oracle Purchasing. The upload supports creation/update/deletion of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Approved, Supplier, List, mtl_categories_tl, po_approved_supplier_list, mtl_manufacturers'
permalink: /PO%20Approved%20Supplier%20List%20Upload/
report_name: 'PO Approved Supplier List Upload'
report_web_name: po-approved-supplier-list-upload
---

# PO Approved Supplier List Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-approved-supplier-list-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload).

## Overview
This upload supports the creation and update of Approved Supplier Lists (ASL) in Oracle Purchasing.

The upload supports creation/update/deletion of the following Approved Supplier List entities:
- Approved Supplier Lists (Global and Local)
- Approved Supplier List Attributes. Including Local (Using Organization specific) attributes against a global ASL.
- Source Documents
- Authorizations
- Supplier Capacities
- Supplier Tolerances

Notes:
- You cannot delete Manufacturer ASLs using this upload. There is a restriction in the standard Oracle API used by this upload that prevents this.

- When the ASL attributes for the same Item/Commodity, Supplier, Supplier Site, and Using Organization are repeated in the upload excel, then first row flagged for upload will be used to apply the attribute updates. The attributes on subsequent rows are ignored. 

- The following points are only significant if you define Local Attributes for a Using Organization against a Global ASL:
  Source Documents are associated with the Using Organization of the ASL Attributes 
  Authorizations, Supplier Capacities and Supplier Tolerances are always associated with the Using Organization of the ASL
  
  If you delete a Local ASL defined for a specific using organization against a Global ASL, only the local using organization attributes will be deleted.
  The Global ASL will not be deleted. 

- When downloading existing ASL data into the upload excel, Source Documents, Authorizations, Capacities, and Tolerances are downloaded into separate rows in the excel.
This is to minimize the duplication of data in the excel. However, when entering data for upload Source Documents, Authorizations, Capacities, and Tolerances can be added in the same excel row.
i.e. You can upload an excel row containing a Source Document, Authorization, Capacity, and Tolerance.

- Capacity Entries with a capacity from/to date in the past cannot be updated by this upload due to validations applied in the standard Oracle API used by the upload. It is possible to delete a capacity entry with a capacity from date in the past, but only if the capacity to date is either null or later than the current date.

- By default, Authorizations, Supplier Capacities, and Supplier Tolerances are not included in the downloaded data. The following report parameters may be Yes in order to include these in the download:
  Download Authorizations
  Download Capacities
  Download Tolerances

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Owning Organization Code, Type, Item, Item From, Item To, Commodity, Commodity From, Commodity To, Global ASL, Using Organization Code, Missing Release Method, Business Type, Operating Unit, Supplier, Supplier Number, Supplier Site, Manufacturer, ASL Status, ASL Disabled, Source Document, Download Authorizations, Download Capacities, Download Tolerances

## Oracle EBS Tables Used
[mtl_categories_tl](https://www.enginatics.com/library/?pg=1&find=mtl_categories_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_approved_supplier_list](https://www.enginatics.com/library/?pg=1&find=po_approved_supplier_list&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [mtl_manufacturers](https://www.enginatics.com/library/?pg=1&find=mtl_manufacturers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_asl_statuses](https://www.enginatics.com/library/?pg=1&find=po_asl_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [chv_bucket_patterns](https://www.enginatics.com/library/?pg=1&find=chv_bucket_patterns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_asl_attributes](https://www.enginatics.com/library/?pg=1&find=po_asl_attributes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_asl_documents](https://www.enginatics.com/library/?pg=1&find=po_asl_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [ap_supplier_sites](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [chv_authorizations](https://www.enginatics.com/library/?pg=1&find=chv_authorizations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_supplier_item_capacity](https://www.enginatics.com/library/?pg=1&find=po_supplier_item_capacity&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [po_supplier_item_tolerance](https://www.enginatics.com/library/?pg=1&find=po_supplier_item_tolerance&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)

## Related Reports
[PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [PO Printed Planning Schedule](/PO%20Printed%20Planning%20Schedule/ "PO Printed Planning Schedule Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approved%20Supplier%20List%20Upload/PO%20Approved%20Supplier%20List%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/po-approved-supplier-list-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload) |
| Blitz Report™ XML Import | [PO_Approved_Supplier_List_Upload.xml](https://www.enginatics.com/xml/po-approved-supplier-list-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload) |
| SQL Source | [PO Approved Supplier List Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approved%20Supplier%20List%20Upload/PO%20Approved%20Supplier%20List%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-approved-supplier-list-upload/](https://www.enginatics.com/reports/po-approved-supplier-list-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload) |

## Case Study & Technical Analysis: PO Approved Supplier List Upload Report

### Executive Summary

The PO Approved Supplier List (ASL) Upload is a powerful data management tool designed to streamline the creation, update, and deletion of Approved Supplier List entries within Oracle Purchasing. It offers comprehensive functionality to manage not only the core ASL records but also associated attributes like source documents, authorizations, supplier capacities, and tolerances, for both global and local ASLs. This Excel-based utility is essential for procurement organizations to efficiently maintain master sourcing data, enforce purchasing policies, optimize supplier relationships, and ensure the accuracy and integrity of their supply chain information.

### Business Challenge

Maintaining an accurate and up-to-date Approved Supplier List is a cornerstone of effective procurement, but it can be a highly complex and resource-intensive task in Oracle EBS:

-   **High Volume Data Entry:** For organizations with numerous items, suppliers, and sourcing rules, manually creating or updating ASL entries and their many associated attributes (e.g., lead times, quality certifications, capacity details) is a slow, repetitive, and error-prone process.
-   **Ensuring Data Consistency:** Inconsistent ASL data can lead to buyers using unauthorized suppliers, incorrect sourcing rules being applied, or inaccurate supplier performance metrics, all of which negatively impact procurement efficiency and compliance.
-   **Managing Complex Attributes:** The ASL can hold a wealth of information, including source documents (like Blanket Purchase Agreements), quality authorizations, supplier capacity constraints, and delivery tolerances. Managing these granular attributes through standard forms is cumbersome.
-   **Impact on Planning and Sourcing:** Outdated or inaccurate ASL data directly affects supply chain planning (e.g., material planning based on incorrect lead times) and strategic sourcing decisions.

### The Solution

This comprehensive Excel-based upload tool transforms the management of the Approved Supplier List, making it efficient, accurate, and scalable.

-   **Bulk Creation, Update, and Deletion:** It enables the mass creation of new ASL entries, efficient updates to existing records, and targeted deletions (with specific limitations) for various ASL components in a single operation from a spreadsheet.
-   **Integrated Attribute Management:** The upload supports all key ASL entities: core entries, attributes, source documents, authorizations, supplier capacities, and tolerances, providing a holistic management solution.
-   **Supports Global and Local ASLs:** The tool differentiates between global ASLs and local (Using Organization-specific) attributes, providing flexibility for centralized sourcing strategies and decentralized operational needs.
-   **Improved Data Accuracy and Efficiency:** By allowing data preparation in Excel, users can leverage spreadsheet validation features before uploading, drastically reducing data entry errors and accelerating ASL maintenance processes.

### Technical Architecture (High Level)

The upload process leverages Oracle Purchasing's standard APIs for ASL management, ensuring robust data validation and integrity.

-   **Primary Tables Involved:**
    -   `po_approved_supplier_list` (the central table for ASL entries).
    -   `po_asl_attributes` (stores item/category-specific attributes for ASL entries).
    -   `po_asl_documents` (links ASL entries to source documents like BPAs).
    -   `chv_authorizations` (for supplier authorizations).
    -   `po_supplier_item_capacity` and `po_supplier_item_tolerance` (for supplier-item specific capacity and tolerance details).
    -   `mtl_system_items_vl`, `mtl_categories_b_kfv`, `ap_suppliers`, `ap_supplier_sites` (for validating master data).
-   **Logical Relationships:** The tool takes an Excel file, validates the data against relevant master data tables, and then utilizes Oracle APIs to perform the requested operations (insert, update, delete) on the `po_approved_supplier_list` and its child tables. The complex logic for handling global vs. local ASL attributes and the specific update/deletion rules (e.g., for capacities) are handled by the underlying Oracle APIs.

### Parameters & Filtering

The upload report offers extensive parameters for precise control over the data operation:

-   **Upload Mode:** The key parameter determining the action: 'Create', 'Update', or 'Delete' (implicitly via 'Create, Update' mode for lines).
-   **ASL Identification:** `Owning Organization Code`, `Type` (Item/Category), `Item`, `Commodity`, `Supplier`, `Supplier Number`, `Supplier Site`, `Manufacturer` allow for precise targeting of ASL entries.
-   **Global/Local Control:** `Global ASL` and `Using Organization Code` manage the scope of the ASL.
-   **Download Options:** `Download Authorizations`, `Download Capacities`, `Download Tolerances` are crucial for populating the Excel template with existing data before making updates.

### Performance & Optimization

Using an API-based upload for complex ASL data is significantly more efficient than manual entry.

-   **Bulk Processing via APIs:** The tool processes ASL entries and their attributes in batches, leveraging Oracle's standard integration mechanisms (APIs) which are designed for high-volume, efficient data loading, particularly for master data.
-   **Error Reporting and Specific Limitations:** The tool provides detailed error messages for invalid records. The `README.md` explicitly calls out specific API limitations (e.g., cannot delete Manufacturer ASLs, restrictions on updating past capacity entries), which are important for users to understand to ensure successful uploads.
-   **Efficient Download for Update:** The ability to download existing ASL data with specific attributes (authorizations, capacities, tolerances) into separate rows simplifies the update process by providing a clear starting point for modifications.

### FAQ

**1. What is the main benefit of using this upload tool over manual ASL entry?**
   The primary benefit is efficiency and accuracy. For high volumes of ASL data, manual entry is time-consuming and error-prone. This tool automates the process, reduces errors, and ensures consistency, freeing up procurement staff for more strategic tasks.

**2. Can I use this tool to remove a supplier from the Approved Supplier List?**
   Yes, the tool supports deleting ASL entries (with the noted exception of Manufacturer ASLs). You would typically download the existing ASL data, mark the line(s) for deletion, and then re-upload. For a local ASL against a Global ASL, only the local attributes will be deleted, leaving the global ASL intact.

**3. How does the system handle the update of supplier capacity entries for past dates?**
   As per the `README.md`, capacity entries with a `capacity from/to date` in the past cannot be *updated* by this upload due to standard Oracle API validations. However, it is possible to *delete* a past capacity entry if its `capacity to date` is null or in the future. This highlights the importance of real-time data maintenance.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approved-supplier-list-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
