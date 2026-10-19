---
layout: default
last_modified_at: 2026-10-19
title: 'AR Transaction Update Upload | Oracle EBS SQL Report'
description: 'Updates the post completion header fields of Receivables transactions in the same way as the Transactions workbench: comments, special instructions, print…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Transaction, Update, ra_salesreps_all, ar_active_remit_to_addresses_v, ra_customer_trx_all'
permalink: /AR%20Transaction%20Update%20Upload/
report_name: 'AR Transaction Update Upload'
report_web_name: ar-transaction-update-upload
---

# AR Transaction Update Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transaction-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload).

## Overview
Updates the post completion header fields of Receivables transactions in the same way as the Transactions workbench: comments, special instructions, print option, purchase order details, salesperson, remit to address, late charges exemption, ship via, FOB, waybill, cross reference and the transaction descriptive flexfield.

The transaction is identified by Operating Unit and Transaction Number. A hidden transaction id links downloaded rows exactly; pasted rows resolve by number, and a number existing under more than one transaction source is rejected with a request to download the transaction instead.

Updates are applied through the Transactions workbench header handler, so the same validations apply as in the form. Completion status, transaction status, amounts, dates, customers and accounting are not changed by this upload. Commitments (deposits and guarantees) are excluded.

The upload only processes changed cells. A row without changes reports No change.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Transaction Number, Transaction Date From, Transaction Date To, Transaction Type, Bill To Customer

## Oracle EBS Tables Used
[ra_salesreps_all](https://www.enginatics.com/library/?pg=1&find=ra_salesreps_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [ar_active_remit_to_addresses_v](https://www.enginatics.com/library/?pg=1&find=ar_active_remit_to_addresses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)

## Related Reports
[AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [ONT Order to Cash Tracker](/ONT%20Order%20to%20Cash%20Tracker/ "ONT Order to Cash Tracker Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [AR Credit Memo Application Upload](/AR%20Credit%20Memo%20Application%20Upload/ "AR Credit Memo Application Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Transaction%20Update%20Upload/AR%20Transaction%20Update%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-transaction-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload) |
| Blitz Report™ XML Import | [AR_Transaction_Update_Upload.xml](https://www.enginatics.com/xml/ar-transaction-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload) |
| SQL Source | [AR Transaction Update Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Transaction%20Update%20Upload/AR%20Transaction%20Update%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-transaction-update-upload/](https://www.enginatics.com/reports/ar-transaction-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload) |

## Case Study & Technical Analysis: AR Transaction Update Upload

### Executive Summary
The AR Transaction Update Upload is a Blitz Report upload for the Receivables transaction header fields that are maintained after an invoice, debit memo or credit memo is completed. Billing and collections administrators use it to correct comments, special instructions, purchase order details, salesperson, remit-to address, ship-via, FOB, waybill and descriptive flexfield values across many transactions at once. The upload changes only the header fields that the Transactions workbench allows to be edited after completion, so financial amounts, dates, customers and accounting remain untouched. The workflow runs in Excel through Blitz Report.

### Business Challenge
*   **Post-completion corrections:** Once a transaction is complete, its header data cannot be changed in the standard workbench one record at a time, which makes bulk corrections of purchase order references or remit-to addresses slow.
*   **Collection and dunning accuracy:** Remit-to addresses, salesperson assignments and late-charge exemptions drive customer correspondence and commission reporting, so errors in them cause collection and dispute problems.
*   **Shipping and tax documentation:** Ship-via, FOB and waybill values are printed on documents and must match the physical shipment.
*   **Flexfield consistency:** Transaction descriptive flexfield values need to be kept consistent across a set of related invoices.

### The Solution
*   **Transaction identification:** Each row is identified by Operating Unit and Transaction Number. A hidden customer transaction ID links downloaded rows exactly, while pasted rows are resolved by number, and a number that exists under more than one transaction source is rejected.
*   **Workbench handler:** Updates are applied through the Transactions workbench header handler, so the validations of the form also apply to the upload.
*   **Changed-cell processing:** Only cells that differ from the database are processed, and a row without changes reports No change.
*   **Scope control:** Deposits and guarantees are excluded by transaction type, and the operating unit list is limited to the organizations the user can access through `MO_GLOB_ORG_ACCESS_TMP`.

### Technical Architecture (High Level)
#### Primary Tables
*   `RA_CUSTOMER_TRX_ALL`: the transaction header, holding the header fields the upload updates, including the transaction flexfield attributes.
*   `RA_CUST_TRX_TYPES_ALL`: the transaction type, which supplies the class and the deposit and guarantee exclusion.
*   `RA_BATCH_SOURCES_ALL`: the transaction source name.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the bill-to customer account and party name.
*   `RA_SALESREPS_ALL`: the primary salesperson name and number.
*   `AR_ACTIVE_REMIT_TO_ADDRESSES_V`: the active remit-to address and its concatenated address.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

#### Logical Relationships
1.  `RA_CUSTOMER_TRX_ALL` is filtered to the accessible operating units and joins to its transaction type on the transaction type ID and operating unit.
2.  The transaction joins to `HZ_CUST_ACCOUNTS` on the bill-to customer ID, and that account joins to `HZ_PARTIES` on the party ID.
3.  The transaction joins to `RA_BATCH_SOURCES_ALL` on the batch source ID and operating unit, and to `HR_ALL_ORGANIZATION_UNITS_VL` on the operating unit.
4.  The salesperson and remit-to address are resolved by correlated lookups on the transaction's primary salesperson ID and remit-to address ID.
5.  Descriptive flexfield values are displayed through the `XXEN_UTIL` flexfield helper functions, using the transaction's attribute category.

### Parameters & Filtering
*   **Upload Mode:** sets whether the report is run as a download of transactions or as an upload of changed rows.
*   **Operating Unit:** restricts the transactions to one organization within the accessible set.
*   **Transaction Number:** identifies the transaction to update, the key used when rows are pasted.
*   **Transaction Date From** and **Transaction Date To:** bound the transaction date of the candidate rows.
*   **Transaction Type:** limits the rows to one transaction type.
*   **Bill To Customer:** limits the rows to one bill-to customer.

### Performance & Optimization
*   The operating unit restriction is an `IN` subquery on the temporary security table `MO_GLOB_ORG_ACCESS_TMP`, so the query reads only the organizations the user is allowed to see.
*   Customer, party and batch source joins are outer joins to the header, so transactions without a customer or source are still returned.
*   Salesperson and remit-to values are fetched with scalar subqueries keyed on primary keys, which avoids repeating a join for every flexfield column.
*   Deposits and guarantees are removed by a filter on the transaction type code, which keeps commitments out of the upload before the header is loaded.

### FAQ
**Q: Can the upload change the amount or the completion status of an invoice?**
A: No. The description states that completion status, transaction status, amounts, dates, customers and accounting are not changed by this upload.

**Q: Why is a transaction number rejected during upload?**
A: The number exists under more than one transaction source, so the upload cannot identify the row by number and asks for the transaction to be downloaded so the hidden transaction ID is used.

**Q: Which AR fields can be updated in bulk?**
A: Comments, special instructions, print option, purchase order details, salesperson, remit-to address, late charge exemption, ship-via, FOB, waybill, cross reference and the transaction descriptive flexfield.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transaction-update-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
