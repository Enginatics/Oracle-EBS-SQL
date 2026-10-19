---
layout: default
last_modified_at: 2026-10-19
title: 'CAC Receiving Expense Value (Period-End) | Oracle EBS SQL Report'
description: 'Report to show receiving value for expense locations and expense destination types, for expenses accrued at time of receipt. You may run this report for…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Receiving, Expense, Value, mtl_parameters, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20Receiving%20Expense%20Value%20%28Period-End%29/
report_name: 'CAC Receiving Expense Value (Period-End)'
report_web_name: cac-receiving-expense-value-period-end
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Receiving Expense Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-expense-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show receiving value for expense locations and expense destination types, for expenses accrued at time of receipt.  You may run this report for open or closed accounting periods.  If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date.  if run for a current period, the report shows the real-time quantities and values.  This report displays both the receiving valuation account as well as the offset (expense or CapEx) account.

Parameters:
Period Name:  the accounting period you wish to report (mandatory).
Category Sets 1 - 3:  any item category you wish (optional)
Supplier Name: enter a supplier name to report (optional)
Item Number:  enter an item number to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2010-25 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com) 
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0  5 Jul 2010 Douglas Volz   Created initial Report for Celgene
-- |                                     based on XXX_IPV_RCV_VALUE_REPT.sql
-- |      1.1  5 Jul 2010 Douglas Volz   Added requisition, requestor and requestor
-- |                                     email address
-- |      1.2 15 Sep 2010 Douglas Volz   Added unit of measure, supplier, buyer columns.
-- |                                     Fix for parameter changes for BO Freehand SQL requirements,
-- |                                     changing the code to accept null or % or value GL Ledger names.
-- |      1.3 27 Sep 2010 Douglas Volz   Changed the report sort to include the offset accounts
-- |      1.4 04 Jan 2012 Douglas Volz   Fixed quantities to sum up rcv_receiving_sub_ledger,
-- |                                     as the view rcv_receiving_value_view and
-- |                                         rcv_transactions does not split out quantities by
-- |                                     po distributions.  For expenses you can have multiple expense
-- |                                     accounts or distributions for each scheduled receipt
-- |                                     in po_line_locations
-- |      1.5 08 Feb 2012 Douglas Volz   Rewrite code to fix quantity and amounts, mtl_supply does
-- |                                     not handle split rcv_transations, split by multiple 
-- |                                     po_distribution_ids.  It only stores one of the PODs for
-- |                                     expenses.
-- |      1.6 06 Jan 2020 Douglas Volz   Added item categories, Org Code and Operating Unit parameters.
-- |      1.7 29 May 2025 Douglas Volz   Removed tabs, added Blitz G/L and OU security..
-- |      1.8 15 Oct 2025 Douglas Volz   Changed inventory periods to PO financial periods.
-- |                                     Added non-recoverable tax amounts into PO prices.
-- |                                     And changed Period Name parameter to use INV Periods
-- |                                     which also include the master inventory org.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Category Set 1, Category Set 2, Category Set 3, Supplier Name, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end), [rcv_accounting_events](https://www.enginatics.com/library/?pg=1&find=rcv_accounting_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)

## Related Reports
[CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/CAC%20Receiving%20Expense%20Value%20%28Period-End%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-receiving-expense-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end) |
| Blitz Report™ XML Import | [CAC_Receiving_Expense_Value_Period_End.xml](https://www.enginatics.com/xml/cac-receiving-expense-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end) |
| SQL Source | [CAC Receiving Expense Value (Period-End).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/CAC%20Receiving%20Expense%20Value%20%28Period-End%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-receiving-expense-value-period-end/](https://www.enginatics.com/reports/cac-receiving-expense-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end) |

## Case Study & Technical Analysis: CAC Receiving Expense Value (Period-End)

### Executive Summary
The **CAC Receiving Expense Value (Period-End)** report focuses on the valuation of "Expense" destination items. In Oracle EBS, you can configure expense items (like Office Supplies) to "Accrue on Receipt". This means they hit the Balance Sheet (Receiving Inspection) upon receipt and only move to the Expense account upon Delivery. This report values that specific slice of inventory.

### Business Challenge
*   **Hidden Liabilities**: Expense accruals are often overlooked. A large delivery of computers (expensed assets) can sit in receiving, representing a significant liability.
*   **Period-End Rollback**: You need to know what the value was *as of* the last day of the month, even if you are running the report on the 5th of the new month.
*   **Account Offset**: Verifying that the offset account (the eventual Expense account) is correct.

### Solution
This report provides "As Of" valuation.
*   **Rollback Logic**: Starts with current quantities and reverses transactions that happened after the "As Of" date.
*   **Scope**: Filters specifically for `Destination Type Code = 'EXPENSE'`.
*   **Valuation**: Uses the PO Price (since expense items often don't have a standard cost).

### Technical Architecture
*   **Tables**: `rcv_transactions`, `po_lines_all`.
*   **Logic**: Complex "As Of" logic using `transaction_date` vs. `p_period_end_date`.

### Parameters
*   **Period Name**: (Mandatory) The target period for valuation.

### Performance
*   **Complex**: Rollback logic requires scanning history, but the volume of Expense receipts is usually lower than Inventory receipts.

### FAQ
**Q: Why not just use the standard Receiving Value report?**
A: The standard report often excludes Expense destinations or mixes them in. This report isolates them for specific accrual reconciliation.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-expense-value-period-end)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
