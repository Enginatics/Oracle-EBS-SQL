---
layout: default
last_modified_at: 2026-10-16
title: 'ZX Financial Tax Register | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Description: Rx-only: Financial Tax Register Application: E-Business Tax Source: RX-only: Financial Tax Register Report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, E-Business Tax, Enginatics, R12 only, Financial, Tax, Register, zx_rep_extract_v'
permalink: /ZX%20Financial%20Tax%20Register/
report_name: 'ZX Financial Tax Register'
report_web_name: zx-financial-tax-register
module: 'E-Business Tax'
module_url: /modules/e-business-tax/
---

# ZX Financial Tax Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/zx-financial-tax-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register).
**Oracle EBS module:** [E-Business Tax](/modules/e-business-tax/ "Oracle EBS E-Business Tax reports") · [all E-Business Tax reports](/modules/e-business-tax/)  

## Overview
Imported from Concurrent Program
Description: Rx-only: Financial Tax Register
Application: E-Business Tax
Source: RX-only: Financial Tax Register Report
Short Name: RXZXPTEX

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Reporting Level, Reporting Context, Company Name, Set of Books Currency, Register Type, Summary Level, Product, GL Date Low, GL Date High, Transaction Date Low, Transaction Date High, VAT Tax Transaction Type, Tax Type Low, Tax Type High, Tax Regime Code, Tax, Tax Jurisdiction, Tax Status Code, Tax Code Low, Tax Code High, Currency Code Low, Currency Code High, Transfer to GL, Accounting Status, AR Exemption Status, Transaction Number, Include Standard Invoices, Include Debit Memos, Include Credit Memos, Include Prepayments, Include Mixed Invoices, Include Expense Reports, Include Invoices, Include Applications, Include Adjustments, Include Miscellaneous receipts, Include Bills Receivables, Include Accounting Segments, Include Discounts, Include Referenced Source

## Oracle EBS Tables Used
[zx_rep_extract_v](https://www.enginatics.com/library/?pg=1&find=zx_rep_extract_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ZX%20Financial%20Tax%20Register/ZX%20Financial%20Tax%20Register.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ZX Financial Tax Register - Tax Register 06-Aug-2024 034931.xlsx](https://www.enginatics.com/example/zx-financial-tax-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register) |
| Blitz Report™ XML Import | [ZX_Financial_Tax_Register.xml](https://www.enginatics.com/xml/zx-financial-tax-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register) |
| SQL Source | [ZX Financial Tax Register.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ZX%20Financial%20Tax%20Register/ZX%20Financial%20Tax%20Register.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/zx-financial-tax-register/](https://www.enginatics.com/reports/zx-financial-tax-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register) |

## ZX Financial Tax Register - Case Study & Technical Analysis

### Executive Summary
The **ZX Financial Tax Register** is a critical compliance and audit tool within the Oracle E-Business Tax (EB-Tax) module. It serves as the primary source of truth for all tax-related transactions across the enterprise, consolidating data from Payables (AP), Receivables (AR), and the General Ledger (GL). This report is essential for preparing VAT/GST returns, US Sales Tax reports, and supporting tax audits with detailed transaction lineage.

### Business Challenge
Tax departments face significant hurdles in:
*   **Reconciliation:** reconciling tax amounts reported to authorities with the General Ledger balances.
*   **Data Fragmentation:** Tax data is often scattered across multiple subledgers (AP Invoices, AR Transactions, GL Journals).
*   **Audit Defense:** Providing a complete, transaction-level audit trail for every tax line item calculated or recovered.
*   **Complex Regimes:** Managing reporting for multiple tax regimes and jurisdictions within a single global instance.

### Solution
This report provides a unified, high-fidelity view of the tax repository. It enables tax professionals to:
*   **Centralize Reporting:** Access a single register for all tax transactions, regardless of the source application.
*   **Verify Accounting:** Check the `Accounting Status` and `Transfer to GL` flags to ensure all tax lines are properly accounted.
*   **Analyze by Regime:** Filter data by Tax Regime, Tax, Status, and Jurisdiction for targeted analysis.
*   **Drill to Source:** Link tax lines back to the original transaction (Invoice, Credit Memo, Journal) for full auditability.

### Technical Architecture
The report is built upon the E-Business Tax repository, specifically leveraging the standard extract views provided by Oracle to ensure consistency with standard concurrent programs.

#### Key Tables & Views
| Table Name | Description |
| :--- | :--- |
| `ZX_REP_EXTRACT_V` | The primary view used by the standard "Financial Tax Register". It consolidates data from `ZX_LINES` and related transaction tables. |
| `ZX_LINES` | The core table storing tax lines for all transactions. |
| `ZX_RATES_B` | Definitions of tax rates and codes. |
| `ZX_REGIMES_B` | Definitions of tax regimes (e.g., VAT, SALES_TAX). |
| `GL_CODE_COMBINATIONS` | Used to display the tax liability and recovery account details. |

#### Core Logic
1.  **Data Extraction:** The report relies on `ZX_REP_EXTRACT_V`, which pre-joins the complex tax model (Regimes, Taxes, Statuses, Rates) with the transaction details.
2.  **Filtering:** Extensive parameters allow filtering by Date Range (GL or Transaction), Tax Regime, Tax Type, and Transaction Type.
3.  **Subledger Integration:** The view abstracts the complexity of linking back to `AP_INVOICES_ALL`, `RA_CUSTOMER_TRX_ALL`, etc., providing a consistent "Transaction Number" and "Transaction Date" regardless of source.

### FAQ
**Q: Is this the same as the standard Oracle "Financial Tax Register"?**
A: Yes, this SQL is designed to replicate the output of the standard `RXZXPTEX` concurrent program but in a direct-to-Excel format.

**Q: Can I use this for both Input (AP) and Output (AR) tax?**
A: Yes, the register covers both Input Tax (Payables) and Output Tax (Receivables).

**Q: Does it show tax that hasn't been accounted yet?**
A: Yes, the `Accounting Status` parameter allows you to view Posted, Unposted, or All transactions.

**Q: How does it handle partial payments for Cash Basis tax reporting?**
A: The underlying view `ZX_REP_EXTRACT_V` contains logic to handle tax reporting based on the tax point basis (Invoice vs. Payment), which is critical for Cash Basis regimes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-financial-tax-register)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
