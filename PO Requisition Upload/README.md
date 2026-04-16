---
layout: default
title: 'PO Requisition Upload | Oracle EBS SQL Report'
description: 'Upload to create and update requisitions. In the generated Excel, the user can amend the following columns for an existing requisition. - Header…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Requisition, po_requisition_headers_all, po_requisition_lines_all, po_req_distributions_all'
permalink: /PO%20Requisition%20Upload/
---

# PO Requisition Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-requisition-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create and update requisitions.

In the generated Excel, the user can amend the following columns for an existing requisition.
-	Header Description
-	Quantity
-	Unit Price
-	Need By Date
-	Reference Number
-	Supplier Item
-	Buyer
-	Note To Buyer
-	Currency
-	Conversion Type
-	Conversion Rate
-	Conversion Date

Additionally, the user can create a requisition by entering the below required fields.
-	Line Type
-        Source Type
-        Item
-	Item Description
-	Category
-	Unit of Measure
-	Quantity
-	Need By Date
-	Destination Type
-	Deliver To Requestor
-	Destination Organization
-	Deliver To Location

## Report Parameters
Operating Unit, Upload Mode, Initiate Approval on Import, Requisition Type, Group By, Requisition Number From, Requisition Number To, Creation Date From, Creation Date To, Need By Date From, Need By Date To, Requestor Name, Buyer Name, Created By, Authorization Status

## Oracle EBS Tables Used
[po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [po_req_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_req_distributions_all), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_tasks_v](https://www.enginatics.com/library/?pg=1&find=pa_tasks_v), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [hr_locations_all_tl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_tl), [po_line_types_tl](https://www.enginatics.com/library/?pg=1&find=po_line_types_tl), [po_document_types_all_tl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_tl), [po_document_types_all_b](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_b), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Requisition Upload - Template without DFF columns 11-Mar-2024 143621 (1).xlsm](https://www.enginatics.com/example/po-requisition-upload/) |
| Blitz Report™ XML Import | [PO_Requisition_Upload.xml](https://www.enginatics.com/xml/po-requisition-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-requisition-upload/](https://www.enginatics.com/reports/po-requisition-upload/) |

## Case Study & Technical Analysis: PO Requisition Upload Report

### Executive Summary

The PO Requisition Upload is a powerful data management tool designed to streamline the creation and update of purchase requisitions within Oracle Purchasing. It enables departmental requestors and procurement teams to efficiently generate and modify a high volume of requisitions (including header, line, and distribution details) through a flexible Excel-based interface. This utility is essential for accelerating the procure-to-pay cycle, ensuring data accuracy and completeness, and reducing the manual effort associated with managing internal demand for goods and services.

### Business Challenge

The creation and maintenance of purchase requisitions are fundamental to initiating the procurement cycle. However, manual entry and updates, especially for organizations with frequent or high-volume purchasing needs, can be a significant operational challenge:

-   **Time-Consuming Manual Entry:** Manually creating numerous requisitions, along with their detailed lines (items, quantities, dates) and distributions (GL accounts, projects), through Oracle forms is a slow, repetitive, and resource-intensive process.
-   **High Risk of Data Entry Errors:** Typing errors in quantities, unit prices, GL coding, or delivery dates can lead to incorrect orders, financial discrepancies, and operational delays, requiring costly corrections.
-   **Inefficient Mass Updates:** Applying the same change (e.g., updating a delivery date across multiple requisitions, modifying a requester) to a large group of documents is extremely cumbersome without a mass-upload capability.
-   **Delayed Procurement Cycle:** The manual effort required for requisition entry can directly impact procurement processing timelines, leading to delays in obtaining goods or services and affecting operational continuity.

### The Solution

This Excel-based upload tool transforms the management of purchase requisitions, making it efficient, accurate, and scalable.

-   **Bulk Creation and Update:** It enables the mass creation of new requisitions and the efficient update of existing ones (including header descriptions, quantities, unit prices, need-by dates, and more) in a single operation, directly from a spreadsheet.
-   **Comprehensive Data Support:** The upload supports all critical requisition components: header details, line items (including item, category, UOM), and distribution details (GL accounts, projects, tasks, organizations).
-   **Improved Data Accuracy and Efficiency:** By allowing data preparation in Excel, users can leverage spreadsheet validation features before uploading, drastically reducing data entry errors and accelerating the requisition creation and maintenance processes.
-   **Flexible Approval Initiation:** The `Initiate Approval on Import` parameter allows organizations to choose whether requisitions are automatically submitted for approval upon successful upload, or held for manual review.

### Technical Architecture (High Level)

The upload process leverages Oracle Purchasing's standard APIs for requisition management, ensuring robust data validation and integrity.

-   **Primary Tables Involved:**
    -   `po_requisition_headers_all` (the central table for requisition headers).
    -   `po_requisition_lines_all` (for individual line items within a requisition).
    -   `po_req_distributions_all` (for account distribution details of requisition lines).
    -   `mtl_system_items_vl`, `mtl_categories_v`, `hr_all_organization_units_vl`, `per_all_people_f` (for validating master data).
    -   `po_lookup_codes`, `po_line_types_tl`, `po_document_types_all_tl` (for decoding various lookup values and document definitions).
-   **Logical Relationships:** The tool takes an Excel file, validates the requisition data against relevant master data tables, and then utilizes Oracle APIs (e.g., `PO_REQUISITION_INTERFACE_PUB.insert_requisition`) to perform the requested operations (insert, update) on the `po_requisition_headers_all`, `po_requisition_lines_all`, and `po_req_distributions_all` tables. The `Upload Mode` dictates whether new requisitions are created or existing ones are modified, and the `Initiate Approval on Import` flag controls the post-upload workflow.

### Parameters & Filtering

The upload parameters provide granular control over the data operation:

-   **Operating Unit:** Filters the upload to requisitions within a specific business unit or organizational context.
-   **Upload Mode:** The key parameter determining the action: 'Create' (for new requisitions) or 'Update' (for modifying existing ones).
-   **Initiate Approval on Import:** A critical operational parameter to control workflow initiation post-upload.
-   **Requisition Type & Grouping:** `Requisition Type` and `Group By` (e.g., by Item, Category) help define the nature and organization of the requisitions.
-   **Document Identification:** `Requisition Number From/To`, `Creation Date From/To`, `Need By Date From/To` allow for precise targeting of specific documents for download and update.
-   **Personnel Filters:** `Requestor Name`, `Buyer Name`, and `Created By` allow for filtering by relevant individuals.
-   **Authorization Status:** Allows for filtering by the current approval state of requisitions.

### Performance & Optimization

Using an API-based upload for bulk requisition management is inherently more efficient than manual entry.

-   **Bulk Processing via APIs:** The tool processes requisition headers, lines, and distributions in batches, leveraging Oracle's standard integration mechanisms (APIs) which are designed for high-volume, efficient data loading.
-   **API Validation:** By utilizing Oracle's own APIs, the tool benefits from built-in, efficient validation logic that ensures data integrity and prevents invalid entries from being committed to the system.
-   **Efficient Download for Update:** The ability to download existing requisition data based on extensive filters into the Excel template simplifies the update process by providing a clear starting point for modifications.

### FAQ

**1. What is the main benefit of using this upload tool over manual requisition entry?**
   The primary benefit is significantly increased efficiency and accuracy. For bulk creation or complex updates, manual entry is very time-consuming and error-prone. This tool automates the process, reduces errors, and ensures consistency, allowing requestors and procurement staff to save considerable time.

**2. Can I use this tool to create requisitions for both inventory and expense items?**
   Yes, the upload supports different `Line Type`s and `Destination Type`s, allowing you to create requisitions for various item types, including inventory items (typically destined for a specific inventory organization) and expense items (typically expensed directly to a GL account or project).

**3. What happens if an uploaded requisition fails validation?**
   If a requisition or a specific line/distribution fails validation (e.g., invalid item, incorrect GL account, missing required field), the Oracle API will typically reject that specific record, and the upload process will provide an error report detailing the reason for failure. You can then correct the data in your Excel file and re-upload the corrected records.


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
