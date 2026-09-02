---
layout: default
title: 'AR Transaction Update Upload | Oracle EBS SQL Report'
description: 'Updates the post completion header fields of Receivables transactions in the same way as the Transactions workbench: comments, special instructions, print…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Transaction, Update, ra_salesreps_all, ar_active_remit_to_addresses_v, ra_customer_trx_all'
permalink: /AR%20Transaction%20Update%20Upload/
---

# AR Transaction Update Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transaction-update-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Updates the post completion header fields of Receivables transactions in the same way as the Transactions workbench: comments, special instructions, print option, purchase order details, salesperson, remit to address, late charges exemption, ship via, FOB, waybill, cross reference and the transaction descriptive flexfield.

The transaction is identified by Operating Unit and Transaction Number. A hidden transaction id links downloaded rows exactly; pasted rows resolve by number, and a number existing under more than one transaction source is rejected with a request to download the transaction instead.

Updates are applied through the Transactions workbench header handler, so the same validations apply as in the form. Completion status, transaction status, amounts, dates, customers and accounting are not changed by this upload. Commitments (deposits and guarantees) are excluded.

The upload only processes changed cells. A row without changes reports No change.

## Report Parameters
Upload Mode, Operating Unit, Transaction Number, Transaction Date From, Transaction Date To, Transaction Type, Bill To Customer

## Oracle EBS Tables Used
[ra_salesreps_all](https://www.enginatics.com/library/?pg=1&find=ra_salesreps_all), [ar_active_remit_to_addresses_v](https://www.enginatics.com/library/?pg=1&find=ar_active_remit_to_addresses_v), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [AR Credit Memo Application Upload](/AR%20Credit%20Memo%20Application%20Upload/ "AR Credit Memo Application Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ar-transaction-update-upload/) |
| Blitz Report™ XML Import | [AR_Transaction_Update_Upload.xml](https://www.enginatics.com/xml/ar-transaction-update-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-transaction-update-upload/](https://www.enginatics.com/reports/ar-transaction-update-upload/) |



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
