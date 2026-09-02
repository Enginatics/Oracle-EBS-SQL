---
layout: default
title: 'ONT Sales Quote Close Upload | Oracle EBS SQL Report'
description: 'Bulk closes open Oracle Order Management sales quotes (documents in the Negotiation transaction phase) - useful for cleaning up large volumes of old draft…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, ONT, Sales, Quote, Close, hr_all_organization_units_vl, oe_order_headers_all, oe_transaction_types_tl'
permalink: /ONT%20Sales%20Quote%20Close%20Upload/
---

# ONT Sales Quote Close Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-sales-quote-close-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Bulk closes open Oracle Order Management sales quotes (documents in the Negotiation transaction phase) - useful for cleaning up large volumes of old draft quotes.

Download the open quotes, keep the rows you want to close, set a Close Reason, and upload. Each quote is driven to the Lost terminal (status Lost, no longer open) through the standard negotiation workflow, and the reason is recorded against the quote.

Quotes are identified by Quote Number and Operating Unit, so you can also paste those two values from an external list instead of downloading. Only open quotes are closed - an order number or an already-closed quote is reported back and left untouched.

Cancelled and Closed are order (fulfillment) statuses and do not apply to a quote - Lost is the correct terminal for a quote you are no longer pursuing. To keep win/loss reporting clean, add a custom OFFER_LOST lookup value (for example Obsolete) and select it as the Close Reason, so data-cleanup closures are distinguishable from genuine competitive losses.

Use the Created Before parameter to target quotes older than a given date, and Quote Number to close a single quote.

## Report Parameters
Upload Mode, Operating Unit, Created Before, Quote Number

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ont-sales-quote-close-upload/) |
| Blitz Report™ XML Import | [ONT_Sales_Quote_Close_Upload.xml](https://www.enginatics.com/xml/ont-sales-quote-close-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ont-sales-quote-close-upload/](https://www.enginatics.com/reports/ont-sales-quote-close-upload/) |



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
