---
layout: default
title: 'CST Resource Overhead Association Upload | Oracle EBS SQL Report'
description: 'CST Resource Overhead Association Upload ======================================== This upload can be used to - Upload new Resource Overhead Associations -…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, CST, Resource, Overhead, Association, cst_cost_types, mtl_parameters, cst_resource_overheads'
permalink: /CST%20Resource%20Overhead%20Association%20Upload/
---

# CST Resource Overhead Association Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-resource-overhead-association-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CST Resource Overhead Association Upload
========================================

This upload can be used to
- Upload new Resource Overhead Associations
- Download the current Resource Overhead Associations for a Cost Type and upload them to a different Target Cost Type
- Update the descriptive flexfield attributes of existing associations by re-uploading them in 'Remove and replace' mode
- Delete existing Resource Overhead Associations

Resource Overhead Associations link Resource or Outside Processing sub-elements to the Overhead or Material Overhead sub-elements they absorb. The associations are imported via the Oracle Cost Import Process.

NOTE:
You can only upload associations to cost types that are not flagged as frozen and are flagged as updateable.

NOTE:
The Cost Import Process cannot delete a Resource Overhead Association, so a row flagged for deletion is not sent to it. Set the Delete Association column to Yes and the association is removed directly when the row is processed, in the same way as the Overheads and Resources forms remove it.
Deletion is not allowed for frozen standard cost types or for cost types which do not allow updates.
Deleted associations are not covered by the Cost Rollup. Run a rollup separately if the removal should be reflected in item costs.

Optionally, the upload can perform a Cost Rollup after the associations have been imported. The Cost Rollup can be performed for
- Specific item - a cost rollup is done only for rolled up items whose cost details in the Target Cost Type use the associated resources
- All items - the 'Supply Chain Cost Rollup - Print Report' concurrent request is submitted to rollup all items within each organization associations are uploaded to

NOTE:
In 'All items' mode the Supply Chain Cost Rollup requests are submitted asynchronously and the upload does not wait for them.
In 'Specific item' mode, the items to roll up are derived from the existing cost details in the Target Cost Type. Items that have never been rolled up in the Target Cost Type are therefore not found, even if their routings use an associated resource - use 'All items' mode for those.

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Resource Overhead Associations are to be uploaded.

Mode (Required, Default: Remove and replace cost information) -
- Remove and replace cost information: an existing association for the same resource, overhead, and cost type is replaced
- Insert new Cost Information Only: uploading an association that already exists raises an error

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded associations only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them.

Source Cost Type - Optionally specify the Cost Type from which to download the current Resource Overhead Associations, to copy them to a different Target Cost Type. New associations can be entered as additional rows in the generated Excel.

Rollup Costs - set to Yes to do a cost rollup after the associations are imported
Rollup Type - All items or Specific item
Rollup Option - Single level rollup or Full cost rollup

Organization Code / Resource / Overhead - Optionally restrict the associations to be downloaded.

Notes on the Upload
===================
The upload supports the Resource Overhead Information descriptive flexfield. The attribute columns are named according to the descriptive flexfield segments setup.

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Resource, Overhead

## Oracle EBS Tables Used
[cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC Department Overhead Rates](/CAC%20Department%20Overhead%20Rates/ "CAC Department Overhead Rates Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CST Department Overhead Rate Upload](/CST%20Department%20Overhead%20Rate%20Upload/ "CST Department Overhead Rate Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/cst-resource-overhead-association-upload/) |
| Blitz Report™ XML Import | [CST_Resource_Overhead_Association_Upload.xml](https://www.enginatics.com/xml/cst-resource-overhead-association-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-resource-overhead-association-upload/](https://www.enginatics.com/reports/cst-resource-overhead-association-upload/) |



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
