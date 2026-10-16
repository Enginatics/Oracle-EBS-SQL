# Case Study & Technical Analysis: AP Period Close Exceptions

## Executive Summary
The AP Period Close Exceptions report lists the Oracle Payables items that stop an accounting period from closing cleanly. It covers invoice distributions that are not posted, invoices without distributions, payments that are not posted, future dated payments, unconfirmed payment batches and Subledger Accounting events that are not transferred or not processed. Accounting managers and Payables supervisors run it before period close to clear each exception by its owner. It follows the logic of the Oracle standard Period Close Exceptions Report (APXPCER), and runs in Excel through Blitz Report.

## Business Challenge
*   **Clean close:** A period cannot be closed while Payables holds unposted or unaccounted items, and these items are spread across invoices, payments and batches.
*   **Subledger to General Ledger reconciliation:** Events that are not transferred to the General Ledger leave the ledger incomplete for the period.
*   **Future dated payments:** Payments scheduled after the period end must be identified so that they fall into the right period.
*   **Ownership:** Each exception type has a different owner, so the report must group the items by type, ledger and operating unit.

## The Solution
*   Builds seven exception types, each as its own block of the query, and labels every row with the exception type in the Exception Type column.
*   Shows the ledger, operating unit, supplier, invoice or check number, accounting date, currency and amount for each exception, so that the owner of an item can find it.
*   Shows the bank account, the payment batch name and status, and the Subledger Accounting event type where these apply to the exception.
*   Reports the period name entered, so each printed or exported page is identified by its period.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_INVOICES_ALL` and `AP_INVOICE_DISTRIBUTIONS_ALL`: invoice headers and their distributions, used for unposted and missing distributions.
*   `AP_INVOICE_LINES_ALL`: invoice lines, compared with distributions to find invoices without distributions.
*   `AP_CHECKS_ALL` and `AP_PAYMENT_HISTORY_ALL`: payments and their history entries, used for unposted payments and future dated payments.
*   `AP_INV_SELECTION_CRITERIA_ALL` and `AP_SELECTED_INVOICES_ALL`: payment batches and the invoices selected for them.
*   `XLA_AE_HEADERS`, `XLA_EVENTS`, `XLA_EVENT_TYPES_TL` and `XLA_TRANSACTION_ENTITIES`: Subledger Accounting events and their transfer status.
*   `AP_SUPPLIERS`, `HZ_PARTIES`, `HR_ALL_ORGANIZATION_UNITS`, `GL_LEDGERS`, `FND_CURRENCIES`, `CE_BANK_ACCOUNTS` and `CE_BANK_ACCT_USES_ALL`: supplier, operating unit, ledger, currency and bank details.
*   `IBY_PAY_SERVICE_REQUESTS`: the Oracle Payments service requests that carry the status of a payment batch.

### Logical Relationships
1.  Each exception type is a separate UNION ALL branch, and the outer query returns `:period_name` with the branch rows.
2.  Invoice distributions are linked to invoices on invoice id, and the posted flag and reversal flag decide whether a distribution is unaccounted.
3.  Payment history rows are linked to checks on check id, and transaction types such as PAYMENT CREATED and PAYMENT CLEARING select the unposted history.
4.  Subledger events in `XLA_EVENTS` are linked to `XLA_TRANSACTION_ENTITIES` by entity id, and to `XLA_AE_HEADERS` for the transfer status. The entity code selects invoices or payments.
5.  Batch status is decoded from `AP_LOOKUP_CODES` and `FND_LOOKUPS`, and from the payment service request status for the Payments system.

## Parameters & Filtering
*   **Ledger** and **Operating Unit:** restrict the exceptions to one ledger or operating unit.
*   **Exception Type:** selects one of the exception types to report.
*   **Period Name:** the accounting period that the report is run for, and which is shown on every row.
*   **From Accounting Date** and **To Accounting Date:** bound the accounting dates of the exceptions.
*   **Supplier:** limits the invoices and payments to one supplier.

## Performance & Optimization
*   Each exception type is a separate block with its own filters, so the database reads only the tables needed for the type selected.
*   The batch status test calls `AP_PAYMENT_UTIL_PKG.GET_PSR_STATUS` only when a payment service request exists, as the DECODE checks for a null request id first.
*   Subledger Accounting events are filtered on the application id 200 for Payables and the transfer and process status codes, which keeps the event tables from being scanned without limit.
*   Running the report for one period and one exception type at a time keeps the output short and the query fast, since each block returns only the open items.

## FAQ
**Q: What does an Unaccounted Invoice Distribution exception mean?**
A: The invoice distribution is not posted and is not a reversal. The item must be posted before the period can be closed.

**Q: How do I find payments that are still future dated?**
A: Run the report with the Exception Type set to Future Dated Payments. These are issued checks with a future payment due date, shown with the accounting date on which they fall.