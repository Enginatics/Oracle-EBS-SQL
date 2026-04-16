---
layout: default
title: 'INV Material Account Distribution Detail | Oracle EBS SQL Report'
description: 'Description: Material account distribution detail Application: Inventory Source: Material account distribution detail (XML) Short Name: INVTRDSTXML'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Material, Account, Distribution, gl_periods, mtl_txn_request_headers, wip_entities'
permalink: /INV%20Material%20Account%20Distribution%20Detail/
---

# INV Material Account Distribution Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-material-account-distribution-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Description: Material account distribution detail
Application: Inventory

Source: Material account distribution detail (XML)
Short Name: INVTRDST_XML

## Report Parameters
Ledger, Operating Unit, Organization Code, Txn Organization Code, Transaction Date From, Transaction Date To, Account, Account From, Account To, Category Set 1, Category Set 2, Category Set 3, Item, Subinventory, Transaction Value From, Transaction Value To, GL Batch, Transaction Source Type, Source From, Source To, Transaction Type, Transaction Reason, Currency, Exchange Rate, Show SLA Accounting

## Oracle EBS Tables Used
[gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_physical_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_sales_orders_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders_kfv), [mtl_generic_dispositions_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions_kfv), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Material Account Distribution Detail 22-Jul-2024 014230.xlsx](https://www.enginatics.com/example/inv-material-account-distribution-detail/) |
| Blitz Report™ XML Import | [INV_Material_Account_Distribution_Detail.xml](https://www.enginatics.com/xml/inv-material-account-distribution-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-material-account-distribution-detail/](https://www.enginatics.com/reports/inv-material-account-distribution-detail/) |

## INV Material Account Distribution Detail - Case Study & Technical Analysis

### Executive Summary
The **INV Material Account Distribution Detail** report is the bridge between Supply Chain operations and Finance. It provides a granular view of the accounting entries generated by inventory transactions. Every material movement (Receipt, Issue, Transfer) creates financial debits and credits; this report validates those entries, ensuring that the General Ledger accurately reflects the physical reality of the warehouse.

### Business Challenge
Reconciling the Inventory Subledger to the General Ledger is a notorious pain point for accountants. Common issues include:
-   **Black Box Accounting:** Operations teams transact items without knowing the financial impact, leading to surprise variances.
-   **Mapping Errors:** Incorrect Subledger Accounting (SLA) rules can send costs to the wrong GL accounts.
-   **Period Close Delays:** Finding the one transaction that caused a $1M variance can take days of manual digging.
-   **Costing Errors:** Items with zero cost or incorrect standard costs distorting the P&L.

### Solution
This report exposes the "Debits and Credits" behind every inventory transaction. It allows users to audit the specific GL accounts hit by each transaction type, providing the transparency needed for rapid reconciliation.

**Key Features:**
-   **SLA Integration:** Shows both the raw inventory accounting and the final SLA-generated journal entries.
-   **Drill-Down:** Links the GL batch back to the specific material transaction ID.
-   **Variance Analysis:** Helps identify transactions where Debits do not equal Credits (though rare in Oracle, it happens).

### Technical Architecture
The report queries the distribution tables that store the accounting lines for inventory transactions.

#### Key Tables and Views
-   **`MTL_TRANSACTION_ACCOUNTS`**: The primary table storing the accounting lines (Account ID, Amount, Dr/Cr) for each transaction.
-   **`MTL_MATERIAL_TRANSACTIONS`**: The parent transaction record.
-   **`GL_CODE_COMBINATIONS_KFV`**: Resolves the Account ID into the readable Chart of Accounts segments.
-   **`XLA_DISTRIBUTION_LINKS`**: (Optional) Links the inventory transaction to the Subledger Accounting (SLA) engine for R12+.

#### Core Logic
1.  **Transaction Retrieval:** Fetches transactions within the specified date range or GL Batch.
2.  **Accounting Join:** Joins `MTL_MATERIAL_TRANSACTIONS` to `MTL_TRANSACTION_ACCOUNTS` on `TRANSACTION_ID`.
3.  **Account Resolution:** Decodes the `REFERENCE_ACCOUNT` using `GL_CODE_COMBINATIONS`.
4.  **Cost Element Breakdown:** Can break down the cost by element (Material, Overhead, Resource) if using Standard Costing.

### Business Impact
-   **Faster Close:** Reduces the time required to reconcile inventory balances at month-end.
-   **Financial Accuracy:** Ensures that COGS and Inventory Asset accounts are stated correctly.
-   **Audit Trail:** Provides a complete audit trail from the Financial Statement down to the individual warehouse receipt.


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
