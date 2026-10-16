# Case Study & Technical Analysis: AP Invoice and Payment Audit by Voucher Number

## Executive Summary
This report lists every voucher number issued from the Oracle Payables invoice and payment document sequences, with the status of each number: Entered, Deleted or Not Entered. Accounts payable supervisors, internal auditors and period-close teams use it to show that every sequentially numbered invoice and payment document is accounted for. The report replaces Oracle's Invoice Audit by Voucher Number and Payment Audit by Voucher Number reports and runs in Excel through Blitz Report™.

## Business Challenge
*   **Sequence gaps:** A missing voucher number in a document sequence can hide a lost, voided or unrecorded invoice or payment, and auditors require each gap to be explained.
*   **Voided versus deleted documents:** A voided payment must be distinguishable from a number that was issued but no longer has a payment behind it.
*   **Multi-ledger control:** Document sequences are assigned per ledger and operating unit, so numbering has to be checked against the correct set of books.
*   **Period-close evidence:** Payments need to be attributed to the accounting period of their GL date when completeness of vouchers is reviewed.

## The Solution
*   Builds the full range of voucher numbers from the sequence audit trail, so a number that was never recorded appears as Not Entered instead of silently disappearing.
*   Matches each recorded number to an invoice in `AP_INVOICES_ALL` or a check in `AP_CHECKS_ALL` and labels it Entered or Deleted, with the void date where a payment was voided.
*   Derives the GL date of a payment from the earliest accounting date of its invoice payments, and shows the supplier, currency, amount and payment status beside each number.
*   Restricts the output by Ledger, Operating Unit, Sequence Name, a voucher number range, a GL date range and Status.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_DOCUMENT_SEQUENCES`: the document sequence definitions, including the initial value used to start gap counting.
*   `AP_DOC_SEQUENCE_AUDIT`: one row per recorded sequence value, which is the basis of the gap analysis.
*   `FND_DOC_SEQUENCE_ASSIGNMENTS` and `FND_DOC_SEQUENCE_CATEGORIES`: link each sequence to its set of books and to the Payables category.
*   `AP_INVOICES_ALL`: the invoice behind an audit row, supplying invoice number, GL date, amount and payment status.
*   `AP_CHECKS_ALL` and `AP_INVOICE_PAYMENTS_ALL`: the payment behind an audit row, its void date and the earliest accounting date of its payments.
*   `AP_SUPPLIERS`: supplier name and supplier number.
*   `HR_OPERATING_UNITS`, `HR_ALL_ORGANIZATION_UNITS_VL` and `GL_LEDGERS`: operating unit, set of books and ledger names.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the organizations the user can access, with a release check for Release 11.

### Logical Relationships
1.  Sequence assignments are limited to the sets of books of the operating units the user can access.
2.  Each audit row is outer-joined to `AP_INVOICES_ALL` and `AP_CHECKS_ALL` on sequence identifier and sequence value, so unmatched numbers are kept.
3.  An analytic LAG over each sequence returns the previously recorded value, which defines the start of each gap.
4.  A row generator (`XXEN_UTIL.ROWGEN`) expands every gap into individual voucher numbers.
5.  Generated gap numbers receive status N (Not Entered); recorded numbers keep the status derived from the invoice or check.
6.  The result joins to `GL_LEDGERS`, the operating unit, and `AP_SUPPLIERS`, and is sorted by sequence name and voucher number.

## Parameters & Filtering
*   **Ledger** and **Operating Unit:** restrict the document sequences to those assigned to the selected sets of books.
*   **Sequence Name:** limits the report to one Payables document sequence.
*   **Voucher Number From** and **Voucher Number To:** define the window of sequence values listed.
*   **GL Date From** and **GL Date To:** define the accounting window used to bound each sequence's numbering range.
*   **Status:** filters the rows by Entered, Deleted or Not Entered.

## Performance & Optimization
*   The LAG and MIN/MAX analytic functions partitioned by sequence identifier find every gap in a single pass over the audit table instead of a self-join.
*   Numbers are generated only between recorded values, and numbers after the last recorded voucher are not generated, so the row count follows the actual gaps.
*   The organization security subquery against `MO_GLOB_ORG_ACCESS_TMP` restricts sequences before the joins to invoices and checks.
*   The GL date and payment status derivations are correlated subqueries evaluated per row, so narrowing the ledger, sequence and date parameters is the main lever on run time.

## FAQ
**Q: What does Not Entered mean in the Payables voucher audit?**
A: Not Entered means the voucher number is missing from the sequence audit trail, so no invoice or payment was recorded against that number.

**Q: How is a voided payment shown in this report?**
A: A voided payment is listed as Entered with its void date, while a payment number with no payment behind it is listed as Deleted.

**Q: How is the GL date of a payment determined?**
A: The GL date of a payment is the earliest accounting date of its invoice payments, taken from `AP_INVOICE_PAYMENTS_ALL`.
