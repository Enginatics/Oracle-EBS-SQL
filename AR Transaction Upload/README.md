---
layout: default
title: 'AR Transaction Upload | Oracle EBS SQL Report'
description: 'This upload can be used to create Invoices, On Account Credit Memos and Debit Memos. The ‘Upload Trx Identifier’ column is used to uniquely identify each…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Transaction, jtf_rs_salesreps, jtf_rs_resource_extns_vl, ra_terms_vl'
permalink: /AR%20Transaction%20Upload/
---

# AR Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transaction-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload can be used to create Invoices, On Account Credit Memos and Debit Memos.

The ‘Upload Trx Identifier’ column is used to uniquely identify each individual transaction (invoice, credit memo, debit memo) to be uploaded. 
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


## Report Parameters
Operating Unit, Source, Default Transaction Type, Default Transaction Currency, Exchange Rate Type, Default Transaction Date, Default GL Date, Use SalesPersons

## Oracle EBS Tables Used
[jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [iby_trxn_extensions_v](https://www.enginatics.com/library/?pg=1&find=iby_trxn_extensions_v), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [org_freight](https://www.enginatics.com/library/?pg=1&find=org_freight), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [zx_output_classifications_v](https://www.enginatics.com/library/?pg=1&find=zx_output_classifications_v), [zx_fc_business_categories_v](https://www.enginatics.com/library/?pg=1&find=zx_fc_business_categories_v), [zx_fc_product_fiscal_v](https://www.enginatics.com/library/?pg=1&find=zx_fc_product_fiscal_v), [zx_fc_product_categories_v](https://www.enginatics.com/library/?pg=1&find=zx_fc_product_categories_v), [zx_product_types_v](https://www.enginatics.com/library/?pg=1&find=zx_product_types_v), [zx_fc_codes_vl](https://www.enginatics.com/library/?pg=1&find=zx_fc_codes_vl), [zx_fc_types_b](https://www.enginatics.com/library/?pg=1&find=zx_fc_types_b), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [mtl_categories_tl](https://www.enginatics.com/library/?pg=1&find=mtl_categories_tl), [=](https://www.enginatics.com/library/?pg=1&find==)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-transaction-upload/) |
| Blitz Report™ XML Import | [AR_Transaction_Upload.xml](https://www.enginatics.com/xml/ar-transaction-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-transaction-upload/](https://www.enginatics.com/reports/ar-transaction-upload/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
