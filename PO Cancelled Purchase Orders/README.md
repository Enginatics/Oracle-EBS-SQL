---
layout: default
title: 'PO Cancelled Purchase Orders | Oracle EBS SQL Report'
description: 'Application: Purchasing Source: Cancelled Purchase Orders Report (XML) Short Name: POXPOCANXML DB package: POPOXPOCANXMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Cancelled, Purchase, Orders, po_headers_all, po_action_history, po_vendors'
permalink: /PO%20Cancelled%20Purchase%20Orders/
---

# PO Cancelled Purchase Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-cancelled-purchase-orders/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Purchasing
Source: Cancelled Purchase Orders Report (XML)
Short Name: POXPOCAN_XML
DB package: PO_POXPOCAN_XMLP_PKG

## Report Parameters
Show Order Lines, Operating Unit, Vendor From, Vendor To, Buyer Name, Cancelled Date From, Cancelled Date To, Creation Date From, Creation Date To

## Oracle EBS Tables Used
[po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_action_history](https://www.enginatics.com/library/?pg=1&find=po_action_history), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PO Cancelled Requisitions](/PO%20Cancelled%20Requisitions/ "PO Cancelled Requisitions Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [PO Headers and Lines 11i](/PO%20Headers%20and%20Lines%2011i/ "PO Headers and Lines 11i Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Cancelled Purchase Orders 03-Mar-2023 034355.xlsx](https://www.enginatics.com/example/po-cancelled-purchase-orders/) |
| Blitz Report™ XML Import | [PO_Cancelled_Purchase_Orders.xml](https://www.enginatics.com/xml/po-cancelled-purchase-orders/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-cancelled-purchase-orders/](https://www.enginatics.com/reports/po-cancelled-purchase-orders/) |

## PO Cancelled Purchase Orders - Case Study

### Executive Summary
The **PO Cancelled Purchase Orders** report provides Procurement Managers and Financial Controllers with critical visibility into cancelled spending commitments. By aggregating data on cancelled headers and lines, this report helps organizations analyze patterns in order cancellations, manage supplier relationships, and ensure that financial liabilities are properly de-obligated in the system.

### Business Challenge
Cancelled orders, if not monitored, can lead to several business issues:
*   **Lost Visibility:** Understanding *why* orders are cancelled is key to improving demand planning.
*   **Supplier Performance:** Frequent cancellations by a supplier (or due to supplier issues) can indicate reliability problems.
*   **Financial Liability:** Ensuring that cancelled POs are fully closed and funds are unencumbered (in encumbrance accounting environments) is vital for accurate budget reporting.
*   **Audit Trails:** Auditors often look for cancelled large-value orders to ensure proper authorization and process adherence.

### The Solution
The **PO Cancelled Purchase Orders** report offers a clear "Operational View" of the cancellation history.

**Key Features:**
*   **Granular Detail:** Can report at both the PO Header level (entire order cancelled) and the Line level (partial cancellation).
*   **Audit Data:** Includes details on *who* cancelled the order and *when*, providing a robust audit trail.
*   **Supplier Focus:** Allows filtering by specific vendors to analyze cancellation trends per supplier.
*   **Buyer Analysis:** Enables performance review by grouping cancellations by the buyer responsible.

### Technical Architecture
The report queries the Purchasing tables, focusing on status flags and action history.

**Primary Tables:**
*   `PO_HEADERS_ALL`: The main table for Purchase Order documents. Contains the `CANCEL_FLAG` and `CANCEL_DATE`.
*   `PO_LINES_ALL`: Contains line-level details. Also has `CANCEL_FLAG` for individual line cancellations.
*   `PO_VENDORS` (AP_SUPPLIERS): Provides supplier names and details.
*   `PO_ACTION_HISTORY`: Used to trace the specific actions taken on the document, identifying the user who performed the cancellation.

**Logical Relationships:**
The report filters `PO_HEADERS_ALL` (and optionally `PO_LINES_ALL`) where the `CANCEL_FLAG` is set to 'Y'. It joins to `PO_VENDORS` to retrieve supplier names and `PER_ALL_PEOPLE_F` to identify the buyer.

### Parameters & Filtering
Key parameters allow for targeted analysis:
*   **Operating Unit:** Restricts data to a specific business entity.
*   **Show Order Lines:** A toggle to determine if the report should list every cancelled line or just cancelled headers.
*   **Vendor From/To:** Filters for a specific supplier or range of suppliers.
*   **Cancelled Date From/To:** The most critical filter, allowing users to see cancellations within a specific reporting period (e.g., last month).
*   **Buyer Name:** Filters by the purchasing agent.

### Performance & Optimization
*   **Date-Based Indexing:** The report is designed to filter efficiently on `CANCEL_DATE` or `CREATION_DATE`, which are typically indexed columns, ensuring fast retrieval even with large historical datasets.
*   **Selective Joins:** The join to `PO_LINES_ALL` is conditional or optimized to only occur when line-level detail is requested, reducing processing overhead for header-level summaries.

### Frequently Asked Questions
**Q: Does this report include orders that were "Finally Closed"?**
A: "Finally Closed" and "Cancelled" are distinct statuses in Oracle EBS. This report specifically targets orders where the Cancel action was performed. Finally Closed orders are typically handled by the "PO Final Close" process.

**Q: Can I see who cancelled the order?**
A: Yes, by linking to the `PO_ACTION_HISTORY` or checking the `LAST_UPDATED_BY` fields on the cancellation action, the report can identify the user responsible.

**Q: Does it show the value of the cancelled funds?**
A: Yes, the report typically calculates the cancelled amount based on the quantity cancelled and the unit price, helping Finance understand the value of de-obligated funds.


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
