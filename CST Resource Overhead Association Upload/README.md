---
layout: default
last_modified_at: 2026-10-26
title: 'CST Resource Overhead Association Upload | Oracle EBS SQL Report'
description: 'CST Resource Overhead Association Upload ======================================== This upload can be used to - Upload new Resource Overhead Associations …'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, CST, Resource, Overhead, Association, cst_resource_overheads, cst_cost_types, mtl_parameters'
permalink: /CST%20Resource%20Overhead%20Association%20Upload/
report_name: 'CST Resource Overhead Association Upload'
report_web_name: cst-resource-overhead-association-upload
---

# CST Resource Overhead Association Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-resource-overhead-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Resource, Overhead

## Oracle EBS Tables Used
[cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)

## Related Reports
[CST Department Overhead Rate Upload](/CST%20Department%20Overhead%20Rate%20Upload/ "CST Department Overhead Rate Upload Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [CST Resource Rate Upload](/CST%20Resource%20Rate%20Upload/ "CST Resource Rate Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Resource%20Overhead%20Association%20Upload/CST%20Resource%20Overhead%20Association%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cst-resource-overhead-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload) |
| Blitz Report™ XML Import | [CST_Resource_Overhead_Association_Upload.xml](https://www.enginatics.com/xml/cst-resource-overhead-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload) |
| SQL Source | [CST Resource Overhead Association Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Resource%20Overhead%20Association%20Upload/CST%20Resource%20Overhead%20Association%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-resource-overhead-association-upload/](https://www.enginatics.com/reports/cst-resource-overhead-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload) |

## Case Study & Technical Analysis: CST Resource Overhead Association Upload

### Executive Summary
The CST Resource Overhead Association Upload maintains the links between Resource or Outside Processing sub-elements and the Overhead or Material Overhead sub-elements they absorb in Oracle Cost Management. Each row is one resource-to-overhead association for one organization and one target cost type. Cost accountants and manufacturing engineers use it to build, copy and correct standard costing structures in bulk, for example when setting up a new cost type or aligning a target cost type with a source one before a cost rollup. The report runs in Excel via Blitz Report; the upload goes through the Oracle Cost Import Process.

### Business Challenge
*   **Manual association maintenance:** Associating each resource with its overheads through the Overheads form is repetitive when many organizations and resources are involved.
*   **Copying between cost types:** Rebuilding the same overhead structure by hand invites inconsistencies.
*   **Frozen and non-updateable types:** Changes are only permitted on cost types that are not frozen and are flagged as updateable, so costing teams need to check the cost type status before loading.
*   **Stale item costs:** Association changes do not change item costs until a rollup is run, and the rollup scope needs to be chosen deliberately.

### The Solution
*   **Source-to-target copy:** Associations are downloaded from a source cost type and written to a target cost type, so an existing structure can be replicated.
*   **Controlled upload modes:** Existing associations for the same resource, overhead and cost type are replaced in "Remove and replace" mode, or uploads that duplicate an existing association raise an error in "Insert new Cost Information Only" mode.
*   **Optional rollup:** The upload can run a cost rollup for specific items or for all items in each organization, in single-level or full-cost form.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_RESOURCE_OVERHEADS`: the resource-to-overhead association rows, keyed by cost type, organization, resource and overhead.
*   `CST_COST_TYPES`: the source and target cost types, referenced by name.
*   `MTL_PARAMETERS`: the organizations and their cost organization assignment.
*   `BOM_RESOURCES`: the resource and overhead sub-element definitions, referenced twice for the resource and the overhead.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

#### Logical Relationships
1. `CST_COST_TYPES` is referenced twice: the source cost type supplies the associations to download, and the target cost type labels every output row.
2. `CST_RESOURCE_OVERHEADS` is joined to the source cost type on cost_type_id and to `MTL_PARAMETERS` on organization_id.
3. The resource_id of `CST_RESOURCE_OVERHEADS` is joined to `BOM_RESOURCES` to obtain the resource code and description.
4. The overhead_id is joined to a second alias of `BOM_RESOURCES` to obtain the overhead code and description.
5. `MTL_PARAMETERS` is limited to organizations in `ORG_ACCESS_VIEW` for the current responsibility, to cost organizations, and to organizations without process enabled flags.

### Parameters & Filtering
*   **Target Cost Type:** The cost type that receives the associations. It is the cost type shown on every row and the one the upload writes to.
*   **Mode:** Sets the upload behaviour: "Remove and replace cost information" replaces an existing association, while "Insert new Cost Information Only" raises an error for an existing one. The SQL filters on the mode through a bind comparison.
*   **Auto Populate Upload Columns:** When set to Yes, downloaded associations are flagged ready for upload even without changes.
*   **Source Cost Type:** The cost type from which the current associations are downloaded. It is the only bind that drives the download source.
*   **Rollup Costs?, Rollup Type, Rollup Option:** Control whether a cost rollup runs after import, whether it covers all items or specific items, and whether it is single-level or full.
*   **Organization Code, Resource, Overhead:** Optionally restrict the downloaded associations to one organization, resource or overhead.

### Performance & Optimization
*   Cost type and organization filters are applied as equality conditions on `CST_COST_TYPES` and `MTL_PARAMETERS`, which limit the scan of `CST_RESOURCE_OVERHEADS` to one source cost type.
*   Organization access is handled by an `IN` subquery on `ORG_ACCESS_VIEW` filtered by the current responsibility, so only permitted organizations are read.
*   The rollup is not performed by this query; the upload triggers it after import.

### FAQ
**Q: How do I copy resource overhead associations from one cost type to another?**
A: Set the Source Cost Type to the existing cost type and the Target Cost Type to the new one, then upload in "Remove and replace cost information" mode.

**Q: Can this upload delete a resource overhead association?**
A: Yes. Setting the Delete Association column to Yes removes the association directly, because the Cost Import Process cannot delete it; deletion is not allowed for frozen standard cost types.

**Q: Why are some items not updated by the Specific item rollup?**
A: In Specific item mode the items are derived from existing cost details in the target cost type, so items never rolled up in that cost type are not found; use All items mode for them.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-overhead-association-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
