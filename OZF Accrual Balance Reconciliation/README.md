---
layout: default
last_modified_at: 2026-11-09
title: 'OZF Accrual Balance Reconciliation | Oracle EBS SQL Report'
description: 'Trade Management accrual balance by offer and customer for a range of GL periods: the opening balance, then the accruals, accrual adjustments and paid…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Trade Management, Enginatics, R12 only, OZF, Accrual, Balance, Reconciliation, ams_user_statuses_vl, ozf_funds_all_vl, gl_periods'
permalink: /OZF%20Accrual%20Balance%20Reconciliation/
report_name: 'OZF Accrual Balance Reconciliation'
report_web_name: ozf-accrual-balance-reconciliation
module: 'Trade Management'
module_url: /modules/trade-management/
---

# OZF Accrual Balance Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ozf-accrual-balance-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation).
**Oracle EBS module:** [Trade Management](/modules/trade-management/ "Oracle EBS Trade Management reports") · [all Trade Management reports](/modules/trade-management/)  

## Overview
Trade Management accrual balance by offer and customer for a range of GL periods: the opening balance, then the accruals, accrual adjustments and paid amounts of each period, in the ledger currency of the operating unit.

Accrual and Adjustment are the offer accruals and accrual adjustments by their GL date. Paid is the earnings paid by closed claims, by the claim's GL date and at the accrual's exchange rate, and is shown negative. Accruals and adjustments that are not posted to GL and claims that are not closed are not included.

The opening balance is the total of all three before the first period, so the opening balance plus the period amounts is the balance at the end of Period To.

The templates Pivot: by Offer and Pivot: by Customer list offers or customers against periods; their Grand Total column is the closing balance.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Period From, Period To, Offer Code, Customer

## Oracle EBS Tables Used
[ams_user_statuses_vl](https://www.enginatics.com/library/?pg=1&find=ams_user_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [ozf_funds_all_vl](https://www.enginatics.com/library/?pg=1&find=ozf_funds_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [ozf_funds_utilized_all_b](https://www.enginatics.com/library/?pg=1&find=ozf_funds_utilized_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [ozf_claims_all](https://www.enginatics.com/library/?pg=1&find=ozf_claims_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [ozf_claim_lines_all](https://www.enginatics.com/library/?pg=1&find=ozf_claim_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [ozf_claim_lines_util_all](https://www.enginatics.com/library/?pg=1&find=ozf_claim_lines_util_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [ozf_offers](https://www.enginatics.com/library/?pg=1&find=ozf_offers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)

## Related Reports
[OZF Offers](/OZF%20Offers/ "OZF Offers Oracle EBS SQL Report"), [OZF Budget Utilization](/OZF%20Budget%20Utilization/ "OZF Budget Utilization Oracle EBS SQL Report"), [OZF Claims and Deductions](/OZF%20Claims%20and%20Deductions/ "OZF Claims and Deductions Oracle EBS SQL Report"), [OZF Budgets](/OZF%20Budgets/ "OZF Budgets Oracle EBS SQL Report"), [XLA Entity ID Mappings](/XLA%20Entity%20ID%20Mappings/ "XLA Entity ID Mappings Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Accrual%20Balance%20Reconciliation/OZF%20Accrual%20Balance%20Reconciliation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ozf-accrual-balance-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation) |
| Blitz Report™ XML Import | [OZF_Accrual_Balance_Reconciliation.xml](https://www.enginatics.com/xml/ozf-accrual-balance-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation) |
| SQL Source | [OZF Accrual Balance Reconciliation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Accrual%20Balance%20Reconciliation/OZF%20Accrual%20Balance%20Reconciliation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ozf-accrual-balance-reconciliation/](https://www.enginatics.com/reports/ozf-accrual-balance-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-accrual-balance-reconciliation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
