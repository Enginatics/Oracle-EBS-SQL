---
layout: default
title: 'CST Item Average Cost Upload | Oracle EBS SQL Report'
description: 'CST Item Average Cost Upload ============================ This upload supports the uploading of item average costs for organizations using the Average…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, CST, Item, Average, Cost, mtl_parameters, mtl_system_items_vl, cst_quantity_layers'
permalink: /CST%20Item%20Average%20Cost%20Upload/
---

# CST Item Average Cost Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-item-average-cost-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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


## Report Parameters
Upload Mode, Upload Type, Transaction Type, Transaction Date, Transaction Source Name, Default Adjustment Account Alias, Default Adjustment Account, Organization Code, Cost Group, Category Set, Category, Item, Item Like, Item Description, Item Type, Excluded Item Statuses, Make or Buy, Buyer, Planner

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [cst_quantity_layers](https://www.enginatics.com/library/?pg=1&find=cst_quantity_layers), [cst_layer_cost_details_v](https://www.enginatics.com/library/?pg=1&find=cst_layer_cost_details_v), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_item_cost_details_v](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cst-item-average-cost-upload/) |
| Blitz Report™ XML Import | [CST_Item_Average_Cost_Upload.xml](https://www.enginatics.com/xml/cst-item-average-cost-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-item-average-cost-upload/](https://www.enginatics.com/reports/cst-item-average-cost-upload/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
