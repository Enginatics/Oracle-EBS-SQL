---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Deferred COGS Out-of-Balance | Oracle EBS SQL Report'
description: 'Report to find the out-of-balance deferred COGS entries by organization, item and sales order number. You do not need to run Create Accounting as this…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Deferred, COGS, Out-of-Balance, mtl_parameters, mtl_material_transactions, mtl_transaction_accounts'
permalink: /CAC%20Deferred%20COGS%20Out-of-Balance/
report_name: 'CAC Deferred COGS Out-of-Balance'
report_web_name: cac-deferred-cogs-out-of-balance
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Deferred COGS Out-of-Balance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.5     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Deferred%20COGS%20Out-of-Balance/CAC%20Deferred%20COGS%20Out-of-Balance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Deferred COGS Out-of-Balance 23-Jun-2022 135858.xlsx](https://www.enginatics.com/example/cac-deferred-cogs-out-of-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance) |
| Blitz Report™ XML Import | [CAC_Deferred_COGS_Out_of_Balance.xml](https://www.enginatics.com/xml/cac-deferred-cogs-out-of-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance) |
| SQL Source | [CAC Deferred COGS Out-of-Balance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Deferred%20COGS%20Out-of-Balance/CAC%20Deferred%20COGS%20Out-of-Balance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/](https://www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-deferred-cogs-out-of-balance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
