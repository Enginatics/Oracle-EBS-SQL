---
layout: default
title: 'CST Resource Rate Upload | Oracle EBS SQL Report'
description: 'CST Resource Rate Upload ======================== This upload can be used to - Upload new Resource Rates - Download the current Resource Rates for a Cost…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, CST, Resource, Rate, cst_cost_types, mtl_parameters, bom_resources'
permalink: /CST%20Resource%20Rate%20Upload/
---

# CST Resource Rate Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-resource-rate-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CST Resource Rate Upload
========================

This upload can be used to
- Upload new Resource Rates
- Download the current Resource Rates for a Cost Type, update, and upload the amended rates
- Download the current Resource Rates from a Source Cost Type and upload them to a different Target Cost Type
- Delete existing Resource Rates

Resource Rates apply to rate based Resource and Outside Processing sub-elements (sub-elements whose charge basis is not currency based). The rates are imported via the Oracle Cost Import Process.

NOTE:
You can only upload rates to cost types that are not flagged as frozen and are flagged as updateable. This includes the rates cost types used by average costing organizations (e.g. AvgRates).

NOTE:
The Cost Import Process cannot delete a Resource Rate, so a row flagged for deletion is not sent to it. Set the Delete Resource Rate column to Yes and the rate is removed directly when the row is processed, in the same way as the Resources form removes it.
Deletion is not allowed for frozen standard cost types or for cost types which do not allow updates.
Deleted rates are not covered by the Cost Rollup. Run a rollup separately if the removal should be reflected in item costs.

Optionally, the upload can perform a Cost Rollup after the rates have been imported. The Cost Rollup can be performed for
- Specific item - a cost rollup is done only for rolled up items whose cost details in the Target Cost Type reference the uploaded resources
- All items - the 'Supply Chain Cost Rollup - Print Report' concurrent request is submitted to rollup all items within each organization rates are uploaded to

NOTE:
In 'All items' mode the Supply Chain Cost Rollup requests are submitted asynchronously and the upload does not wait for them.
In 'Specific item' mode, the items to roll up are derived from the existing cost details in the Target Cost Type. Items that have never been rolled up in the Target Cost Type are therefore not found, even if their routings use an uploaded resource - use 'All items' mode for those.

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Resource Rates are to be uploaded.

Mode (Required, Default: Remove and replace cost information) -
- Remove and replace cost information: an existing rate for the same resource is replaced
- Insert new Cost Information Only: uploading a rate for a resource that already has one raises an error

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded rates only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them.

Source Cost Type - Optionally specify the Cost Type from which to download the current Resource Rates, to amend them or to copy them to a different Target Cost Type.

Include Resources without a Rate - Set to Yes to also download rate eligible resources that do not yet have a rate in the Source Cost Type, with a blank rate ready to be entered. To rate new resources for a cost type, select that cost type as both Source and Target Cost Type.

Rollup Costs - set to Yes to do a cost rollup after the rates are imported
Rollup Type - All items or Specific item
Rollup Option - Single level rollup or Full cost rollup

Organization Code / Resource / Resource Like - Optionally restrict the resources to be downloaded.

Notes on the Upload
===================
The upload supports the Resource Cost Information descriptive flexfield. The attribute columns are named according to the descriptive flexfield segments setup.

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Include Resources without a Rate, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Resource, Resource Like

## Oracle EBS Tables Used
[cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CST Resource Overhead Association Upload](/CST%20Resource%20Overhead%20Association%20Upload/ "CST Resource Overhead Association Upload Oracle EBS SQL Report"), [CST Department Overhead Rate Upload](/CST%20Department%20Overhead%20Rate%20Upload/ "CST Department Overhead Rate Upload Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/cst-resource-rate-upload/) |
| Blitz Report™ XML Import | [CST_Resource_Rate_Upload.xml](https://www.enginatics.com/xml/cst-resource-rate-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-resource-rate-upload/](https://www.enginatics.com/reports/cst-resource-rate-upload/) |



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
