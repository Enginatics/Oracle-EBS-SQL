---
layout: default
last_modified_at: 2026-10-26
title: 'AR Transaction Upload | Oracle EBS SQL Report'
description: 'This upload can be used to create Invoices, Debit Memos and Credit Memos. Credit memos can be created On Account, or created and applied directly to an…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Transaction, jtf_rs_salesreps, jtf_rs_resource_extns_vl, ra_terms_vl'
permalink: /AR%20Transaction%20Upload/
report_name: 'AR Transaction Upload'
report_web_name: ar-transaction-upload
---

# AR Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload).

## Overview
This upload can be used to create Invoices, Debit Memos and Credit Memos. Credit memos can be created On Account, or created and applied directly to an existing transaction (an applied credit memo).

The 'Upload Trx Identifier' column is used to uniquely identify each individual transaction (invoice, credit memo, debit memo) to be uploaded.
If the selected batch source uses manual transaction numbering, the Upload Trx Identifier will be copied to the Transaction Number column (the Oracle Transaction Number), but this can be overridden in the upload excel.
If the selected transaction type uses a Manual Document Sequence, the Upload Trx Identifier will be used as the Document Sequence Value in Oracle.

The upload supports the entry of
- Standard Invoice Lines
- Manual Tax Lines (if permitted)
- Header Level Freight Lines (if permitted) – identified by leaving the Link to Line Number null
- Line Level Freight Lines (if permitted) – identified by populating the Link to Line Number column

For Tax Lines, and Line level Freight Lines, use the Link to Line Number to identify the Invoice Line to which the Tax Line or Freight Line should be linked. Tax Lines must be linked to a standard invoice line.

Note. Tax Lines and Line level Freight Lines must occur after the row containing the invoice line to which they will be linked, although it does not need to be immediately following.

- A Quantity and Unit Price must be specified for standard invoice lines. The upload will calculate the line amount.
- You can specify a quantity and unit price for a freight line in which case the upload will calculate the line amount, or you enter the line amount directly. Only the amount is uploaded to Oracle.
- For manual Tax Lines, you can enter the line amount directly. If left blank, the upload will calculate the amount based on the selected Tax Rate and the line amount from the linked standard invoice.

For Manual Tax Lines you must specify the Tax Regime, Tax, Tax Jurisdiction, Tax Status, Tax Rate Name, and Tax Rate columns.

Applied Credit Memos
To create a credit memo and apply it to an existing transaction in one step, populate the Credit Against Transaction column with the transaction to be credited.  A Credit Memo Reason is required for an applied credit memo.

The Transaction Type and Transaction Date are derived automatically from the credited invoice and are informational on this flow. The Transaction Type list shows only the credit memo type linked to the credited invoice's transaction type, and the Transaction Date defaults to the later of today and the credited invoice's date.

You can credit the invoice at header level or at line level.

Header level – leave the Credit Against Line column blank.
- Leave Credit Line Amount, Credit Tax Amount and Credit Freight Amount blank to credit the full outstanding balance of the invoice.
- Or enter negative Credit Line, Credit Tax and/or Credit Freight Amounts to credit part of the invoice.

Line level – populate the Credit Against Line column.
- Enter one row per invoice line to be credited, identifying the line in the Credit Against Line column.
- A negative Credit Line Amount is required for each credited line. It defaults to the full line amount; edit it for a partial line credit.
- Credit Tax Amount and Credit Freight Amount are not used at line level. Credit tax and freight using a header level credit, or let the credit method spread the tax automatically.

The report parameters Credit Method for Rules and Credit Method for Installments control how the credit is applied across accounting rule periods and payment schedules.

On a line with an invoicing rule, enter one distribution row per accounting class - Revenue plus Unearned Revenue or Unbilled Receivable - each allocating the whole line.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Source, Default Transaction Type, Default Transaction Currency, Exchange Rate Type, Default Transaction Date, Default GL Date, Use SalesPersons, Derive Applied CM Batch Source, Credit Method for Rules, Credit Method for Installments, Historical Transaction Load?

## Oracle EBS Tables Used
[jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [iby_trxn_extensions_v](https://www.enginatics.com/library/?pg=1&find=iby_trxn_extensions_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ar_memo_lines_all_vl](https://www.enginatics.com/library/?pg=1&find=ar_memo_lines_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [org_freight](https://www.enginatics.com/library/?pg=1&find=org_freight&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_output_classifications_v](https://www.enginatics.com/library/?pg=1&find=zx_output_classifications_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_fc_business_categories_v](https://www.enginatics.com/library/?pg=1&find=zx_fc_business_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_fc_product_fiscal_v](https://www.enginatics.com/library/?pg=1&find=zx_fc_product_fiscal_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_fc_product_categories_v](https://www.enginatics.com/library/?pg=1&find=zx_fc_product_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_product_types_v](https://www.enginatics.com/library/?pg=1&find=zx_product_types_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_fc_codes_vl](https://www.enginatics.com/library/?pg=1&find=zx_fc_codes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_fc_types_b](https://www.enginatics.com/library/?pg=1&find=zx_fc_types_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [mtl_categories_tl](https://www.enginatics.com/library/?pg=1&find=mtl_categories_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_cust_trx_line_salesreps_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_salesreps_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_batches_all](https://www.enginatics.com/library/?pg=1&find=ra_batches_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_lines_det_factors](https://www.enginatics.com/library/?pg=1&find=zx_lines_det_factors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)

## Related Reports
[AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Transaction%20Upload/AR%20Transaction%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload) |
| Blitz Report™ XML Import | [AR_Transaction_Upload.xml](https://www.enginatics.com/xml/ar-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload) |
| SQL Source | [AR Transaction Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Transaction%20Upload/AR%20Transaction%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-transaction-upload/](https://www.enginatics.com/reports/ar-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload) |

## AR Transaction Upload - Case Study & Technical Analysis

### Executive Summary

The **AR Transaction Upload** is a high-productivity utility designed to streamline the creation of Receivables transactions. Unlike standard reports that only read data, this tool allows users to bulk-load Invoices, Credit Memos, and Debit Memos directly from an Excel spreadsheet into Oracle EBS. It serves as a user-friendly alternative to the complex AutoInvoice interface or manual form entry.

### Business Challenge

Data entry in Oracle Receivables can be a bottleneck.
*   **Volume:** Manually keying in hundreds of monthly service invoices is time-consuming and error-prone.
*   **Integration:** Loading data from external systems (e.g., a specialized billing platform) typically requires IT to build SQL loader scripts for the AutoInvoice interface tables.
*   **Flexibility:** Business users often need a quick way to upload ad-hoc corrections or one-off billing batches without waiting for a formal integration project.

### Solution

The **AR Transaction Upload** empowers end-users to manage their own data loads:
*   **Excel Interface:** Users work in a familiar spreadsheet environment to prepare their data.
*   **Validation:** The tool validates customers, items, and dates against Oracle master data before attempting the upload.
*   **Complexity Handling:** It supports advanced features like multi-line invoices, manual tax lines, and freight charges.

### Technical Architecture

This tool leverages Oracle's public APIs to ensure data integrity and standard validation.

#### Key Features & Logic

*   **Grouping:** The `Upload Trx Identifier` column is the key. All rows with the same identifier are grouped into a single transaction header.
*   **Line Types:**
    *   *Standard Lines:* Created with Item, Quantity, and Price.
    *   *Freight:* Can be header-level or line-level (linked via `Link to Line Number`).
    *   *Tax:* Manual tax lines can be added and linked to specific invoice lines.
*   **API Usage:** Instead of inserting directly into tables (which is unsafe), the upload typically calls standard Oracle APIs (e.g., `AR_INVOICE_API_PUB`) or populates the AutoInvoice interface tables (`RA_INTERFACE_LINES_ALL`) and triggers the import program.

#### Data Mapping

*   **Customer:** Mapped via Name or Account Number.
*   **Item:** Validated against `MTL_SYSTEM_ITEMS_VL`.
*   **Tax:** Validated against the E-Business Tax engine (`ZX_` tables).
*   **Terms:** Validated against `RA_TERMS`.

### Parameters

*   **Operating Unit:** The target business unit for the transactions.
*   **Source:** The Batch Source (e.g., 'Blitz Upload') which determines numbering and validation rules.
*   **Default Transaction Type:** Used if a specific type is not provided in the spreadsheet row.
*   **Default GL Date:** The accounting date for the batch (must be in an open period).

### FAQ

**Q: Can I upload invoices for multiple customers in one sheet?**
A: Yes. Each row specifies the customer. The tool groups rows by the "Upload Trx Identifier," so you can have Invoice A for Customer X and Invoice B for Customer Y in the same upload.

**Q: How are invoice numbers assigned?**
A: It depends on the "Batch Source." If the source is set to "Automatic Numbering," Oracle assigns the number. If "Manual," the value in the "Transaction Number" column (or the Upload Trx Identifier) is used.

**Q: What happens if one line fails validation?**
A: Typically, the entire transaction (invoice) is rejected to ensure data consistency. The error message is returned to the Excel sheet for correction.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
