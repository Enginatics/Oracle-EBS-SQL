---
layout: default
title: 'CAC AP Accrual IR ISO Match Analysis | Oracle EBS SQL Report'
description: 'Use this report to match the A/P Accrual entries for internal order inventory receipts with the internal order payables invoices, by the internal sale…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Accrual, ISO, Match, gl_code_combinations_kfv, gl_ledgers, mtl_system_items_vl'
permalink: /CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/
---

# CAC AP Accrual IR ISO Match Analysis – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-ap-accrual-ir-iso-match-analysis/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Use this report to match the A/P Accrual entries for internal order inventory receipts with the internal order payables invoices, by the internal sale order and line number.  If run in Detail Mode, shows inventory receipts and payables invoices on separate lines with detailed information, if run in Summary Mode, the sales order line is summarized into one row.

Parameters:
===========
Report Mode:  you can get a summary by sales order and line or a detailed report, enter Detail or Summary (mandatory).
Transaction Date from:  enter the IR/ISO beginning transaction date you wish to report (optional).
Transaction Date to:  enter the IR/ISO ending transaction date you wish to report (optional).
Transaction Type:  enter the transaction type you wish to report (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Category Set 3:  the third item category set to report (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2016 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.09o warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     23 Nov 2016 Douglas Volz   Initial Coding 
-- |  1.1     15 Dec 2016 Douglas Volz   Added Customer Name for A/P Invoice
-- |  1.2     20 Dec 2016 Douglas Volz   Fixed calculation bug for Net Amount
-- |  1.3     10 Jan 2017 Douglas Volz   Added Transaction Type Code 61 and Transaction
-- |                                     Source Type 7 in order to report internal 
-- |                                     order receipts for txn type Int Req Intr Rcpt
-- |                                     and corrected SIGN of net quantity.
-- |  1.4     17 Jan 2017 Douglas Volz   Added Int Req Intr Rcpt to the Inventory Queries
-- |                                     corrected the transaction type code for material
-- |                                     transactions, truncated the transaction date 
-- |                                     and corrected the report sort by order number and
-- |                                     transaction type (receipts first).
-- |  1.5     18 Jan 2017 Douglas Volz   Added Vendor Name and Transaction Source.
-- |  1.6     19 Jan 2017 Douglas Volz   Commented out the customer type indicator, was
-- |                                     preventing A/P invoices from being reported.
-- |  1.7     09 Jun 2017 Douglas Volz   Added new section to report Intransit Shipments
-- |                                     for FOB Shipment with the order booked in one
-- |                                     OU but shipped from another OU
-- |  1.8     11 Jun 2017 Douglas Volz   Added Transaction Date and Operating Unit
-- |                                     Parameters.  Added new section 5 for Payables
-- |                                     invoices which are unmatched to POs or for IR/ISOs.
-- |  1.9     26 Feb 2025 Douglas Volz   Removed tabs, cleaned up for Blitz Report.
-- +=============================================================================+*/

## Report Parameters
Report Mode, Transaction Date From, Transaction Date To, Transaction Type, Item Number, Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [cst_misc_reconciliation](https://www.enginatics.com/library/?pg=1&find=cst_misc_reconciliation), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-ap-accrual-ir-iso-match-analysis/) |
| Blitz Report™ XML Import | [CAC_AP_Accrual_IR_ISO_Match_Analysis.xml](https://www.enginatics.com/xml/cac-ap-accrual-ir-iso-match-analysis/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-ap-accrual-ir-iso-match-analysis/](https://www.enginatics.com/reports/cac-ap-accrual-ir-iso-match-analysis/) |

## Case Study & Technical Analysis: CAC AP Accrual IR ISO Match Analysis

### Executive Summary
The **CAC AP Accrual IR ISO Match Analysis** is a specialized reconciliation tool designed to solve one of the most complex accounting challenges in Oracle E-Business Suite: reconciling Internal Requisitions (IR) and Internal Sales Orders (ISO). This report bridges the gap between the **Inventory Receipt** (which generates the accrual liability) and the **Intercompany AP Invoice** (which clears that liability). By matching these transactions at the Sales Order Line level, it provides a clear picture of the intercompany accrual balance, identifying missing invoices or receipts that cause period-end write-off issues.

### Business Challenge
Intercompany transfers involve two distinct accounting events that often happen at different times and in different modules:
1.  **Shipment/Receipt:** The receiving organization records a receipt, debiting Inventory and crediting the Intercompany Accrual account.
2.  **Invoicing:** The shipping organization generates an AR invoice, which triggers the creation of an AP invoice in the receiving organization to clear the accrual.

**The Problem:** Standard Oracle reports often struggle to link these two events effectively. If the AP invoice creation fails, is delayed, or is matched incorrectly, the accrual balance remains open indefinitely. Finance teams often spend days manually searching for the corresponding AP invoice for a specific inventory receipt to prove the balance is valid.

### Solution
This report automates the matching process by using the **Internal Sales Order (ISO)** number as the common identifier between the Inventory and Payables modules.
*   **Automated Matching:** Programmatically links `MTL_MATERIAL_TRANSACTIONS` (Receipts) with `AP_INVOICES_ALL` (Invoices) via the Order Management tables.
*   **Variance Detection:** Instantly highlights receipts that have no corresponding AP invoice (Uninvoiced Receipts) and AP invoices that cannot be linked to a receipt.
*   **Detail & Summary Modes:**
    *   **Detail Mode:** Shows every individual receipt and invoice line, perfect for deep-dive investigation.
    *   **Summary Mode:** Aggregates data by Sales Order Line to show the net accrual balance per transaction.

### Technical Architecture
The report employs a complex multi-module join strategy to reconstruct the transaction lifecycle:
*   **Inventory Leg:** Queries `MTL_MATERIAL_TRANSACTIONS` and `CST_MISC_RECONCILIATION` to identify the accrual liability generated by the receipt.
*   **Order Management Leg:** Uses `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL` to traverse from the inventory transaction back to the source order.
*   **Payables Leg:** Queries `AP_INVOICES_ALL` and `AP_INVOICE_LINES_ALL`, looking for invoices referenced by the Internal Sales Order.
*   **Logic:** The SQL handles complex scenarios, including "Intransit Shipments" (FOB Shipment) where the liability is booked upon shipment rather than receipt.

### Parameters & Filtering
*   **Report Mode:** (Mandatory) Choose `Detail` for line-level auditing or `Summary` for high-level balance review.
*   **Transaction Date:** Filter by a specific date range to isolate period-specific issues.
*   **Transaction Type:** Filter by specific inventory transaction types (e.g., 'Internal Order Intr Rcpt').
*   **Category Sets:** Supports reporting by up to three different Item Category Sets (e.g., Inventory, Cost, Purchasing) for flexible grouping.
*   **Organization/Operating Unit:** Filter by specific Inventory Organizations or Operating Units.

### Performance & Optimization
*   **Complexity:** High. This report joins large transaction tables across three major modules (INV, OM, AP).
*   **Optimization:**
    *   Ensure the `Transaction Date` range is reasonable (e.g., one period or quarter) to maintain performance.
    *   Filtering by `Item Number` or `Sales Order` significantly speeds up the query for targeted investigations.

### FAQ
**Q: Why does the report show a "Net Amount" difference?**
A: A difference implies that the amount accrued upon receipt differs from the amount invoiced. This can happen due to price variances, currency exchange rate differences between the receipt date and invoice date, or partial invoicing.

**Q: Does this report handle FOB Shipment vs. FOB Destination?**
A: Yes, the SQL logic (specifically around version 1.7) includes sections to report Intransit Shipments for FOB Shipment scenarios where the order is booked in one OU but shipped from another.

**Q: What should I do with "Unmatched Receipts"?**
A: These represent liabilities that have not been cleared. You should investigate if the "Create Intercompany AP Invoices" program has run successfully or if the invoice is stuck in the AP Interface tables.


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
