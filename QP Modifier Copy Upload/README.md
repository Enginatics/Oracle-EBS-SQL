---
layout: default
last_modified_at: 2026-11-16
title: 'QP Modifier Copy Upload | Oracle EBS SQL Report'
description: 'Copies modifier lists, one row per modifier list, as the Copy Modifier List window of Advanced Pricing (Modifiers > Copy) does. Upload Mode Create, Update…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Modifier, Copy, qp_secu_list_headers_vl, hr_operating_units, xxen_report_org_access'
permalink: /QP%20Modifier%20Copy%20Upload/
report_name: 'QP Modifier Copy Upload'
report_web_name: qp-modifier-copy-upload
---

# QP Modifier Copy Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-modifier-copy-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload).

## Overview
Copies modifier lists, one row per modifier list, as the Copy Modifier List window of Advanced Pricing (Modifiers > Copy) does.

Upload Mode Create, Update downloads the selected modifier lists; Create gives an empty sheet to paste rows into.

Enter a New Modifier Number and New Modifier Name to copy the row's modifier list with its qualifiers and the lines active today. The copy keeps the type and version of its source.

A list number can exist in several versions. List Version then selects the modifier list, and a row without it is rejected.

Change List Effective To to end-date the row's modifier list, for example the day before the new list starts. Only a modifier list without an end date can be end-dated: an existing end date cannot be changed or removed, and a blank List Effective To leaves the modifier list unchanged.

The copy is saved as soon as it runs. A row that fails afterwards keeps the new modifier list and its message says so: end-date the source in a separate row instead of uploading the row again.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, List Type, List Number, List Number Like, List Number From, List Number To, Effective Date

## Oracle EBS Tables Used
[qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)

## Related Reports
[QP Price List Copy and Adjust Upload](/QP%20Price%20List%20Copy%20and%20Adjust%20Upload/ "QP Price List Copy and Adjust Upload Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [QP Price List Upload](/QP%20Price%20List%20Upload/ "QP Price List Upload Oracle EBS SQL Report"), [QP GSA Pricing Upload](/QP%20GSA%20Pricing%20Upload/ "QP GSA Pricing Upload Oracle EBS SQL Report"), [QP Modifier Upload](/QP%20Modifier%20Upload/ "QP Modifier Upload Oracle EBS SQL Report"), [ONT Blanket Sales Agreements](/ONT%20Blanket%20Sales%20Agreements/ "ONT Blanket Sales Agreements Oracle EBS SQL Report"), [ONT Price Adjustments and Charges](/ONT%20Price%20Adjustments%20and%20Charges/ "ONT Price Adjustments and Charges Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20Modifier%20Copy%20Upload/QP%20Modifier%20Copy%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/qp-modifier-copy-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload) |
| Blitz Report™ XML Import | [QP_Modifier_Copy_Upload.xml](https://www.enginatics.com/xml/qp-modifier-copy-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload) |
| SQL Source | [QP Modifier Copy Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20Modifier%20Copy%20Upload/QP%20Modifier%20Copy%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qp-modifier-copy-upload/](https://www.enginatics.com/reports/qp-modifier-copy-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-modifier-copy-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
