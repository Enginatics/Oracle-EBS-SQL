# Case Study & Technical Analysis: PO Procure to Pay Tracker

## Executive Summary
The PO Procure to Pay Tracker shows, for each purchase order shipment and for each requisition line not yet on a purchase order, the date of every step from requisition to payment, together with the accounting and general ledger posting of the invoice. It is written for procurement managers, accounts payable supervisors and process owners who need to see where a purchase is stuck in the procure-to-pay cycle. The report sits in the Purchasing module and is R12 only.

## Business Challenge
*   **Cycle time visibility:** Procurement leaders need to measure the time between requisition, purchase order approval, receipt, invoice and payment for each purchase.
*   **Locating stalled transactions:** Invoices held for matching, requisitions not yet ordered and purchase orders not yet received are common bottlenecks, and each needs a clear status.
*   **Three-way match control:** The invoice must match the purchase order and the receipt, so the team needs to see which invoices are blocked from payment and why.

## The Solution
*   **One row per shipment or open requisition line:** Purchase order shipments and unordered requisition lines appear in one listing, so both ends of the cycle are visible.
*   **Date of each step:** Requisition date and approval date, purchase order date and approval date, receipt date, invoice entry date, accounting date, GL posted date and paid date are returned together.
*   **Validation status:** The invoice distribution status is derived from the match status of its distributions, and reported as approved, never approved or needs reapproval.
*   **Holds and due dates:** Unreleased holds are listed by name with the hold date, and the due date and remaining amount come from the payment schedule.

## Technical Architecture (High Level)
### Primary Tables
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

### Logical Relationships
1. The report is built from a union of two sets: purchase order shipments, from `PO_HEADERS_ALL` through `PO_LINES_ALL` to `PO_LINE_LOCATIONS_ALL`, and requisition lines not on a purchase order.
2. Each shipment is linked to the requisition line that created it, and that requisition is joined to its header and requester.
3. Each shipment is linked to matched invoice lines through the line location identifier, and then to the invoice header.
4. The invoice links to its accounting entities in `XLA_TRANSACTION_ENTITIES`, then to `XLA_AE_HEADERS`, and to the journal through `XLA_AE_LINES` and `GL_IMPORT_REFERENCES`.
5. Payments link through the invoice identifier to `AP_INVOICE_PAYMENTS_ALL` and `AP_CHECKS_ALL`.

## Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit.
*   **Supplier and Buyer:** Restrict the rows to one supplier or one buyer.
*   **PO Number and Requisition Number:** Identify one purchase order or requisition.
*   **Creation Date From and Creation Date To:** Bound the creation date of the purchase order or requisition.

## Performance & Optimization
*   **Organisation access filter:** Both branches of the union are limited to operating units in the access table, so only permitted purchase orders and requisitions are scanned.
*   **Status-based exclusions:** Cancelled shipments, cancelled lines, closed requisition lines and requisitions that are system saved, cancelled, rejected or returned are excluded before the step lookups.
*   **Scalar subqueries for steps:** Receipt, invoice, hold, due date, accounting and payment dates are computed in correlated subqueries, so each step is read per shipment or invoice.

## FAQ
**Q: How do I see where a purchase order is stuck in procure to pay in Oracle Purchasing?**
A: Run PO Procure to Pay Tracker for the purchase order number and read the dates and status columns in sequence, from the requisition date through to the paid date.

**Q: Why does an invoice show needs reapproval?**
A: The validation status is needs reapproval when the invoice is approved but has been flagged for revalidation or carries an unreleased hold.

**Q: Is the invoiced amount the full invoice amount?**
A: The invoiced amount sums the matched item lines for the shipment, while the amount remaining is shown on the first row of each invoice so it can be summed.
