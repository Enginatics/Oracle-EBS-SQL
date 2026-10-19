---
layout: default
last_modified_at: 2026-10-19
title: 'CST Inventory Value - Multi-Organization (Item Costs) | Oracle EBS SQL Report'
description: 'Report: CST Inventory Value - Multi-Organization (Item Costs) Description: The Inventory Value Report can be used to report Inventory Value by - Elemental…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, CST, Inventory, Value, Multi-Organization, cst_inv_qty_temp, cst_inv_cost_temp, mtl_parameters'
permalink: /CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29/
report_name: 'CST Inventory Value - Multi-Organization (Item Costs)'
report_web_name: cst-inventory-value-multi-organization-item-costs
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Inventory Value - Multi-Organization (Item Costs) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-inventory-value-multi-organization-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
Report: CST Inventory Value - Multi-Organization (Item Costs)

Description: 
The Inventory Value Report can be used to report  Inventory Value by 
- Elemental Item Cost level 
- Quantity Type (Onhand, Intransit, Receiving)

The report can be used to analyze inventory value by Ledger, Operating Unit, Organization, Subinventory, Item Category, Cost Group

The report corresponds to the following standard Oracle Reports
- Elemental Inventory Value Report
- All Inventories Value Report 

The report can be run across multiple Inventory Organizations

Templates are provided that match the existing standard Oracle Reports of the same name:
- All Inventories Value
- All Inventories Value by Cost Group
- Elemental Inventory Value
- Elemental Inventory Value by Subinventory
- Elemental Inventory Value by Cost Group
- Intransit Value Report

New parameter added: Show Shipment Details
If this parameter is set to Y, columns related to shipment details will be included, such as Shipment Number, Ship Date, FOB Point, etc.

DB package: XXEN_INV_VALUE

Notes:
To run the report including non-costed items the As of Date parameter must be left blank (current date). The report cannot be run historically when including non-costed items due to a bug in the Oracle API uses to populate the interminm costing tables used by the report. The API will error with the following error, however the report will complete but  return no data: ORA-01403: no data found in Package CST_Inventory_PVT Procedure Calculate_InventoryCost

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Quantity Type, Ledger, Operating Unit, Organization Code, Cost Type, As of Date, Costing Enabled Items Only, Item From, Item To, Category Set, Category From, Category To, Subinventory From, Subinventory To, Currency, Exchange Rate, Quantities By Revision, Negative Quantities only, Display Zero Costs only, Include Expense Items, Include Expense Subinventories, Include Zero Quantities, Include Unvalued Transactions, Show Shipment Details

## Oracle EBS Tables Used
[cst_inv_qty_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_qty_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [cst_inv_cost_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_cost_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)

## Related Reports
[CST Subinventory Account Value - Multi-Org](/CST%20Subinventory%20Account%20Value%20-%20Multi-Org/ "CST Subinventory Account Value - Multi-Org Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Inventory Value - Multi-Organization (Item Costs) - Pivot Organization Subinventory Item 15-Mar-2024 020251.xlsx](https://www.enginatics.com/example/cst-inventory-value-multi-organization-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs) |
| Blitz Report™ XML Import | [CST_Inventory_Value_Multi_Organization_Item_Costs.xml](https://www.enginatics.com/xml/cst-inventory-value-multi-organization-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs) |
| SQL Source | [CST Inventory Value - Multi-Organization (Item Costs).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-inventory-value-multi-organization-item-costs/](https://www.enginatics.com/reports/cst-inventory-value-multi-organization-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs) |

## Executive Summary
The **CST Inventory Value - Multi-Organization (Item Costs)** report is a comprehensive valuation tool that aggregates inventory data across multiple inventory organizations. Unlike the "Element Costs" version which focuses on the breakdown of cost components (Material, Labor, etc.), this report focuses on the total item cost and quantity types (Onhand, Intransit, Receiving). It serves as a consolidated "All Inventories Value Report" for the entire enterprise.

## Business Challenge
Large enterprises with multiple warehouses (Organizations) often struggle to get a single, consolidated view of their total inventory asset.
*   **Fragmented Reporting**: Standard Oracle reports must be run organization by organization, requiring manual aggregation in Excel.
*   **Intransit Visibility**: Goods moving between warehouses (Intransit) are often missed in standard on-hand reports, leading to an understatement of assets.
*   **Period-End Reconciliation**: Finance needs a snapshot of inventory value at a specific "As Of" date to support the month-end balance sheet.

## Solution
This report provides a multi-org view of inventory value, capable of rolling back to a historical date.

**Key Features:**
*   **Quantity Types**: Reports not just On-hand, but also Intransit and Receiving inspection quantities.
*   **Flexible Grouping**: Can analyze value by Ledger, Operating Unit, Organization, Subinventory, or Cost Group.
*   **Historical Reporting**: The "As of Date" parameter allows for retrospective valuation (though note the limitation on non-costed items).

## Architecture
The report relies on the `XXEN_INV_VALUE` package and standard Oracle temporary tables `CST_INV_QTY_TEMP` and `CST_INV_COST_TEMP` to calculate quantities and costs dynamically.

**Key Tables:**
*   `CST_INV_QTY_TEMP`: Stores calculated quantities based on the "As Of" date.
*   `CST_INV_COST_TEMP`: Stores calculated costs.
*   `MTL_SYSTEM_ITEMS_VL`: Item master data.
*   `ORG_ORGANIZATION_DEFINITIONS`: Organization hierarchy.

## Impact
*   **Consolidated Financials**: Provides the "big picture" number for total inventory assets across the company.
*   **Supply Chain Visibility**: Highlights how much capital is tied up in transit between locations.
*   **Efficiency**: Eliminates the need to run dozens of separate reports for each warehouse.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-inventory-value-multi-organization-item-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
