---
layout: default
last_modified_at: 2026-10-26
title: 'CST Department Overhead Rate Upload | Oracle EBS SQL Report'
description: 'CST Department Overhead Rate Upload =================================== This upload can be used to - Upload new Department Overhead Rates - Download the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, CST, Department, Overhead, Rate, cst_department_overheads, cst_cost_types, mtl_parameters'
permalink: /CST%20Department%20Overhead%20Rate%20Upload/
report_name: 'CST Department Overhead Rate Upload'
report_web_name: cst-department-overhead-rate-upload
---

# CST Department Overhead Rate Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-department-overhead-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Department, Overhead

## Oracle EBS Tables Used
[cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [WIP Resource Transactions](/WIP%20Resource%20Transactions/ "WIP Resource Transactions Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC Department Overhead Rates](/CAC%20Department%20Overhead%20Rates/ "CAC Department Overhead Rates Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Department%20Overhead%20Rate%20Upload/CST%20Department%20Overhead%20Rate%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cst-department-overhead-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload) |
| Blitz Report™ XML Import | [CST_Department_Overhead_Rate_Upload.xml](https://www.enginatics.com/xml/cst-department-overhead-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload) |
| SQL Source | [CST Department Overhead Rate Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Department%20Overhead%20Rate%20Upload/CST%20Department%20Overhead%20Rate%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-department-overhead-rate-upload/](https://www.enginatics.com/reports/cst-department-overhead-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload) |

## Case Study & Technical Analysis: CST Department Overhead Rate Upload

### Executive Summary
The CST Department Overhead Rate Upload maintains department overhead rates in Oracle Cost Management, the rates that charge overhead sub-elements to departments by item, lot, resource units or resource value. It is written for cost accountants and manufacturing finance teams who set up or revise standard costs and need to change many department overhead rates at once. The upload can download current rates for a cost type, amend them, copy them from a source cost type to a target cost type, create new rates or delete existing ones.
### Business Challenge
*   **Standard cost maintenance at volume:** Department overhead rates are defined per department and overhead, so a plant-wide change touches many rows that are tedious to key in the form.
*   **Copying rates between cost types:** Companies that maintain several cost types, such as frozen and pending standards, need the same overhead structure in each.
*   **Import limitations:** The Cost Import Process cannot delete a rate and accepts only one row per department, overhead and cost type in a single run, so the workflow must handle these constraints.

### The Solution
*   **Download, amend and upload:** The report downloads the current rates for a target cost type, optionally from a source cost type, and the user edits and re-uploads them.
*   **Two import behaviours:** Remove and replace mode replaces an existing rate for the same department, overhead and cost type, while Insert new mode raises an error if the combination already exists.
*   **Direct deletion:** A row flagged with Delete Overhead Rate is removed directly, in the same way as the Overheads form, because the Cost Import Process cannot perform deletions.
*   **Optional rollup:** Rollup can be run for specific items that reference the uploaded overheads, or for all items in each organisation, with single level or full cost options.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_DEPARTMENT_OVERHEADS`: the department overhead rates, holding the basis type, rate or amount, activity and flexfield values.
*   `CST_COST_TYPES`: the source and target cost types, used to select the rates to download and the type to upload into.
*   `MTL_PARAMETERS`: the inventory organisations, with their cost organisation and process manufacturing flags.
*   `BOM_DEPARTMENTS`: the departments that carry overhead rates.
*   `BOM_RESOURCES`: the overhead resources, restricted to the overhead cost element.
*   `CST_ACTIVITIES`: the activity attached to each rate.

#### Logical Relationships
1. `CST_COST_TYPES` is joined twice, once as the source type and once as the target type, which allows rates to be copied between cost types.
2. `CST_DEPARTMENT_OVERHEADS` joins to the source cost type on its cost type identifier, and to `MTL_PARAMETERS` on the organisation identifier.
3. Rates join to `BOM_DEPARTMENTS` on the department identifier and to `BOM_RESOURCES` on the overhead identifier, with the resource restricted to cost element 5.
4. Rates join to `CST_ACTIVITIES` through an outer join on the activity identifier.
5. Organisations are limited to those returned by `ORG_ACCESS_VIEW` for the current responsibility.

### Parameters & Filtering
*   **Target Cost Type:** The cost type into which rates are uploaded, and the type whose rates are returned.
*   **Mode:** Remove and replace cost information, or Insert new cost information only, as described in the Technical Architecture section.
*   **Auto Populate Upload Columns:** When set to Yes, downloaded rows are flagged for upload even if unchanged.
*   **Source Cost Type:** The cost type from which rates are downloaded when copying between types.
*   **Rollup Costs?, Rollup Type and Rollup Option:** Control whether a cost rollup runs after import, whether it covers specific or all items, and whether it is single level or full cost.

### Performance & Optimization
*   **Organisation filter first:** The query limits `MTL_PARAMETERS` to the organisations in `ORG_ACCESS_VIEW` before joining the rate tables.
*   **Current records only:** Departments and resources are filtered to those with no disable date or a future one, so retired records are excluded from download.

### FAQ
**Q: How do I copy department overhead rates from one cost type to another in Oracle Cost Management?**
A: Set the Source Cost Type and Target Cost Type parameters, download the rates, and upload the file to the target type.

**Q: Why is a deleted department overhead rate still in my item costs?**
A: The description states that deletion does not trigger a rollup. Run a rollup separately if the removal should be reflected in item costs.

**Q: Can I upload two overhead rates for the same department with different basis types in one run?**
A: No. The Cost Import Process accepts only one row per department, overhead and cost type in a single run, so in Remove and replace mode the uploaded row replaces all existing basis rows for that combination.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-department-overhead-rate-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
