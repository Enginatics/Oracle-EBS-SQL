---
layout: default
title: 'PO Requisition Template Upload | Oracle EBS SQL Report'
description: 'PO Requisition Template Upload ================================ The purpose of the PO Requisition Template Upload is to allow for: - the creation of new…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Requisition, Template, po_reqexpress_headers_all, po_reqexpress_lines_all, financials_system_params_all'
permalink: /PO%20Requisition%20Template%20Upload/
---

# PO Requisition Template Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-requisition-template-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PO Requisition Template Upload
================================

The purpose of the PO Requisition Template Upload is to allow for: 
- the creation of new Requisition Templates (Create Mode).
- the update of existing Requisition Templates (Update Mode). Update includes the update to existing template and template lines, the creation of new template lines against an existing template, and the deletion of template lines from an existing template.

As far as feasible, the upload provides the user with the same functionality available in the ‘Requisition Template’ Form. (Purchasing:  + Setup – Purchasing – Requisition Templates)

Upload Mode
============

The upload mode determines the actions the user is allowed to perform in the upload.

Create - the user may upload new Requisition Templates only.

Update - the user may update existing Requisition Templates only. This includes adding new and deleting existing template lines from the template.

Create and Update - the user can create new Requisition Templates and update existing Requisition Templates.


Parameters
==========

Upload Mode	(Required=Yes Default=Create) - See above.

The following optional parameters are only applicable in the 'Create and Update' and 'Update' modes, and can be used to restrict the template data downloaded for update:

- Operating Unit - the operating unit(s) the templates belong to.
- Template Type - the template type (Purchase Requisition, Internal Requisition).
- Template Name - the template name(s) to be downloaded.
- Template Name Contains - the user can restrict the download of existing templates where the Template Name contains the specified text (case insensitive).


## Report Parameters
Upload Mode, Operating Unit, Template Type, Template Name, Template Name Contains

## Oracle EBS Tables Used
[po_reqexpress_headers_all](https://www.enginatics.com/library/?pg=1&find=po_reqexpress_headers_all), [po_reqexpress_lines_all](https://www.enginatics.com/library/?pg=1&find=po_reqexpress_lines_all), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [po_line_types](https://www.enginatics.com/library/?pg=1&find=po_line_types), [po_document_types_all_tl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_tl), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [ap_supplier_contacts](https://www.enginatics.com/library/?pg=1&find=ap_supplier_contacts), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/po-requisition-template-upload/) |
| Blitz Report™ XML Import | [PO_Requisition_Template_Upload.xml](https://www.enginatics.com/xml/po-requisition-template-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-requisition-template-upload/](https://www.enginatics.com/reports/po-requisition-template-upload/) |

## Case Study & Technical Analysis: PO Requisition Template Upload Report

### Executive Summary

The PO Requisition Template Upload is a powerful master data management tool designed to streamline the creation, update, and maintenance of requisition templates within Oracle Purchasing. These templates are essential for standardizing and accelerating the creation of purchase and internal requisitions. This Excel-based utility empowers procurement administrators and departmental requestors to efficiently manage a high volume of template definitions and their associated lines, ensuring consistency in purchasing requests, reducing data entry errors, and improving overall procurement efficiency.

### Business Challenge

For frequently purchased items or common internal requests, requisition templates significantly speed up the requisition process. However, managing these templates in Oracle EBS can present several challenges:

-   **Time-Consuming Manual Setup:** Manually creating or updating numerous requisition templates and their many lines through Oracle forms is a slow, repetitive, and resource-intensive process, especially when establishing standard item lists for different departments.
-   **Ensuring Data Consistency:** Inconsistent template definitions can lead to variations in requisition data, causing errors in purchasing, delays in approvals, and discrepancies in inventory planning.
-   **Complex Updates and Maintenance:** Making changes to existing templates (e.g., updating an item price, adding a new item to a template, or deleting an obsolete line) can be cumbersome, particularly for templates with many lines or those used across multiple operating units.
-   **Lack of Centralized Control:** Without an efficient mass-upload tool, central procurement teams struggle to enforce standardized requisition practices across the organization by ensuring all templates are up-to-date and consistent.

### The Solution

This comprehensive Excel-based upload tool transforms the management of requisition templates, making it efficient, accurate, and scalable.

-   **Bulk Creation and Update:** It enables the mass creation of new requisition templates and the efficient update of existing templates (including adding or deleting template lines) in a single operation, directly from a spreadsheet.
-   **Replicates Form Functionality:** The upload provides similar functionality to Oracle's standard 'Requisition Template' form, ensuring that all underlying business rules and validations are respected during the upload process.
-   **Improved Data Accuracy and Efficiency:** By allowing data preparation in Excel, users can leverage spreadsheet validation features before uploading, drastically reducing data entry errors and accelerating template maintenance processes.
-   **Supports Standardization:** The tool is crucial for organizations looking to standardize their purchasing processes. By making it easy to create and maintain robust templates, it encourages users to leverage these templates, leading to more consistent and accurate requisitions.

### Technical Architecture (High Level)

The upload process leverages Oracle Purchasing's standard APIs for requisition template management, ensuring robust data validation and integrity.

-   **Primary Tables Involved:**
    -   `po_reqexpress_headers_all` (the central table for requisition template headers).
    -   `po_reqexpress_lines_all` (for individual line items within a requisition template).
    -   `po_document_types_all_tl` (for document type names, e.g., Purchase Requisition, Internal Requisition).
    -   `mtl_system_items_vl`, `mtl_categories_kfv`, `mtl_units_of_measure_vl` (for validating item, category, and UOM master data).
    -   `ap_suppliers`, `ap_supplier_sites_all` (for supplier details on templates).
-   **Logical Relationships:** The tool takes an Excel file, validates the template and line data against relevant master data tables, and then utilizes Oracle APIs to perform the requested operations (insert, update, delete lines) on the `po_reqexpress_headers_all` and `po_reqexpress_lines_all` tables. The `Upload Mode` dictates whether new templates are created or existing ones are modified.

### Parameters & Filtering

The upload parameters provide granular control over the data operation:

-   **Upload Mode:** The key parameter determining the action: 'Create' (for new templates), 'Update' (for modifying existing ones), or 'Create and Update' (for mixed operations).
-   **Organizational Context:** `Operating Unit` filters the upload to templates within a specific business unit.
-   **Template Identification:** `Template Type` (e.g., Purchase Requisition, Internal Requisition), `Template Name`, and `Template Name Contains` allow for precise targeting of specific templates for download and update.

### Performance & Optimization

Using an API-based upload for bulk requisition template management is inherently more efficient than manual entry.

-   **Bulk Processing via APIs:** The tool processes template headers and lines in batches, leveraging Oracle's standard integration mechanisms (APIs) which are designed for high-volume, efficient master data loading.
-   **API Validation:** By utilizing Oracle's own APIs, the tool benefits from built-in, efficient validation logic that ensures data integrity and prevents invalid entries from being committed to the system.
-   **Efficient Download for Update:** The ability to download existing template data based on extensive filters into the Excel template simplifies the update process by providing a clear starting point for modifications.

### FAQ

**1. What is a 'Requisition Template' and how does it benefit the procurement process?**
   A 'Requisition Template' is a predefined set of items, services, or descriptions that can be quickly added to a purchase requisition. It benefits the process by standardizing common requests, reducing manual data entry, minimizing errors, and accelerating the creation of requisitions.

**2. Can this tool be used to update the supplier on a template line?**
   Yes, if the supplier information is part of the template line definition, this upload tool, when in 'Update' mode, would allow you to modify the supplier details for existing template lines. This is crucial for managing preferred suppliers for templated items.

**3. What happens if I try to delete a template line, but it's still referenced elsewhere?**
   Oracle's underlying APIs will typically prevent the deletion of a template line if it has dependent records or if system constraints prohibit it. The upload process would provide an error message, indicating that the deletion could not be completed, consistent with standard Oracle data integrity rules.


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
