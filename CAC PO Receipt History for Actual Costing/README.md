---
layout: default
last_modified_at: 2026-10-26
title: 'CAC PO Receipt History for Actual Costing | Oracle EBS SQL Report'
description: 'Report to show Purchase Order (PO) Receipt History for non-Standard Cost inventory organizations, by PO receipt date range. You may also use this report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Receipt, History, Actual, hr_employees, po_releases_all, mtl_parameters'
permalink: /CAC%20PO%20Receipt%20History%20for%20Actual%20Costing/
report_name: 'CAC PO Receipt History for Actual Costing'
report_web_name: cac-po-receipt-history-for-actual-costing
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC PO Receipt History for Actual Costing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-po-receipt-history-for-actual-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show Purchase Order (PO) Receipt History for non-Standard Cost inventory organizations, by PO receipt date range.  You may also use this report for Standard Cost organizations but the CAC PO Receipt History for Item Costing report may be a better choice, as the following columns will have zero or empty values for Standard Cost organizations:  prior costed quantity, prior cost and new onhand quantity.

/* +=============================================================================+
-- | Copyright 2006 - 2022 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_history.sql
-- |
-- |  Parameters:
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_trx_date_from        -- Starting transaction date for the PO Receipt History
-- |  p_trx_date_to          -- Ending transaction date for the PO Receipt History
-- |  p_item_number          -- Enter a specific item number to review.  If you 
-- |                            enter a blank or null value you get all items.
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |
-- | Description:
-- | Report to show PO Receipt History for non-standard cost inventory organizations,
-- | by PO receipt date range.
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     28 May 2006 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.1     04 Jan 2019 Douglas Volz   Added transaction date range, inventory
-- |                                    org and specific item parameters.
-- | 1.2     30 Aug 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                    and item categories for cost and inventory.
-- | 1.3     27 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- | 1.4     05 Jul 2022 Douglas Volz   Modify for multi-language tables, change UOM to
-- |                                    primary, and changes for Non-Standard Costing.
-- |  1.5     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Organization Code, Item Number, Ledger

## Oracle EBS Tables Used
[hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [mtl_cst_actual_cost_details](https://www.enginatics.com/library/?pg=1&find=mtl_cst_actual_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)

## Related Reports
[CAC PO Receipt History for Item Costing](/CAC%20PO%20Receipt%20History%20for%20Item%20Costing/ "CAC PO Receipt History for Item Costing Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [PO Purchase Price Variance](/PO%20Purchase%20Price%20Variance/ "PO Purchase Price Variance Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20PO%20Receipt%20History%20for%20Actual%20Costing/CAC%20PO%20Receipt%20History%20for%20Actual%20Costing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC PO Receipt History for Actual Costing 13-Dec-2022 011635.xlsx](https://www.enginatics.com/example/cac-po-receipt-history-for-actual-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing) |
| Blitz Report™ XML Import | [CAC_PO_Receipt_History_for_Actual_Costing.xml](https://www.enginatics.com/xml/cac-po-receipt-history-for-actual-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing) |
| SQL Source | [CAC PO Receipt History for Actual Costing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20PO%20Receipt%20History%20for%20Actual%20Costing/CAC%20PO%20Receipt%20History%20for%20Actual%20Costing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-po-receipt-history-for-actual-costing/](https://www.enginatics.com/reports/cac-po-receipt-history-for-actual-costing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing) |

## Case Study & Technical Analysis: CAC PO Receipt History for Actual Costing

### Executive Summary
The **CAC PO Receipt History for Actual Costing** report is essential for organizations using Average, FIFO, or LIFO costing. In these methods, the "Item Cost" is dynamic—it updates with every receipt. This report provides the audit trail explaining *why* the cost changed, by showing the receipt quantity and price that drove the update.

### Business Challenge
*   **Cost Volatility**: "Why did the cost of Widget A jump from $5 to $8 yesterday?"
*   **Audit Trail**: In Standard Costing, costs only change once a year. In Actual Costing, they change daily. Tracing the specific receipt that caused a spike is difficult without a dedicated report.
*   **Inventory Valuation**: Validating that the weighted average calculation was performed correctly.

### Solution
This report reconstructs the cost update logic.
*   **Sequence**: Lists receipts in chronological order.
*   **Calculation**: Shows `Prior Onhand`, `Prior Cost`, `Receipt Qty`, `Receipt Price` -> `New Onhand`, `New Cost`.
*   **Scope**: Includes PO Receipts and Inter-Org Transfers (which also update average cost).

### Technical Architecture
*   **Tables**: `mtl_material_transactions` (MMT), `rcv_transactions`.
*   **Logic**: Links the inventory transaction (MMT) to the receiving transaction (RCV) to get the PO price details.
*   **Complexity**: Actual Costing history is stored in `mtl_cst_actual_cost_details` and `mtl_material_txn_allocations`, which are complex to join.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Period to analyze.
*   **Item Number**: (Optional) Specific item to trace.

### Performance
*   **High Volume**: MMT is often the largest table in the database. Filtering by Date and Item is crucial for performance.

### FAQ
**Q: Can I use this for Standard Costing?**
A: You can, but the "Prior Cost" and "New Cost" columns might not be relevant as Standard Cost doesn't change on receipt. Use the "Item Costing" version instead.

**Q: Does it include freight?**
A: If "Landed Cost Management" (LCM) is used, the receipt price will include estimated landed costs.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-receipt-history-for-actual-costing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
