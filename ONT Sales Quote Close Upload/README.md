---
layout: default
last_modified_at: 2026-10-16
title: 'ONT Sales Quote Close Upload | Oracle EBS SQL Report'
description: 'Bulk closes open Oracle Order Management sales quotes (documents in the Negotiation transaction phase) - useful for cleaning up large volumes of old draft…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, ONT, Sales, Quote, Close, hr_all_organization_units_vl, oe_order_headers_all, oe_transaction_types_tl'
permalink: /ONT%20Sales%20Quote%20Close%20Upload/
report_name: 'ONT Sales Quote Close Upload'
report_web_name: ont-sales-quote-close-upload
---

# ONT Sales Quote Close Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-sales-quote-close-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload).

## Overview
Bulk closes open Oracle Order Management sales quotes (documents in the Negotiation transaction phase) - useful for cleaning up large volumes of old draft quotes.

Download the open quotes, keep the rows you want to close, set a Close Reason, and upload. Each quote is driven to the Lost terminal (status Lost, no longer open) through the standard negotiation workflow, and the reason is recorded against the quote.

Quotes are identified by Quote Number and Operating Unit, so you can also paste those two values from an external list instead of downloading. Only open quotes are closed - an order number or an already-closed quote is reported back and left untouched.

Cancelled and Closed are order (fulfillment) statuses and do not apply to a quote - Lost is the correct terminal for a quote you are no longer pursuing. To keep win/loss reporting clean, add a custom OFFER_LOST lookup value (for example Obsolete) and select it as the Close Reason, so data-cleanup closures are distinguishable from genuine competitive losses.

Use the Created Before parameter to target quotes older than a given date, and Quote Number to close a single quote.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Created Before, Quote Number

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)

## Related Reports
[ONT Blanket Sales Agreements](/ONT%20Blanket%20Sales%20Agreements/ "ONT Blanket Sales Agreements Oracle EBS SQL Report"), [ONT Order to Cash Tracker](/ONT%20Order%20to%20Cash%20Tracker/ "ONT Order to Cash Tracker Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Sales%20Quote%20Close%20Upload/ONT%20Sales%20Quote%20Close%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ont-sales-quote-close-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload) |
| Blitz Report™ XML Import | [ONT_Sales_Quote_Close_Upload.xml](https://www.enginatics.com/xml/ont-sales-quote-close-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload) |
| SQL Source | [ONT Sales Quote Close Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Sales%20Quote%20Close%20Upload/ONT%20Sales%20Quote%20Close%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-sales-quote-close-upload/](https://www.enginatics.com/reports/ont-sales-quote-close-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload) |

## Case Study & Technical Analysis: ONT Sales Quote Close Upload

### Executive Summary
This upload closes open sales quotes in Oracle Order Management. It targets quotes in the Negotiation transaction phase that are still open, and it lets a sales operations administrator download them, mark the quotes to close, choose a close reason and upload. Each quote is moved to the Lost terminal through the standard negotiation workflow, and the reason is recorded against the quote. It is used to clean up large volumes of old draft quotes that were never converted, while keeping genuine competitive losses separate from data cleanup. Blitz Report™ provides the spreadsheet for selecting and closing the quotes.

### Business Challenge
*   **Stale draft quotes:** Quotes created for prospects who never ordered remain open, which distorts pipeline reports and quote counts.
*   **Closing one by one:** Closing thousands of quotes through the forms is too slow for a cleanup project.
*   **Keeping win and loss data clean:** Quotes closed as cleanup must not be mixed with genuine losses in win and loss analysis.
*   **Selecting the right quotes:** Quotes need to be chosen by age or by number, and the upload must reject records that cannot be closed.

### The Solution
*   Downloads the open quotes of the chosen operating units, with quote number, order type, customer, ordered date, currency, quote status and creation date.
*   Accepts a Close Reason and Close Comments for each quote, so the reason of each closure is recorded.
*   Closes each quote to the Lost terminal through the negotiation workflow, so the quote leaves the open state.
*   Identifies quotes by quote number and operating unit, so a list of quote numbers can be pasted in place of a download.
*   Reports back quotes that are not open quotes, such as orders or quotes already closed, and leaves them untouched.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_ORDER_HEADERS_ALL`: the sales document header, with its order number, order type, transaction phase, open flag, flow status, sold to customer and creation date.
*   `OE_TRANSACTION_TYPES_TL`: the order type name, in the session language.
*   `HZ_CUST_ACCOUNTS`: the sold to customer account.
*   `HZ_PARTIES`: the customer party name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.

#### Logical Relationships
1. `HR_ALL_ORGANIZATION_UNITS_VL` is joined to the order header on the operating unit identifier.
2. The order header is restricted to documents in the Negotiation transaction phase that are open.
3. The order type name is outer joined from `OE_TRANSACTION_TYPES_TL` in the session language.
4. The sold to customer account is outer joined from `HZ_CUST_ACCOUNTS`, and the party name from `HZ_PARTIES`.
5. The flow status is translated through the FLOW_STATUS lookup for display.

### Parameters & Filtering
*   **Upload Mode:** selects the download of open quotes, or the closure of the quotes marked in the file.
*   **Operating Unit:** limits the quotes to one operating unit.
*   **Created Before:** selects the quotes created before a date, to target old drafts.
*   **Quote Number:** selects a single quote.

### Performance & Optimization
*   The report starts from the operating unit and the open negotiation quotes, so the rest of the joins are applied only to the open quotes.
*   The customer lookups are outer joins, so quotes without a resolved customer still appear in the download.
*   The order type name is restricted to the session language, so only one translation row is joined for each order type.
*   Filtering by Created Before and Quote Number at download time keeps the upload file to the quotes that will be closed.

### FAQ
**Q: Why is Lost the status used for closed quotes?**
A: Cancelled and Closed are order fulfilment statuses and do not apply to a quote. Lost is the terminal status for a quote that is no longer being pursued.

**Q: How do I keep cleanup closures separate from real losses?**
A: Add a custom OFFERLOST lookup value, for example Obsolete, and select it as the Close Reason. The closures can then be told apart in win and loss reporting.

**Q: What happens to an order number in the file?**
A: Only open quotes are closed. An order number, or a quote that is already closed, is reported back and left untouched.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-sales-quote-close-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
