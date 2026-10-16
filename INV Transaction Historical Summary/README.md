---
layout: default
last_modified_at: 2026-10-16
title: 'INV Transaction Historical Summary | Oracle EBS SQL Report'
description: 'Application: Inventory Description: Transaction Historical Summary Report This report provides equivalent functionality to the Oracle standard Transaction…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, R12 only, INV, Transaction, Historical, Summary, mtl_secondary_inventories, mtl_system_items_vl, mtl_item_categories'
permalink: /INV%20Transaction%20Historical%20Summary/
report_name: 'INV Transaction Historical Summary'
report_web_name: inv-transaction-historical-summary
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Transaction Historical Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-transaction-historical-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Application: Inventory
Description: Transaction Historical Summary Report

This report provides equivalent functionality to the Oracle standard Transaction historical summary (XML) report.

Templates
Quantity/Value Template – for use with the Quantity and Value Selection Option
Balance Template – for use with the Balance Selection Option

The templates provide a summary pivot based on the selected sort option parameter with drill down to the detail data.

Sort Option Category: Pivot by Category, Subinventory/Cost Group
All Others: Pivot by Subinventory/Cost Group, Category

Source: Transaction historical summary (XML)
Short Name: INVTRHAN_XML
DB package: INV_INVTRHAN_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Selection Option, Sort By, Cost Groups From, Cost Groups To, Include Consigned, Rollback to this Date, Category Set, Categories From, Categories To, Items From, Items To, Subinventories From, Subinventories To, Source Type for Column One, Source Type for Column Two, Source Type for Column Three, Source Type for Column Four

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [mtl_onhand_qty_cost_v](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_qty_cost_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [cst_item_costs_for_gl_view](https://www.enginatics.com/library/?pg=1&find=cst_item_costs_for_gl_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [cst_inv_qty_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_qty_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [cst_inv_cost_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_cost_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Transaction%20Historical%20Summary/INV%20Transaction%20Historical%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-transaction-historical-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary) |
| Blitz Report™ XML Import | [INV_Transaction_Historical_Summary.xml](https://www.enginatics.com/xml/inv-transaction-historical-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary) |
| SQL Source | [INV Transaction Historical Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Transaction%20Historical%20Summary/INV%20Transaction%20Historical%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-transaction-historical-summary/](https://www.enginatics.com/reports/inv-transaction-historical-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary) |

## INV Transaction Historical Summary - Case Study & Technical Analysis

### Executive Summary
The **INV Transaction Historical Summary** report is a retrospective analysis tool. It allows users to "roll back" the clock and see what the inventory value or quantity was at a specific point in the past. This is essential for audit reconstruction and trend analysis.

### Business Challenge
Standard on-hand reports only show the *current* balance. But businesses often ask:
-   **Audit:** "What was the inventory value on December 31st at midnight?"
-   **Investigation:** "Why did we run out of stock last Tuesday? How much did we have on Monday?"
-   **Trend:** "What was our average inventory level for Q1 vs Q2?"

### Solution
The **INV Transaction Historical Summary** report reconstructs the past balance by taking the current balance and "reversing" all transactions that happened since the target date.

**Key Features:**
-   **Rollback Logic:** Calculates the balance as of a specific past date.
-   **Valuation:** Can report on both Quantity and Value.
-   **Flexibility:** Supports pivoting by Category or Subinventory.

### Technical Architecture
This report uses a complex calculation engine (often involving temporary tables) to perform the rollback.

#### Key Tables and Views
-   **`MTL_MATERIAL_TRANSACTIONS`**: The history of all movements.
-   **`CST_INV_QTY_TEMP`**: Temporary table used to store the calculated past quantities.
-   **`CST_INV_COST_TEMP`**: Temporary table used to store the calculated past costs.

#### Core Logic
1.  **Current Balance:** Starts with the current on-hand quantity.
2.  **Reverse Transactions:** Subtracts (or adds) the quantities of all transactions that occurred *after* the "Rollback Date".
    *   *Formula:* `Historical Qty = Current Qty - (Sum of Inflows since Date) + (Sum of Outflows since Date)`
3.  **Costing:** Applies the cost that was active at that historical date (for Standard Costing) or the calculated layer cost (for Average/FIFO).

### Business Impact
-   **Audit Defense:** The primary tool for proving the inventory balance at year-end if the period was not closed exactly on time.
-   **Performance Analysis:** Helps analyze inventory turnover trends over time.
-   **Dispute Resolution:** Resolves "he said, she said" arguments about stock availability in the past.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-historical-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
