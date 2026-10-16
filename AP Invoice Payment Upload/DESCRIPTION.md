# Case Study & Technical Analysis: AP Invoice Payment Upload

## Executive Summary
The AP Invoice Payment Upload is an Excel upload that records Manual and Quick payments of open Oracle Payables invoices and voids payments, in the same way as the Payments window. Each row is one invoice installment paid, and rows with identical payment columns form one payment. Accounts Payable teams use it to pay large numbers of invoices, to void payments in bulk and to correct payment details before they are finalized. Blitz Report downloads the open installments and existing payments, and the upload writes the changes back through the Payables invoice and payment tables.

## Business Challenge
*   **Volume payment processing:** Paying hundreds of installments one at a time in the Payments window is slow, while each payment must remain complete and balanced.
*   **Partial payments and discounts:** Amount Paid and Discount Taken must reflect the discount still available on the Payment Date, and an installment sometimes has to be paid only in part.
*   **Document control:** A Manual payment records a document already issued, while a Quick payment draws on the next number of a printed Payment Document, so each type needs its own data.
*   **Reversal:** Voiding a payment reverses all its invoice payments, and the team must control what happens to the invoices afterwards.

## The Solution
*   Downloads open installments of a supplier and operating unit as new rows to pay when the Open Invoices parameter is set, with the amount remaining and discount available filled in.
*   Groups rows with identical payment columns into one payment, and processes each payment as a whole: when any row fails validation, none of its rows are saved.
*   Downloads existing Manual and Quick payments in Create, Update mode, so a Void Date can be entered to void a payment.
*   Carries the Invoice Action, Hold Name and Hold Reason columns, which decide whether the invoices of a voided payment are left unpaid, put on hold or cancelled.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_CHECKS_ALL`: the payment header, with type, date, amount, currency, exchange rate and status.
*   `AP_INVOICE_PAYMENTS_ALL`: one row per invoice installment paid by a payment.
*   `AP_INVOICES_ALL`: the invoice header, supplying the invoice number, date, currency and approval status.
*   `AP_PAYMENT_SCHEDULES_ALL`: the installments of each invoice, with due date, amount remaining and hold flag.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the trading partner and supplier site.
*   `CE_PAYMENT_DOCUMENTS`, `HR_ALL_ORGANIZATION_UNITS_VL`, `GL_DAILY_CONVERSION_TYPES`, `AP_HOLDS_ALL`, `AP_SELECTED_INVOICES_ALL` and `MO_GLOB_ORG_ACCESS_TMP`: the payment document, operating unit, rate type, hold, selection and access controls.

### Logical Relationships
1.  Existing payments: `AP_CHECKS_ALL` is joined to `AP_INVOICE_PAYMENTS_ALL` on check id, and that row to its invoice and to the matching payment schedule. Reversal rows are excluded by the null reversal invoice payment id condition.
2.  Open installments: `AP_INVOICES_ALL` is joined to `AP_PAYMENT_SCHEDULES_ALL` and filtered to uncancelled, approved invoices whose installment is unpaid, not on hold and not in a check run.
3.  Exclusions: invoices with an unreleased hold in `AP_HOLDS_ALL`, or a row in `AP_SELECTED_INVOICES_ALL`, are left out of the open list.
4.  The two branches are combined with UNION ALL, so both have the same columns, with payment columns empty for open invoice rows.

## Parameters & Filtering
*   **Upload Mode:** selects whether rows are downloaded for creation, update or both.
*   **Operating Unit** and **Trading Partner:** restrict the rows to one operating unit and one supplier.
*   **Payment Date From** and **Payment Date To:** bound the payment dates of the existing payments downloaded.
*   **Document Num:** selects a payment by its document number.
*   **Open Invoices:** when set to Y, adds the open installments of the selected supplier and operating unit as new rows to pay.

## Performance & Optimization
*   Open invoices are selected by NOT IN and NOT EXISTS conditions on holds and selected invoices, so no open installment is joined more than once.
*   The approval status is checked through the `AP_INVOICES_PKG.GET_APPROVAL_STATUS` function in the final filter, so it runs only for invoices that pass the earlier conditions.
*   The operating unit access list is a subquery on `MO_GLOB_ORG_ACCESS_TMP`, which keeps the report within the responsibility's organizations.
*   Setting Trading Partner and Payment Date filters before the download keeps the rows of a large upload file to a manageable number.

## FAQ
**Q: How do I pay open invoices from Excel in Oracle Payables?**
A: Set the Open Invoices parameter to Y with the supplier and operating unit. The open installments are downloaded as new rows, with Amount Paid filled in as the full amount remaining less the discount available at the Payment Date.

**Q: How do I void an AP payment through the upload?**
A: Download the payment in Create, Update mode and enter a Void Date. Voiding reverses all the invoice payments of that payment, and the invoices become unpaid unless Invoice Action puts them on hold or cancels them.
