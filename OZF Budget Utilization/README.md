---
layout: default
last_modified_at: 2026-11-09
title: 'OZF Budget Utilization | Oracle EBS SQL Report'
description: 'Trade Management budget utilization lines, as the utilized, earned and paid checkbooks of a budget: offer accruals, accrual adjustments, off-invoice…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Trade Management, Enginatics, R12 only, OZF, Budget, Utilization, hr_operating_units, ozf_claim_types_all_vl, hz_cust_site_uses_all'
permalink: /OZF%20Budget%20Utilization/
report_name: 'OZF Budget Utilization'
report_web_name: ozf-budget-utilization
module: 'Trade Management'
module_url: /modules/trade-management/
---

# OZF Budget Utilization – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ozf-budget-utilization/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization).
**Oracle EBS module:** [Trade Management](/modules/trade-management/ "Oracle EBS Trade Management reports") · [all Trade Management reports](/modules/trade-management/)  

## Overview
Trade Management budget utilization lines, as the utilized, earned and paid checkbooks of a budget: offer accruals, accrual adjustments, off-invoice discounts, chargebacks and referral accruals, with the customer, product and order or transaction they come from.

Utilized, Earned, Paid and Unpaid are in the budget currency. Earned excludes lines that are not posted to GL. Paid is the amount settled by closed claims, or for an off-invoice discount the discount itself, and Unpaid is earned less paid. The accounted columns show the same in the ledger currency, with Paid at the exchange rate of the accrual.

The totals by budget agree with the Utilized, Earned and Paid amounts of OZF Budgets. The template Pivot: by Customer lists the earned, paid and unpaid amounts by customer and offer, as the promotional payments view.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, GL Date From, GL Date To, Budget Name, Offer Code, Customer, Utilization Type

## Oracle EBS Tables Used
[hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_claim_types_all_vl](https://www.enginatics.com/library/?pg=1&find=ozf_claim_types_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_funds_utilized_all_b](https://www.enginatics.com/library/?pg=1&find=ozf_funds_utilized_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_funds_all_vl](https://www.enginatics.com/library/?pg=1&find=ozf_funds_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_offers](https://www.enginatics.com/library/?pg=1&find=ozf_offers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [oe_sys_parameters_all](https://www.enginatics.com/library/?pg=1&find=oe_sys_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_claims_all](https://www.enginatics.com/library/?pg=1&find=ozf_claims_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_claim_lines_all](https://www.enginatics.com/library/?pg=1&find=ozf_claim_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [ozf_claim_lines_util_all](https://www.enginatics.com/library/?pg=1&find=ozf_claim_lines_util_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)

## Related Reports
[OZF Offers](/OZF%20Offers/ "OZF Offers Oracle EBS SQL Report"), [OZF Accrual Balance Reconciliation](/OZF%20Accrual%20Balance%20Reconciliation/ "OZF Accrual Balance Reconciliation Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Budget%20Utilization/OZF%20Budget%20Utilization.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ozf-budget-utilization/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization) |
| Blitz Report™ XML Import | [OZF_Budget_Utilization.xml](https://www.enginatics.com/xml/ozf-budget-utilization/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization) |
| SQL Source | [OZF Budget Utilization.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Budget%20Utilization/OZF%20Budget%20Utilization.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ozf-budget-utilization/](https://www.enginatics.com/reports/ozf-budget-utilization/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budget-utilization)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
