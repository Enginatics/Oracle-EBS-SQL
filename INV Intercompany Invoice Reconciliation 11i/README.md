---
layout: default
title: 'INV Intercompany Invoice Reconciliation 11i | Oracle EBS SQL Report'
description: 'Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Intercompany, Invoice, Reconciliation, ra_customer_trx_lines_all, ra_customer_trx_all, ar_payment_schedules_all'
permalink: /INV%20Intercompany%20Invoice%20Reconciliation%2011i/
---

# INV Intercompany Invoice Reconciliation 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced quantities, amounts and possible discrepancies.
It also includes all intercompany Receivables (AR) and Payables (AP) invoice details.

## Report Parameters
Report Detail, Shipping/Procuring Operating Unit, Receiving Operating Unit, Shipment/Receiving Date From, Shipment/Receiving Date To, Quantity Variance only, Amount Variance only

## Oracle EBS Tables Used
[ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [mmt](https://www.enginatics.com/library/?pg=1&find=mmt), [mtl_trx_types_view](https://www.enginatics.com/library/?pg=1&find=mtl_trx_types_view), [mtl_system_items_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [ar_intf](https://www.enginatics.com/library/?pg=1&find=ar_intf), [ar_ico](https://www.enginatics.com/library/?pg=1&find=ar_ico), [ap_intf](https://www.enginatics.com/library/?pg=1&find=ap_intf), [ap_ico](https://www.enginatics.com/library/?pg=1&find=ap_ico), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-intercompany-invoice-reconciliation-11i/) |
| Blitz Report™ XML Import | [INV_Intercompany_Invoice_Reconciliation_11i.xml](https://www.enginatics.com/xml/inv-intercompany-invoice-reconciliation-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-intercompany-invoice-reconciliation-11i/](https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation-11i/) |

## Case Study & Technical Analysis: INV Intercompany Invoice Reconciliation 11i

### Executive Summary

The INV Intercompany Invoice Reconciliation 11i report provides a comprehensive solution for reconciling intercompany transactions within Oracle E-Business Suite. It delivers a unified view of inventory transactions between shipping and receiving organizations, highlighting discrepancies in quantities and amounts, and integrating both Accounts Receivable (AR) and Accounts Payable (AP) invoice details. This report is a critical tool for financial analysts and supply chain managers seeking to ensure accuracy and efficiency in their intercompany accounting processes.

### Business Challenge

Many organizations with complex intercompany supply chains struggle with the reconciliation of transactions. The process is often manual, time-consuming, and prone to errors. Key challenges include:

-   **Lack of Visibility:** Difficulty in tracking the end-to-end flow of goods from the shipping organization to the receiving organization, including the corresponding financial transactions.
-   **Manual Reconciliation:** Heavy reliance on spreadsheets to match shipment data with AR and AP invoices, leading to significant administrative overhead and delays in period-end closing.
-   **Discrepancy Resolution:** Time-consuming investigation to identify and resolve quantity and amount variances between what was shipped, received, and invoiced.
-   **Compliance Risks:** Inaccurate intercompany accounting can lead to compliance issues and audit findings.

### The Solution

The INV Intercompany Invoice Reconciliation 11i report streamlines the reconciliation process by providing a detailed, operational view of all intercompany transactions.

-   **Automated Reconciliation:** The report automatically matches inventory shipment and receipt transactions with their corresponding AR and AP invoices, eliminating the need for manual data compilation.
-   **Variance Highlighting:** It flags any discrepancies in quantities and amounts, allowing financial controllers to focus on exceptions rather than combing through thousands of transactions.
-   **Centralized Data:** By joining data from Inventory, Order Management, Receivables, and Payables, the report serves as a single source of truth for all intercompany activities.
-   **Improved Efficiency:** The report significantly reduces the time and effort required for period-end closing and intercompany settlement.

### Technical Architecture (High Level)

The report is built upon a direct SQL query against the Oracle EBS database, ensuring high performance and real-time data access.

-   **Primary Tables Involved:**
    -   `mtl_material_transactions` (for inventory transaction details)
    -   `ra_customer_trx_all` and `ra_customer_trx_lines_all` (for AR invoice information)
    -   `ap_invoices_all` and `ap_invoice_lines_all` (for AP invoice information)
    -   `mtl_system_items_kfv` (for item master details)
    -   `hr_all_organization_units` (for organization details)
-   **Logical Relationships:** The report logically links inventory shipment transactions from the shipping organization to the corresponding receipt transactions in the receiving organization. It then joins this data to the AR invoice generated by the shipping entity and the AP invoice recorded by the receiving entity.

### Parameters & Filtering

The report includes several parameters that allow users to tailor the output to their specific needs:

-   **Report Detail:** Allows the user to choose between summary and detail level views.
-   **Shipping/Procuring Operating Unit:** Filters the report for a specific shipping or procuring operating unit.
-   **Receiving Operating Unit:** Narrows down the data to a specific receiving operating unit.
-   **Shipment/Receiving Date From/To:** Enables analysis for a specific time period.
-   **Quantity Variance only / Amount Variance only:** Allows users to focus exclusively on transactions with quantity or amount discrepancies.

### Performance & Optimization

The report is designed for optimal performance:

-   **Direct Database Extraction:** By leveraging the Blitz Report framework, the report queries the database directly, bypassing the performance overhead associated with intermediate formats like XML.
-   **Indexed Columns:** The query is optimized to use standard Oracle indexes on key columns such as transaction dates and organization IDs, ensuring fast data retrieval even with large data volumes.

### FAQ

**1. What is the primary cause of discrepancies shown in the report?**
   Discrepancies can arise from various factors, including timing differences between shipment and receipt, unit of measure conversions, or incorrect pricing on the intercompany invoice. The report provides the necessary details to investigate and identify the root cause.

**2. Can this report be used to reconcile transactions across different ledgers?**
   Yes, as long as the operating units are properly configured for intercompany transactions within Oracle EBS, the report can reconcile transactions that cross ledger boundaries.

**3. How does the report handle returns or credit memos?**
   The report includes all transaction types, including returns and credit memos, ensuring a complete reconciliation picture. The transaction type is displayed for each line, allowing users to identify these specific scenarios.


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
