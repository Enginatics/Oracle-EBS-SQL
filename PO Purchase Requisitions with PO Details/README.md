---
layout: default
title: 'PO Purchase Requisitions with PO Details | Oracle EBS SQL Report'
description: 'Purchase Requisitions Status with PO Details Report – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, Purchase, Requisitions, Details, mtl_categories_kfv, mtl_item_status_vl, mtl_parameters'
permalink: /PO%20Purchase%20Requisitions%20with%20PO%20Details/
---

# PO Purchase Requisitions with PO Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-purchase-requisitions-with-po-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Purchase Requisitions Status with PO Details Report

## Report Parameters
Report Level, Ledger, Operating Unit, Requisition Number, Creation Date From, Creation Date To, Need By Date From, Need By Date To, Converted To PO Date From, Converted To PO Date To, Destination Organization, Deliver To Location, Requestor Name, Preparer Name, Created By, Exclude Fully Delivered, Show Cancelled, Category Set 1, Category Set 2, Category Set 3, Show Item DFF Attributes, Show Requisition DFF Attributes, Show PO DFF Attributes, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To

## Oracle EBS Tables Used
[mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [&req_dist_tables](https://www.enginatics.com/library/?pg=1&find=&req_dist_tables), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [po_action_history](https://www.enginatics.com/library/?pg=1&find=po_action_history), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [&po_dist_tables](https://www.enginatics.com/library/?pg=1&find=&po_dist_tables), [po_line_types_v](https://www.enginatics.com/library/?pg=1&find=po_line_types_v), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [req](https://www.enginatics.com/library/?pg=1&find=req), [po](https://www.enginatics.com/library/?pg=1&find=po)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Purchase Requisitions with PO Details 23-Aug-2021 014326.xlsx](https://www.enginatics.com/example/po-purchase-requisitions-with-po-details/) |
| Blitz Report™ XML Import | [PO_Purchase_Requisitions_with_PO_Details.xml](https://www.enginatics.com/xml/po-purchase-requisitions-with-po-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-purchase-requisitions-with-po-details/](https://www.enginatics.com/reports/po-purchase-requisitions-with-po-details/) |

## Case Study & Technical Analysis: PO Purchase Requisitions with PO Details Report

### Executive Summary

The PO Purchase Requisitions with PO Details report is a crucial procure-to-pay visibility and analysis tool within Oracle E-Business Suite Purchasing. It provides a consolidated view that links purchase requisitions (PRs) with their corresponding purchase orders (POs), offering detailed status information and a comprehensive overview of the requisition-to-PO lifecycle. This report is indispensable for procurement managers, buyers, and departmental requestors to track demand fulfillment, monitor conversion rates, identify bottlenecks in the purchasing process, and ensure that internal requests are being addressed effectively by external procurement.

### Business Challenge

The process of converting an internal demand (requisition) into an external supply order (purchase order) involves multiple steps and different departments. Organizations frequently face significant challenges in tracking this critical linkage:

-   **Lack of End-to-End Visibility:** It's difficult to get a single, consolidated view that clearly shows a requisition, whether it has been converted into a PO, and the details of that PO (e.g., supplier, PO number, status, delivery information).
-   **Monitoring Conversion Rates:** Understanding how many requisitions are being converted into POs, and how quickly, is crucial for assessing procurement efficiency, but this metric is hard to track without a dedicated report.
-   **Identifying Bottlenecks:** Delays in converting requisitions to POs can impact project timelines and operational continuity. Pinpointing where these delays occur (e.g., requisition awaiting approval, PO stuck in creation) is challenging without integrated data.
-   **Reconciliation and Audit:** For audit purposes, it's essential to link a purchase request to its ultimate external purchase order. Manual reconciliation across different screens is time-consuming and prone to errors.

### The Solution

This report offers a flexible, consolidated, and actionable solution for managing the requisition-to-PO lifecycle, enhancing transparency and efficiency in procurement.

-   **Unified Requisition-to-PO View:** It seamlessly links purchase requisitions (headers and lines) with their associated purchase orders (headers, lines, and schedules), providing a complete end-to-end view of the procurement process.
-   **Status Tracking and Conversion Metrics:** The report clearly shows the status of requisitions (e.g., 'Approved', 'Purchased') and provides key details about the linked PO, including its number, supplier, and creation date, allowing for monitoring of conversion progress.
-   **Flexible Reporting Levels:** The "Report Level" parameter allows users to view data at a summary level (Requisition Header) or drill down to granular detail (Requisition Line), while the "Exclude Fully Delivered" and "Show Cancelled" flags provide precise control over the data population.
-   **Enhanced Audit and Troubleshooting:** By consolidating all relevant data, the report simplifies the process of auditing procurement transactions and troubleshooting issues related to delayed PO creation or requisition fulfillment.

### Technical Architecture (High Level)

The report queries core Oracle Purchasing tables to link requisitions with their corresponding purchase orders.

-   **Primary Tables Involved:**
    -   `po_requisition_headers_all` and `po_requisition_lines_all` (for requisition details).
    -   `po_headers_all`, `po_lines_all`, and `po_line_locations_all` (for purchase order details and schedules).
    -   `mtl_system_items_vl` and `mtl_categories_kfv` (for item and category context).
    -   `per_all_people_f` (for requestor and preparer names).
    -   `ap_suppliers` and `ap_supplier_sites_all` (for supplier information).
-   **Logical Relationships:** The report establishes a critical link between `po_requisition_lines_all` and `po_line_locations_all` (the PO schedule table), typically via `requisition_line_id`. This linkage identifies which PO line schedule was created from which requisition line. It then joins to header tables for both requisitions and POs, and to various other tables to provide comprehensive contextual details, status information, and DFF attributes.

### Parameters & Filtering

The report offers an extensive set of parameters for precise filtering and detailed data inclusion:

-   **Report Level:** Crucial for selecting data granularity: 'Header' for summary or 'Line' for detailed requisition lines.
-   **Organizational Context:** `Ledger`, `Operating Unit`, `Destination Organization`, and `Deliver To Location` provide comprehensive filtering.
-   **Date Ranges:** `Creation Date From/To`, `Need By Date From/To`, and `Converted To PO Date From/To` are essential for time-based analysis of requisition-to-PO conversion.
-   **Status Filters:** `Exclude Fully Delivered` and `Show Cancelled` allow users to focus on open or problematic requisitions.
-   **Personnel Filters:** `Requestor Name` and `Preparer Name` enable analysis by employee.
-   **DFF Inclusion Flags:** `Show Item DFF Attributes`, `Show Requisition DFF Attributes`, and `Show PO DFF Attributes` allow for dynamic inclusion of client-specific custom data.

### Performance & Optimization

As a transactional report linking data across procurement documents, it is optimized through strong filtering and efficient joining strategies.

-   **Parameter-Driven Efficiency:** The use of specific `Requisition Number` and various `Date From/To` ranges is critical for performance, allowing the database to efficiently narrow down the large transactional datasets.
-   **Report Level and Exclusion Filters:** The `Report Level` parameter and exclusion flags (e.g., `Exclude Fully Delivered`) help to reduce the data volume processed, focusing on relevant, open items.
-   **Indexed Joins:** Queries leverage standard Oracle indexes on `requisition_header_id`, `requisition_line_id`, `po_header_id`, `po_line_id`, `destination_organization_id`, and `item_id` for efficient data retrieval across procurement tables.

### FAQ

**1. What does it mean if a requisition is 'Converted To PO'?**
   When a requisition is 'Converted To PO', it means that a buyer has taken the approved requisition line(s) and created a purchase order from them to an external supplier. This is a key step in the procure-to-pay process, moving internal demand to external fulfillment.

**2. Can this report help identify requisitions that have *not yet* been converted to a PO?**
   Yes. By using the `Converted To PO Date From/To` parameters (or by looking for null values in the PO details columns if the report is designed to show them when no PO exists) and filtering for `Open` requisitions, this report can highlight requests that are still pending PO creation, allowing buyers to take action.

**3. How do the 'Show DFF Attributes' parameters work?**
   These parameters enable the report to dynamically include columns for Descriptive Flexfield (DFF) attributes that your organization has configured for items, requisitions, or purchase orders. This allows users to report on client-specific custom data that is stored in these flexfields, providing a more complete picture without needing report modifications.


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
