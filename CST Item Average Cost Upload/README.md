---
layout: default
last_modified_at: 2026-10-26
title: 'CST Item Average Cost Upload | Oracle EBS SQL Report'
description: 'CST Item Average Cost Upload ============================ This upload supports the uploading of item average costs for organizations using the Average…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, CST, Item, Average, Cost, mtl_parameters, mtl_system_items_vl, cst_quantity_layers'
permalink: /CST%20Item%20Average%20Cost%20Upload/
report_name: 'CST Item Average Cost Upload'
report_web_name: cst-item-average-cost-upload
---

# CST Item Average Cost Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-item-average-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload).

## Overview
CST Item Average Cost Upload
============================

This upload supports the uploading of item average costs for organizations using the Average Costing Method.

The upload delivers equivalent functionality to the Average Cost Update form in Oracle EBS 
(At this time the upload does not support value change quantity adjustments). 

Upload Mode:
Use the “Create” upload mode to generate an empty excel into which you can paste the average cost updates to be uploaded.
Use the “Create, Update” upload mode if you wish to download the current average costs for a specified set of items into the excel for updating. Additional entries (rows) can also be created in the generated excel.  

Upload Type:
The upload supports updating average costs at the (summary) item level or at the (detailed) elemental cost level. This is determined by the Upload Type report parameter.

If updating the average cost at the item level, any change made to the item average cost is spread to all cost elements and levels in the same proportion as existed prior to the update.

If updating the average cost at the elemental cost level, you only need to adjust and upload the specific cost elements/levels that require a change. It is not necessary to upload the average costs for all cost elements/levels for the item. The upload will only adjust the costs for the cost elements/levels uploaded and leave the others unchanged. The total item average cost will be updated based on the total of the item’s elemental costs.

For uploads at the item cost level, the Cost Element Level Type (This, Previous) and the Cost Element columns must be left blank.
For uploads at the elemental cost level, the Cost Element Level Type (This, Previous) and the Cost Element columns must be populated in the upload excel.

To adjust the average price for an item or cost element you must enter one and one only of either of the following columns 
- New Average Cost: the average cost of the item or cost element will be set to this value. It must be a positive value
- Percentage Change: the average cost of the item or cost element will be changed by this +/- percentage
- Value Change: the +/- amount by which the onhand inventory value should be changed. The average cost will be calculated based on the dividing the new inventory value by the quantity onhand. You can only perform a value change for items with onhand quantity.

Default Adjustment Account
The default adjustment account is used for the inventory revaluations. You can override the default adjustment account for each cost element within the upload excel if required. Otherwise leave the adjustment accounts in the upload excel blank, or you can remove them from the report template so they do not show. 

Informational Columns.
The upload excel by default contains some information columns. If you do not require these columns they can be removed from the template being used so they do not show.

The following columns are informational only
- Description: the item description
- Item Average Cost: the item’s current average cost
- Valued Quantity: the quantity on hand 
- Old Average Cost: the item or cost element/level current average cost
- Old Valuation: the current valuation of inventory onhand for the item or cost element/level
- Adjusted Average Cost: the item or cost element/level new average cost based
- Adjusted Valuation: the new valuation of inventory onhand for the item or cost element/level
- Valuation Change: the change in inventory valuation for the item or cost element/level

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Upload Type, Transaction Type, Transaction Date, Transaction Source Name, Default Adjustment Account Alias, Default Adjustment Account, Organization Code, Cost Group, Category Set, Category, Item, Item Like, Item Description, Item Type, Excluded Item Statuses, Make or Buy, Buyer, Planner

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [cst_quantity_layers](https://www.enginatics.com/library/?pg=1&find=cst_quantity_layers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [cst_layer_cost_details_v](https://www.enginatics.com/library/?pg=1&find=cst_layer_cost_details_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [cst_item_cost_details_v](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)

## Related Reports
[PO Purchase Price Variance](/PO%20Purchase%20Price%20Variance/ "PO Purchase Price Variance Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Item%20Average%20Cost%20Upload/CST%20Item%20Average%20Cost%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cst-item-average-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload) |
| Blitz Report™ XML Import | [CST_Item_Average_Cost_Upload.xml](https://www.enginatics.com/xml/cst-item-average-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload) |
| SQL Source | [CST Item Average Cost Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Item%20Average%20Cost%20Upload/CST%20Item%20Average%20Cost%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-item-average-cost-upload/](https://www.enginatics.com/reports/cst-item-average-cost-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload) |

## Executive Summary
The **CST Item Average Cost Upload** is a utility for mass-updating item costs in an Average Costing organization. In Average Costing environments, costs are typically recalculated automatically by the system based on transactions (PO Receipts, WIP Completions). However, manual adjustments are sometimes necessary (e.g., to correct data entry errors, revalue inventory, or initialize costs). This tool replaces the manual "Average Cost Update" form with an Excel-based bulk loader.

## Business Challenge
*   **Manual Effort**: Updating average costs one by one in the Oracle forms is slow and error-prone.
*   **Cost Corrections**: If a PO was received at the wrong price, it skews the average cost. Correcting this requires a calculated adjustment.
*   **Initial Load**: When migrating to Oracle, thousands of items need their initial average cost set.

## Solution
This tool allows users to download current average costs, modify them in Excel, and upload the changes.

**Key Features:**
*   **Modes**: "Create" (blank template) or "Create, Update" (download existing data).
*   **Granularity**: Supports updates at the Summary Item level or the Detailed Elemental level (Material, Resource, etc.).
*   **Adjustment Types**:
    *   **New Average Cost**: Set the cost to a specific value.
    *   **Percentage Change**: Increase/decrease by X%.
    *   **Value Change**: Adjust the total inventory value (system recalculates unit cost).
*   **Account Override**: Allows specifying a specific Adjustment Account (GL) for the revaluation entry.

## Architecture
The upload likely interfaces with the Oracle Inventory/Costing APIs to process the adjustments, similar to the `MTL_TRANSACTIONS_INTERFACE` or specific Costing APIs.

**Key Concepts:**
*   **Average Costing**: A costing method where the unit cost is a weighted average of the value of on-hand inventory.
*   **Revaluation**: Changing the cost of an item while it is on-hand triggers a revaluation entry to the GL.

## Impact
*   **Data Accuracy**: Ensures average costs reflect the true value of inventory.
*   **Productivity**: Reduces the time required for cost corrections from days to minutes.
*   **Flexibility**: Handles complex elemental cost adjustments that are difficult to calculate manually.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-item-average-cost-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
