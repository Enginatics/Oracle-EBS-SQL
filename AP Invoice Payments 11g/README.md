---
layout: default
last_modified_at: 2026-10-16
title: 'AP Invoice Payments 11g | Oracle EBS SQL Report'
description: '11g-compatible version of AP Invoice Payments. Supplier invoice payment details. There can be multiple payments per invoice and one document/check can be…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Invoice, Payments, 11g, iby_payment_profiles, gl_je_batches, ap_invoice_distributions_all'
permalink: /AP%20Invoice%20Payments%2011g/
report_name: 'AP Invoice Payments 11g'
report_web_name: ap-invoice-payments-11g
module: 'Payables'
module_url: /modules/payables/
---

# AP Invoice Payments 11g – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-payments-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
11g-compatible version of AP Invoice Payments.

Supplier invoice payment details.
There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To allow reconciling payment with invoices and checks, invoice and check level amounts are shown on the last payment record only and are blank for multiple/duplicate records.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Payment Date From, Payment Date To, Accounting Date From, Accounting Date To, Supplier, Supplier Number, Supplier Site, Invoice Number, Check Number, Check State

## Oracle EBS Tables Used
[iby_payment_profiles](https://www.enginatics.com/library/?pg=1&find=iby_payment_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g), [ap_inv_selection_criteria_all](https://www.enginatics.com/library/?pg=1&find=ap_inv_selection_criteria_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)

## Related Reports
[AP Invoice Payments](/AP%20Invoice%20Payments/ "AP Invoice Payments Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Payments%2011g/AP%20Invoice%20Payments%2011g.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-invoice-payments-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g) |
| Blitz Report™ XML Import | [AP_Invoice_Payments_11g.xml](https://www.enginatics.com/xml/ap-invoice-payments-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g) |
| SQL Source | [AP Invoice Payments 11g.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Payments%2011g/AP%20Invoice%20Payments%2011g.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-invoice-payments-11g/](https://www.enginatics.com/reports/ap-invoice-payments-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g) |

## Case Study & Technical Analysis: AP Invoice Payments 11g

### Executive Summary
The AP Invoice Payments 11g report is the Oracle Database 11g compatible version of the supplier invoice payment listing. It shows the payment details of each supplier invoice, including every payment record, the check or document that settled it, the bank account used and the payment amounts in invoice, check and functional currency. It is written for Payables supervisors, cash management teams and finance controllers who must reconcile invoices with the checks and electronic payments that settled them. It sits in the Payables module.

### Business Challenge
*   **Reconciling payments to invoices:** Finance teams need to match each invoice to its payments and to the check or document that carried them, across multiple payments per invoice.
*   **Avoiding double counting:** A single check can pay several invoices, so totals taken naively from payment rows overstate what was paid.
*   **Multi-currency visibility:** Payments in foreign currency must be shown in invoice, check, functional and USD terms for management reporting.

### The Solution
*   **Single-amount-per-document logic:** Invoice and check amounts are shown only on the last payment record for each invoice or check, using analytic functions over the payment identifiers, so that totals can be summed without duplication.
*   **Multi-currency amounts:** Invoice, check and payment amounts are returned in invoice currency, functional currency and USD, with USD derived from the corporate daily rate.
*   **Bank context:** Bank name, branch EFT or SWIFT code, bank account name and masked account number are returned from the Cash Management bank tables.

### Technical Architecture (High Level)
#### Primary Tables
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

#### Logical Relationships
1. `AP_INVOICE_PAYMENTS_ALL` joins to `AP_CHECKS_ALL` on the check identifier, giving the document behind each payment.
2. Payments join to `AP_INVOICES_ALL`, and from there to `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`.
3. Payments join to `AP_PAYMENT_SCHEDULES_ALL` on invoice and payment number, supplying the due date and remaining amount.
4. Checks join to `GL_DAILY_RATES` on currency and check date, for the USD conversion.
5. Checks join through `CE_BANK_ACCT_USES_ALL` to `CE_BANK_ACCOUNTS` and `CE_BANK_BRANCHES_V`, giving bank details.
6. Payments join to `GL_LEDGERS` and `HR_OPERATING_UNITS` through the set of books and organisation identifiers.

### Parameters & Filtering
*   **Ledger and Operating Unit:** Restrict payments to one ledger or operating unit.
*   **Payment Date From and Payment Date To:** Bound the check date of the payments.
*   **Accounting Date From and Accounting Date To:** Bound the accounting date of the payment records.
*   **Supplier, Supplier Number and Supplier Site:** Restrict the output to one supplier or site.
*   **Invoice Number:** Shows the payments of a single invoice.
*   **Check Number:** Shows the invoices and payments carried by one check or document.
*   **Check State:** Filters on the check status, translated through the CHECK STATE lookup.

### Performance & Optimization
*   **Analytic window functions:** `max` and `sum` over partitions by invoice and by check replace self-joins, so invoice and check totals are computed in one pass.
*   **Outer joins for optional sources:** Bank, rate, territory and term tables are attached with outer joins, so payments without those references are still returned.
*   **Distribution account aggregation:** The distribution accounts are gathered with `xmlagg` into a single text value per payment, avoiding a separate row for each distribution.

### FAQ
**Q: How do I list every payment made against a supplier invoice in Oracle Payables?**
A: Run AP Invoice Payments 11g with the Invoice Number parameter, and read the payment number, payment date, payment amount and document number on each row.

**Q: Why are some invoice and check amounts blank on certain rows?**
A: Invoice and check level amounts are shown on the last payment record only, so duplicate records for the same invoice or check are left blank to allow reconciliation.

**Q: How are foreign currency payments converted to USD in this report?**
A: The USD amounts use the corporate rate from `GL_DAILY_RATES` for the check date, and amounts in USD currency are not converted.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments-11g)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
