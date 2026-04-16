---
layout: default
title: 'PO Headers and Lines 11i | Oracle EBS SQL Report'
description: 'PO headers, lines, receiving transactions and corresponding AP invoices – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Headers, Lines, 11i, mrp_item_purchase_orders, mrp_recommendations, mrp_full_pegging'
permalink: /PO%20Headers%20and%20Lines%2011i/
---

# PO Headers and Lines 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-headers-and-lines-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PO headers, lines, receiving transactions and corresponding AP invoices

## Report Parameters
Operating Unit, Receiving Organization, PO Number, Release, Buyer, Supplier, Supplier Site, Item, Item Type, WIP Job, Project, Has Open Quantity, Promised, Overdue, Open only, Exclude Cancelled, PO Creation Date From, PO Creation Date To, PO Created By

## Oracle EBS Tables Used
[mrp_item_purchase_orders](https://www.enginatics.com/library/?pg=1&find=mrp_item_purchase_orders), [mrp_recommendations](https://www.enginatics.com/library/?pg=1&find=mrp_recommendations), [mrp_full_pegging](https://www.enginatics.com/library/?pg=1&find=mrp_full_pegging), [mrp_gross_requirements](https://www.enginatics.com/library/?pg=1&find=mrp_gross_requirements), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [po_line_locations_archive_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_archive_all), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_action_history](https://www.enginatics.com/library/?pg=1&find=po_action_history), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [po_vendor_contacts](https://www.enginatics.com/library/?pg=1&find=po_vendor_contacts), [po_document_types_all_vl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_vl), [po_line_types_v](https://www.enginatics.com/library/?pg=1&find=po_line_types_v), [hr_locations_all_tl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_tl), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/po-headers-and-lines-11i/) |
| Blitz Report™ XML Import | [PO_Headers_and_Lines_11i.xml](https://www.enginatics.com/xml/po-headers-and-lines-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-headers-and-lines-11i/](https://www.enginatics.com/reports/po-headers-and-lines-11i/) |

## Case Study: End-to-End Procurement Lifecycle Visibility

### Executive Summary
The **PO Headers and Lines** report provides a comprehensive, "cradle-to-grave" view of the procurement process within Oracle E-Business Suite. By consolidating data from purchase order headers, lines, shipments, and distributions—and linking them to receiving transactions and Accounts Payable invoices—this report enables organizations to track the complete lifecycle of every purchasing document. It is an essential tool for procurement managers, buyers, and financial analysts to monitor spend, ensure compliance, and streamline the procure-to-pay cycle.

### Business Challenge
Managing procurement in a complex ERP environment often involves navigating fragmented data. Key challenges include:
*   **Fragmented Visibility:** Critical purchasing data is scattered across multiple tables (Headers, Lines, Shipments, Distributions), making it difficult to get a single, unified view of a PO.
*   **Process Gaps:** Tracking a PO from creation to receipt and final invoicing often requires running multiple disparate reports, leading to inefficiencies and data reconciliation errors.
*   **Spend Management:** Without a consolidated view of what was ordered versus what was billed, organizations struggle to analyze spend patterns and enforce contract compliance.
*   **Accrual Reconciliation:** Discrepancies between ordered amounts, received quantities, and invoiced amounts can lead to inaccurate financial reporting and accrual write-offs.

### The Solution
This report solves these challenges by creating a unified data model that flattens the complex hierarchy of Oracle Purchasing tables.
*   **Full Lifecycle Tracking:** Links POs directly to receipts and invoices, allowing users to see exactly what was ordered, what has been received, and what has been paid.
*   **Granular Detail:** Provides analysis down to the distribution level, ensuring that project associations, charge accounts, and budget centers are clearly visible.
*   **Status Monitoring:** Includes fields for "Document Closure Status," "Promised Date," and "Overdue" flags, enabling proactive management of open orders and supplier performance.
*   **Flexible Filtering:** Users can filter by Buyer, Supplier, Item, Project, and Date ranges to focus on specific areas of interest.

### Technical Architecture
The solution leverages a robust SQL architecture to join core Purchasing tables with Inventory, Receiving, and Payables modules.
*   **Core Tables:** `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_DISTRIBUTIONS_ALL`.
*   **Integration Points:**
    *   **Receiving:** Joins with `RCV_TRANSACTIONS` to bring in receipt dates and quantities.
    *   **Payables:** Links to `AP_INVOICES_ALL` and `AP_INVOICE_LINES_ALL` to show billed amounts and invoice status.
    *   **General Ledger:** Resolves account code combinations via `GL_CODE_COMBINATIONS` for accurate financial reporting.
    *   **Projects:** Integrates with `PA_PROJECTS_ALL` for project-centric procurement tracking.

### Parameters & Filtering
The report offers extensive parameters for targeted analysis:
*   **Organizational Context:** Operating Unit, Receiving Organization.
*   **Document Attributes:** PO Number, Release, Document Type, Document Closure Status.
*   **Parties:** Buyer, Supplier, Supplier Site.
*   **Item Details:** Item, Item Type, Category Sets.
*   **Dates:** Document Creation Date, Promised Date, Need By Date, Receipt Date.
*   **Status Flags:** Has Open Quantity, Overdue, Exclude Cancelled.

### Performance & Optimization
*   **Materialized Views:** For high-volume environments, consider using materialized views for the heavy joins between PO and AP tables to improve query response times.
*   **Indexing:** Ensure standard Oracle indexes on `PO_HEADER_ID`, `PO_LINE_ID`, and `CREATION_DATE` are active and analyzed.
*   **Date Ranges:** Always encourage users to run the report with specific date ranges (e.g., "Creation Date" or "Need By Date") to limit the dataset and enhance performance.

### FAQ
**Q: Does this report include Cancelled POs?**
A: By default, you can choose to include or exclude cancelled lines using the "Exclude Cancelled" parameter.

**Q: Can I see the GL Charge Account for each line?**
A: Yes, the report includes distribution-level details, showing the full GL Charge Account segments.

**Q: How does it handle Blanket Purchase Agreements (BPAs)?**
A: The report supports Releases against BPAs. You can filter by "Release" number or view the release details associated with the blanket header.


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
