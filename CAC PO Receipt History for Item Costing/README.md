---
layout: default
last_modified_at: 2026-10-26
title: 'CAC PO Receipt History for Item Costing | Oracle EBS SQL Report'
description: 'Report to show Purchase Order (PO) Receipt History for inventory organizations, for a selected PO receipt date range. If the Comparison Cost Type is not…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Receipt, History, Item, hr_employees, po_releases_all, mtl_parameters'
permalink: /CAC%20PO%20Receipt%20History%20for%20Item%20Costing/
report_name: 'CAC PO Receipt History for Item Costing'
report_web_name: cac-po-receipt-history-for-item-costing
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC PO Receipt History for Item Costing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show Purchase Order (PO) Receipt History for inventory organizations, for a selected PO receipt date range.  If the Comparison Cost Type is not entered the report uses the Cost Type from the Primary Costing Method, such as Frozen, Average, FIFO or LIFO.  And note you may use this report for any discrete costing method but the CAC PO Receipt History for Actual Costing report may be a better choice for Average, FIFO and LIFO Costing, as additional information is available, such as the prior costed quantity, prior cost and new onhand quantity.

Parameters:
===========
Transaction Date From:  enter the starting transaction date for PO Receipt History (mandatory).
Transaction Date To:  enter the ending transaction date for PO Receipt History (mandatory).
Comparison Cost Type: enter the cost type to compare against the PO receipts (optional).  If the Comparison Cost Type is not entered the report uses Cost Type from the Primary Costing Method.
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2006 - 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.                                                                 
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     28 May 2006 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.1     04 Jan 2019 Douglas Volz   Added transaction date range, inventory
-- |                                    org and specific item parameters.
-- | 1.2     30 Aug 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                    and item categories for cost and inventory.
-- | 1.3     27 Jan 2020 Douglas Volz   Added Org_Code and Operating_Unit parameters.
-- | 1.4     05 Jul 2022 Douglas Volz   Modify for multi-language tables, change UOM to
-- |                                    primary, and changes for Standard Costing.
-- | 1.5     01 Sep 2022 Douglas Volz   Add supplier information to report.
-- | 1.6     13 Dec 2022 Douglas Volz   Fix supplier type and cost type logic.
-- | 1.7     11 Sep 2023 Douglas Volz   Added Transaction Type to report.
-- |  1.8     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Comparison Cost Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)

## Related Reports
[CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoices with PO, Intercompany and SLA Details](/AP%20Invoices%20with%20PO-%20Intercompany%20and%20SLA%20Details/ "AP Invoices with PO, Intercompany and SLA Details Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20PO%20Receipt%20History%20for%20Item%20Costing/CAC%20PO%20Receipt%20History%20for%20Item%20Costing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC PO Receipt History for Item Costing 13-Dec-2022 104628.xlsx](https://www.enginatics.com/example/cac-po-receipt-history-for-item-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing) |
| Blitz Report™ XML Import | [CAC_PO_Receipt_History_for_Item_Costing.xml](https://www.enginatics.com/xml/cac-po-receipt-history-for-item-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing) |
| SQL Source | [CAC PO Receipt History for Item Costing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20PO%20Receipt%20History%20for%20Item%20Costing/CAC%20PO%20Receipt%20History%20for%20Item%20Costing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/](https://www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing) |

## Case Study & Technical Analysis: CAC PO Receipt History for Item Costing

### Executive Summary
The **CAC PO Receipt History for Item Costing** report is a general-purpose purchasing analysis tool. While the "Actual Costing" version focuses on cost updates, this version focuses on the *purchasing* aspect: Supplier performance, price trends, and comparison against a fixed Standard Cost.

### Business Challenge
*   **Vendor Analysis**: "Who is selling us this part cheapest?"
*   **Inflation Tracking**: "How has the price of Steel changed over the last 6 months?"
*   **Standard Cost Validation**: "Is our Standard Cost of $10 accurate, or have we been paying $12 all year?"

### Solution
This report provides a clean list of receipts.
*   **Details**: Supplier Name, PO Number, Receipt Date, Quantity, Unit Price.
*   **Comparison**: Compares the PO Price to a selected Cost Type (e.g., "Frozen").
*   **Flexibility**: Can be run for any Costing Method (Standard, Average, etc.) as a purchasing report.

### Technical Architecture
*   **Tables**: `rcv_transactions`, `po_headers/lines`, `cst_item_costs`.
*   **Logic**: Focuses on the `RECEIVE` and `MATCH` transactions in the Receiving module.

### Parameters
*   **Comparison Cost Type**: (Optional) Defaults to the primary costing method.
*   **Category Set**: (Optional) Useful for analyzing specific commodity groups (e.g., "Electronics").

### Performance
*   **Moderate**: Joins Receiving, PO, and Costing tables. Generally performs well with date filters.

### FAQ
**Q: What is the difference between this and the "Actual Costing" report?**
A: This report does *not* show the "Prior Cost" or "New Onhand" calculation. It is simpler and focused on the receipt transaction itself vs. the cost update impact.

**Q: Does it show returns?**
A: Yes, "Return to Vendor" (RTV) transactions are typically included (often with negative quantities) to show net purchasing.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-item-costing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
