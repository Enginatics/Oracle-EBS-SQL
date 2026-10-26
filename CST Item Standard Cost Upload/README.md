---
layout: default
last_modified_at: 2026-10-26
title: 'CST Item Standard Cost Upload | Oracle EBS SQL Report'
description: 'CST Item Standard Cost Upload ============================= This upload can be used to - Upload New Item Costs - Download the current Item Costs, Update…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, CST, Item, Standard, Cost, mtl_item_status_vl, cst_cost_elements, bom_resources'
permalink: /CST%20Item%20Standard%20Cost%20Upload/
report_name: 'CST Item Standard Cost Upload'
report_web_name: cst-item-standard-cost-upload
---

# CST Item Standard Cost Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-item-standard-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload).

## Overview
CST Item Standard Cost Upload
=============================

This upload can be used to
- Upload New Item Costs
- Download the current Item Costs, Update, and Upload the amended item costs for a specified Cost Type
- Download the current item Costs from one Source cost type, update, and upload the amended item costs to a different Target Cost Type

NOTE:
You can only upload costs to cost types that are not flagged as frozen and are flagged as updateable. This upload is used for updating cost types using the standard costing method.

Optionally, the upload can perform a Cost Rollup after the Item Costs have been imported. The Cost Rollup can be performed for
- Specific Items - a cost rollup will be done for only those items for which costs have been uploaded
- All Items - in this mode the upload will submit the 'Supply Chain Cost Rollup - Print Report' concurrent request to roll up all items within each organization costs are uploaded to

NOTE: The Item Cost Interface only supports importing 'This Level' costs. As such, this upload does not support the direct upload of rolled up costs

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Item Costs are to be uploaded to.

Mode (Required, Default: Remove and replace cost information) -
The Item Cost Update Mode
- Remove and replace cost information
- Insert new Cost Information Only

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded Item Cost Entries only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them. Where an Item Cost has multiple cost elements, all cost element records of that item must then be flagged for upload by amending them, as only flagged records are uploaded.

Source Cost Type
Optionally specify the source Cost Type from which to download the current Item Costs. For the scenarios where you want to amend the current items costs for a Cost Type or want to copy the current item costs for a Cost Type to a different Target Cost Type.

Rollup Costs - set to Yes to do a cost rollup after the costs are uploaded
Rollup Type - Rollup specific Items or All Items
Rollup Option - Single level rollup or Full cost rollup

NOTE:
In All Items mode the Supply Chain Cost Rollup requests are submitted asynchronously, and the upload does not wait for them, so the item summary costs in the upload result may not yet reflect the completed rollup.

Organization Code - Optionally select the Organization(s) for which you want to download the Item Costs for
Additional Parameters - optionally restrict the items to be downloaded.

Inventory Asset? (Default: Yes)
Costs can only be uploaded against items flagged as an inventory asset in the cost type, so others are excluded by default. Select No or clear it to download them, so the flag can be set to Yes and costs entered. On Release 12.1 and earlier the item must also be set as an inventory asset in the selected organization, or the import rejects it.

Based on Rollup? and Zero Cost Items? further restrict the download. Zero cost items include those with no cost details yet, which download with Cost Element, Sub-Element and Usage Rate or Amount defaulted.

Notes on the Upload
===================
Mode Remove and replace rebuilds the whole item: the import deletes every cost detail the item holds in the cost type and re-creates it from the uploaded rows. All cost element rows of an item must therefore be uploaded together, which Auto Populate Upload Columns Yes ensures; clear it and amend one element only and the rest are deleted. Deleting a row removes that cost element.

Items whose costs default from the Default Cost Type have no cost details of their own, so they are not downloaded. Uploading costs against such an item gives it its own costs and it stops defaulting.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Category Set, Category, Item, Item Like, Item Description, Item Type, Excluded Item Statuses, Make or Buy, Buyer, Planner, Inventory Asset?, Based on Rollup?, Zero Cost Items?

## Oracle EBS Tables Used
[mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)

## Related Reports
[CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC Load More4Apps Buy Item Costs](/CAC%20Load%20More4Apps%20Buy%20Item%20Costs/ "CAC Load More4Apps Buy Item Costs Oracle EBS SQL Report"), [BOM Resource Upload](/BOM%20Resource%20Upload/ "BOM Resource Upload Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Item%20Standard%20Cost%20Upload/CST%20Item%20Standard%20Cost%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cst-item-standard-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload) |
| Blitz Report™ XML Import | [CST_Item_Standard_Cost_Upload.xml](https://www.enginatics.com/xml/cst-item-standard-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload) |
| SQL Source | [CST Item Standard Cost Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Item%20Standard%20Cost%20Upload/CST%20Item%20Standard%20Cost%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-item-standard-cost-upload/](https://www.enginatics.com/reports/cst-item-standard-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload) |

## Executive Summary
The **CST Item Standard Cost Upload** is a specialized tool for managing Standard Costs in Oracle EBS. It extends the capabilities of the basic cost upload by adding features specifically designed for the standard costing lifecycle, such as the ability to trigger a "Cost Rollup" directly after upload. This ensures that when component costs are updated, the parent assembly costs are immediately recalculated to reflect the change.

## Business Challenge
*   **Cost Rollup Latency**: In standard processes, updating a raw material cost requires a separate, manual step to run the "Supply Chain Cost Rollup" to propagate that change to finished goods. Forgetting this step leads to undervalued inventory.
*   **Mass Updates**: Updating thousands of items for the new fiscal year is labor-intensive.
*   **Simulation**: Creating "What-If" cost scenarios requires a quick way to populate a simulation Cost Type.

## Solution
This tool provides a seamless "Download -> Update -> Upload -> Rollup" workflow.

**Key Features:**
*   **Integrated Rollup**: Can automatically submit the "Supply Chain Cost Rollup" concurrent request after the upload completes.
*   **Rollup Scope**: Can roll up only the specific items uploaded or all items in the organization.
*   **Update Modes**: Supports "Remove and Replace" or "Insert New".
*   **Source Copy**: Can download costs from a Source Cost Type (e.g., "Frozen") to populate a Target Cost Type (e.g., "Pending").

## Architecture
The tool populates the standard interface tables and then calls the Cost Rollup API.

**Key Tables:**
*   `CST_ITEM_COSTS_INTERFACE`: Interface for item costs.
*   `CST_ITEM_CST_DTLS_INTERFACE`: Interface for cost details.
*   `CST_COST_TYPES`: Cost types definition.

## Impact
*   **Data Integrity**: Ensures that finished good costs are always synchronized with their component costs via the immediate rollup.
*   **Process Efficiency**: Combines two distinct tasks (Data Entry + Rollup) into a single action.
*   **Strategic Planning**: Facilitates rapid iteration of cost scenarios for budgeting.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-standard-cost-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
