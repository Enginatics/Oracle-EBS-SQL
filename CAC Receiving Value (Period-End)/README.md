---
layout: default
title: 'CAC Receiving Value (Period-End) | Oracle EBS SQL Report'
description: 'Report to show receiving value for all locations, as of the end of an accounting period. You may run this report for open or closed accounting periods…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting - Inventory Value, Enginatics, CAC, Receiving, Value, (Period-End), po_requisition_headers_all, po_requisition_lines_all, hr_employees'
permalink: /CAC%20Receiving%20Value%20%28Period-End%29/
---

# CAC Receiving Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-value-period-end/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show receiving value for all locations, as of the end of an accounting period.  You may run this report for open or closed accounting periods.  With parameters to display or not display WIP outside processing information (WIP job, status, close date and OSP resource code).  If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date.  In addition, for any receipt with an item number, this report displays Inventory, Shop Floor (Outside Processing) and Expense destination types.

Note:  The Adjustment Amount column show differences between the PO unit price for the Receipt and Deliver transactions, which currently is not included in the receiving accounting entries. 

Reconciliation Notes to Oracle Reports:
The Oracle All Inventory Values Report does not display Shop Floor (Outside Processing) or Expense destination types.  
If the PO line is closed, the Oracle Receiving Value Report does not display Expense destination types, even if the receipt is still in receiving and has not been delivered.

Parameters:
Period Name:  the accounting period you wish to report (mandatory).
Show WIP Outside Processing:  display WIP job details for outside processing, enter Yes or No (mandatory).
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Item Number:  specific item you wish to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)
Product Line Accounting:  use this parameter to tell the report if you have set up product line accounting information in your item master accounts.  Enter Yes or No.
Product Line Segment:  use this parameter to tell the report which segment to use to find the product line information.  If the Product Line Accounting parameter is set to No this parameter is grayed out and not required.
Item Master Account Type:  use this parameter to determine if you store your product line information in your item master Expense, Cost of Sales or Sales Accounts.  If the Product Line Accounting parameter is set to No this parameter is grayed out and not required.

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
-- +=============================================================================+*/

## Report Parameters
Period Name, Show WIP Outside Processing, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger, Product Line Accounting, Item Master Account Type, Product Line Segment

## Oracle EBS Tables Used
[po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply), [rcv_accounting_events](https://www.enginatics.com/library/?pg=1&find=rcv_accounting_events), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger)

## Report Categories
[Cost Accounting - Inventory Value](https://www.enginatics.com/library/?pg=1&category[]=Cost%20Accounting%20-%20Inventory%20Value), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Value (Period-End) - Pivot by Org 11-Aug-2022 151851.xlsx](https://www.enginatics.com/example/cac-receiving-value-period-end/) |
| Blitz Report™ XML Import | [CAC_Receiving_Value_Period_End.xml](https://www.enginatics.com/xml/cac-receiving-value-period-end/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-receiving-value-period-end/](https://www.enginatics.com/reports/cac-receiving-value-period-end/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
