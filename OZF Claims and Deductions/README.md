---
layout: default
last_modified_at: 2026-11-09
title: 'OZF Claims and Deductions | Oracle EBS SQL Report'
description: 'Trade Management claims, deductions and overpayments with their type, reason, status, customer, amounts, owner, source transaction and settlement. Days…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Trade Management, Enginatics, OZF, Claims, Deductions, hr_operating_units, ozf_claim_types_all_vl, ozf_reason_codes_all_vl'
permalink: /OZF%20Claims%20and%20Deductions/
report_name: 'OZF Claims and Deductions'
report_web_name: ozf-claims-and-deductions
module: 'Trade Management'
module_url: /modules/trade-management/
---

# OZF Claims and Deductions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ozf-claims-and-deductions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions).
**Oracle EBS module:** [Trade Management](/modules/trade-management/ "Oracle EBS Trade Management reports") · [all Trade Management reports](/modules/trade-management/)  

## Overview
Trade Management claims, deductions and overpayments with their type, reason, status, customer, amounts, owner, source transaction and settlement.

Days Past Due and Aging Bucket are calculated from the due date as of today, for claims in status New, Open, Complete or Rejected, the claims that Oracle Trade Management ages. Aging Bucket uses the Receivables aging bucket selected in the parameter of the same name. Open Only restricts the report to these claims.

The template Pivot: Aging by Customer shows the accounted remaining amount of the open claims by customer and aging bucket, as the claims aging view.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Claim Class, Status, Open Only, Customer, Claim Date From, Claim Date To, Reason, Aging Bucket

## Oracle EBS Tables Used
[hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ozf_claim_types_all_vl](https://www.enginatics.com/library/?pg=1&find=ozf_claim_types_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ozf_reason_codes_all_vl](https://www.enginatics.com/library/?pg=1&find=ozf_reason_codes_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ams_user_statuses_vl](https://www.enginatics.com/library/?pg=1&find=ams_user_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ar_aging_buckets](https://www.enginatics.com/library/?pg=1&find=ar_aging_buckets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ar_aging_bucket_lines_b](https://www.enginatics.com/library/?pg=1&find=ar_aging_bucket_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ar_aging_bucket_lines_tl](https://www.enginatics.com/library/?pg=1&find=ar_aging_bucket_lines_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [ozf_claims_all](https://www.enginatics.com/library/?pg=1&find=ozf_claims_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Claims%20and%20Deductions/OZF%20Claims%20and%20Deductions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ozf-claims-and-deductions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions) |
| Blitz Report™ XML Import | [OZF_Claims_and_Deductions.xml](https://www.enginatics.com/xml/ozf-claims-and-deductions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions) |
| SQL Source | [OZF Claims and Deductions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OZF%20Claims%20and%20Deductions/OZF%20Claims%20and%20Deductions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ozf-claims-and-deductions/](https://www.enginatics.com/reports/ozf-claims-and-deductions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ozf-claims-and-deductions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
