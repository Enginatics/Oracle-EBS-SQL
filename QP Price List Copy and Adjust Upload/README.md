---
layout: default
last_modified_at: 2026-11-09
title: 'QP Price List Copy and Adjust Upload | Oracle EBS SQL Report'
description: 'Copies price lists and adjusts their prices, one row per price list, as the Copy Price List and Adjust Price List windows of Advanced Pricing do. Upload…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Price, List, Copy, Adjust, qp_secu_list_headers_vl, hr_operating_units, xxen_report_org_access'
permalink: /QP%20Price%20List%20Copy%20and%20Adjust%20Upload/
report_name: 'QP Price List Copy and Adjust Upload'
report_web_name: qp-price-list-copy-and-adjust-upload
---

# QP Price List Copy and Adjust Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-price-list-copy-and-adjust-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload).

## Overview
Copies price lists and adjusts their prices, one row per price list, as the Copy Price List and Adjust Price List windows of Advanced Pricing do.

Upload Mode Create, Update downloads the selected price lists; Create gives an empty sheet to paste rows into.

Enter a New Price List to copy the row's price list with its qualifiers and the lines active today. Adjust By and Adjust Value then change the prices of the new list, or of the row's own list when no New Price List is entered.

Standard and agreement price lists can be copied, and the copy keeps the type of its source. A copied agreement price list gets no qualifiers and is not attached to an agreement. Prices can be adjusted on standard price lists only, as in the Adjust Price Lists window.

Change Effective To to end-date the row's price list, for example the day before the new list starts. Only a price list without an end date can be end-dated: an existing end date cannot be changed or removed, and a blank Effective To leaves the price list unchanged.

Item From, Item To and Category limit both the copy and the adjustment; Adjust Item Status and Adjust Creation Date limit the adjustment only. With any of these filters only lines priced by item number are copied or adjusted; lines priced by item category or all items are left out.

The copy and the adjustment are saved as soon as they run. A row that fails afterwards keeps the new price list and its message says so: adjust the new list in a separate row instead of uploading the row again.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Price List, Price List like, Price List From, Price List To, Effective Date

## Oracle EBS Tables Used
[qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)

## Related Reports
[QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [QP Price List Upload](/QP%20Price%20List%20Upload/ "QP Price List Upload Oracle EBS SQL Report"), [QP GSA Pricing Upload](/QP%20GSA%20Pricing%20Upload/ "QP GSA Pricing Upload Oracle EBS SQL Report"), [QP Modifier Upload](/QP%20Modifier%20Upload/ "QP Modifier Upload Oracle EBS SQL Report"), [ONT Blanket Sales Agreements](/ONT%20Blanket%20Sales%20Agreements/ "ONT Blanket Sales Agreements Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [ONT Price Adjustments and Charges](/ONT%20Price%20Adjustments%20and%20Charges/ "ONT Price Adjustments and Charges Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20Price%20List%20Copy%20and%20Adjust%20Upload/QP%20Price%20List%20Copy%20and%20Adjust%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/qp-price-list-copy-and-adjust-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload) |
| Blitz Report™ XML Import | [QP_Price_List_Copy_and_Adjust_Upload.xml](https://www.enginatics.com/xml/qp-price-list-copy-and-adjust-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload) |
| SQL Source | [QP Price List Copy and Adjust Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20Price%20List%20Copy%20and%20Adjust%20Upload/QP%20Price%20List%20Copy%20and%20Adjust%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qp-price-list-copy-and-adjust-upload/](https://www.enginatics.com/reports/qp-price-list-copy-and-adjust-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-price-list-copy-and-adjust-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
