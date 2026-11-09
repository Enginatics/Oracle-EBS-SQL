---
layout: default
last_modified_at: 2026-11-09
title: 'XLA Accounting Errors | Oracle EBS SQL Report'
description: 'Errors and warnings of the subledger accounting program (Create Accounting) for each ledger, application, accounting event and transaction, as the Create…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Subledger Accounting, Enginatics, R12 only, XLA, Accounting, Errors, xla_accounting_errors, fnd_application_vl, xla_events'
permalink: /XLA%20Accounting%20Errors/
report_name: 'XLA Accounting Errors'
report_web_name: xla-accounting-errors
module: 'Subledger Accounting'
module_url: /modules/subledger-accounting/
---

# XLA Accounting Errors – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xla-accounting-errors/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors).
**Oracle EBS module:** [Subledger Accounting](/modules/subledger-accounting/ "Oracle EBS Subledger Accounting reports") · [all Subledger Accounting reports](/modules/subledger-accounting/)  

## Overview
Errors and warnings of the subledger accounting program (Create Accounting) for each ledger, application, accounting event and transaction, as the Create Accounting output lists them with Errors Only = Yes. Run as the daily check of failed events, so that scheduled Create Accounting runs can use Errors Only = Yes or Report = Summary instead of writing every accounted line to their output.
Request Id matches the Create Accounting request or one of its Accounting Program child requests. An accounting program run deletes the earlier errors of the events it processes, so the report shows the errors of each event's latest run.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Application, Created within Days, Request Id

## Oracle EBS Tables Used
[xla_accounting_errors](https://www.enginatics.com/library/?pg=1&find=xla_accounting_errors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [xla_event_types_vl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [xla_event_classes_vl](https://www.enginatics.com/library/?pg=1&find=xla_event_classes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Accounting%20Errors/XLA%20Accounting%20Errors.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XLA Accounting Errors 08-Nov-2026 212252.xlsx](https://www.enginatics.com/example/xla-accounting-errors/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors) |
| Blitz Report™ XML Import | [XLA_Accounting_Errors.xml](https://www.enginatics.com/xml/xla-accounting-errors/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors) |
| SQL Source | [XLA Accounting Errors.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Accounting%20Errors/XLA%20Accounting%20Errors.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/xla-accounting-errors/](https://www.enginatics.com/reports/xla-accounting-errors/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-accounting-errors)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
