---
layout: default
title: 'GL Recurring Journal and Budget Formulas | Oracle EBS SQL Report'
description: 'Lists Oracle General Ledger recurring journal and budget formula definitions - batches, journal entries, lines and each line''s formula steps - with the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Recurring, Journal, Budget, Formulas, gl_je_categories_vl, gl_daily_conversion_types, gl_code_combinations_kfv'
permalink: /GL%20Recurring%20Journal%20and%20Budget%20Formulas/
---

# GL Recurring Journal and Budget Formulas – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists Oracle General Ledger recurring journal and budget formula definitions - batches, journal entries, lines and each line's formula steps - with the account code combinations exploded into one column per Accounting Flexfield segment.

Each row is one formula step. The line account, which is the account the generated journal posts to, and the formula account, which is the account a step reads a balance from, are both shown segment by segment. Company, Department, Account, Sub-Account and the remaining segments of your chart of accounts therefore become individual columns that can be sorted and filtered in Excel.

Replaces the Oracle standard report 'Other - Recurring Formula Listing' (GLXRLRFL), which prints concatenated code combinations in a fixed page layout. Definition access set security on recurring batches is applied exactly as in the standard report.

Use the Ledger, Batch Name, Journal Entry Name and Category parameters to focus on a subset, for example intercompany or intracompany batches, and the per segment like, From and To parameters to restrict the accounts.

## Report Parameters
Ledger, Calendar, Batch Name, Journal Entry Name, Category, Balance Type, Batch Type, MassAllocation Batch, Enabled, Account like, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To

## Oracle EBS Tables Used
[gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_recurring_batches](https://www.enginatics.com/library/?pg=1&find=gl_recurring_batches), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_recurring_headers](https://www.enginatics.com/library/?pg=1&find=gl_recurring_headers), [gl_recurring_lines](https://www.enginatics.com/library/?pg=1&find=gl_recurring_lines), [gl_recurring_line_calc_rules](https://www.enginatics.com/library/?pg=1&find=gl_recurring_line_calc_rules)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Recurring Journal and Budget Formulas 30-Jul-2026 203224.xlsx](https://www.enginatics.com/example/gl-recurring-journal-and-budget-formulas/) |
| Blitz Report™ XML Import | [GL_Recurring_Journal_and_Budget_Formulas.xml](https://www.enginatics.com/xml/gl-recurring-journal-and-budget-formulas/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/](https://www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/) |



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
