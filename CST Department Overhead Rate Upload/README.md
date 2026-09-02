---
layout: default
title: 'CST Department Overhead Rate Upload | Oracle EBS SQL Report'
description: 'CST Department Overhead Rate Upload =================================== This upload can be used to - Upload new Department Overhead Rates - Download the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, CST, Department, Overhead, Rate, cst_cost_types, mtl_parameters, bom_departments'
permalink: /CST%20Department%20Overhead%20Rate%20Upload/
---

# CST Department Overhead Rate Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-department-overhead-rate-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CST Department Overhead Rate Upload
===================================

This upload can be used to
- Upload new Department Overhead Rates
- Download the current Department Overhead Rates for a Cost Type, update, and upload the amended rates
- Download the current Department Overhead Rates from a Source Cost Type and upload them to a different Target Cost Type
- Delete existing Department Overhead Rates

Department Overhead Rates associate Overhead sub-elements with Departments and specify the rate or amount charged, per basis (Item, Lot, Resource Units, or Resource Value). The rates are imported via the Oracle Cost Import Process.

NOTE:
You can only upload rates to cost types that are not flagged as frozen and are flagged as updateable.

NOTE:
The Cost Import Process cannot delete a Department Overhead Rate, so a row flagged for deletion is not sent to it. Set the Delete Overhead Rate column to Yes and the rate is removed directly when the row is processed, in the same way as the Overheads form removes it.
Deletion is not allowed for frozen standard cost types or for cost types which do not allow updates.
Deleted rates are not covered by the Cost Rollup. Run a rollup separately if the removal should be reflected in item costs.

NOTE:
The Cost Import Process accepts only one row per Department, Overhead, and Cost Type combination in a single run, even when the rows carry different basis types. In 'Remove and replace' mode all existing basis rows of an uploaded combination are replaced by the uploaded row.

Optionally, the upload can perform a Cost Rollup after the rates have been imported. The Cost Rollup can be performed for
- Specific item - a cost rollup is done only for rolled up items whose cost details in the Target Cost Type reference the uploaded department overheads
- All items - the 'Supply Chain Cost Rollup - Print Report' concurrent request is submitted to rollup all items within each organization rates are uploaded to

NOTE:
In 'All items' mode the Supply Chain Cost Rollup requests are submitted asynchronously and the upload does not wait for them.
In 'Specific item' mode, the items to roll up are derived from the existing cost details in the Target Cost Type. Items that have never been rolled up in the Target Cost Type are therefore not found, even if their routings use a department carrying an uploaded overhead rate - use 'All items' mode for those.

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Department Overhead Rates are to be uploaded.

Mode (Required, Default: Remove and replace cost information) -
- Remove and replace cost information: an existing rate for the same department, overhead, and cost type combination is replaced
- Insert new Cost Information Only: uploading a rate for a combination that already has one raises an error

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded rates only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them.

Source Cost Type - Optionally specify the Cost Type from which to download the current Department Overhead Rates, to amend them or to copy them to a different Target Cost Type. New rates can be entered as additional rows in the generated Excel.

Rollup Costs - set to Yes to do a cost rollup after the rates are imported
Rollup Type - All items or Specific item
Rollup Option - Single level rollup or Full cost rollup

Organization Code / Department / Overhead - Optionally restrict the rates to be downloaded.

Notes on the Upload
===================
The upload supports the Department Overhead Information descriptive flexfield. The attribute columns are named according to the descriptive flexfield segments setup.

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Department, Overhead

## Oracle EBS Tables Used
[cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC Department Overhead Rates](/CAC%20Department%20Overhead%20Rates/ "CAC Department Overhead Rates Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/cst-department-overhead-rate-upload/) |
| Blitz Report™ XML Import | [CST_Department_Overhead_Rate_Upload.xml](https://www.enginatics.com/xml/cst-department-overhead-rate-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-department-overhead-rate-upload/](https://www.enginatics.com/reports/cst-department-overhead-rate-upload/) |



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
