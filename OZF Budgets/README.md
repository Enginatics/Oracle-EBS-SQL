---
layout: default
last_modified_at: 2026-11-09
title: 'OZF Budgets | Oracle EBS SQL Report'
description: 'Trade Management budgets with the amounts of the budget checkbook, in the budget currency: original budget, transfers, holdback, planned, committed…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Trade Management, Enginatics, OZF, Budgets, hr_operating_units, ams_categories_vl, ams_user_statuses_vl'
permalink: /OZF%20Budgets/
report_name: 'OZF Budgets'
report_web_name: ozf-budgets
module: 'Trade Management'
module_url: /modules/trade-management/
---

# OZF Budgets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ozf-budgets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets).
**Oracle EBS module:** [Trade Management](/modules/trade-management/ "Oracle EBS Trade Management reports") · [all Trade Management reports](/modules/trade-management/)  

## Overview
Trade Management budgets with the amounts of the budget checkbook, in the budget currency: original budget, transfers, holdback, planned, committed, available, utilized, earned, paid and unpaid.

Total is the original budget plus transfers in less transfers out. Available is the total less holdback and committed. Unpaid is earned less paid. OZF Budget Utilization lists the accruals, adjustments and payments behind Utilized, Earned and Paid.

Rollup Amounts shows the amounts of each budget including its child budgets, as the rollup view of the budget checkbook. Quotas are not included.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Budget Type, Budget Category, Budget Name, Status, Rollup Amounts

## Oracle EBS Tables Used
[hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets), [ams_categories_vl](https://www.enginatics.com/library/?pg=1&find=ams_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets), [ams_user_statuses_vl](https://www.enginatics.com/library/?pg=1&find=ams_user_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets), [ozf_funds_all_vl](https://www.enginatics.com/library/?pg=1&find=ozf_funds_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)

## Related Reports
[OZF Claims and Deductions](/OZF%20Claims%20and%20Deductions/ "OZF Claims and Deductions Oracle EBS SQL Report"), [OZF Offers](/OZF%20Offers/ "OZF Offers Oracle EBS SQL Report"), [OZF Accrual Balance Reconciliation](/OZF%20Accrual%20Balance%20Reconciliation/ "OZF Accrual Balance Reconciliation Oracle EBS SQL Report"), [CN Manual Payment Upload](/CN%20Manual%20Payment%20Upload/ "CN Manual Payment Upload Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [ONT Blanket Sales Agreements](/ONT%20Blanket%20Sales%20Agreements/ "ONT Blanket Sales Agreements Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Budgets/OZF%20Budgets.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ozf-budgets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets) |
| Blitz Report™ XML Import | [OZF_Budgets.xml](https://www.enginatics.com/xml/ozf-budgets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets) |
| SQL Source | [OZF Budgets.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Budgets/OZF%20Budgets.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ozf-budgets/](https://www.enginatics.com/reports/ozf-budgets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-budgets)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
