---
layout: default
last_modified_at: 2026-10-16
title: 'ZX US Sales Tax | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Description: Sales Tax Report for use in U.S Application: E-Business Tax Source: U.S. Sales Tax Report Short Name: ZXXSTR…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, E-Business Tax, Enginatics, R12 only, Sales, Tax, ra_customer_trx_all, zx_lines_det_factors, ra_cust_trx_line_gl_dist_all'
permalink: /ZX%20US%20Sales%20Tax/
report_name: 'ZX US Sales Tax'
report_web_name: zx-us-sales-tax
module: 'E-Business Tax'
module_url: /modules/e-business-tax/
---

# ZX US Sales Tax – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/zx-us-sales-tax/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax).
**Oracle EBS module:** [E-Business Tax](/modules/e-business-tax/ "Oracle EBS E-Business Tax reports") · [all E-Business Tax reports](/modules/e-business-tax/)  

## Overview
Imported from Concurrent Program
Description: Sales Tax Report for use in U.S
Application: E-Business Tax
Source: U.S. Sales Tax Report
Short Name: ZXXSTR

The State, County and City columns are the tax jurisdiction the tax was determined for, which is the transaction ship to site falling back to the bill to site. The State Low and State High parameters filter on that same jurisdiction. The Ship To and Bill To address columns are the transaction sites themselves, so they can differ from those three.

Invoice Freight Amount follows Invoice Lines Amount and Invoice Tax Amount: on an invoice or credit memo it is the total of that transaction's Freight lines, on an adjustment it is the freight the adjustment applied. It is shown on the first row of each transaction only, so summing the column does not multiply it by the line and tax line count.

The Intermediate Ship To columns come from the sales order line the invoice line was created from. Set DFF Display to also report the invoice line and sales order line descriptive flexfields, which is where an intermediate ship to address entered outside Order Management is usually held.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Reporting Level, Reporting Context, Transaction Number, Transaction Date Low, Transaction Date High, GL Date Low, GL Date High, State Low, State High, Currency Low, Currency High, Exemption Status, Sales Tax Liability Account From, Sales Tax Liability Account To, Transfer to GL, Show all Adjustments & Credits, Include Non Tax Transactions, Debug Mode, DFF Display

## Oracle EBS Tables Used
[ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [zx_lines_det_factors](https://www.enginatics.com/library/?pg=1&find=zx_lines_det_factors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_loc_assignments_obs](https://www.enginatics.com/library/?pg=1&find=hz_loc_assignments_obs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [zx_rates_vl](https://www.enginatics.com/library/?pg=1&find=zx_rates_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [zx_exemptions](https://www.enginatics.com/library/?pg=1&find=zx_exemptions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [zx_taxes_b](https://www.enginatics.com/library/?pg=1&find=zx_taxes_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [ar_adjustments_all](https://www.enginatics.com/library/?pg=1&find=ar_adjustments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)

## Related Reports
[AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Open Items Revaluation](/AR%20Open%20Items%20Revaluation/ "AR Open Items Revaluation Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ZX%20US%20Sales%20Tax/ZX%20US%20Sales%20Tax.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/zx-us-sales-tax/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax) |
| Blitz Report™ XML Import | [ZX_US_Sales_Tax.xml](https://www.enginatics.com/xml/zx-us-sales-tax/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax) |
| SQL Source | [ZX US Sales Tax.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ZX%20US%20Sales%20Tax/ZX%20US%20Sales%20Tax.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/zx-us-sales-tax/](https://www.enginatics.com/reports/zx-us-sales-tax/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax) |

## Case Study & Technical Analysis: ZX US Sales Tax Report

### Executive Summary

The ZX US Sales Tax report is a crucial tax compliance and audit tool for organizations operating in the United States and utilizing Oracle E-Business Tax (EBTax). It provides a detailed breakdown of sales tax transactions, helping businesses manage their state-specific sales tax liabilities, reconcile collected tax amounts, and ensure accurate reporting to US tax authorities. This report is indispensable for tax accountants, financial analysts, and system administrators to understand the complex origination of sales tax, identify taxable and exempt transactions, troubleshoot tax calculation issues, and maintain a robust and compliant US sales tax framework.

### Business Challenge

US Sales Tax is a highly complex area, with rules varying significantly by state, county, and even city, as well as by item and customer taxability. Managing this complexity presents significant challenges:

-   **Multi-Jurisdictional Compliance:** Organizations operating across multiple US states face the daunting task of ensuring correct sales tax calculation and reporting for each relevant jurisdiction, a task prone to error with manual processes.
-   **Reconciling Sales Tax Liabilities:** Reconciling collected sales tax amounts from customer invoices (Accounts Receivable) with the sales tax liability accounts in the General Ledger is a critical and often complex month-end task.
-   **Identifying Exempt Transactions:** Accurately identifying and reporting sales that were exempt from tax (e.g., resale, government purchases) is essential for compliance but requires clear visibility into transaction attributes.
-   **Troubleshooting Tax Calculation Errors:** When sales tax is incorrectly calculated on a sales order or invoice, diagnosing the issue requires precise information on the transaction details, customer taxability, and EBTax setup that generated the tax line.
-   **Audit Readiness:** For state sales tax audits, providing detailed transaction-level data, including taxability and exemption status, is a mandatory requirement that necessitates robust reporting capabilities.

### The Solution

This report offers a powerful, configurable, and transparent solution for analyzing US Sales Tax transactions, bringing clarity and control to sales tax compliance and reporting.

-   **Detailed Sales Tax Breakdown:** It provides a granular listing of sales tax lines, including transaction details (e.g., `Transaction Number`, `Transaction Date`), `State` information, `Currency`, `Exemption Status`, and the `Sales Tax Liability Account` affected. This offers a holistic view of sales tax activity.
-   **Flexible Reporting Levels and Context:** Parameters like `Reporting Level` and `Reporting Context` allow users to focus on specific legal entities or operating units for targeted tax analysis.
-   **Reconciliation Support:** By detailing tax lines and their GL distributions, the report assists tax accountants in reconciling sales tax collected (from AR) to the corresponding sales tax liability accounts in the GL.
-   **Visibility into Exemptions and Adjustments:** Parameters to `Show all Adjustments & Credits` and `Include Non Tax Transactions` (for complete transaction context) provide crucial insight into the various factors influencing net sales tax liability.
-   **Debug Mode for Troubleshooting:** The `Debug Mode` parameter is an invaluable feature for technical analysts, providing additional diagnostic information to troubleshoot complex tax calculation issues.

### Technical Architecture (High Level)

The report queries core Oracle Receivables (AR) and E-Business Tax (ZX) tables to provide its detailed sales tax analysis. It is an enhanced version of a standard Oracle concurrent program.

-   **Primary Tables Involved:**
    -   `ra_customer_trx_all` and `ra_customer_trx_lines_all` (for sales invoice headers and lines).
    -   `zx_lines_det_factors` (the central table for EBTax line details, linking to specific tax rates and determined factors).
    -   `ra_cust_trx_line_gl_dist_all` (for GL account distributions of AR transactions).
    -   `hz_cust_accounts`, `hz_parties`, `hz_cust_site_uses_all`, `hz_locations` (for customer and bill-to/ship-to location details).
    -   `gl_code_combinations_kfv` (for GL sales tax liability account details).
    -   `zx_rates_vl` and `zx_taxes_b` (for tax rate and tax definitions).
-   **Logical Relationships:** The report links `ra_customer_trx_all` and `ra_customer_trx_lines_all` to `zx_lines_det_factors` to retrieve all sales tax lines associated with customer transactions. It then joins to customer master, geographical, and GL tables to provide rich contextual information, including the `State` (jurisdiction), `Sales Tax Liability Account`, and various transaction details, all filtered by the user's specified criteria.

### Parameters & Filtering

The report offers an extensive set of parameters for precise filtering and detailed data inclusion:

-   **Reporting Context:** `Reporting Level` and `Reporting Context` (e.g., Legal Entity, Operating Unit) define the organizational scope for tax reporting.
-   **Transaction Identification:** `Transaction Number` allows for precise targeting of specific invoices. `Transaction Date Low/High` and `GL Date Low/High` are crucial for defining the reporting period.
-   **Geographical Filters:** `State Low/High` allows for focusing on specific US states for sales tax analysis.
-   **Financial Filters:** `Currency Low/High` filters by currency. `Sales Tax Liability Account From/To` allows for filtering by specific GL accounts.
-   **Inclusion Flags:** `Exemption Status` (to show taxable vs. exempt), `Transfer to GL` (to see what has been posted), `Show all Adjustments & Credits`, and `Include Non Tax Transactions` provide comprehensive control over the report's content.
-   **Debug Mode:** `Debug Mode` is a technical parameter for detailed troubleshooting.

### Performance & Optimization

As a detailed transactional report integrating data across multiple modules (AR, EBTax, GL), it is optimized through strong filtering and date-driven processing.

-   **Date and State-Driven Filtering:** The `Transaction Date Low/High`, `GL Date Low/High`, and `State Low/High` parameters are critical for performance, allowing the database to efficiently narrow down the large volumes of AR and EBTax transaction data to the relevant timeframe and geographical scope using existing indexes.
-   **Targeted Data Retrieval:** The report's SQL is specifically designed to retrieve sales tax lines and their associated details efficiently, avoiding full table scans of all transactional data.
-   **Conditional Data Inclusion:** Parameters like `Include Non Tax Transactions` or `Show all Adjustments & Credits` allow the report to execute more complex joins or data retrieval only when that specific detail is requested, preventing unnecessary database load.

### FAQ

**1. What is the primary difference between a 'Transaction Date' and a 'GL Date' in this report?**
   The `Transaction Date` is the actual date the customer invoice or sales order was created. The `GL Date` is the accounting period date when the transaction's financial impact (including sales tax) is recognized in the General Ledger. These dates can differ, especially if transactions are created in one period but accounted for in another.

**2. How does the report identify 'Sales Tax Liability Accounts'?**
   The report links the sales tax lines (`zx_lines_det_factors`) to their corresponding GL distributions (`ra_cust_trx_line_gl_dist_all`) and then retrieves the GL code combination. The `Sales Tax Liability Account From/To` parameters allow users to filter for these specific GL accounts, which are typically where the collected sales tax is posted before remittance to tax authorities.

**3. Can this report help identify transactions where a sales tax exemption was incorrectly applied or missed?**
   Yes. By using the `Exemption Status` parameter, you can filter for both exempt and taxable transactions. Reviewing exempt transactions (and their supporting `Exemption Certificate` details, if included in the report) ensures proper application. Conversely, reviewing taxable transactions for which an exemption *should* have applied can highlight potential missed exemptions, leading to over-collection or incorrect billing.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=zx-us-sales-tax)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
