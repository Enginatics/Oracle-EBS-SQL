---
layout: default
last_modified_at: 2026-10-19
title: 'AP Prepayments Status | Oracle EBS SQL Report'
description: 'Prepayments with an unapplied amount and the open, that is unpaid or partially paid, invoices, credit and debit memos of the suppliers holding such a…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, R12 only, Prepayments, Status, ap_invoice_distributions_all, ap_invoice_lines_all, ap_payment_schedules_all'
permalink: /AP%20Prepayments%20Status/
report_name: 'AP Prepayments Status'
report_web_name: ap-prepayments-status
module: 'Payables'
module_url: /modules/payables/
---

# AP Prepayments Status – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-prepayments-status/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Prepayments with an unapplied amount and the open, that is unpaid or partially paid, invoices, credit and debit memos of the suppliers holding such a prepayment, one row per invoice.

Equivalent to the Oracle standard Prepayments Status Report (APXINPSR). Amount Remaining is in the invoice currency: for a prepayment the amount not yet applied, for other invoices the unpaid payment schedule amount converted at the payment cross rate. Net Amount Remaining nets paid temporary prepayments (negative) against open invoices and permanent prepayments; an unpaid prepayment counts as zero.

Show Prepayment Lines adds one row per item line of a paid prepayment that still has an amount available to apply, with its purchase order and receipt.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Supplier, Supplier Type, Prepayment Type, Include Invoices, Include Credit/Debit Memos, Invoice Date From, Invoice Date To, Show Prepayment Lines

## Oracle EBS Tables Used
[ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)

## Related Reports
[PO Procure to Pay Tracker](/PO%20Procure%20to%20Pay%20Tracker/ "PO Procure to Pay Tracker Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [AP Invoice and Payment Audit by Voucher Number](/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number/ "AP Invoice and Payment Audit by Voucher Number Oracle EBS SQL Report"), [AP Invoice Payment Upload](/AP%20Invoice%20Payment%20Upload/ "AP Invoice Payment Upload Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Prepayments%20Status/AP%20Prepayments%20Status.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-prepayments-status/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status) |
| Blitz Report™ XML Import | [AP_Prepayments_Status.xml](https://www.enginatics.com/xml/ap-prepayments-status/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status) |
| SQL Source | [AP Prepayments Status.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Prepayments%20Status/AP%20Prepayments%20Status.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-prepayments-status/](https://www.enginatics.com/reports/ap-prepayments-status/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status) |

## Case Study & Technical Analysis: AP Prepayments Status

### Executive Summary
The AP Prepayments Status report shows the Oracle Payables prepayments that still hold an unapplied amount, together with the open invoices, credit memos and debit memos of the suppliers who hold them. It has one row per invoice, and a prepayment line is added when Show Prepayment Lines is set. Accounts Payable managers use it to decide which prepayments to apply, to check supplier balances and to net the amounts owed to a supplier before payment. It follows the logic of the Oracle standard Prepayments Status Report (APXINPSR), and runs in Excel through Blitz Report.

### Business Challenge
*   **Unapplied prepayments:** A prepayment is useful only when applied to invoices, and an unapplied balance ties up cash that should be recovered.
*   **Net supplier position:** Temporary prepayments are negative and offset open invoices, so the true amount owed to a supplier is not visible from the invoice list alone.
*   **Currency consistency:** Amounts paid in another currency must be shown in the invoice currency to be compared.
*   **Purchasing traceability:** A prepayment item is linked to a purchase order and receipt, which the buyer needs to see before applying it.

### The Solution
*   Selects every prepayment with an amount not yet applied, and every open invoice or memo of the same supplier and operating unit, so both sides of a supplier's position appear in one list.
*   Calculates the Amount Remaining of an invoice in the invoice currency, from the payment schedule amounts converted at the payment cross rate, or from the amount not yet applied for a prepayment.
*   Calculates a Net Amount Remaining that nets paid temporary prepayments against open invoices, and counts an unpaid prepayment as zero.
*   Adds one row per paid item line of a prepayment that still has an amount available to apply, with its purchase order and receipt numbers.

### Technical Architecture (High Level)
#### Primary Tables
*   `AP_INVOICES_ALL`: prepayments, invoices, credit memos and debit memos, with payment status and earliest settlement date.
*   `AP_INVOICE_DISTRIBUTIONS_ALL`: the distributions that carry the prepay amount remaining for each line.
*   `AP_INVOICE_LINES_ALL`: the item lines of a prepayment, with the line selection flag.
*   `AP_PAYMENT_SCHEDULES_ALL`: the payment schedules, whose remaining amounts give the amount remaining of an open invoice.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and its site.
*   `GL_LEDGERS`, `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the ledger, operating unit and organization access.
*   `PO_HEADERS_ALL`, `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the purchase order and receipt of a prepayment line.

#### Logical Relationships
1.  `AP_INVOICES_ALL` is joined to `AP_SUPPLIERS`, `AP_SUPPLIER_SITES_ALL`, `GL_LEDGERS` and `HR_ALL_ORGANIZATION_UNITS_VL`, and restricted to the operating units in `MO_GLOB_ORG_ACCESS_TMP`.
2.  Open invoices have payment status N or P, and prepayments are of type PREPAYMENT. Cancelled invoices are excluded.
3.  Invoice lines of a prepayment are joined on invoice id, and each line to its purchase order header and to its receipt transaction and shipment header.
4.  An analytic MAX over the supplier and operating unit identifies the suppliers that hold a prepayment, and only those suppliers' rows are returned.

### Parameters & Filtering
*   **Ledger** and **Operating Unit:** restrict the invoices to one ledger or operating unit.
*   **Supplier** and **Supplier Type:** select one supplier or one supplier type.
*   **Prepayment Type:** selects temporary or permanent prepayments.
*   **Include Invoices** and **Include Credit/Debit Memos:** choose whether standard invoices and memos are listed with the prepayments.
*   **Invoice Date From** and **Invoice Date To:** bound the invoice dates.
*   **Show Prepayment Lines:** when set to Y, adds one row for each item line of a paid prepayment that still has an amount available to apply.

### Performance & Optimization
*   The prepayment amount remaining is taken from the distributions as a sum of the prepay amount remaining, which avoids a second pass over the payment schedules for prepayments.
*   The analytic MAX over supplier and operating unit is computed once for the whole result, so the supplier filter needs no separate subquery.
*   Operating unit access is applied through `MO_GLOB_ORG_ACCESS_TMP`, so only the organizations the responsibility can see are read.
*   Setting Invoice Date From and Supplier narrows the invoices before the nested sums run, the most effective way to reduce the work on a large ledger.

### FAQ
**Q: How do I find unapplied prepayments for a supplier in Oracle Payables?**
A: Set the Supplier parameter and leave Prepayment Type open. The prepayment status column shows UNPAID, PERMANENT or AVAILABLE for each prepayment held.

**Q: How is the net amount remaining calculated?**
A: A paid temporary prepayment counts as a negative amount, a permanent prepayment at its amount remaining, an unpaid prepayment as zero, and any other invoice at its amount remaining.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-prepayments-status)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
