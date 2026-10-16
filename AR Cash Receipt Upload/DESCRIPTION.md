# Case Study & Technical Analysis: AR Cash Receipt Upload

## Executive Summary
This upload creates Oracle Receivables cash receipts in bulk and optionally applies them to open customer invoices, to a specific invoice number, or on account. It serves cash application teams that receive lockbox files, bank remittance advices or manual payments and need them recorded in the AR subledger without keying each receipt into the Receipts window. Each spreadsheet row creates or applies one receipt, and the same workbook can apply existing receipts to further invoices. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Manual receipt entry:** Keying every customer payment into the Receipts form is slow and error-prone when a period produces hundreds of remittances.
*   **Multi-invoice remittances:** One payment often settles several invoices, and each application has to be recorded against the same receipt.
*   **Unmatched cash:** Receipts that cannot yet be tied to an invoice must still be recorded as Unapplied or On Account before period close.
*   **Bank and flexfield consistency:** The remittance bank account and the receipt descriptive flexfield values must follow the receipt method setup.
*   **Non-customer income:** Bank interest and refunds need recording as Miscellaneous receipts that post through a Receivables Activity rather than against a customer.

## The Solution
*   **Receipt creation by number:** A row creates the receipt when its Receipt Number is new. Later rows that repeat the number add one application each against the receipt that already exists.
*   **Application options:** A blank Invoice Number leaves the receipt Unapplied. An Invoice Number applies it to that invoice. Apply on Account = Yes applies it to the customer without a specific invoice.
*   **Bank account defaulting:** The remittance bank account defaults to the primary bank account of the receipt method. A non-primary account can be picked from the list of values, and the Override flag is then set to Yes.
*   **Apply-only mode:** An existing Receipt Number with application columns only adds applications. Receipt Method, Receipt Amount, Receipt Date and Currency are needed only when a new receipt is created.
*   **Receipt type and notes:** Receipt Type switches between Standard and Miscellaneous. Issuer Name, Issue Date and Issuer Bank Branch are populated only for Notes Receivable and bills of exchange.

## Technical Architecture (High Level)
### Primary Tables
*   `AR_CASH_RECEIPTS_ALL`: the receipt header, with amount, currency, receipt date, method, remittance account, descriptive flexfield values and reversal data.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: one row per application, holding the amount applied, discount taken, apply date, GL date and on-account status.
*   `AR_PAYMENT_SCHEDULES_ALL`: the invoice installment that an application settles, identified by its terms sequence number.
*   `RA_CUSTOMER_TRX_ALL`: the invoice header that supplies the invoice number.
*   `AR_RECEIPT_METHODS` and `AR_RECEIVABLES_TRX_ALL`: the receipt method and the Receivables Activity used by Miscellaneous receipts.
*   `AR_CASH_RECEIPT_HISTORY_ALL`: the current history record, from which the GL date and reversal GL date are taken.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES` and `HZ_CUST_SITE_USES_ALL`: the customer, its party name and the bill-to site.
*   `CE_BANK_ACCT_USES_ALL`, `CE_BANK_ACCOUNTS`, `CE_BANK_BRANCHES_V` and `IBY_EXT_BANK_ACCOUNTS`: remittance, issuer and customer bank accounts.

### Logical Relationships
1. `HR_ALL_ORGANIZATION_UNITS_VL` supplies the operating unit, which is matched to `AR_CASH_RECEIPTS_ALL.org_id`.
2. `AR_CASH_RECEIPTS_ALL` joins to `AR_RECEIPT_METHODS` on the receipt method and to `HZ_CUST_ACCOUNTS` on the paying customer, then to `HZ_PARTIES` and `HZ_CUST_SITE_USES_ALL`.
3. `AR_CASH_RECEIPTS_ALL` joins to `AR_RECEIVABLE_APPLICATIONS_ALL` on the cash receipt id, as an outer join so unapplied receipts still appear.
4. Each application joins to `RA_CUSTOMER_TRX_ALL` on the applied customer transaction and to `AR_PAYMENT_SCHEDULES_ALL` on the applied payment schedule.
5. The remittance bank account is resolved from the remittance bank account use id through `CE_BANK_ACCT_USES_ALL` to `CE_BANK_ACCOUNTS`.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing receipts with their applications.
*   **Operating Unit:** restricts the receipts to one operating unit.
*   **Receipt Date From / Receipt Date To:** bound the receipts returned when the workbook is downloaded.
*   **Customer Name, Customer Number and Bill To Site:** narrow the downloaded receipts to one customer and site.
*   **Receipt Method:** restricts the downloaded receipts to one receipt method.

## Performance & Optimization
*   The receipt history lookups for GL date and reversal GL date are scalar subqueries keyed on the cash receipt id, so they run only for the receipts that the outer filters return.
*   Applications are joined with outer joins and a status filter of APP or ACC with display set to Y, which keeps unapplied receipts in the result without a second pass.

## FAQ
**Q: How do I apply one receipt to several invoices in a single upload?**
A: Enter one row per invoice with the same Receipt Number. The receipt is created on the first row, and each following row adds an application.

**Q: Can I apply a receipt to an existing receipt that was created earlier?**
A: Yes. Enter the existing Receipt Number with the Invoice Number and Amount Applied. Receipt Method, Amount, Date and Currency can be left blank.
