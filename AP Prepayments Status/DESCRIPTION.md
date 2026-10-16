# Case Study & Technical Analysis: AP Prepayments Status

## Executive Summary
The AP Prepayments Status report shows the Oracle Payables prepayments that still hold an unapplied amount, together with the open invoices, credit memos and debit memos of the suppliers who hold them. It has one row per invoice, and a prepayment line is added when Show Prepayment Lines is set. Accounts Payable managers use it to decide which prepayments to apply, to check supplier balances and to net the amounts owed to a supplier before payment. It follows the logic of the Oracle standard Prepayments Status Report (APXINPSR), and runs in Excel through Blitz Report.

## Business Challenge
*   **Unapplied prepayments:** A prepayment is useful only when applied to invoices, and an unapplied balance ties up cash that should be recovered.
*   **Net supplier position:** Temporary prepayments are negative and offset open invoices, so the true amount owed to a supplier is not visible from the invoice list alone.
*   **Currency consistency:** Amounts paid in another currency must be shown in the invoice currency to be compared.
*   **Purchasing traceability:** A prepayment item is linked to a purchase order and receipt, which the buyer needs to see before applying it.

## The Solution
*   Selects every prepayment with an amount not yet applied, and every open invoice or memo of the same supplier and operating unit, so both sides of a supplier's position appear in one list.
*   Calculates the Amount Remaining of an invoice in the invoice currency, from the payment schedule amounts converted at the payment cross rate, or from the amount not yet applied for a prepayment.
*   Calculates a Net Amount Remaining that nets paid temporary prepayments against open invoices, and counts an unpaid prepayment as zero.
*   Adds one row per paid item line of a prepayment that still has an amount available to apply, with its purchase order and receipt numbers.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_INVOICES_ALL`: prepayments, invoices, credit memos and debit memos, with payment status and earliest settlement date.
*   `AP_INVOICE_DISTRIBUTIONS_ALL`: the distributions that carry the prepay amount remaining for each line.
*   `AP_INVOICE_LINES_ALL`: the item lines of a prepayment, with the line selection flag.
*   `AP_PAYMENT_SCHEDULES_ALL`: the payment schedules, whose remaining amounts give the amount remaining of an open invoice.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and its site.
*   `GL_LEDGERS`, `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the ledger, operating unit and organization access.
*   `PO_HEADERS_ALL`, `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the purchase order and receipt of a prepayment line.

### Logical Relationships
1.  `AP_INVOICES_ALL` is joined to `AP_SUPPLIERS`, `AP_SUPPLIER_SITES_ALL`, `GL_LEDGERS` and `HR_ALL_ORGANIZATION_UNITS_VL`, and restricted to the operating units in `MO_GLOB_ORG_ACCESS_TMP`.
2.  Open invoices have payment status N or P, and prepayments are of type PREPAYMENT. Cancelled invoices are excluded.
3.  Invoice lines of a prepayment are joined on invoice id, and each line to its purchase order header and to its receipt transaction and shipment header.
4.  An analytic MAX over the supplier and operating unit identifies the suppliers that hold a prepayment, and only those suppliers' rows are returned.

## Parameters & Filtering
*   **Ledger** and **Operating Unit:** restrict the invoices to one ledger or operating unit.
*   **Supplier** and **Supplier Type:** select one supplier or one supplier type.
*   **Prepayment Type:** selects temporary or permanent prepayments.
*   **Include Invoices** and **Include Credit/Debit Memos:** choose whether standard invoices and memos are listed with the prepayments.
*   **Invoice Date From** and **Invoice Date To:** bound the invoice dates.
*   **Show Prepayment Lines:** when set to Y, adds one row for each item line of a paid prepayment that still has an amount available to apply.

## Performance & Optimization
*   The prepayment amount remaining is taken from the distributions as a sum of the prepay amount remaining, which avoids a second pass over the payment schedules for prepayments.
*   The analytic MAX over supplier and operating unit is computed once for the whole result, so the supplier filter needs no separate subquery.
*   Operating unit access is applied through `MO_GLOB_ORG_ACCESS_TMP`, so only the organizations the responsibility can see are read.
*   Setting Invoice Date From and Supplier narrows the invoices before the nested sums run, the most effective way to reduce the work on a large ledger.

## FAQ
**Q: How do I find unapplied prepayments for a supplier in Oracle Payables?**
A: Set the Supplier parameter and leave Prepayment Type open. The prepayment status column shows UNPAID, PERMANENT or AVAILABLE for each prepayment held.

**Q: How is the net amount remaining calculated?**
A: A paid temporary prepayment counts as a negative amount, a permanent prepayment at its amount remaining, an unpaid prepayment as zero, and any other invoice at its amount remaining.
