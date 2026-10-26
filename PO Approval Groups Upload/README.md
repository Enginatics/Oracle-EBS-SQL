---
layout: default
last_modified_at: 2026-10-26
title: 'PO Approval Groups Upload | Oracle EBS SQL Report'
description: 'Creates and updates the approval groups of the Approval Groups form, with their rules, and the assignments of approval groups to positions or jobs per…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Approval, Groups, po_control_groups_all, po_control_rules, per_positions'
permalink: /PO%20Approval%20Groups%20Upload/
report_name: 'PO Approval Groups Upload'
report_web_name: po-approval-groups-upload
---

# PO Approval Groups Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-approval-groups-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload).

## Overview
Creates and updates the approval groups of the Approval Groups form, with their rules, and the assignments of approval groups to positions or jobs per document type of the Approval Assignments form.

A row carries an approval group, optionally with one rule (Object, Type, Amount Limit, Low Value, High Value, Inactive Date), one assignment (Position or Job, Document Type, Start Date, End Date), or both. The group values are taken from the first row of each group.

Low Value and High Value of an account, item or item category range hold the segment values separated by the flexfield delimiter, such as 01-000-0000-0000-000. A Location rule takes the location in Low Value.

An operating unit that uses approval hierarchies (Use Approval Hierarchies in the Financials options) assigns positions, otherwise jobs.

Rules and assignments are ended with Inactive Date and End Date, not deleted.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Approval Group, Position, Job, Document Type

## Oracle EBS Tables Used
[po_control_groups_all](https://www.enginatics.com/library/?pg=1&find=po_control_groups_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [po_control_rules](https://www.enginatics.com/library/?pg=1&find=po_control_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [per_positions](https://www.enginatics.com/library/?pg=1&find=per_positions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [po_control_functions_all](https://www.enginatics.com/library/?pg=1&find=po_control_functions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [po_position_controls_all](https://www.enginatics.com/library/?pg=1&find=po_position_controls_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)

## Related Reports
[PO Approval Assignments](/PO%20Approval%20Assignments/ "PO Approval Assignments Oracle EBS SQL Report"), [PO Approval History](/PO%20Approval%20History/ "PO Approval History Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [PO Supplier Scheduling On-Time Delivery](/PO%20Supplier%20Scheduling%20On-Time%20Delivery/ "PO Supplier Scheduling On-Time Delivery Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approval%20Groups%20Upload/PO%20Approval%20Groups%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/po-approval-groups-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload) |
| Blitz Report™ XML Import | [PO_Approval_Groups_Upload.xml](https://www.enginatics.com/xml/po-approval-groups-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload) |
| SQL Source | [PO Approval Groups Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approval%20Groups%20Upload/PO%20Approval%20Groups%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-approval-groups-upload/](https://www.enginatics.com/reports/po-approval-groups-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-groups-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
