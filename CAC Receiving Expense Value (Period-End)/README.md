---
layout: default
title: 'CAC Receiving Expense Value (Period-End) | Oracle EBS SQL Report'
description: 'Report to show receiving value for expense locations and expense destination types, for expenses accrued at time of receipt. You may run this report for…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Receiving, Expense, Value, po_requisition_headers_all, po_requisition_lines_all, hr_employees'
permalink: /CAC%20Receiving%20Expense%20Value%20%28Period-End%29/
---

# CAC Receiving Expense Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-expense-value-period-end/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Period Name, Category Set 1, Category Set 2, Category Set 3, Supplier Name, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [orgs_and_period](https://www.enginatics.com/library/?pg=1&find=orgs_and_period), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-receiving-expense-value-period-end/) |
| Blitz Report™ XML Import | [CAC_Receiving_Expense_Value_Period_End.xml](https://www.enginatics.com/xml/cac-receiving-expense-value-period-end/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-receiving-expense-value-period-end/](https://www.enginatics.com/reports/cac-receiving-expense-value-period-end/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
