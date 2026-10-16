---
layout: default
last_modified_at: 2026-10-16
title: 'INV Intercompany Invoice Reconciliation | Oracle EBS SQL Report'
description: 'Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Intercompany, Invoice, Reconciliation, mtl_item_categories_v, mtl_material_transactions, hr_organization_information'
permalink: /INV%20Intercompany%20Invoice%20Reconciliation/
report_name: 'INV Intercompany Invoice Reconciliation'
report_web_name: inv-intercompany-invoice-reconciliation
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Intercompany Invoice Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced quantities, amounts and possible discrepancies.
It also includes all intercompany Receivables (AR) and Payables (AP) invoice details. Optionally includes the Inventory and Intercompany AP SLA Accounting

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Detail, Shipping/Procuring Operating Unit, Receiving Operating Unit, Shipment/Receiving Date From, Shipment/Receiving Date To, Display Item Category Set, Intercompany Source, Quantity Variance only, Amount Variance only

## Oracle EBS Tables Used
[mtl_item_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mtl_transaction_flow_headers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_flow_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mtl_units_of_measure](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ra_interface_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_interface_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ra_interface_errors_all](https://www.enginatics.com/library/?pg=1&find=ra_interface_errors_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_invoices_interface](https://www.enginatics.com/library/?pg=1&find=ap_invoices_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_invoice_lines_interface](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [ap_interface_rejections](https://www.enginatics.com/library/?pg=1&find=ap_interface_rejections&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mtl_trx_types_view](https://www.enginatics.com/library/?pg=1&find=mtl_trx_types_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Intercompany%20Invoice%20Reconciliation/INV%20Intercompany%20Invoice%20Reconciliation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Intercompany Invoice Reconciliation 28-Nov-2020 110524.xlsx](https://www.enginatics.com/example/inv-intercompany-invoice-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation) |
| Blitz Report™ XML Import | [INV_Intercompany_Invoice_Reconciliation.xml](https://www.enginatics.com/xml/inv-intercompany-invoice-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation) |
| SQL Source | [INV Intercompany Invoice Reconciliation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Intercompany%20Invoice%20Reconciliation/INV%20Intercompany%20Invoice%20Reconciliation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/](https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation) |

## INV Intercompany Invoice Reconciliation - Case Study & Technical Analysis

### Executive Summary
The **INV Intercompany Invoice Reconciliation** report is a complex financial reconciliation tool designed to align the three legs of an intercompany transaction:
1.  **Inventory**: The physical shipment from Org A to Org B.
2.  **Receivables (AR)**: The invoice Org A sends to Org B.
3.  **Payables (AP)**: The invoice Org B receives from Org A.

Discrepancies between these three can lead to significant accounting issues and intercompany elimination problems during financial consolidation.

### Business Use Cases
*   **Month-End Reconciliation**: The primary tool for ensuring that Intercompany AR matches Intercompany AP.
*   **Transfer Pricing Validation**: Verifies that the price charged on the AR invoice matches the expected transfer price calculated by the shipping engine.
*   **Accrual Auditing**: Ensures that goods received (Inventory) have been invoiced (AP), preventing "Received Not Invoiced" (RNI) accrual errors.

### Technical Analysis

#### Core Tables
*   `MTL_MATERIAL_TRANSACTIONS`: The source of truth for the physical movement (Transfer Type = Intercompany).
*   `RA_CUSTOMER_TRX_ALL` / `RA_CUSTOMER_TRX_LINES_ALL`: The AR invoice data.
*   `AP_INVOICES_ALL` / `AP_INVOICE_LINES_ALL`: The AP invoice data.
*   `MTL_SYSTEM_ITEMS_B`: Item details.

#### Key Joins & Logic
*   **The "Logical" Link**: Linking these transactions is notoriously difficult in Oracle EBS. The report typically uses a combination of:
    *   `TRX_SOURCE_LINE_ID` (linking AR to Inventory).
    *   Purchase Order references (linking AP to Inventory/PO).
    *   Global Intercompany System (GIS) references if used.
*   **Variance Calculation**: Compares Quantity and Amount across the three sources (Inv vs AR, AR vs AP).

#### Key Parameters
*   **Shipping/Receiving Org**: The pair of organizations to analyze.
*   **Date Range**: Shipment or Invoice date.
*   **Variance Only**: Filters to show only problem records.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-intercompany-invoice-reconciliation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
