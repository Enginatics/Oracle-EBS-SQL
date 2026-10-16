# Case Study & Technical Analysis: AR Credit Memo Application Upload

## Executive Summary
This upload applies open credit memos to invoices and debit memos in Oracle Receivables, and unapplies existing credit memo applications. It mirrors the Applications action of the Transactions workbench, so the same rules govern each change. It is used by accounts receivable clerks and collections analysts who need to clear customer credits against open debt in bulk, usually at month end or after a dispute is settled. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Unapplied customer credits:** Credit memos that sit on account keep customer balances overstated and distort aging reports.
*   **Bulk clearing at close:** Applying credits one at a time in the Transactions window is slow when a customer carries many small credits.
*   **Reversing mistaken applications:** An application posted against the wrong invoice must be unapplied and re-applied without manual reconstruction.
*   **Audit of credit positions:** Finance needs a single list of open credits and their existing applications for each operating unit.

## The Solution
*   **Open credit list:** The download returns the operating unit's open credit memos, identified by a payment schedule with class CM, status OP and a non-zero remaining amount.
*   **Apply by row:** Entering an Apply To Invoice value on an open credit memo row creates an application to that invoice, with an installment, amount, apply date and GL date.
*   **Unapply by row:** Setting Unapply to Yes on an existing application row reverses it.
*   **Re-application rule:** An application cannot be changed in place. The clerk unapplies the old row, then enters the new application on the credit memo's open row.
*   **Both directions in one file:** Open credit memo rows and active application rows are combined in one result set, so a correction can be made in the same workbook.

## Technical Architecture (High Level)
### Primary Tables
*   `AR_PAYMENT_SCHEDULES_ALL`: the balance of each credit memo and invoice, with status and remaining amount.
*   `RA_CUSTOMER_TRX_ALL`: the credit memo and invoice transaction headers, including transaction number and date.
*   `RA_BATCH_SOURCES_ALL`: the batch source that created each credit memo.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: the applications, with amount applied, apply date, GL date, comments and application type.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the bill-to customer's account number and name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the session can access.

### Logical Relationships
1. The first query block starts from `AR_PAYMENT_SCHEDULES_ALL` with class CM and status OP, joins `RA_CUSTOMER_TRX_ALL` on the customer transaction id, and then reaches the batch source and customer.
2. The second query block starts from `AR_RECEIVABLE_APPLICATIONS_ALL` with application type CM and status APP, and joins the credit memo's transaction and payment schedule.
3. The applied invoice is reached through the applied customer transaction id and the applied payment schedule id, giving the invoice number and installment.
4. Both blocks restrict the operating unit through the organization list in `MO_GLOB_ORG_ACCESS_TMP` and join it to `HR_ALL_ORGANIZATION_UNITS_VL`.
5. The two blocks are combined with UNION ALL, so open credits and existing applications share one set of columns.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download credit memos and their applications.
*   **Operating Unit:** limits the credit memos and applications to one operating unit.
*   **Credit Memo Number:** finds one credit memo by its transaction number.
*   **Credit Memo Date From / Credit Memo Date To:** bound the credit memos by transaction date.
*   **Bill To Customer:** limits the rows to one customer.

## Performance & Optimization
*   The driving filter on payment schedule class CM and status OP reduces the first block to open credits before any join is evaluated.
*   Operating unit access is enforced with an IN subquery on `MO_GLOB_ORG_ACCESS_TMP`, so the report never returns rows from units the user cannot access.
*   Batch source is joined as an outer join, so credit memos without a recorded source still appear.

## FAQ
**Q: How do I apply an open credit memo to an invoice in Excel?**
A: Enter the invoice number in Apply To Invoice on the credit memo's row, then enter the installment, amount and dates on that row.

**Q: Why can I not change the amount of an existing application?**
A: Applications cannot be edited in place. Set Unapply to Yes on the existing row, then enter the new application on the open credit memo row.

**Q: Which credit memos are listed in the download?**
A: Credit memos with an open payment schedule and a remaining amount that is not zero, for the operating units the responsibility can access.
