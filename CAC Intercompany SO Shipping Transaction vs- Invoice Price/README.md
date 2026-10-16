---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Intercompany SO Shipping Transaction vs. Invoice Price | Oracle EBS SQL Report'
description: 'Report to compare the transaction item cost from the selling internal org to the invoice sales price the selling internal organization is charging the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Intercompany, Shipping, Transaction, ra_customer_trx_lines_all, mtl_material_transactions, mtl_transaction_types'
permalink: /CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price/
report_name: 'CAC Intercompany SO Shipping Transaction vs. Invoice Price'
report_web_name: cac-intercompany-so-shipping-transaction-vs-invoice-price
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Intercompany SO Shipping Transaction vs. Invoice Price – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Ledger

## Oracle EBS Tables Used
[ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)

## Related Reports
[CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price/CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intercompany SO Shipping Transaction vs. Invoice Price 10-Jul-2022 224012.xlsx](https://www.enginatics.com/example/cac-intercompany-so-shipping-transaction-vs-invoice-price/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price) |
| Blitz Report™ XML Import | [CAC_Intercompany_SO_Shipping_Transaction_vs_Invoice_Price.xml](https://www.enginatics.com/xml/cac-intercompany-so-shipping-transaction-vs-invoice-price/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price) |
| SQL Source | [CAC Intercompany SO Shipping Transaction vs- Invoice Price.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price/CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/](https://www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-so-shipping-transaction-vs-invoice-price)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
