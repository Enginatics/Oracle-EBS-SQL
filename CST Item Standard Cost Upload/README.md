---
layout: default
title: 'CST Item Standard Cost Upload | Oracle EBS SQL Report'
description: 'CST Item Standard Cost Upload ============================= This upload can be used to - Upload New Item Costs - Download the current Item Costs, Update…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, CST, Item, Standard, Cost, mtl_item_status_vl, cst_cost_types, cst_item_costs'
permalink: /CST%20Item%20Standard%20Cost%20Upload/
---

# CST Item Standard Cost Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-item-standard-cost-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CST Item Standard Cost Upload
=============================

This upload can be used to 
- Upload New Item Costs
- Download the current Item Costs, Update, and Upload the amended item costs for a specified Cost Type
- Download the current item Costs from one Source cost type, update, and upload the amended item costs to a different Target Cost Type

NOTE: 
You can only upload costs to cost types that are not flagged as frozen and are flagged as updateable. Typically, this upload is used for updating cost types using the standard costing method.   

Optionally, the upload can perform a Cost Rollup after the Item Costs have been imported. The Cost Rollup can be performed for
- Specific Items - a cost rollup will be done for only those items for which costs have been uploaded
- All Items - in this mode the upload will submit the 'Supply Chain Cost Rollup - Print Report' concurrent request to rollup all items within each organization costs are uploaded to

NOTE: 
The Item Cost Interface only support importing ‘This Level’ costs. As such, this upload does not support the direct upload of rolled up costs

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Item Costs are to be uploaded to.

Mode (Required, Default: Remove and replace cost information) -
The Item Cost Update Mode
- Remove and replace cost information
- Insert new Cost Information Only

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded Item Cost Entries only. If set to Yes, the downloaded records will be flagged ready for upload, even if though no changes have been made. 
If left blank, the downloaded records will only be flagged for upload when the user amends any data against a record. 
In this case, it is important to remember where an Item Cost has multiple cost elements, then all the cost element records for that item would need to be amended to flag them for update. Only records flagged for update are uploaded. If all cost elements for an item are to be uploaded, even if some do not require any amendment, then the user must trigger the record to be uploaded by making a change against the record.

Source Cost Type
Optionally specify the source Cost Type from which to download the current Item Costs. For the scenarios where you want to amend the current items costs for a Cost Type or want to copy the current item costs for a Cost Type to a different Target Cost Type.

Rollup Costs - set to Yes to do a cost rollup after the costs are uploaded
Rollup Type - Rollup specific Items or All Items
Rollup Option - Single level rollup or Full cost rollup 
  
Organization Code - Optionally select the Organization(s) for which you want to download the Item Costs for
Additional Parameters - The additional parameters are used to optionally restrict the items to be downloaded.

Notes on the Upload
===================
The generated upload Excel contains one record per elemental item cost.

The following columns in the Excel are display only and are populated initially on download, and then refreshed in the results excel after the upload is performed as they calculated during the Item Cost Import

- Basis Factor                  
- Net Yield or Shrinkage Factor 
- Element Unit Cost             
- Item Material Cost - the summary Item Level Material Cost.
- Item Material Overhead Cost - the summary Item Level Material Overhead Cost.
- Item Resource Cost - the Summary Item Level Resource Cost.
- Item Outside Processing Cost - the summary Item Level Outside Processing Cost.
- Item Overhead Cost - the summary Item Level Overhead Cost.
- Item Cost - the summary Item Level Item Cost.
- Item Unburdened Cost - the summary Item Level Unburdened Cost.
- Item Burden Cost - the summary Item Level Burden Cost.


## Report Parameters
Target Cost Type, Mode, Auto Populate Upload Columns, Source Cost Type, Rollup Costs?, Rollup Type, Rollup Option, Organization Code, Category Set, Category, Item, Item Like, Item Description, Item Type, Excluded Item Statuses, Make or Buy, Buyer, Planner, Exclude Items with no Cost Details, Exclude Rolled Up Items

## Oracle EBS Tables Used
[mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_detail_cost_view](https://www.enginatics.com/library/?pg=1&find=cst_detail_cost_view), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Where Used by Cost Type](/CAC%20Where%20Used%20by%20Cost%20Type/ "CAC Where Used by Cost Type Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [INV Material Movements](/INV%20Material%20Movements/ "INV Material Movements Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cst-item-standard-cost-upload/) |
| Blitz Report™ XML Import | [CST_Item_Standard_Cost_Upload.xml](https://www.enginatics.com/xml/cst-item-standard-cost-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-item-standard-cost-upload/](https://www.enginatics.com/reports/cst-item-standard-cost-upload/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
