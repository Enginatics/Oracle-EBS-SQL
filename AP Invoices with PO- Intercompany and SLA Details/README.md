---
layout: default
title: 'AP Invoices with PO, Intercompany and SLA Details | Oracle EBS SQL Report'
description: 'AP Invoices with PO, Intercompany and SLA Details – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Invoices, PO,, Intercompany, SLA, po_req_distributions_all, po_requisition_lines_all, po_requisition_headers_all'
permalink: /AP%20Invoices%20with%20PO-%20Intercompany%20and%20SLA%20Details/
---

# AP Invoices with PO, Intercompany and SLA Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoices-with-po-intercompany-and-sla-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
AP Invoices with PO, Intercompany and SLA Details

## Report Parameters
Ledger, Operating Unit, Invoice Date From, Invoice Date To, Accounting Date From, Accounting Date To, Supplier, Supplier Site, Invoice Source, Invoice Number, Exlude Invoice Line Types, Exlude Invoice Dist Types, Include Discarded Invoice Lines, Display Item Category Set, Show AP SLA Accounting, Show INV SLA Accounting, Show Intercompany Details

## Oracle EBS Tables Used
[po_req_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_req_distributions_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_line_types_v](https://www.enginatics.com/library/?pg=1&find=po_line_types_v), [mtl_units_of_measure](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [mtl_item_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories_v), [ap_inv](https://www.enginatics.com/library/?pg=1&find=ap_inv), [po](https://www.enginatics.com/library/?pg=1&find=po)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [AP Invoices with PO, Intercompany and SLA Details(GST)](/AP%20Invoices%20with%20PO-%20Intercompany%20and%20SLA%20Details%28GST%29/ "AP Invoices with PO, Intercompany and SLA Details(GST) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-invoices-with-po-intercompany-and-sla-details/) |
| Blitz Report™ XML Import | [AP_Invoices_with_PO_Intercompany_and_SLA_Details.xml](https://www.enginatics.com/xml/ap-invoices-with-po-intercompany-and-sla-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-invoices-with-po-intercompany-and-sla-details/](https://www.enginatics.com/reports/ap-invoices-with-po-intercompany-and-sla-details/) |

## Case Study & Technical Analysis: AP Invoices with PO, Intercompany and SLA Details

### 1. Executive Summary

#### Business Problem
In the Oracle E-Business Suite "Procure-to-Pay" (P2P) cycle, data is often siloed across multiple modules: Purchasing, Receiving, Payables, and Subledger Accounting (SLA). Standard reports typically focus on one area (e.g., "Invoice Register" or "Purchase Order Detail"), making it difficult for Finance and Procurement teams to:
*   **Trace Lineage:** Easily link an invoice back to the original Requisition and Receipt to validate 3-way matching.
*   **Reconcile Accounting:** Verify that the AP Invoice distribution accounts match the final SLA journal entries posted to the General Ledger.
*   **Analyze Intercompany:** Isolate and reconcile intercompany transactions which often have complex accounting flows.

#### Solution Overview
The **AP Invoices with PO, Intercompany and SLA Details** report serves as a comprehensive P2P analysis tool. It bridges the gap between modules by joining AP Invoice data directly with upstream Purchasing/Receiving records and downstream SLA accounting entries. This "horizontal" view allows users to audit the entire lifecycle of a transaction in a single row, ensuring data integrity and simplifying month-end reconciliation.

#### Key Benefits
*   **Full P2P Visibility:** See the Requisition Number, PO Number, Receipt Number, and Invoice Number side-by-side.
*   **SLA Reconciliation:** Optional inclusion of Subledger Accounting data allows for detailed reconciliation between AP Distributions and GL Journals.
*   **Intercompany Focus:** Dedicated logic to identify and report on Intercompany transactions, aiding in elimination and reconciliation processes.
*   **Flexible Granularity:** Parameters allow users to toggle detail levels (e.g., "Show AP SLA Accounting"), optimizing performance and relevance.

### 2. Technical Analysis

#### Core Tables and Views
The report navigates the complex P2P schema, primarily anchoring on Payables and linking outwards:
*   **`AP_INVOICES_ALL` / `AP_INVOICE_LINES_ALL` / `AP_INVOICE_DISTRIBUTIONS_ALL`**: The core Payables tables containing invoice header, line, and accounting distribution data.
*   **`PO_HEADERS_ALL` / `PO_LINES_ALL` / `PO_DISTRIBUTIONS_ALL`**: Purchasing tables linked via `PO_DISTRIBUTION_ID` to show the source order.
*   **`PO_REQUISITION_HEADERS_ALL` / `PO_REQ_DISTRIBUTIONS_ALL`**: Requisition tables linked to the PO to show the initial request.
*   **`RCV_TRANSACTIONS` / `RCV_SHIPMENT_HEADERS`**: Receiving tables linked to show proof of delivery (Receipts).
*   **`XLA_AE_HEADERS` / `XLA_AE_LINES`**: Subledger Accounting tables (conditionally joined) to show the final debits and credits sent to GL.
*   **`GL_CODE_COMBINATIONS`**: For resolving account segment values.

#### SQL Logic and Data Flow
The query likely starts with `AP_INVOICE_DISTRIBUTIONS_ALL` (or Lines) as the grain, as this is the lowest level of detail that links to both PO Distributions and SLA.
*   **Left Outer Joins:** Used extensively for PO and Receipt tables, ensuring that "Non-PO" invoices (like expense reports or direct entry) are still reported, just with blank PO columns.
*   **Conditional Logic (SLA):** The "Show AP SLA Accounting" parameter likely controls a dynamic join or a `UNION` branch that brings in `XLA` tables. This is a critical performance feature, as joining to SLA tables significantly increases row count and query cost.
*   **Intercompany Logic:** Specific filters or columns are derived to flag transactions where the balancing segment of the liability account differs from the expense account, or based on specific Intercompany transaction types.

#### Integration Points
*   **Purchasing:** Validates price variances by comparing Invoice Unit Price vs. PO Unit Price.
*   **Inventory/Receiving:** Validates quantity variances by comparing Billed Quantity vs. Received Quantity.
*   **General Ledger:** Provides the "Accounting Date" and final GL accounts.

### 3. Functional Capabilities

#### Parameters & Filtering
*   **Date Ranges:** Filter by `Invoice Date` (operational) or `Accounting Date` (financial/period close).
*   **Supplier/Site:** Target specific vendors for audit.
*   **Show Flags:**
    *   `Show AP SLA Accounting`: Enables the join to XLA tables for deep accounting analysis.
    *   `Show Intercompany Details`: Adds columns relevant to intercompany reconciliation.
    *   `Include Discarded Invoice Lines`: Allows filtering out cancelled/discarded lines for a cleaner view of "Net" liability.

#### Performance & Optimization
*   **On-Demand Joins:** By making the SLA and Intercompany sections optional via parameters, the report avoids scanning massive tables (`XLA_AE_LINES`) when users only need operational AP/PO data.
*   **Indexed Columns:** Filtering on `Accounting Date` and `Org_ID` leverages standard Oracle indexes for fast retrieval.

### 4. FAQ

**Q: Why are the PO and Receipt columns blank for some rows?**
A: These are likely "Non-PO" invoices, such as manual expense entries or direct invoices that were not matched to a Purchase Order.

**Q: Why do I see multiple rows for the same Invoice Line?**
A: If "Show AP SLA Accounting" is enabled, a single invoice distribution may result in multiple SLA journal lines (e.g., liability, expense, tax, variance), causing the row to split.

**Q: How does this report help with Accrual Reconciliation?**
A: By showing the `PO_DISTRIBUTION_ID` and the `ACCRUAL_ACCOUNT`, you can match the AP entry against the PO Receipt accrual to identify discrepancies in the "AP/PO Accrual Reconciliation" process.


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
