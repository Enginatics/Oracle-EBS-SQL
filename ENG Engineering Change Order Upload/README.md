---
layout: default
last_modified_at: 2026-10-26
title: 'ENG Engineering Change Order Upload | Oracle EBS SQL Report'
description: 'Creates and updates engineering change orders (ECOs) with their revised items and revised components - the Engineering Change Orders form (Engineering >…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, ENG, Engineering, Change, Order, eng_engineering_changes, eng_revised_items, mtl_system_items_vl'
permalink: /ENG%20Engineering%20Change%20Order%20Upload/
report_name: 'ENG Engineering Change Order Upload'
report_web_name: eng-engineering-change-order-upload
---

# ENG Engineering Change Order Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eng-engineering-change-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload).

## Overview
Creates and updates engineering change orders (ECOs) with their revised items and revised components - the Engineering Change Orders form (Engineering > ECOs > ECOs).

Each row holds one ECO, optionally one of its revised items and one revised component of that revised item. The ECO and revised item columns repeat on every row, and a change in any of these rows is applied. A new ECO is created with status Open.

A revised item is identified by item and alternate. An Effective Date in the past is moved to the current date, as in the form. Changing the Effective Date of an existing revised item reschedules it with its revised components, and changing New Item Revision renames the new revision. Revised items are not deleted; set their status to Cancelled instead.

Component Action Add adds a component to the bill. Change and Disable refer to the implemented component of the revised item's bill at Old Operation Seq (or Operation Seq when Old Operation Seq is blank) effective at the revised item's effective date; for Change enter only the values that change. Delete Component removes a pending revised component from the ECO.

Approval, implementation, substitute components, reference designators and revised operations are maintained in the form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, ECO, ECO Type, Revised Item, Pending only

## Oracle EBS Tables Used
[eng_engineering_changes](https://www.enginatics.com/library/?pg=1&find=eng_engineering_changes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [eng_revised_items](https://www.enginatics.com/library/?pg=1&find=eng_revised_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [eng_change_order_types_vl](https://www.enginatics.com/library/?pg=1&find=eng_change_order_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [eng_change_statuses_vl](https://www.enginatics.com/library/?pg=1&find=eng_change_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [mtl_item_revisions_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [ENG Engineering Change Orders](/ENG%20Engineering%20Change%20Orders/ "ENG Engineering Change Orders Oracle EBS SQL Report"), [BOM Bill of Material Structure](/BOM%20Bill%20of%20Material%20Structure/ "BOM Bill of Material Structure Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [BOM Item Where Used GUI](/BOM%20Item%20Where%20Used%20GUI/ "BOM Item Where Used GUI Oracle EBS SQL Report"), [BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ENG%20Engineering%20Change%20Order%20Upload/ENG%20Engineering%20Change%20Order%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eng-engineering-change-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload) |
| Blitz Report™ XML Import | [ENG_Engineering_Change_Order_Upload.xml](https://www.enginatics.com/xml/eng-engineering-change-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload) |
| SQL Source | [ENG Engineering Change Order Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ENG%20Engineering%20Change%20Order%20Upload/ENG%20Engineering%20Change%20Order%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eng-engineering-change-order-upload/](https://www.enginatics.com/reports/eng-engineering-change-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-order-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
