---
layout: default
last_modified_at: 2026-10-26
title: 'GL Mass Allocation Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes GL MassAllocation and MassBudget batches, formulas and formula lines - the Excel equivalent of the Define MassAllocations and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Mass, Allocation, gl_alloc_batches_v, gl_alloc_formulas, gl_je_categories'
permalink: /GL%20Mass%20Allocation%20Upload/
report_name: 'GL Mass Allocation Upload'
report_web_name: gl-mass-allocation-upload
---

# GL Mass Allocation Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-mass-allocation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload).

## Overview
Creates, updates and deletes GL MassAllocation and MassBudget batches, formulas and formula lines - the Excel equivalent of the Define MassAllocations and Define MassBudgets forms.

Each row is one formula line, with the batch and formula columns repeated on every line. The batch and formula values are taken from the first row of each batch and formula. Leave the formula columns blank to create or update a batch only.

A formula has the lines A, B, C, Target (T) and Offset (O); a MassBudget formula needs A, B, C and T. Lines A, B and C take either an Amount or an account, the Target and Offset lines an account. Enter the Ledger, Ledger Type, Account and Segment Types as in the account flexfield of the form: the account segments and their types C (Constant), L (Looping) or S (Summing) are separated by the segment delimiter of the chart of accounts.

The lines are validated as in the form. Each batch is saved as a whole: when one of its rows fails, none of its rows are saved. A saved change sets the batch to Not Validated and submits the Validate MassAllocations program, as the form does when it is closed.

Set Delete Batch to Yes to delete a batch, Delete Formula to delete a formula with its lines, and Delete Line to delete the Offset line of a MassBudget formula. Batches are maintained in the chart of accounts of the GL access set of the responsibility.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Balance Type, Batch, Formula

## Oracle EBS Tables Used
[gl_alloc_batches_v](https://www.enginatics.com/library/?pg=1&find=gl_alloc_batches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_alloc_formulas](https://www.enginatics.com/library/?pg=1&find=gl_alloc_formulas&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_je_categories](https://www.enginatics.com/library/?pg=1&find=gl_je_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_alloc_formula_lines](https://www.enginatics.com/library/?pg=1&find=gl_alloc_formula_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [gl_access_sets](https://www.enginatics.com/library/?pg=1&find=gl_access_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)

## Related Reports
[GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Journals 11i](/GL%20Journals%2011i/ "GL Journals 11i Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Mass%20Allocation%20Upload/GL%20Mass%20Allocation%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-mass-allocation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload) |
| Blitz Report™ XML Import | [GL_Mass_Allocation_Upload.xml](https://www.enginatics.com/xml/gl-mass-allocation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload) |
| SQL Source | [GL Mass Allocation Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Mass%20Allocation%20Upload/GL%20Mass%20Allocation%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-mass-allocation-upload/](https://www.enginatics.com/reports/gl-mass-allocation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-mass-allocation-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
