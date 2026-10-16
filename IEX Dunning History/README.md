---
layout: default
last_modified_at: 2026-10-16
title: 'IEX Dunning History | Oracle EBS SQL Report'
description: 'Dunning letters sent by Advanced Collections, one row per dunning, with the customer, account or bill-to site dunned, the dunning plan, the letter…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Collections, Enginatics, R12 only, IEX, Dunning, History, hz_customer_profiles, ar_collectors, iex_dunning_plans_vl'
permalink: /IEX%20Dunning%20History/
report_name: 'IEX Dunning History'
report_web_name: iex-dunning-history
module: 'Collections'
module_url: /modules/collections/
---

# IEX Dunning History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/iex-dunning-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history).
**Oracle EBS module:** [Collections](/modules/collections/ "Oracle EBS Collections reports") · [all Collections reports](/modules/collections/)  

## Overview
Dunning letters sent by Advanced Collections, one row per dunning, with the customer, account or bill-to site dunned, the dunning plan, the letter template, the delivery method and the amount due at the time of the dunning.

The customer, account and bill-to site are derived from the dunning level: a customer level dunning has no account, and a delinquency level dunning shows the delinquent transaction with its due date and the days past due on the dunning date.

Collector is the collector of the bill-to site profile, else of the account profile, else of the party profile.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Dunning Date From, Dunning Date To, Customer Name, Account Number, Dunning Level, Dunning Plan, Delivery Method

## Oracle EBS Tables Used
[hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [iex_dunning_plans_vl](https://www.enginatics.com/library/?pg=1&find=iex_dunning_plans_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [xdo_templates_vl](https://www.enginatics.com/library/?pg=1&find=xdo_templates_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [jtf_fm_template_all](https://www.enginatics.com/library/?pg=1&find=jtf_fm_template_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [iex_dunnings](https://www.enginatics.com/library/?pg=1&find=iex_dunnings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [iex_delinquencies_all](https://www.enginatics.com/library/?pg=1&find=iex_delinquencies_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)

## Related Reports
[IEX Collection Note Upload](/IEX%20Collection%20Note%20Upload/ "IEX Collection Note Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customer Profiles](/AR%20Customer%20Profiles/ "AR Customer Profiles Oracle EBS SQL Report"), [AR Customer Credit Snapshot](/AR%20Customer%20Credit%20Snapshot/ "AR Customer Credit Snapshot Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/IEX%20Dunning%20History/IEX%20Dunning%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [IEX Dunning History 15-Oct-2026 022644.xlsx](https://www.enginatics.com/example/iex-dunning-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history) |
| Blitz Report™ XML Import | [IEX_Dunning_History.xml](https://www.enginatics.com/xml/iex-dunning-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history) |
| SQL Source | [IEX Dunning History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/IEX%20Dunning%20History/IEX%20Dunning%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/iex-dunning-history/](https://www.enginatics.com/reports/iex-dunning-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history) |

## Case Study & Technical Analysis: IEX Dunning History

### Executive Summary
The IEX Dunning History report lists the dunning letters that Oracle Advanced Collections sent to customers, one row per dunning. Each row shows the customer, account and bill-to site that was dunned, the dunning plan and letter template, the delivery method, the status of the dunning and the amount due when the letter was issued. Collections managers and credit controllers use it to confirm which customers were contacted, by what route and at what level, and to evidence the collection effort on overdue accounts. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Collection effort evidence:** Credit teams must show which dunning letters were sent, when, and for what amount, to support escalation and write-off decisions.
*   **Dunning level clarity:** Customer, account, bill-to and delinquency level dunnings target different objects, and the target of each letter must be identified correctly.
*   **Delivery and status tracking:** Delivery method, delivery status and confirmation mode must be checked when a letter is disputed or returned.
*   **Collector accountability:** Each dunning must be attributed to the collector responsible for the customer.

### The Solution
*   **Dunning object resolution:** The report derives the party, account and bill-to site from the dunning level, so a customer level dunning has no account and a delinquency level dunning is linked to its delinquent transaction.
*   **Delinquency detail:** For delinquency level dunnings, the due date of the delinquent transaction and the days past due on the dunning date are shown.
*   **Collector fallback:** The collector is taken from the bill-to site profile, then from the account profile, then from the party profile.
*   **Letter and delivery details:** The template name, letter name, delivery method, contact and status are resolved to readable values.

### Technical Architecture (High Level)
#### Primary Tables
*   `IEX_DUNNINGS`: one row per dunning, with its level, plan, template, method, status, amount and dates.
*   `IEX_DELINQUENCIES_ALL`: the delinquency record that links a delinquency level dunning to its payment schedule and customer site.
*   `IEX_DUNNING_PLANS_VL`: the dunning plan name.
*   `XDO_TEMPLATES_VL` and `JTF_FM_TEMPLATE_ALL`: the letter templates, from the XML publisher and the fulfillment template sources.
*   `AR_PAYMENT_SCHEDULES_ALL`: the delinquent transaction, its due date and amount due.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL` and `HZ_CUST_ACCT_SITES_ALL`: the customer, account and bill-to site.
*   `HZ_CUSTOMER_PROFILES` and `AR_COLLECTORS`: the collector profile and collector name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the user.

#### Logical Relationships
1.  The inner query reads `IEX_DUNNINGS` and outer joins `IEX_DELINQUENCIES_ALL` on the delinquency ID, limited to the accessible operating units.
2.  The derived party, account and site values are set by a `DECODE` on the dunning level, which uses the dunning object ID or the delinquency record.
3.  The cust account is filled from the site use when the account is not directly known, through `HZ_CUST_SITE_USES_ALL` and `HZ_CUST_ACCT_SITES_ALL`.
4.  The outer query joins the account, party and site, and the payment schedule of the delinquent transaction in `AR_PAYMENT_SCHEDULES_ALL`.
5.  The collector, plan and template are resolved by correlated subqueries, and results are ordered by party name, account number, creation date and dunning ID.

### Parameters & Filtering
*   **Operating Unit:** limits the dunnings to one organization within the accessible set.
*   **Dunning Date From** and **Dunning Date To:** bound the date the dunning was created.
*   **Customer Name** and **Account Number:** identify the customer or account dunned.
*   **Dunning Level:** filters by the level of the dunning, such as customer, account, bill-to or delinquency.
*   **Dunning Plan:** limits the output to dunnings issued under one plan.
*   **Delivery Method:** limits the output to one method of sending the letter.

### Performance & Optimization
*   The organization restriction uses an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so the report reads only dunnings for accessible operating units.
*   The delinquency link is an outer join, so customer level and account level dunnings are kept even without a delinquency record.
*   Collector, plan and template names are fetched by correlated subqueries on primary keys, which keeps each dunning to one row.
*   The site-to-account lookup is used only when the account is not already present on the dunning, which limits the number of joins that are evaluated.

### FAQ
**Q: How is the dunned customer identified for a customer level dunning?**
A: The customer is taken from the dunning object itself, and the account and bill-to site are left blank because the dunning is not tied to them.

**Q: Who is shown as the collector for a dunning?**
A: The collector of the bill-to site profile, or if none, the collector of the account profile, or if none, the collector of the party profile.

**Q: How do I see how many days a delinquent invoice was overdue when the letter was sent?**
A: Use the days past due column for a delinquency level dunning, which is the dunning date minus the due date of the delinquent transaction.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-dunning-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
