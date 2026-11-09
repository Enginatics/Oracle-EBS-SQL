---
layout: default
last_modified_at: 2026-11-09
title: 'GL Budget Account Range Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes the account ranges of GL budget organizations - the Excel equivalent of the Ranges region of the Define Budget Organization…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Budget, Account, Range, gl_budget_assignment_ranges, gl_ledgers, gl_budget_entities'
permalink: /GL%20Budget%20Account%20Range%20Upload/
report_name: 'GL Budget Account Range Upload'
report_web_name: gl-budget-account-range-upload
---

# GL Budget Account Range Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-budget-account-range-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload).

## Overview
Creates, updates and deletes the account ranges of GL budget organizations - the Excel equivalent of the Ranges region of the Define Budget Organization form (Budgets > Define > Organization).

Each row is one account range (line) of a budget organization. Account Low and Account High are entered with all segments, separated by the segment delimiter of the chart of accounts.

As in the form, the account range, Entry Type and Currency of an existing line cannot be changed: delete the line and create a new one. Deleting a line also removes its account assignments and budgetary control options.

After the upload, Assign Budget Account Ranges is submitted for every budget organization that has new lines. It assigns the accounts of the new ranges to the budget organization; its request is shown in the Assignment Request column.

Funds Check Level, Amount Type, Boundary and Funding Budget are the budgetary control options of a line, available for entered lines in the ledger currency of a ledger with budgetary control enabled. A line with several funding budgets takes one row per funding budget.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Upload Mode, Budget Organization

## Oracle EBS Tables Used
[gl_budget_assignment_ranges](https://www.enginatics.com/library/?pg=1&find=gl_budget_assignment_ranges&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [gl_budget_entities](https://www.enginatics.com/library/?pg=1&find=gl_budget_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [gl_budorg_bc_options](https://www.enginatics.com/library/?pg=1&find=gl_budorg_bc_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)

## Related Reports
[GL Budget Amounts Upload](/GL%20Budget%20Amounts%20Upload/ "GL Budget Amounts Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [GL Setup Upload](/GL%20Setup%20Upload/ "GL Setup Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Budget%20Account%20Range%20Upload/GL%20Budget%20Account%20Range%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-budget-account-range-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload) |
| Blitz Report™ XML Import | [GL_Budget_Account_Range_Upload.xml](https://www.enginatics.com/xml/gl-budget-account-range-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload) |
| SQL Source | [GL Budget Account Range Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Budget%20Account%20Range%20Upload/GL%20Budget%20Account%20Range%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-budget-account-range-upload/](https://www.enginatics.com/reports/gl-budget-account-range-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-budget-account-range-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
