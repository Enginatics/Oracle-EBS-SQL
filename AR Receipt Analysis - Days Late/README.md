---
layout: default
last_modified_at: 2026-11-02
title: 'AR Receipt Analysis - Days Late | Oracle EBS SQL Report'
description: 'Receipt applications against all transactions except credit memos, with the days between the installment due date and the application date. Converted from…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, Receipt, Analysis, Days, Late, hr_all_organization_units_vl, ar_payment_schedules_all, ar_receivable_applications_all'
permalink: /AR%20Receipt%20Analysis%20-%20Days%20Late/
report_name: 'AR Receipt Analysis - Days Late'
report_web_name: ar-receipt-analysis-days-late
module: 'Receivables'
module_url: /modules/receivables/
---

# AR Receipt Analysis - Days Late – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-receipt-analysis-days-late/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
Receipt applications against all transactions except credit memos, with the days between the installment due date and the application date. Converted from the Oracle report Receipt Analysis - Days Late.

One row per receipt application. Days Late is the apply date minus the due date and is negative for an early payment. Weighted Days Late is Days Late multiplied by the amount applied, in the transaction currency.

Invoice Amount shows the installment's original amount on its first application row only, so the column sums to the Oracle report's currency totals.

Average Days Late and Weighted Average Days Late are calculated per operating unit, customer account and currency and repeated on every row of that group. The Oracle report prints 0 for a negative Average Days Late, and splits a customer's currency group when receipts in another currency are applied.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Customer Name, Customer Name Low, Customer Name High, Customer Number, Customer Number Low, Customer Number High, Invoice Number, Invoice Number Low, Invoice Number High, Apply Date From, Apply Date To, Payment Term, Payment Term Low, Payment Term High, Collector, Collector Low, Collector High

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)

## Related Reports
[AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [AR Cash Receipt Upload](/AR%20Cash%20Receipt%20Upload/ "AR Cash Receipt Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Open Items Revaluation](/AR%20Open%20Items%20Revaluation/ "AR Open Items Revaluation Oracle EBS SQL Report"), [AR Customer Statement](/AR%20Customer%20Statement/ "AR Customer Statement Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Receipt%20Analysis%20-%20Days%20Late/AR%20Receipt%20Analysis%20-%20Days%20Late.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Receipt Analysis - Days Late 05-Apr-2018 190325.xlsx](https://www.enginatics.com/example/ar-receipt-analysis-days-late/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late) |
| Blitz Report™ XML Import | [AR_Receipt_Analysis_Days_Late.xml](https://www.enginatics.com/xml/ar-receipt-analysis-days-late/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late) |
| SQL Source | [AR Receipt Analysis - Days Late.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Receipt%20Analysis%20-%20Days%20Late/AR%20Receipt%20Analysis%20-%20Days%20Late.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-receipt-analysis-days-late/](https://www.enginatics.com/reports/ar-receipt-analysis-days-late/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-receipt-analysis-days-late)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
