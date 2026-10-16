# Case Study & Technical Analysis: AP 1099 Payments

## Executive Summary
The AP 1099 Payments report lists the payments made to 1099 reportable suppliers within a payment date range, grouped by supplier, tax reporting site, tax ID and 1099 income tax type. It is the Blitz Report equivalent of the Oracle standard 1099 Payments Report (APXTRRVT). Accounts payable staff and tax reporting teams use it to reconcile the amounts paid to each 1099 vendor before the year-end 1099 filing, and to separate gross reportable amounts from backup withholding. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Year-end 1099 reconciliation:** Tax teams must establish, for each reportable supplier, the amount paid in the calendar year and the 1099 type it belongs to, which the standard payment history does not present in one view.
*   **Backup withholding:** Amounts withheld under the MISC4 type must be reported separately from the reportable payment, and the net effect must be visible for each supplier.
*   **Multi-site vendors:** A supplier can have several supplier sites, and tax reporting must be attributed to a single tax reporting site within the correct Tax Reporting Entity.

## The Solution
*   **1099 vendor scope:** Suppliers are restricted to those present in `AP_1099_TAPE_DATA`, the vendors processed for 1099 reporting, and matched to the Tax Reporting Entity and its balancing segment lines.
*   **Prorated amount calculation:** Each invoice distribution amount is prorated by the payment amount divided by the net invoice amount from `AP_UTILITIES_PKG.NET_INVOICE_AMOUNT`, so partial payments yield the correct reportable portion.
*   **Backup withholding split:** Distributions typed MISC4 populate a separate Withheld Amount column, and their payment amount is sign-flipped so that Payment Amount reflects the net figure.
*   **Voided checks excluded:** Payments whose check was voided inside the date window are removed, so voids do not inflate the totals.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_INVOICE_PAYMENTS_ALL`: the payment-to-invoice link, supplying the payment amount and accounting date used for the date window.
*   `AP_INVOICE_DISTRIBUTIONS_ALL`: the distribution lines that carry the 1099 type (`TYPE_1099`) and the distribution amount.
*   `AP_INVOICES_ALL`: invoice header data, including the cancelled amount.
*   `AP_CHECKS_ALL`: the check number, date and void date.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: supplier identity, 1099 identifiers and the tax reporting site.
*   `AP_REPORTING_ENTITIES_ALL` and `AP_REPORTING_ENTITY_LINES_ALL`: Tax Reporting Entity definitions and their balancing segment values.
*   `AP_1099_TAPE_DATA`: the vendors processed for 1099 reporting.
*   `CE_BANK_ACCT_USES_ALL` and `CE_BANK_ACCOUNTS`: the bank account used for the payment.
*   `GL_CODE_COMBINATIONS` and `GL_LEDGERS`: balancing segment matching and the ledger.
*   `PER_ALL_PEOPLE_F`: the employee record that supplies the national identifier for employee vendors.

### Logical Relationships
1.  `AP_REPORTING_ENTITIES_ALL` joins to `AP_REPORTING_ENTITY_LINES_ALL` on the tax entity, then to the operating unit and ledger.
2.  The balancing segment is matched to the distribution code combination (INV) or to the bank account asset code combination (PAY).
3.  `AP_SUPPLIERS` joins to the 1099 vendor list and to the single selected row from `AP_SUPPLIER_SITES_ALL`.
4.  Invoices join to their distributions and payments, and each payment joins to `AP_CHECKS_ALL` and then to the bank account.
5.  Detail rows are aggregated by supplier, supplier number, tax reporting site, tax ID, income tax type and region.

## Parameters & Filtering
*   **Reporting Option:** selects Summary or Detail output, which adds or removes the check and invoice columns.
*   **From Payment Date** and **To Payment Date:** bound the payment accounting date, and decide which distributions are prorated.
*   **Tax Reporting Entity:** limits the balancing segments and operating units reported.
*   **Federal Reportable Only:** when set to Y, keeps only suppliers flagged as federal reportable.
*   **Query Driver:** INV matches the balancing segment through the invoice distribution code combination, while PAY matches it through the bank account code combination.

## Performance & Optimization
*   The 1099 vendor restriction is an `IN` subquery on `AP_1099_TAPE_DATA`, so only 1099 vendors enter the payment join.
*   Tax reporting site selection uses an analytic `ROW_NUMBER` over the supplier site table, which avoids a correlated lookup per payment row.
*   Outer joins to `PER_ALL_PEOPLE_F` are restricted to the current effective row, so each supplier keeps one employee record.

## FAQ
**Q: How is backup withholding reported in the AP 1099 Payments report?**
A: Distributions typed MISC4 populate the Withheld Amount column as a positive value, and their payment amount is negated, so Payment Amount shows the net reportable figure.

**Q: Why does a voided check not appear in the 1099 payment totals?**
A: Payments whose check void date falls within the From and To Payment Date range are excluded by the condition on `AP_CHECKS_ALL.VOID_DATE`.

**Q: How does the report choose the tax reporting site for a supplier?**
A: It ranks the supplier's sites with an analytic function, placing the site flagged as tax reporting site first and otherwise the alphabetically first site, and keeps only the top row.
