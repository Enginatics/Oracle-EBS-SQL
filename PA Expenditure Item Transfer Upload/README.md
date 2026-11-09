---
layout: default
last_modified_at: 2026-11-09
title: 'PA Expenditure Item Transfer Upload | Oracle EBS SQL Report'
description: 'Transfers expenditure items to another project or task, as the Transfer action of the Expenditure Items window (Expenditure Inquiry) does, through…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Expenditure, Item, Transfer, pa_system_linkages, per_all_people_f, hr_all_organization_units_vl'
permalink: /PA%20Expenditure%20Item%20Transfer%20Upload/
report_name: 'PA Expenditure Item Transfer Upload'
report_web_name: pa-expenditure-item-transfer-upload
---

# PA Expenditure Item Transfer Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-expenditure-item-transfer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload).

## Overview
Transfers expenditure items to another project or task, as the Transfer action of the Expenditure Items window (Expenditure Inquiry) does, through pa_adjustments.

Enter a To Task, and a To Project for a transfer to another project, on the rows to transfer. Each transferred item is reversed on its current task and recreated on the destination task, which takes its billable or capitalizable flag and transaction controls from there. The result shows the new item, with the original item in Transferred From Item Id. Rows without a To Task are not transferred.

The download lists the items that are not reversed, reversing or related items. An item is rejected with Oracle's message where the window refuses the transfer, such as an unapproved item, an item already transferred or a date outside the destination project or task dates.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Project, Task, Expenditure Item Date From, Expenditure Item Date To, Expenditure Type Class, Expenditure Category, Expenditure Type, Employee, Expenditure Organization, Transaction Source, Expenditure Batch

## Oracle EBS Tables Used
[pa_system_linkages](https://www.enginatics.com/library/?pg=1&find=pa_system_linkages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_transaction_sources](https://www.enginatics.com/library/?pg=1&find=pa_transaction_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_expenditure_comments](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_comments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PA Project Expenditure Items with WIP and INV Detail](/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/ "PA Project Expenditure Items with WIP and INV Detail Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [PO Purchasing Document Upload](/PO%20Purchasing%20Document%20Upload/ "PO Purchasing Document Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Expenditure%20Item%20Transfer%20Upload/PA%20Expenditure%20Item%20Transfer%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Expenditure Item Transfer Upload 07-Nov-2026 154553.xlsx](https://www.enginatics.com/example/pa-expenditure-item-transfer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload) |
| Blitz Report™ XML Import | [PA_Expenditure_Item_Transfer_Upload.xml](https://www.enginatics.com/xml/pa-expenditure-item-transfer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload) |
| SQL Source | [PA Expenditure Item Transfer Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Expenditure%20Item%20Transfer%20Upload/PA%20Expenditure%20Item%20Transfer%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-expenditure-item-transfer-upload/](https://www.enginatics.com/reports/pa-expenditure-item-transfer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-item-transfer-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
