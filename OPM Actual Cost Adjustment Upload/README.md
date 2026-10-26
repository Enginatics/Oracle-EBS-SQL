---
layout: default
last_modified_at: 2026-10-26
title: 'OPM Actual Cost Adjustment Upload | Oracle EBS SQL Report'
description: 'Upload to create, update and delete OPM actual cost adjustments per organization, item, calendar period, cost type, component class, analysis code and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, OPM, Actual, Cost, Adjustment, mtl_parameters, cm_adjs_dtl, mtl_system_items_vl'
permalink: /OPM%20Actual%20Cost%20Adjustment%20Upload/
report_name: 'OPM Actual Cost Adjustment Upload'
report_web_name: opm-actual-cost-adjustment-upload
---

# OPM Actual Cost Adjustment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-actual-cost-adjustment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload).

## Overview
Upload to create, update and delete OPM actual cost adjustments per organization, item, calendar period, cost type, component class, analysis code and adjustment type, as in the Actual Cost Adjustments form. The adjustments are applied by the next actual cost process.

Quantity applies to average cost adjustments only and is stored as zero for value and unit cost adjustments. A subledger entry is dated within the period, by default on its first day.

Delete marks an adjustment for purge, as the form does. Adjustments posted to GL, and those of frozen or closed periods, cannot be changed. Changing an applied adjustment sets its status to Modified.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Calendar, Period, Cost Type, Item

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [cm_adjs_dtl](https://www.enginatics.com/library/?pg=1&find=cm_adjs_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [cm_cmpt_mst_vl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)

## Related Reports
[CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC OPM Item Cost Detail](/CAC%20OPM%20Item%20Cost%20Detail/ "CAC OPM Item Cost Detail Oracle EBS SQL Report"), [INV Slow Moving Inventory](/INV%20Slow%20Moving%20Inventory/ "INV Slow Moving Inventory Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Actual%20Cost%20Adjustment%20Upload/OPM%20Actual%20Cost%20Adjustment%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/opm-actual-cost-adjustment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload) |
| Blitz Report™ XML Import | [OPM_Actual_Cost_Adjustment_Upload.xml](https://www.enginatics.com/xml/opm-actual-cost-adjustment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload) |
| SQL Source | [OPM Actual Cost Adjustment Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Actual%20Cost%20Adjustment%20Upload/OPM%20Actual%20Cost%20Adjustment%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-actual-cost-adjustment-upload/](https://www.enginatics.com/reports/opm-actual-cost-adjustment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-actual-cost-adjustment-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
