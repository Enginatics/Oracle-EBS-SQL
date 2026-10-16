# Case Study & Technical Analysis: AP Invoice Payments 11g

## Executive Summary
The AP Invoice Payments 11g report is the Oracle Database 11g compatible version of the supplier invoice payment listing. It shows the payment details of each supplier invoice, including every payment record, the check or document that settled it, the bank account used and the payment amounts in invoice, check and functional currency. It is written for Payables supervisors, cash management teams and finance controllers who must reconcile invoices with the checks and electronic payments that settled them. It sits in the Payables module.

## Business Challenge
*   **Reconciling payments to invoices:** Finance teams need to match each invoice to its payments and to the check or document that carried them, across multiple payments per invoice.
*   **Avoiding double counting:** A single check can pay several invoices, so totals taken naively from payment rows overstate what was paid.
*   **Multi-currency visibility:** Payments in foreign currency must be shown in invoice, check, functional and USD terms for management reporting.

## The Solution
*   **Single-amount-per-document logic:** Invoice and check amounts are shown only on the last payment record for each invoice or check, using analytic functions over the payment identifiers, so that totals can be summed without duplication.
*   **Multi-currency amounts:** Invoice, check and payment amounts are returned in invoice currency, functional currency and USD, with USD derived from the corporate daily rate.
*   **Bank context:** Bank name, branch EFT or SWIFT code, bank account name and masked account number are returned from the Cash Management bank tables.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_INVOICE_PAYMENTS_ALL`: one row per payment applied to an invoice, the core of the report.
*   `AP_CHECKS_ALL`: the check or electronic document that carried the payment, including state, amount and cleared amount.
*   `AP_INVOICES_ALL`: the invoice header, including number, type, amount and paid amount.
*   `AP_INVOICE_DISTRIBUTIONS_ALL`: the invoice distributions, used to list distribution accounts.
*   `AP_PAYMENT_SCHEDULES_ALL`: the payment schedule, supplying the due date and remaining amount.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `AP_INV_SELECTION_CRITERIA_ALL`: the payment run that created the check.
*   `CE_BANK_ACCT_USES_ALL`, `CE_BANK_ACCOUNTS` and `CE_BANK_BRANCHES_V`: the bank account and branch used for payment.
*   `IBY_PAYMENT_METHODS_VL` and `IBY_PAYMENT_PROFILES`: the payment method and payment profile.
*   `GL_DAILY_RATES`: the corporate rate used for USD amounts.
*   `GL_CODE_COMBINATIONS_KFV`, `GL_JE_BATCHES`, `GL_LEDGERS` and `HR_OPERATING_UNITS`: accounting, ledger and organisation context.

### Logical Relationships
1. `AP_INVOICE_PAYMENTS_ALL` joins to `AP_CHECKS_ALL` on the check identifier, giving the document behind each payment.
2. Payments join to `AP_INVOICES_ALL`, and from there to `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`.
3. Payments join to `AP_PAYMENT_SCHEDULES_ALL` on invoice and payment number, supplying the due date and remaining amount.
4. Checks join to `GL_DAILY_RATES` on currency and check date, for the USD conversion.
5. Checks join through `CE_BANK_ACCT_USES_ALL` to `CE_BANK_ACCOUNTS` and `CE_BANK_BRANCHES_V`, giving bank details.
6. Payments join to `GL_LEDGERS` and `HR_OPERATING_UNITS` through the set of books and organisation identifiers.

## Parameters & Filtering
*   **Ledger and Operating Unit:** Restrict payments to one ledger or operating unit.
*   **Payment Date From and Payment Date To:** Bound the check date of the payments.
*   **Accounting Date From and Accounting Date To:** Bound the accounting date of the payment records.
*   **Supplier, Supplier Number and Supplier Site:** Restrict the output to one supplier or site.
*   **Invoice Number:** Shows the payments of a single invoice.
*   **Check Number:** Shows the invoices and payments carried by one check or document.
*   **Check State:** Filters on the check status, translated through the CHECK STATE lookup.

## Performance & Optimization
*   **Analytic window functions:** `max` and `sum` over partitions by invoice and by check replace self-joins, so invoice and check totals are computed in one pass.
*   **Outer joins for optional sources:** Bank, rate, territory and term tables are attached with outer joins, so payments without those references are still returned.
*   **Distribution account aggregation:** The distribution accounts are gathered with `xmlagg` into a single text value per payment, avoiding a separate row for each distribution.

## FAQ
**Q: How do I list every payment made against a supplier invoice in Oracle Payables?**
A: Run AP Invoice Payments 11g with the Invoice Number parameter, and read the payment number, payment date, payment amount and document number on each row.

**Q: Why are some invoice and check amounts blank on certain rows?**
A: Invoice and check level amounts are shown on the last payment record only, so duplicate records for the same invoice or check are left blank to allow reconciliation.

**Q: How are foreign currency payments converted to USD in this report?**
A: The USD amounts use the corporate rate from `GL_DAILY_RATES` for the check date, and amounts in USD currency are not converted.
