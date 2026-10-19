---
layout: default
last_modified_at: 2026-10-19
title: 'AR Aging | Oracle EBS SQL Report'
description: 'The AR Aging report allows users to review information about their open receivables items at a specified point in time (the As of Date). The report will…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, R12 only, Aging, hr_all_organization_units, hz_cust_site_uses_all, hz_cust_acct_sites_all'
permalink: /AR%20Aging/
report_name: 'AR Aging'
report_web_name: ar-aging
module: 'Receivables'
module_url: /modules/receivables/
---

# AR Aging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
The AR Aging report allows users to review information about their open receivables items at a specified point in time (the As of Date). The report will show the aging of the open receivables items based on the selected aging bucket.

- The report includes detailed (Transaction Level) or summary (Customer Level) information about customers current and past due invoices, debit memos, and chargebacks.
- Optionally the report can include details of credit memos, on-account credits, unidentified payments, on-account and unapplied cash amounts, and receipts at risk.
- Optionally the report allows the open receivables items to be revalued to a different currency on a specified revaluation date using a specified revaluation currency rate type.
- All amounts in the report are shown in functional currency, except where the report is run for a specified entered currency, in which case the amounts are shown in the specified entered currency.

Report Parameters:

Reporting Level: The report can be run by Ledger or by Operating Unit. 

Reporting Context: The Ledgers or Operating Units the report is to be run for. Only Ledgers or Operating Units accessible to the current responsibility maybe selected. The report supports the multiple selection of Ledgers or Operating Units allowing to be run for more than one Ledger or Operating Unit. If the Reporting Context is left null, then the report will be run for all Operating Units accessible to the current responsibility. 

Report Summary: The report is summarized at either the Customer Level (Customer Summary) or at Transaction Level (Invoice Summary). The Customer Summary report includes open receivables totals at the customer level only and does not include transaction level details. The Invoice Summary report includes details and the outstanding amounts of the open receivables transactions.

As of Date: The report can be run to provide an aging snapshot at a specified point in time in the past. By default, the As of Date will be the current date. 

Aging Bucket Name:  The Aging Bucket Name determine the Aging Buckets to be used for aging the open receivables items. The aging amount columns in the report are dynamically determined based on the selected Aging Buket. 

Aging Basis: Transactions can be aged based on their Due Date (default) or on their Transaction (Invoice) Date.

Show On Account: The report can optionally include the details and/or amounts for credit memos, on-account credits, unidentified payments, on-account and unapplied cash amounts.
The options for displaying these are:
Do Not Show – they are not included in the report.
Summarize – the amounts are shown as separate columns in the report and are not included in the Aging Amount report columns.
Age – the amounts are included in the Aging Amount report columns.

Show Receipts At Risk: The report can optionally include the details and/or amounts for receipts at risk.
Do Not Show – they are not included in the report.
Summarize – the amounts are shown as separate a column in the report and are not included in the Aging Amount report columns.
Age – the amounts are included in the Aging Amount report columns.

Entered Currency: Restrict the report to open receivables items entered in the specified currency. 

Revaluation Date, Revaluation Currency, Revaluation Rate Type: 
If a revaluation date, currency, and rate type are specified, the report will include additional columns showing the open receivables amounts and aging in the specified revaluation currency.

Additionally, there are several additional parameters which can be used to restrict the data returned by the report.

Show SLA Accounting: Set to Yes to fetch SLA receivable accounting details for each transaction.

Exclude Unaccounted: Set to Yes to exclude transactions and receipts for which accounting has not been created, matching the Oracle Aging - 7 Buckets - By Account Report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Reporting Level, Reporting Context, Report Summary, As Of Date, Aging Bucket Name, Aging Basis, Show On Account, Show Receipts At Risk, Salesrep Name, Salesrep Name Low, Salesrep Name High, Customer Name, Customer Name Low, Customer Name High, Customer Number, Customer Number Low, Customer Number High, Customer Classification, Entered Currency, Balance Due Low, Balance Due High, Invoice Type Low, Invoice Type High, Company Segment Low, Company Segment High, GL Account Segment Low, GL Account Segment High, Exclude Unaccounted, Revaluation Date, Revaluation Currency, Revaluation Rate Type, Party DFF Display, Account DFF Display, Show SLA Accounting

## Oracle EBS Tables Used
[hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_payment_schedules](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_adjustments](https://www.enginatics.com/library/?pg=1&find=ar_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_receivable_applications](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ra_customer_trx](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_cons_inv](https://www.enginatics.com/library/?pg=1&find=ar_cons_inv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ra_salesreps_all](https://www.enginatics.com/library/?pg=1&find=ra_salesreps_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_cust_site_uses](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_cust_acct_sites](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ra_cust_trx_line_gl_dist](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_dispute_history](https://www.enginatics.com/library/?pg=1&find=ar_dispute_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ra_terms](https://www.enginatics.com/library/?pg=1&find=ra_terms&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_cash_receipts](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_cash_receipt_history](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_transaction_history](https://www.enginatics.com/library/?pg=1&find=ar_transaction_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [ar_distributions](https://www.enginatics.com/library/?pg=1&find=ar_distributions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [hz_cust_profile_amts](https://www.enginatics.com/library/?pg=1&find=hz_cust_profile_amts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)

## Related Reports
[AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AR Open Items Revaluation](/AR%20Open%20Items%20Revaluation/ "AR Open Items Revaluation Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Aging/AR%20Aging.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Aging - Pivot and sort by customer 22-Feb-2024 185021.xlsx](https://www.enginatics.com/example/ar-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging) |
| Blitz Report™ XML Import | [AR_Aging.xml](https://www.enginatics.com/xml/ar-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging) |
| SQL Source | [AR Aging.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Aging/AR%20Aging.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-aging/](https://www.enginatics.com/reports/ar-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging) |

## AR Aging Report

### Executive Summary
The AR Aging report provides a snapshot of accounts receivable balances, categorized by age. This report is a critical tool for credit and collections departments, offering a clear view of outstanding customer balances and the length of time they have been overdue. By providing a detailed aging of receivables, the report helps organizations to manage credit risk, improve cash flow, and reduce the incidence of bad debt.

### Business Challenge
Managing accounts receivable is a critical function for any business. However, many organizations face challenges in effectively managing their receivables, including:
- **Lack of Visibility:** Difficulty in getting a clear and up-to-date view of outstanding receivables, which can lead to delayed collections and an increased risk of bad debt.
- **Inefficient Collections:** The collections process can be time-consuming and inefficient, particularly if the collections team does not have access to timely and accurate information about overdue invoices.
- **Inaccurate Cash Flow Forecasting:** Without a clear understanding of the aging of receivables, it is difficult to accurately forecast cash inflows and manage working capital effectively.
- **High Levels of Bad Debt:** A lack of proactive collections management can lead to a high level of bad debt, which can have a significant impact on the bottom line.

### The Solution
The AR Aging report provides a comprehensive and actionable view of outstanding receivables, helping organizations to:
- **Improve Collections:** By providing a clear view of overdue invoices, the report helps collections teams to prioritize their efforts and focus on the accounts that are most at risk of non-payment.
- **Reduce Bad Debt:** By enabling a more proactive approach to collections, the report helps to reduce the incidence of bad debt and improve the overall financial health of the organization.
- **Enhance Cash Flow Forecasting:** The report provides a reliable basis for forecasting cash inflows, enabling organizations to better manage their working capital and make more informed financial decisions.
- **Strengthen Customer Relationships:** By providing a clear and accurate view of outstanding invoices, the report can help to facilitate communication with customers and resolve payment issues in a timely and professional manner.

### Technical Architecture (High Level)
The report is based on a complex query that joins several key tables in the Oracle Receivables module. The primary tables used include:
- **ar_payment_schedules_all:** This table contains the payment schedule for each invoice, including the due date and amount due.
- **ar_receivable_applications_all:** This table stores information about how payments have been applied to invoices.
- **hz_cust_accounts:** This table contains information about the customer accounts.
- **hz_parties:** This table provides information about the parties associated with the customer accounts.

The report also uses several other tables to retrieve additional information, such as the customer's credit limit, the collector assigned to the account, and the currency of the invoice.

### Parameters & Filtering
The report includes a wide range of parameters that allow you to customize the output to your specific needs. The key parameters include:
- **Reporting Level and Context:** These parameters allow you to run the report for a specific ledger or operating unit, or for all accessible ledgers or operating units.
- **Report Summary:** This parameter allows you to choose between a detailed (transaction level) or summary (customer level) report.
- **As of Date:** This parameter allows you to run the report for a specific point in time in the past.
- **Aging Bucket Name:** This parameter allows you to select the aging bucket definition that you want to use for the report.
- **Customer Name and Number:** These parameters allow you to filter the report by a specific customer.

### Performance & Optimization
The AR Aging report is designed to be both powerful and efficient. It is optimized to use the standard indexes on the Oracle Receivables tables, which helps to ensure that the report runs quickly, even with large amounts of data.

### FAQ
**Q: Can I use this report to see the aging of my receivables in a different currency?**
A: Yes, the report includes parameters that allow you to revalue the open receivables amounts to a different currency on a specified revaluation date using a specified revaluation currency rate type.

**Q: Can I use this report to see the details of the invoices that are included in the aging buckets?**
A: Yes, the "Invoice Summary" option for the "Report Summary" parameter provides a detailed, transaction-level view of the open receivables items.

**Q: Can I use this report to see the on-account and unapplied cash amounts for each customer?**
A: Yes, the "Show On Account" parameter allows you to include details of credit memos, on-account credits, unidentified payments, on-account and unapplied cash amounts, and receipts at risk.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-aging)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
