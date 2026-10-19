---
layout: default
last_modified_at: 2026-10-19
title: 'AP 1099 Payments | Oracle EBS SQL Report'
description: '1099 Payments report showing payments made to 1099 reportable suppliers. This is the Blitz Report equivalent of the Oracle standard 1099 Payments Report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, R12 only, 1099, Payments, ap_invoice_payments_all, ap_reporting_entities_all, ap_supplier_sites_all'
permalink: /AP%201099%20Payments/
report_name: 'AP 1099 Payments'
report_web_name: ap-1099-payments
module: 'Payables'
module_url: /modules/payables/
---

# AP 1099 Payments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-1099-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
1099 Payments report showing payments made to 1099 reportable suppliers.
This is the Blitz Report equivalent of the Oracle standard 1099 Payments Report (APXTRRVT).

The report lists suppliers from the 1099 tape data (vendors processed for 1099 reporting) along with their payment totals within the specified date range.

Key features:
- Uses ap_1099_tape_data to filter vendors processed for 1099 reporting
- Validates against Tax Reporting Entity and balancing segments
- Calculates payment amounts using Oracle AP_UTILITIES_PKG.Net_Invoice_Amount
- Determines tax reporting site (site with tax_reporting_site_flag=Y or first alphabetical site)
- Handles void checks by excluding payments voided within the date range
- Supports Summary (totals by supplier/type) and Detail (individual checks/invoices) modes
- MISC4 (Backup Withholding) amounts tracked separately as Withheld Amount
- Distribution Total shows gross amounts before withholding adjustments
- Payment Amount shows net reportable amounts (with MISC4 as negative)
- Query Driver parameter controls balancing segment matching (INV=invoice distribution, PAY=bank cash account)
- Employee vendors use national_identifier from per_all_people_f for tax ID
- Tax ID cleanup removes dashes, spaces, and treats 000000000 as blank

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, GST TAN No, CGST Amount, SGST Amount, IGST Amount, CGST Rate, SGST Rate, IGST Rate, GST Supplier Registration No, Custom Amount, Unclassified Tax Amount, Taxable Value, HSN SAC Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Reporting Option, From Payment Date, To Payment Date, Tax Reporting Entity, Supplier Name, Income Tax Region, Federal Reportable Only, Query Driver

## Oracle EBS Tables Used
[ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments), [ap_reporting_entities_all](https://www.enginatics.com/library/?pg=1&find=ap_reporting_entities_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments), [ap_1099_tape_data](https://www.enginatics.com/library/?pg=1&find=ap_1099_tape_data&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%201099%20Payments/AP%201099%20Payments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP 1099 Payments 28-Dec-2025 142614.xlsx](https://www.enginatics.com/example/ap-1099-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments) |
| Blitz Report™ XML Import | [AP_1099_Payments.xml](https://www.enginatics.com/xml/ap-1099-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments) |
| SQL Source | [AP 1099 Payments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%201099%20Payments/AP%201099%20Payments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-1099-payments/](https://www.enginatics.com/reports/ap-1099-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments) |

## Case Study & Technical Analysis: AP 1099 Payments

### Executive Summary
The AP 1099 Payments report lists the payments made to 1099 reportable suppliers within a payment date range, grouped by supplier, tax reporting site, tax ID and 1099 income tax type. It is the Blitz Report equivalent of the Oracle standard 1099 Payments Report (APXTRRVT). Accounts payable staff and tax reporting teams use it to reconcile the amounts paid to each 1099 vendor before the year-end 1099 filing, and to separate gross reportable amounts from backup withholding. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Year-end 1099 reconciliation:** Tax teams must establish, for each reportable supplier, the amount paid in the calendar year and the 1099 type it belongs to, which the standard payment history does not present in one view.
*   **Backup withholding:** Amounts withheld under the MISC4 type must be reported separately from the reportable payment, and the net effect must be visible for each supplier.
*   **Multi-site vendors:** A supplier can have several supplier sites, and tax reporting must be attributed to a single tax reporting site within the correct Tax Reporting Entity.

### The Solution
*   **1099 vendor scope:** Suppliers are restricted to those present in `AP_1099_TAPE_DATA`, the vendors processed for 1099 reporting, and matched to the Tax Reporting Entity and its balancing segment lines.
*   **Prorated amount calculation:** Each invoice distribution amount is prorated by the payment amount divided by the net invoice amount from `AP_UTILITIES_PKG.NET_INVOICE_AMOUNT`, so partial payments yield the correct reportable portion.
*   **Backup withholding split:** Distributions typed MISC4 populate a separate Withheld Amount column, and their payment amount is sign-flipped so that Payment Amount reflects the net figure.
*   **Voided checks excluded:** Payments whose check was voided inside the date window are removed, so voids do not inflate the totals.

### Technical Architecture (High Level)
#### Primary Tables
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

#### Logical Relationships
1.  `AP_REPORTING_ENTITIES_ALL` joins to `AP_REPORTING_ENTITY_LINES_ALL` on the tax entity, then to the operating unit and ledger.
2.  The balancing segment is matched to the distribution code combination (INV) or to the bank account asset code combination (PAY).
3.  `AP_SUPPLIERS` joins to the 1099 vendor list and to the single selected row from `AP_SUPPLIER_SITES_ALL`.
4.  Invoices join to their distributions and payments, and each payment joins to `AP_CHECKS_ALL` and then to the bank account.
5.  Detail rows are aggregated by supplier, supplier number, tax reporting site, tax ID, income tax type and region.

### Parameters & Filtering
*   **Reporting Option:** selects Summary or Detail output, which adds or removes the check and invoice columns.
*   **From Payment Date** and **To Payment Date:** bound the payment accounting date, and decide which distributions are prorated.
*   **Tax Reporting Entity:** limits the balancing segments and operating units reported.
*   **Federal Reportable Only:** when set to Y, keeps only suppliers flagged as federal reportable.
*   **Query Driver:** INV matches the balancing segment through the invoice distribution code combination, while PAY matches it through the bank account code combination.

### Performance & Optimization
*   The 1099 vendor restriction is an `IN` subquery on `AP_1099_TAPE_DATA`, so only 1099 vendors enter the payment join.
*   Tax reporting site selection uses an analytic `ROW_NUMBER` over the supplier site table, which avoids a correlated lookup per payment row.
*   Outer joins to `PER_ALL_PEOPLE_F` are restricted to the current effective row, so each supplier keeps one employee record.

### FAQ
**Q: How is backup withholding reported in the AP 1099 Payments report?**
A: Distributions typed MISC4 populate the Withheld Amount column as a positive value, and their payment amount is negated, so Payment Amount shows the net reportable figure.

**Q: Why does a voided check not appear in the 1099 payment totals?**
A: Payments whose check void date falls within the From and To Payment Date range are excluded by the condition on `AP_CHECKS_ALL.VOID_DATE`.

**Q: How does the report choose the tax reporting site for a supplier?**
A: It ranks the supplier's sites with an analytic function, placing the site flagged as tax reporting site first and otherwise the alphabetically first site, and keeps only the top row.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-1099-payments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
