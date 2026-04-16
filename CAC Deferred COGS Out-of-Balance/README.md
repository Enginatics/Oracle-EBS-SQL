---
layout: default
title: 'CAC Deferred COGS Out-of-Balance | Oracle EBS SQL Report'
description: 'Report to find the out-of-balance deferred COGS entries by organization, item and sales order number. You do not need to run Create Accounting as this…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Deferred, COGS, Out-of-Balance, gl_code_combinations, mfg_lookups, fnd_common_lookups'
permalink: /CAC%20Deferred%20COGS%20Out-of-Balance/
---

# CAC Deferred COGS Out-of-Balance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to find the out-of-balance deferred COGS entries by organization, item and sales order number.  You do not need to run Create Accounting as this report uses the pre-Create Accounting material accounting entries.

/* +=============================================================================+
-- |  Copyright 2019 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged                                                               |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_mtl_dist_xla_oob_dcogs_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- Starting accounting date for the transaction lines
-- |  p_trx_date_to      -- Ending accounting date for the transaction lines
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report to find the out-of-balance deferred COGS entries.  
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 Jun 2019 Douglas Volz   Initial Coding, based on version 1.25 for
-- |                                     the xxx_mtl_dist_xla_detail_rept.sql.
-- |  1.1     06 Feb 2020 Douglas Volz   Adding Operating Unit and Org Code parameters. 
-- |  1.2     20 Apr 2020 Douglas Volz   Changed to multi-lang views for the item
-- |                                     master, item category sets and operating units.   
-- |  1.3     26 Jul 2020 Douglas Volz   Removed Ledger, Operating Unit, subinventory,
-- |                                     Item Type, Subledger Accounting tables and joins. 
-- |                                     Removed Create Accounting from this report;
-- |                                     get the quantities from mmt, when the item
-- |                                     cost is zero the DCOGS entries are not
-- |                                     recorded on the COGS Recognition Txn Type.
-- |  1.4     29 Jun 2022 Douglas Volz   Added back Ledger, Operating Unit, item type, plus
-- |                                     added language tables for item status and UOM.   
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [select](https://www.enginatics.com/library/?pg=1&find=select), [organization_id](https://www.enginatics.com/library/?pg=1&find=organization_id), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [reference_account](https://www.enginatics.com/library/?pg=1&find=reference_account), [inv_sub_ledger_id](https://www.enginatics.com/library/?pg=1&find=inv_sub_ledger_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [description](https://www.enginatics.com/library/?pg=1&find=description), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [planning_make_buy_code](https://www.enginatics.com/library/?pg=1&find=planning_make_buy_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [accounting_line_type](https://www.enginatics.com/library/?pg=1&find=accounting_line_type), [transaction_type_name](https://www.enginatics.com/library/?pg=1&find=transaction_type_name), [transaction_source_type_name](https://www.enginatics.com/library/?pg=1&find=transaction_source_type_name), [Decode](https://www.enginatics.com/library/?pg=1&find=Decode), [nvl](https://www.enginatics.com/library/?pg=1&find=nvl), [transaction_id](https://www.enginatics.com/library/?pg=1&find=transaction_id), [parent_transaction_id](https://www.enginatics.com/library/?pg=1&find=parent_transaction_id), [decode](https://www.enginatics.com/library/?pg=1&find=decode), [uom_code](https://www.enginatics.com/library/?pg=1&find=uom_code), [-](https://www.enginatics.com/library/?pg=1&find=-), [base_transaction_value](https://www.enginatics.com/library/?pg=1&find=base_transaction_value), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Deferred COGS Out-of-Balance 23-Jun-2022 135858.xlsx](https://www.enginatics.com/example/cac-deferred-cogs-out-of-balance/) |
| Blitz Report™ XML Import | [CAC_Deferred_COGS_Out_of_Balance.xml](https://www.enginatics.com/xml/cac-deferred-cogs-out-of-balance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/](https://www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/) |

## Case Study & Technical Analysis: CAC Deferred COGS Out-of-Balance

### Executive Summary
The **CAC Deferred COGS Out-of-Balance** report is a reconciliation tool used to analyze the "Deferred Cost of Goods Sold" (DCOGS) account. In Oracle EBS, when a Sales Order is shipped, the cost is typically debited to a DCOGS account rather than the final COGS account. The balance is only moved to COGS when the associated revenue is recognized (matching principle). This report identifies Sales Orders and Items where the DCOGS account has a non-zero balance, effectively highlighting shipments for which revenue has not yet been fully recognized (or where the accounting flow is incomplete).

### Business Challenge
Managing the DCOGS account is complex due to the timing differences between shipment and revenue recognition. Common challenges include:
*   **Revenue Recognition Delays:** Shipments made in one period but not invoiced/recognized until later, leaving balances in DCOGS.
*   **Data Integrity Issues:** "Stuck" DCOGS balances where revenue was recognized but the Cost Processor failed to generate the offsetting credit to DCOGS.
*   **RMA Mismatches:** Returns (RMAs) that credit DCOGS but don't have a corresponding original shipment debit in the same period/context.
*   **Period Close Reconciliation:** Finance teams need to substantiate the balance in the DCOGS GL account at month-end; this report provides the detailed sub-ledger breakdown to match the GL balance.

### The Solution
The report provides a granular view of the DCOGS account by:
*   **Sales Order & Item Level Detail:** It doesn't just show a total; it breaks down the balance by specific Sales Order and Item, allowing for precise troubleshooting.
*   **Netting Logic:** It sums all debits (Shipments) and credits (COGS Recognition, RMAs) for the DCOGS line type (36). If the sum is zero, the transaction is considered "closed" and excluded. If non-zero, it appears on the report.
*   **Pre-Create Accounting:** It queries the `MTL_TRANSACTION_ACCOUNTS` table directly, meaning it reflects the inventory subledger view before the General Ledger transfer, allowing for faster operational analysis without waiting for the "Create Accounting" process.

### Technical Architecture (High Level)
The report aggregates accounting lines from the inventory subledger to calculate the net position of the DCOGS account.
*   **Core Table:** `MTL_TRANSACTION_ACCOUNTS` (MTA) is the primary source, filtered for `ACCOUNTING_LINE_TYPE = 36` (Deferred COGS).
*   **Transaction Sources:** It focuses on `Sales Order` (Source Type 2) and `RMA` (Source Type 12) transactions.
*   **Aggregation:** The query groups data by Ledger, Operating Unit, Organization, Period, Item, and Sales Order.
*   **Filtering:** The `HAVING` clause `SUM(AMOUNT) <> 0` ensures that only orders with a remaining DCOGS balance are displayed. Fully recognized orders (where Shipment Debit = Recognition Credit) are automatically filtered out.

### Parameters & Filtering
*   **Transaction Date From/To:** Defines the period of analysis.
*   **Category Sets:** Allows filtering by specific product lines or inventory categories.
*   **Organization Code:** Filter by specific inventory organization.
*   **Operating Unit/Ledger:** Supports multi-org reporting.

### Performance & Optimization
*   **Inline View Strategy:** The report uses an inline view (`mtl_acct`) to perform the heavy lifting of joining `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_ACCOUNTS` and resolving the polymorphic `TRANSACTION_SOURCE_ID` (which can point to PO headers, OE headers, etc.) before aggregating.
*   **Materialized View Avoidance:** It accesses base tables directly rather than relying on potentially stale or slow views like `ORG_ORGANIZATION_DEFINITIONS`.
*   **Indexed Filtering:** Filters on `ACCOUNTING_LINE_TYPE` and `TRANSACTION_SOURCE_TYPE_ID` leverage standard Oracle indexes to quickly isolate the relevant DCOGS rows.

### FAQ
**Q: Why is this report called "Out-of-Balance"?**
A: In this context, "Out-of-Balance" refers to any Sales Order line that has a *remaining balance* in the DCOGS account. While a balance is normal for recently shipped items (waiting for revenue), old balances often indicate errors or "stuck" transactions that need investigation.

**Q: Does this report match the General Ledger?**
A: Ideally, yes. The sum of the "Net Deferred COGS Amount" column for a given period should tie to the ending balance of the DCOGS GL account (assuming all journals have been posted).

**Q: Why do I see negative balances?**
A: A negative balance might occur if an RMA (Return) was processed and credited to DCOGS, but the original shipment happened in a prior period or was already fully recognized. It could also indicate a COGS Recognition transaction occurred without a corresponding Shipment (rare, but possible in data corruption scenarios).

**Q: Do I need to run "Create Accounting" first?**
A: No. This report looks at `MTL_TRANSACTION_ACCOUNTS`, which is populated by the Cost Processor. It reflects the inventory subledger reality immediately after the Cost Manager runs, regardless of whether the GL transfer has happened.


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
