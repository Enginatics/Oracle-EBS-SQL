---
layout: default
last_modified_at: 2026-10-16
title: 'PO Procure to Pay Tracker | Oracle EBS SQL Report'
description: 'One row per purchase order shipment, and per requisition line not yet on a purchase order, with the date of each step from requisition to payment and the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, R12 only, Procure, Pay, Tracker, ap_invoice_distributions_all, ap_holds_all, ap_payment_schedules_all'
permalink: /PO%20Procure%20to%20Pay%20Tracker/
report_name: 'PO Procure to Pay Tracker'
report_web_name: po-procure-to-pay-tracker
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Procure to Pay Tracker – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-procure-to-pay-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
One row per purchase order shipment, and per requisition line not yet on a purchase order, with the date of each step from requisition to payment and the accounting and GL posting of the invoice.

Requisition columns are those of the first requisition line placed on the shipment. Invoice columns are those of the first invoice matched to the shipment; Invoiced Amount sums its matched item lines. Validation Status reads as in the invoice workbench, Hold Name lists the invoice's unreleased holds, and Amount Remaining is shown on the invoice's first row only, so it can be summed. Paid Date is the latest payment date once the invoice is fully paid.

Accounted Date is when final accounting was created for the invoice, GL Posted Date when its journal was posted. Cancelled shipments and requisition lines are left out.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Supplier, Buyer, PO Number, Requisition Number, Creation Date From, Creation Date To, Open Only

## Oracle EBS Tables Used
[ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Procure%20to%20Pay%20Tracker/PO%20Procure%20to%20Pay%20Tracker.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/po-procure-to-pay-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker) |
| Blitz Report™ XML Import | [PO_Procure_to_Pay_Tracker.xml](https://www.enginatics.com/xml/po-procure-to-pay-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker) |
| SQL Source | [PO Procure to Pay Tracker.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Procure%20to%20Pay%20Tracker/PO%20Procure%20to%20Pay%20Tracker.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-procure-to-pay-tracker/](https://www.enginatics.com/reports/po-procure-to-pay-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker) |

## Case Study & Technical Analysis: PO Procure to Pay Tracker

### Executive Summary
The PO Procure to Pay Tracker shows, for each purchase order shipment and for each requisition line not yet on a purchase order, the date of every step from requisition to payment, together with the accounting and general ledger posting of the invoice. It is written for procurement managers, accounts payable supervisors and process owners who need to see where a purchase is stuck in the procure-to-pay cycle. The report sits in the Purchasing module and is R12 only.

### Business Challenge
*   **Cycle time visibility:** Procurement leaders need to measure the time between requisition, purchase order approval, receipt, invoice and payment for each purchase.
*   **Locating stalled transactions:** Invoices held for matching, requisitions not yet ordered and purchase orders not yet received are common bottlenecks, and each needs a clear status.
*   **Three-way match control:** The invoice must match the purchase order and the receipt, so the team needs to see which invoices are blocked from payment and why.

### The Solution
*   **One row per shipment or open requisition line:** Purchase order shipments and unordered requisition lines appear in one listing, so both ends of the cycle are visible.
*   **Date of each step:** Requisition date and approval date, purchase order date and approval date, receipt date, invoice entry date, accounting date, GL posted date and paid date are returned together.
*   **Validation status:** The invoice distribution status is derived from the match status of its distributions, and reported as approved, never approved or needs reapproval.
*   **Holds and due dates:** Unreleased holds are listed by name with the hold date, and the due date and remaining amount come from the payment schedule.

### Technical Architecture (High Level)
#### Primary Tables
*   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL` and `PO_RELEASES_ALL`: the purchase order header, line, shipment and release.
*   `PO_REQUISITION_HEADERS_ALL` and `PO_REQUISITION_LINES_ALL`: the requisitions, used for unordered requisition lines and the requisition of each shipment.
*   `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the receiving transactions and their receipt numbers.
*   `AP_INVOICES_ALL`, `AP_INVOICE_LINES_ALL` and `AP_INVOICE_DISTRIBUTIONS_ALL`: the invoice, its item lines and its distributions.
*   `AP_HOLDS_ALL`: the holds placed on the invoice.
*   `AP_PAYMENT_SCHEDULES_ALL`: the payment schedule, supplying due date and remaining amount.
*   `AP_INVOICE_PAYMENTS_ALL` and `AP_CHECKS_ALL`: the payments and checks.
*   `XLA_TRANSACTION_ENTITIES`, `XLA_AE_HEADERS` and `XLA_AE_LINES`: the subledger accounting entities.
*   `GL_IMPORT_REFERENCES` and `GL_JE_HEADERS`: the link to the general ledger journal and its posting status.
*   `AP_SUPPLIERS`, `AP_SUPPLIER_SITES_ALL` and `HR_ALL_ORGANIZATION_UNITS_VL`: the supplier, site and operating unit.
*   `PER_PEOPLE_X`, `MTL_SYSTEM_ITEMS_VL` and `MTL_CATEGORIES_KFV`: the buyer, requester, item and category.

#### Logical Relationships
1. The report is built from a union of two sets: purchase order shipments, from `PO_HEADERS_ALL` through `PO_LINES_ALL` to `PO_LINE_LOCATIONS_ALL`, and requisition lines not on a purchase order.
2. Each shipment is linked to the requisition line that created it, and that requisition is joined to its header and requester.
3. Each shipment is linked to matched invoice lines through the line location identifier, and then to the invoice header.
4. The invoice links to its accounting entities in `XLA_TRANSACTION_ENTITIES`, then to `XLA_AE_HEADERS`, and to the journal through `XLA_AE_LINES` and `GL_IMPORT_REFERENCES`.
5. Payments link through the invoice identifier to `AP_INVOICE_PAYMENTS_ALL` and `AP_CHECKS_ALL`.

### Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit.
*   **Supplier and Buyer:** Restrict the rows to one supplier or one buyer.
*   **PO Number and Requisition Number:** Identify one purchase order or requisition.
*   **Creation Date From and Creation Date To:** Bound the creation date of the purchase order or requisition.

### Performance & Optimization
*   **Organisation access filter:** Both branches of the union are limited to operating units in the access table, so only permitted purchase orders and requisitions are scanned.
*   **Status-based exclusions:** Cancelled shipments, cancelled lines, closed requisition lines and requisitions that are system saved, cancelled, rejected or returned are excluded before the step lookups.
*   **Scalar subqueries for steps:** Receipt, invoice, hold, due date, accounting and payment dates are computed in correlated subqueries, so each step is read per shipment or invoice.

### FAQ
**Q: How do I see where a purchase order is stuck in procure to pay in Oracle Purchasing?**
A: Run PO Procure to Pay Tracker for the purchase order number and read the dates and status columns in sequence, from the requisition date through to the paid date.

**Q: Why does an invoice show needs reapproval?**
A: The validation status is needs reapproval when the invoice is approved but has been flagged for revalidation or carries an unreleased hold.

**Q: Is the invoiced amount the full invoice amount?**
A: The invoiced amount sums the matched item lines for the shipment, while the amount remaining is shown on the first row of each invoice so it can be summed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-procure-to-pay-tracker)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
