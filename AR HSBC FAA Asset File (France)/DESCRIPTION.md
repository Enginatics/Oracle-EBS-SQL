# Case Study & Technical Analysis: AR HSBC FAA Asset File (France)

## Executive Summary
This report extracts completed Receivables invoices and credit memos in the HSBC Factoring France FAA file format used for invoice discounting, producing one 532-character record per document. French sellers that assign receivables to HSBC use it to build each submission's asset file. The output is a delimited text file that is run through Blitz Report™ with Output Format set to TSV and written to the server output directory.

## Business Challenge
*   **Fixed-format submission:** HSBC requires a fixed-length asset file with 31 zones in a set order, and a manual build of that layout is error-prone.
*   **Debtor identification:** Each debtor must be identified with its French fiscal identifier, activity code, legal name, trade name and full bill-to address.
*   **Amount conventions:** Amounts must be positive, expressed in the smallest unit of the invoice currency and zero-filled to the left, with no decimal separator.
*   **Credit memo linkage:** A credit memo must carry the number of the invoice it reduces so that HSBC can reconcile the file.

## The Solution
*   Assembles each record in the exact zone order of the HSBC specification, padding or truncating each zone to its defined length and terminating each zone with a semicolon.
*   Converts amounts with the currency precision from `FND_CURRENCIES`, and derives the VAT rate as the highest tax rate on the document.
*   Populates the credited invoice number from the largest credit memo application, and sets the document type to F for an invoice and A for a credit note.
*   Removes semicolons, tabs and line breaks from text zones so that no record can be split, and applies the HSBC invoice status of RGL or LIT1 from amounts in dispute.

## Technical Architecture (High Level)
### Primary Tables
*   `RA_CUSTOMER_TRX_ALL`: the completed invoice and credit memo headers, including trx number, date, currency, purchase order and bill-to customer.
*   `RA_CUSTOMER_TRX_LINES_ALL`: the TAX lines whose extended amount gives the tax total of each document.
*   `AR_PAYMENT_SCHEDULES_ALL`: the INV and CM installments, supplying the amount including tax, due date and amount in dispute.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: the applications that link a credit memo to the invoice it reduces.
*   `ZX_LINES`: the tax rate of each transaction line, used for the VAT rate zone.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the debtor account, legal name, bill-to site and address.
*   `HR_OPERATING_UNITS`: the operating unit that restricts the transactions.
*   `FND_CURRENCIES`: the precision of the invoice currency.

### Logical Relationships
1.  Completed transactions (`COMPLETE_FLAG` = Y) in the selected operating unit are joined to their INV and CM payment schedules and grouped per transaction.
2.  The tax total comes from the TAX lines of `RA_CUSTOMER_TRX_LINES_ALL`, and the amount excluding tax is the total less that tax.
3.  The due date is the earliest installment due date, and the invoice status is LIT1 when any installment has an amount in dispute.
4.  The credited invoice is found in `AR_RECEIVABLE_APPLICATIONS_ALL` for applications of type CM with status APP, choosing the application with the largest amount.
5.  The bill-to customer account is joined to its party, then to the bill-to site use, account site, party site and location, supplying the debtor address.
6.  Records are built per document and ordered by debtor identifier and document number.

## Parameters & Filtering
*   **Operating Unit:** selects the transactions of one operating unit.
*   **Seller Account Number:** the account number allocated by HSBC; only its digits are kept, truncated to five characters and zero-filled.
*   **Currency:** a required parameter that defaults to the functional currency of the operating unit, and restricts each file to one currency.
*   **Invoice Date From** and **Invoice Date To:** bound the documents included in the file.

## Performance & Optimization
*   The transaction header is aggregated in an inline view before the debtor joins, so each document is processed once rather than once per installment.
*   The file creation timestamp uses an analytic MAX over the result, so no second pass is needed.
*   The VAT rate is a correlated subquery on `ZX_LINES` restricted to the transactions application and entity code, which keeps the lookup to one entity per document.
*   Text zones are cleaned with TRANSLATE and padded with RPAD to their fixed lengths.

## FAQ
**Q: What format does the HSBC France FAA asset file use?**
A: Each record is 532 characters long, contains 31 zones separated by semicolons, and is written as a text file with CR LF line endings and ANSI encoding by the custom post-process script.

**Q: How are amounts written in the FAA file?**
A: Amounts are always positive, expressed in the smallest unit of the invoice currency with no decimal separator, and zero-filled to the left.

**Q: Why must the report be run once for each currency?**
A: HSBC allocates a different seller account number for each currency, so a single file can only cover one currency and one seller account.
