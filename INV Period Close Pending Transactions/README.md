---
layout: default
last_modified_at: 2026-10-16
title: 'INV Period Close Pending Transactions | Oracle EBS SQL Report'
description: 'Summary report to display the pending transaction counts as found in the Inventory Account Periods Close form, checking open receipts, pending shipments…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, R12 only, INV, Period, Close, Pending, org_organization_definitions, org_acct_periods, mtl_material_transactions_temp'
permalink: /INV%20Period%20Close%20Pending%20Transactions/
report_name: 'INV Period Close Pending Transactions'
report_web_name: inv-period-close-pending-transactions
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Period Close Pending Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-period-close-pending-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Summary report to display the pending transaction counts as found in the Inventory Account Periods Close form, checking open receipts, pending shipments, failed inventory, WIP, etc

The Period Count shows the pending transactions occurring within the specified period.
The Period Close Count shows the count of pending transactions as at the scheduled period close date of the specified period. 
The Period Close Count are the counts displayed in the Pending Transactions Inventory Account Periods Close Form.  
This is the accumulated count of pending transactions upto the shceduled close date of the specified period, except for the count of  'Unprocessed Shipping Transactions' which are not carried over to the next period. 

Period count queries are sourced from procedure CST_AccountingPeriod_PUB.Get_PendingTcount (CSTPAPEB.pls 120.18.12020000.8)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Period From, Period To

## Oracle EBS Tables Used
[org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wip_cost_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_cost_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsm_split_merge_txn_interface](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsm_lot_move_txn_interface](https://www.enginatics.com/library/?pg=1&find=wsm_lot_move_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsm_lot_split_merges_interface](https://www.enginatics.com/library/?pg=1&find=wsm_lot_split_merges_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [cst_lc_adj_interface](https://www.enginatics.com/library/?pg=1&find=cst_lc_adj_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [rcv_transactions_interface](https://www.enginatics.com/library/?pg=1&find=rcv_transactions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [mtl_transactions_interface](https://www.enginatics.com/library/?pg=1&find=mtl_transactions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wip_move_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_move_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsh_delivery_assignments_v](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsh_delivery_legs](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_legs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsh_trip_stops](https://www.enginatics.com/library/?pg=1&find=wsh_trip_stops&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)

## Related Reports
[CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status But Not Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status But Not Ready for Close Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Period%20Close%20Pending%20Transactions/INV%20Period%20Close%20Pending%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Period Close Pending Transactions 03-Dec-2024 195754.xlsx](https://www.enginatics.com/example/inv-period-close-pending-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions) |
| Blitz Report™ XML Import | [INV_Period_Close_Pending_Transactions.xml](https://www.enginatics.com/xml/inv-period-close-pending-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions) |
| SQL Source | [INV Period Close Pending Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Period%20Close%20Pending%20Transactions/INV%20Period%20Close%20Pending%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-period-close-pending-transactions/](https://www.enginatics.com/reports/inv-period-close-pending-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions) |

## INV Period Close Pending Transactions - Case Study & Technical Analysis

### Executive Summary
The **INV Period Close Pending Transactions** report is the "Pre-Flight Check" for the inventory month-end close. Before an accounting period can be closed, Oracle requires all transactions to be fully processed. This report identifies any "stuck" transactions (Unprocessed Material, Pending WIP, Uncosted items) that are blocking the close.

### Business Challenge
The "Period Close" is often a stressful time. The system prevents closing if *anything* is pending, but finding *what* is pending can be like finding a needle in a haystack. Users struggle with:
-   **Vague Errors:** The system says "Pending Transactions exist" but doesn't say where.
-   **Interface Tables:** Transactions might be stuck in an interface table (Open Interface, WIP Interface) that users can't easily see.
-   **Uncosted Items:** Transactions that processed physically but failed financially (e.g., missing cost).

### Solution
The **INV Period Close Pending Transactions** report aggregates counts from all the various "holding areas" in the system. It replicates the logic of the "Pending Transactions" form but provides a printable, shareable format.

**Key Features:**
-   **Comprehensive Check:** Checks Material Transactions, WIP Move Transactions, Uncosted Transactions, Pending Shipping, and Receiving Interfaces.
-   **Count Summary:** Shows the count of stuck records in each category.
-   **Drill-Down:** (In some versions) Provides details on the specific IDs that are stuck.

### Technical Architecture
The report queries a series of interface and temporary tables that act as queues for the inventory processors.

#### Key Tables and Views
-   **`MTL_MATERIAL_TRANSACTIONS_TEMP`**: The primary queue for on-line processing.
-   **`MTL_TRANSACTIONS_INTERFACE`**: The queue for open interface / background processing.
-   **`WIP_COST_TXN_INTERFACE`**: Pending resource transactions.
-   **`RCV_TRANSACTIONS_INTERFACE`**: Pending receipts.
-   **`WSH_DELIVERY_DETAILS`**: Pending shipments (not yet interfaced).

#### Core Logic
1.  **Union Query:** The report runs a series of `SELECT COUNT(*)` queries against each interface table.
2.  **Date Filtering:** It only counts transactions that fall within the period being closed.
3.  **Resolution:** If the count > 0, the period cannot close.

### Business Impact
-   **Faster Close:** Pinpoints the exact blockers so they can be fixed immediately.
-   **Data Integrity:** Ensures that all activity for the month is fully accounted for before the books are closed.
-   **Stress Reduction:** Eliminates the "mystery" of why the period won't close.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-period-close-pending-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
