---
layout: default
title: 'CST Inventory Value Report - by Subinventory (Item Cost) | Oracle EBS SQL Report'
description: 'Imported Oracle standard inventory value subinventory report by item cost Source: Inventory Value Report - by Subinventory (XML) Short Name: CSTRINVRXML…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CST, Inventory, Value, Report, mtl_categories_b_kfv, mtl_system_items_vl, mtl_secondary_inventories'
permalink: /CST%20Inventory%20Value%20Report%20-%20by%20Subinventory%20%28Item%20Cost%29/
---

# CST Inventory Value Report - by Subinventory (Item Cost) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-inventory-value-report-by-subinventory-item-cost/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard inventory value subinventory report by item cost
Source: Inventory Value Report - by Subinventory (XML)
Short Name: CSTRINVR_XML
DB package: BOM_CSTRINVR_XMLP_PKG

## Report Parameters
Cost Type, As of Date, Item From, Item To, Category Set, Category From, Category To, Subinventory From, Subinventory To, Currency, Exchange Rate, Quantities By Revision, Negative Quantities only, Display Zero Costs only, Include Expense Items, Include Expense Subinventories, Include Zero Quantities, Include Unvalued Transactions

## Oracle EBS Tables Used
[mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [cst_inv_qty_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_qty_temp), [cst_inv_cost_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_cost_temp), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CST Inventory Value - Multi-Organization (Element Costs) 11i](/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Element%20Costs%29%2011i/ "CST Inventory Value - Multi-Organization (Element Costs) 11i Oracle EBS SQL Report"), [INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [CST Subinventory Account Value - Multi-Org](/CST%20Subinventory%20Account%20Value%20-%20Multi-Org/ "CST Subinventory Account Value - Multi-Org Oracle EBS SQL Report"), [CST Inventory Value - Multi-Organization (Item Costs)](/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29/ "CST Inventory Value - Multi-Organization (Item Costs) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Inventory Value Report - by Subinventory (Item Cost) 21-Sep-2020 122236.xlsx](https://www.enginatics.com/example/cst-inventory-value-report-by-subinventory-item-cost/) |
| Blitz Report™ XML Import | [CST_Inventory_Value_Report_by_Subinventory_Item_Cost.xml](https://www.enginatics.com/xml/cst-inventory-value-report-by-subinventory-item-cost/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-inventory-value-report-by-subinventory-item-cost/](https://www.enginatics.com/reports/cst-inventory-value-report-by-subinventory-item-cost/) |

## Executive Summary
The **CST Inventory Value Report - by Subinventory (Item Cost)** is a direct extraction of the standard Oracle "Inventory Value Report - by Subinventory". It provides a valuation of on-hand inventory, grouped and subtotaled by Subinventory (storage location). This view is essential for warehouse managers and cost accountants who need to validate the value of goods in specific physical areas (e.g., "Finished Goods" vs. "Raw Materials" vs. "Quarantine").

## Business Challenge
While the General Ledger shows the total inventory balance, it doesn't explain *where* that value sits physically.
*   **Location Analysis**: "Why is the value in the 'Scrap' subinventory so high?"
*   **Account Reconciliation**: Different subinventories often map to different GL asset accounts. This report helps reconcile those specific sub-ledger accounts.
*   **Audit**: Auditors often select specific subinventories for physical counts and valuation testing.

## Solution
This report lists items and their values within each subinventory.

**Key Features:**
*   **Subinventory Grouping**: The primary sort key is the Subinventory, allowing for easy subtotaling.
*   **Cost Type Flexibility**: Can report based on Frozen (Standard) costs or other simulation cost types.
*   **Granularity**: Shows Quantity, Unit Cost, and Total Value for each item.

## Architecture
This is a Blitz Report import of the standard Oracle XML Publisher report `CSTRINVR_XML`. It uses the package `BOM_CSTRINVR_XMLP_PKG`.

**Key Tables:**
*   `MTL_SECONDARY_INVENTORIES`: Defines the subinventories.
*   `CST_INV_QTY_TEMP`: Calculates on-hand quantities.
*   `CST_ITEM_COSTS`: Retrieves unit costs.
*   `MTL_SYSTEM_ITEMS_VL`: Item details.

## Impact
*   **Asset Protection**: Helps identify high-value items sitting in unsecured or inappropriate subinventories.
*   **Financial Accuracy**: Supports the detailed reconciliation of inventory GL accounts.
*   **Operational Control**: Provides visibility into the distribution of inventory value across the warehouse layout.


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
