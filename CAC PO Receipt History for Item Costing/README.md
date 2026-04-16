---
layout: default
title: 'CAC PO Receipt History for Item Costing | Oracle EBS SQL Report'
description: 'Report to show Purchase Order (PO) Receipt History for inventory organizations, for a selected PO receipt date range. If the Comparison Cost Type is not…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Receipt, History, Item, mtl_material_transactions, mtl_transaction_types, cst_item_costs'
permalink: /CAC%20PO%20Receipt%20History%20for%20Item%20Costing/
---

# CAC PO Receipt History for Item Costing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Comparison Cost Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [PO Headers and Lines 11i](/PO%20Headers%20and%20Lines%2011i/ "PO Headers and Lines 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC PO Receipt History for Item Costing 13-Dec-2022 104628.xlsx](https://www.enginatics.com/example/cac-po-receipt-history-for-item-costing/) |
| Blitz Report™ XML Import | [CAC_PO_Receipt_History_for_Item_Costing.xml](https://www.enginatics.com/xml/cac-po-receipt-history-for-item-costing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/](https://www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
