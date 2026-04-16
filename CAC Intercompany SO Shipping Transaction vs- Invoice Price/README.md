---
layout: default
title: 'CAC Intercompany SO Shipping Transaction vs. Invoice Price | Oracle EBS SQL Report'
description: 'Report to compare the transaction item cost from the selling internal org to the invoice sales price the selling internal organization is charging the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Intercompany, Shipping, Transaction, ra_customer_trx_lines_all, mtl_material_transactions, mtl_transaction_types'
permalink: /CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price/
---

# CAC Intercompany SO Shipping Transaction vs. Invoice Price – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to compare the transaction item cost from the selling internal org to the invoice sales price the selling internal organization is charging the internal receiving organization. 

/* +=============================================================================+
-- |  Copyright 2017 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_verify_so_price_vs_cost_txn.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from           -- starting shipping transaction date, mandatory
-- |  p_trx_date_to             -- ending shipping transaction date, mandatory
-- |
-- |  Description:
-- |  Report to compare the transaction item cost from the selling internal org
-- |  to the invoice sales price the selling internal organization is charging the
-- |  receiving organization. 
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     01 May 2017 Douglas Volz   Initial Coding
-- |  1.1     03 Sep 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                     and item categories for cost and inventory.
-- |  1.2     27 Jan 2020 Douglas Volz   Added Ledger, Operating Unit and Org Code 
-- |                                     parameters.
-- |  1.3     09 Jul 2022 Douglas Volz   Changes for multi-language lookup values.
-- +=============================================================================+*/


## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Ledger

## Oracle EBS Tables Used
[ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intercompany SO Shipping Transaction vs. Invoice Price 10-Jul-2022 224012.xlsx](https://www.enginatics.com/example/cac-intercompany-so-shipping-transaction-vs-invoice-price/) |
| Blitz Report™ XML Import | [CAC_Intercompany_SO_Shipping_Transaction_vs_Invoice_Price.xml](https://www.enginatics.com/xml/cac-intercompany-so-shipping-transaction-vs-invoice-price/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/](https://www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/) |

## Case Study & Technical Analysis: CAC Intercompany SO Shipping Transaction vs. Invoice Price

### Executive Summary
The **CAC Intercompany SO Shipping Transaction vs. Invoice Price** report is a transactional audit tool that verifies the financial accuracy of intercompany shipments. It compares the cost of the item at the time of shipment (from the selling organization) against the actual invoice price charged to the receiving organization. This report is vital for detecting revenue leakage and ensuring that intercompany billing aligns with transfer pricing policies.

### Business Challenge
In day-to-day operations, discrepancies can arise between the expected transfer price and the actual invoiced amount.
*   **Timing Issues**: Price list changes between the time of order entry and shipment/invoicing can lead to incorrect billing.
*   **Cost Variances**: If the item cost changes (e.g., standard cost update) but the price list is not updated, the intercompany margin may be eroded.
*   **Audit Gaps**: Identifying specific shipment lines where the price charged does not match the expected cost-plus model is tedious without transaction-level matching.

### Solution
This report provides a line-level reconciliation of shipping transactions.
*   **Transaction Matching**: Links the physical inventory transaction (`mtl_material_transactions`) with the financial invoice line (`ra_customer_trx_lines_all`).
*   **Variance Analysis**: Allows users to compare the Unit Cost at shipment with the Unit Selling Price on the invoice.
*   **Scope**: Covers a specific date range, making it ideal for month-end validation routines.

### Technical Architecture
The report bridges the gap between Supply Chain and Finance:
*   **Linkage**: Joins `oe_order_lines_all` (Order Management) to `mtl_material_transactions` (Inventory) and `ra_customer_trx_lines_all` (Receivables).
*   **Cost Retrieval**: Fetches the transaction cost directly from the material transaction record, ensuring it reflects the cost *at the moment of shipment*.
*   **Org Context**: Resolves Operating Unit and Ledger details to support multi-org reporting.

### Parameters
*   **Transaction Date From/To**: (Mandatory) The date range of the shipping transactions to audit.
*   **Category Set**: (Optional) Filter by item categories.
*   **Ledger/Operating Unit**: (Optional) Scope the report to specific financial entities.

### Performance
*   **Indexed Access**: Relies on date-based indexes on `mtl_material_transactions` for efficient retrieval of shipment records.
*   **Data Volume**: Performance depends on the volume of shipments in the selected date range. Narrower date ranges yield faster results.

### FAQ
**Q: Why would the invoice price differ from the price list?**
A: Manual overrides on the sales order, modifiers/discounts applied inadvertently, or price list changes between order booking and invoicing can cause discrepancies.

**Q: Does this report show the receiving side?**
A: This report focuses on the *selling* side (Shipment and AR Invoice). The receiving side (Receipt and AP Invoice) is typically handled by separate reconciliation reports.

**Q: Can I use this for external customers?**
A: While the logic is similar, this report is tailored for Intercompany flows where the relationship between Cost and Price is strictly governed by policy.


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
