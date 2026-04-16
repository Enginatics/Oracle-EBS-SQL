---
layout: default
title: 'INV Intercompany Invoice Reconciliation | Oracle EBS SQL Report'
description: 'Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Intercompany, Invoice, Reconciliation, ra_customer_trx_lines_all, ra_customer_trx_all, ar_payment_schedules_all'
permalink: /INV%20Intercompany%20Invoice%20Reconciliation/
---

# INV Intercompany Invoice Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced quantities, amounts and possible discrepancies.
It also includes all intercompany Receivables (AR) and Payables (AP) invoice details. Optionally includes the Inventory and Intercompany AP SLA Accounting

## Report Parameters
Report Detail, Shipping/Procuring Operating Unit, Receiving Operating Unit, Shipment/Receiving Date From, Shipment/Receiving Date To, Display Item Category Set, Intercompany Source, Quantity Variance only, Amount Variance only

## Oracle EBS Tables Used
[ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines), [mmt](https://www.enginatics.com/library/?pg=1&find=mmt), [mtl_trx_types_view](https://www.enginatics.com/library/?pg=1&find=mtl_trx_types_view), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [ar_intf](https://www.enginatics.com/library/?pg=1&find=ar_intf), [ar_ico](https://www.enginatics.com/library/?pg=1&find=ar_ico), [ap_intf](https://www.enginatics.com/library/?pg=1&find=ap_intf), [ap_ico](https://www.enginatics.com/library/?pg=1&find=ap_ico), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation 11i](/INV%20Intercompany%20Invoice%20Reconciliation%2011i/ "INV Intercompany Invoice Reconciliation 11i Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Intercompany Invoice Reconciliation 28-Nov-2020 110524.xlsx](https://www.enginatics.com/example/inv-intercompany-invoice-reconciliation/) |
| Blitz Report™ XML Import | [INV_Intercompany_Invoice_Reconciliation.xml](https://www.enginatics.com/xml/inv-intercompany-invoice-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/](https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
