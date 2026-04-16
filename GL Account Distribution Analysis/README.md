---
layout: default
title: 'GL Account Distribution Analysis | Oracle EBS SQL Report'
description: 'Detailed GL transaction report with one line per distribution including all segments and subledger data, with amounts in both transaction currency and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Account, Distribution, Analysis, fnd_flex_value_norm_hierarchy, gl_code_combinations_kfv, gl_je_categories_vl'
permalink: /GL%20Account%20Distribution%20Analysis/
---

# GL Account Distribution Analysis – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-distribution-analysis/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detailed GL transaction report with one line per distribution including all segments and subledger data, with amounts in both transaction currency and ledger currency.
The report includes VAT tax codes and rates for AR and AP transactions.

## Report Parameters
Ledger, Period, Period From, Period To, Posted Date From, Posted Date To, Journal Source, Journal Category, Batch, Journal, Journal Line, Tax Rate Code, Account Type, Hierarchy Segment, Hierarchy Name, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, Status, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type, Exclude Zero Amount Lines, Show Segments with Descriptions, Show Open/Close Balances, Show Sub Ledger Contra Accounts, Show Journal Line DFF Attributes, Show Invoice DFF Attributes, Relative Period, Relative Period From, Relative Period To

## Oracle EBS Tables Used
[fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines), [xla_event_types_tl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_tl), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-account-distribution-analysis/) |
| Blitz Report™ XML Import | [GL_Account_Distribution_Analysis.xml](https://www.enginatics.com/xml/gl-account-distribution-analysis/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-account-distribution-analysis/](https://www.enginatics.com/reports/gl-account-distribution-analysis/) |



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
