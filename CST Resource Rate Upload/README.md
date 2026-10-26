---
layout: default
last_modified_at: 2026-10-26
title: 'CST Resource Rate Upload | Oracle EBS SQL Report'
description: 'CST Resource Rate Upload ======================== This upload can be used to - Upload new Resource Rates - Download the current Resource Rates for a Cost…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, CST, Resource, Rate, cst_resource_costs, cst_cost_types, mtl_parameters'
permalink: /CST%20Resource%20Rate%20Upload/
report_name: 'CST Resource Rate Upload'
report_web_name: cst-resource-rate-upload
---

# CST Resource Rate Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-resource-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Include Resources without a Rate, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Resource, Resource Like

## Oracle EBS Tables Used
[cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)

## Related Reports
[CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [BOM Resource Upload](/BOM%20Resource%20Upload/ "BOM Resource Upload Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [CST Resource Overhead Association Upload](/CST%20Resource%20Overhead%20Association%20Upload/ "CST Resource Overhead Association Upload Oracle EBS SQL Report"), [CST Department Overhead Rate Upload](/CST%20Department%20Overhead%20Rate%20Upload/ "CST Department Overhead Rate Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Resource%20Rate%20Upload/CST%20Resource%20Rate%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cst-resource-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload) |
| Blitz Report™ XML Import | [CST_Resource_Rate_Upload.xml](https://www.enginatics.com/xml/cst-resource-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload) |
| SQL Source | [CST Resource Rate Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Resource%20Rate%20Upload/CST%20Resource%20Rate%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-resource-rate-upload/](https://www.enginatics.com/reports/cst-resource-rate-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload) |

## Case Study & Technical Analysis: CST Resource Rate Upload

### Executive Summary
The CST Resource Rate Upload maintains resource rates in Oracle Cost Management. Each row is one resource in one organization for one target cost type, with its rate and descriptive flexfield attributes. Cost accountants, manufacturing engineers and implementation teams use it to rate new resources, amend existing rates in bulk, and copy rates between cost types, including the AvgRates cost types used by average costing organizations. The report runs in Excel via Blitz Report, and the rates are imported through the Oracle Cost Import Process, with deletions applied directly to the resource rate records.

### Business Challenge
*   **Bulk rate changes:** Updating standard rates for many resources through the Resources form is slow when several organizations and cost types are involved.
*   **Rating new resources:** Resources added to an organization need rates in each cost type, and rates for them must be entered before costs roll up correctly.
*   **Cost type restrictions:** Rates can only be loaded to cost types that are not frozen and are flagged as updateable, so the target cost type status must be checked.
*   **Rate effect on item costs:** Rate changes do not reach item costs until a rollup runs, so the rollup scope must be chosen deliberately.

### The Solution
*   **Download, amend and upload:** Current rates are downloaded from a source cost type, amended in Excel and uploaded to the target cost type.
*   **Copy between cost types:** A rate set from one cost type can be written to another, including rates for AvgRates cost types.
*   **Unrated resource capture:** The optional Include Resources without a Rate setting adds rate-eligible resources with a blank rate, ready to be entered.
*   **Optional rollup:** The upload can run a cost rollup for specific items or for all items in each organization.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_RESOURCE_COSTS`: the resource rate rows, keyed by cost type, organization and resource.
*   `CST_COST_TYPES`: the source and target cost types, referenced by name.
*   `MTL_PARAMETERS`: the organizations and their cost organization assignment.
*   `BOM_RESOURCES`: the resource definitions, including unit of measure, cost element and disable date.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

#### Logical Relationships
1. `CST_COST_TYPES` is referenced twice: the source cost type is joined to `CST_RESOURCE_COSTS` on cost_type_id, and the target cost type labels every output row.
2. `BOM_RESOURCES` is joined to `MTL_PARAMETERS` on organization_id, restricted to resources with cost element 3 or 4.
3. `CST_RESOURCE_COSTS` is outer joined to `BOM_RESOURCES` on cost type, organization and resource, so resources without a rate are present as rows.
4. `MTL_PARAMETERS` is limited to organizations in `ORG_ACCESS_VIEW` for the current responsibility and to cost organizations without process enabled flags.

### Parameters & Filtering
*   **Target Cost Type:** The cost type to which the rates are uploaded and that labels every row.
*   **Mode:** "Remove and replace cost information" replaces an existing rate for the same resource, while "Insert new Cost Information Only" raises an error when a rate already exists.
*   **Auto Populate Upload Columns:** For downloaded rates, Yes flags every record ready for upload even without changes.
*   **Source Cost Type:** The cost type from which the current rates are downloaded.
*   **Include Resources without a Rate:** When Yes, rate-eligible resources without a rate in the source cost type are also downloaded with a blank rate.
*   **Rollup Costs?, Rollup Type, Rollup Option:** Control whether a rollup runs after import, whether it covers all items or specific items, and whether it is single-level or full.
*   **Organization Code, Resource, Resource Like:** Optionally restrict the downloaded resources, with Resource Like allowing a pattern match on the resource code.

### Performance & Optimization
*   Equality conditions on the cost type names and the organization access subquery limit the main scan to the source cost type and the permitted organizations.
*   The include flag and the outer join on `CST_RESOURCE_COSTS` decide whether unrated resources are returned.
*   Resource eligibility is filtered directly in the query: cost element identifiers 3 and 4, a non-functional-currency flag, allowed costs, and an open disable date.
*   The rollup is run by the upload after import, not by this query.

### FAQ
**Q: How do I rate a new resource in an organization for a cost type?**
A: Select the same cost type as both Source and Target Cost Type, set Include Resources without a Rate to Yes, enter the rate in the blank row, and upload.

**Q: Can this upload delete a resource rate?**
A: Yes. Setting the Delete Resource Rate column to Yes removes the rate directly, since the Cost Import Process cannot delete it; deletion is not allowed for frozen standard cost types.

**Q: Are rates loaded into average costing organizations?**
A: Yes. The description states that the rates cost types used by average costing organizations, such as AvgRates, can be uploaded to, provided they are not frozen and are updateable.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-resource-rate-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
