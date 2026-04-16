---
layout: default
title: 'CAC Recost Cost of Goods Sold | Oracle EBS SQL Report'
description: 'Report to compare the "as transacted" cost of goods sold (COGS) transactions in Oracle Inventory with the "what if" costs from a simulation cost type. Use…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Recost, Cost, Goods, mtl_system_items_vl, mtl_txn_source_types, cst_item_costs'
permalink: /CAC%20Recost%20Cost%20of%20Goods%20Sold/
---

# CAC Recost Cost of Goods Sold – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-recost-cost-of-goods-sold/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to compare the "as transacted" cost of goods sold (COGS) transactions in Oracle Inventory with the "what if" costs from a simulation cost type.  Use this report when you need to make manual journal entry corrections to your COGS entries, due to incorrect item costs.  In addition to reporting the normal COGS entries for the COGS Recognition, Sales Order Issue, RMA Receipt and RMA Return transactions, you can also report user-defined material transactions such as Account Issues/Receipts, Miscellaneous Issues/Receipts and Account Alias transactions which could represent COGS entries from other ERP Systems.  To report additional user-defined transactions enter these along with the defaulted values for the COGS Transaction Type parameter:  COGS Recognition, Sales Order Issue, RMA Receipt and RMA Return.

Note:  in order for COGS entries to be reported you must first run Create Accounting.

Parameters:
===========
Transaction Date From:  enter the starting transaction date for COGS transactions (mandatory).
Transaction Date To:  enter the ending transaction date for PO COGS transactions (mandatory).
COGS Transaction Types:  enter the COGS related transaction types you wish to report (mandatory).
Recost Cost Type:  enter the cost type you wish to use to recost your COGS transactions (mandatory).
Minimum Value Difference:  the absolute smallest COGS difference you want to report (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006- 2023 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_recost_cogs_detail_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 Apr 2006 Douglas Volz   Initial Coding
-- |  1.1     28 Apr 2006 Douglas Volz   Final Coding
-- |  1.2     02 May 2017 Douglas Volz   Modified for Client's use, added inline table
-- |                                     to get one row for COGS accounting entries, to
-- |                                     to get the mmt correct qty and avoid cross-joining.
-- |  1.3     13 Nov 2023 Douglas Volz   Modified for organization access, removed tabs and
-- |                                     added subledger accounting ccids.
-- |  1.4     16 Nov 2023 Douglas Volz   Remove org_acct_periods, use period name from xla_ae_headers.
-- |  1.5     05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- |  1.6     12 Mar 2024 Douglas Volz   Add cost elements for COGS per client request.
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, COGS Transaction Types, Recost Cost Type, Minimum Value Difference, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_generic_dispositions](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_physical_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-recost-cost-of-goods-sold/) |
| Blitz Report™ XML Import | [CAC_Recost_Cost_of_Goods_Sold.xml](https://www.enginatics.com/xml/cac-recost-cost-of-goods-sold/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-recost-cost-of-goods-sold/](https://www.enginatics.com/reports/cac-recost-cost-of-goods-sold/) |

## Case Study & Technical Analysis: CAC Recost Cost of Goods Sold

### Executive Summary
The **CAC Recost Cost of Goods Sold** report is a powerful financial simulation tool. It allows Cost Accountants to answer "What If" questions regarding margins. Specifically, it compares the COGS recorded in the General Ledger (based on the active Standard Cost) against a theoretical COGS calculated using a different Cost Type (e.g., "Proposed 2024 Standard").

### Business Challenge
*   **Margin Analysis**: "If we had used the new raw material prices, what would our Q1 margins have looked like?"
*   **Correction**: "We set the standard cost of Item A to $10 by mistake. It should have been $100. How much COGS do we need to adjust manually?"
*   **Budgeting**: Validating the impact of next year's standard costs on historical sales volumes.

### Solution
This report performs a retrospective valuation.
*   **Input**: Historical Sales Transactions (COGS Recognition, Sales Order Issue).
*   **Calculation**:
    *   Actual COGS = Qty * Frozen Cost.
    *   Simulated COGS = Qty * Recost Cost Type (e.g., Pending).
*   **Output**: The variance between Actual and Simulated COGS, grouped by Account and Item.

### Technical Architecture
*   **Tables**: `mtl_material_transactions`, `cst_item_costs` (joined twice: once for Frozen, once for Recost).
*   **Logic**: Filters for Transaction Action 'Issue from Stores' and Source Type 'Sales Order'.

### Parameters
*   **Recost Cost Type**: (Mandatory) The "What If" cost type.
*   **Transaction Date From/To**: (Mandatory) The historical period to analyze.
*   **Minimum Value Difference**: (Mandatory) Threshold to filter out noise.

### Performance
*   **Heavy**: Recalculating costs for millions of sales lines is intensive. Use tight date ranges.

### FAQ
**Q: Does this update the GL?**
A: No, it is a reporting tool only. Any adjustments must be booked via manual journal entries.
**Q: Can it handle RMA?**
A: Yes, Return Material Authorizations (Credits) are included to give a net COGS impact.


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
