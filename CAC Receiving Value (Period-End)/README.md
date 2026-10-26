---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Receiving Value (Period-End) | Oracle EBS SQL Report'
description: 'Report to show receiving value for all locations, as of the end of an accounting period. You may run this report for open or closed accounting periods…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Receiving, Value, (Period-End), hr_employees, po_requisition_lines_all, po_requisition_headers_all'
permalink: /CAC%20Receiving%20Value%20%28Period-End%29/
report_name: 'CAC Receiving Value (Period-End)'
report_web_name: cac-receiving-value-period-end
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Receiving Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show receiving value for all locations, as of the end of an accounting period.  You may run this report for open or closed accounting periods.  With parameters to display or not display WIP outside processing information (WIP job, status, close date and OSP resource code).  If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date.  In addition, for any receipt with an item number, this report displays Inventory, Shop Floor (Outside Processing) and Expense destination types.

Note:  The Adjustment Amount column show differences between the PO unit price for the Receipt and Deliver transactions, which currently is not included in the receiving accounting entries. 

Reconciliation Notes to Oracle Reports:
The Oracle All Inventory Values Report does not display Shop Floor (Outside Processing) or Expense destination types.  
If the PO line is closed, the Oracle Receiving Value Report does not display Expense destination types, even if the receipt is still in receiving and has not been delivered.

/* +=============================================================================+
-- |  Copyright 2009 - 2025 Douglas Volz Consulting, Inc. and Enginatics GmbH
-- |  All rights reserved. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |     1.0  25 Nov 2009 Douglas Volz   Created initial Report for client
-- |                                     based on xxx_inv_value.sql
-- |     1.36 10 Aug 2022 Douglas Volz   Performance improvements for main query.  Allow expense
-- |                                     receipts with items, add PO line status column.
-- |     1.37 12 Aug 2022 Douglas Volz   Add parameter to Show WIP OSP columns and remove extra
-- |                                     join to the item master table.
-- |     1.38 16 Aug 2022 Douglas Volz   Fixes for quantities for Correction transactions and
-- |                                     for when the PO unit price is zero.
-- |     1.39 02 Jun 2025 Douglas Volz   Removed tabs.
-- |     1.40 05 Jun 2025 Douglas Volz   Added section 1.6 for PO unit price differences between
-- |                 Piyush Khandelwal   the PO Receipt and the PO Deliver transactions.  Put
-- |                                     this into an "Adjustment Amount" column, as this is
-- |                                     included in the Oracle Receiving Value Report but is
-- |                                     not recorded on any Receiving Accounting entry.
-- |                                     Also added in inventory org access, XXEN G/L and OU security profiles.
-- |  1.44    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Show WIP Outside Processing, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger, Product Line Accounting, Item Master Account Type, Product Line Segment

## Oracle EBS Tables Used
[hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [rcv_accounting_events](https://www.enginatics.com/library/?pg=1&find=rcv_accounting_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [wip_cost_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_cost_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)

## Related Reports
[CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Receiving Transactions](/PO%20Receiving%20Transactions/ "PO Receiving Transactions Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Value%20%28Period-End%29/CAC%20Receiving%20Value%20%28Period-End%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Value (Period-End) - Pivot by Org 11-Aug-2022 151851.xlsx](https://www.enginatics.com/example/cac-receiving-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end) |
| Blitz Report™ XML Import | [CAC_Receiving_Value_Period_End.xml](https://www.enginatics.com/xml/cac-receiving-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end) |
| SQL Source | [CAC Receiving Value (Period-End).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Value%20%28Period-End%29/CAC%20Receiving%20Value%20%28Period-End%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-receiving-value-period-end/](https://www.enginatics.com/reports/cac-receiving-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end) |

## Case Study & Technical Analysis: CAC Receiving Value (Period-End)

### Executive Summary
The **CAC Receiving Value (Period-End)** report is the "Gold Standard" for reconciling the Receiving Inspection account. It calculates the value of all goods (Inventory, Expense, and OSP) that are legally owned by the company (FOB Receipt) but have not yet been delivered to their final destination.

### Business Challenge
*   **Balance Sheet Validation**: The "Receiving Inspection" account is a temporary asset account. It must be supported by a detailed subledger listing.
*   **Audit Compliance**: Auditors require a "Point in Time" valuation. "What was the value on Dec 31st?"
*   **Data Integrity**: Identifying "Stuck" receipts that have been in receiving for months (phantom assets).

### Solution
This report provides the subledger detail.
*   **Coverage**: Includes all Destination Types (Inventory, Expense, Shop Floor).
*   **Rollback**: Accurately calculates the quantity on hand in Receiving as of the period end.
*   **Valuation**:
    *   Inventory Items: Valued at PO Price (usually).
    *   OSP: Valued at PO Price.

### Technical Architecture
*   **Tables**: `rcv_transactions`, `rcv_receiving_sub_ledger` (for historical quantities).
*   **Logic**: Similar to the "Inventory Value Report", it reconstructs the balance by taking the current state and reversing transactions.

### Parameters
*   **Period Name**: (Mandatory) The snapshot date.
*   **Show WIP Outside Processing**: (Mandatory) Toggle for OSP details.

### Performance
*   **Heavy**: This is a major period-end report. It processes the entire history of open receipts.

### FAQ
**Q: Why is there a difference between this and the GL?**
A: Common reasons: Manual journal entries to the GL account, receipts not accrued (Period End Accrual vs. On Receipt), or FX rate differences.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-value-period-end)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
