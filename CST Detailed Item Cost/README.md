---
layout: default
last_modified_at: 2026-10-26
title: 'CST Detailed Item Cost | Oracle EBS SQL Report'
description: 'Detail report that lists each item and the associated costs to be recognized as part of total unit cost of producing the item.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, CST, Detailed, Item, Cost, cst_activities, gl_ledgers, fnd_currencies'
permalink: /CST%20Detailed%20Item%20Cost/
report_name: 'CST Detailed Item Cost'
report_web_name: cst-detailed-item-cost
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Detailed Item Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-detailed-item-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
Detail report that lists each item and the associated costs to be recognized as part of total unit cost of producing the item.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Organization Code, Cost Type, Category Set 1, Category Set 2, Category From, Category To, Item, Item From, Item To, Exclude Items with no Cost Details

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)

## Related Reports
[CST Supply Chain Indented Bills of Material Cost](/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/ "CST Supply Chain Indented Bills of Material Cost Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CST Item Cost Reports](/CST%20Item%20Cost%20Reports/ "CST Item Cost Reports Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [PO Internal Requisitions and Sales Orders](/PO%20Internal%20Requisitions%20and%20Sales%20Orders/ "PO Internal Requisitions and Sales Orders Oracle EBS SQL Report"), [CAC Resource Costs](/CAC%20Resource%20Costs/ "CAC Resource Costs Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Detailed%20Item%20Cost/CST%20Detailed%20Item%20Cost.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Detailed Item Cost 25-Jun-2019 140038.xlsx](https://www.enginatics.com/example/cst-detailed-item-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost) |
| Blitz Report™ XML Import | [CST_Detailed_Item_Cost.xml](https://www.enginatics.com/xml/cst-detailed-item-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost) |
| SQL Source | [CST Detailed Item Cost.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Detailed%20Item%20Cost/CST%20Detailed%20Item%20Cost.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-detailed-item-cost/](https://www.enginatics.com/reports/cst-detailed-item-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost) |

## CST Detailed Item Cost - Case Study

### Executive Summary
The **CST Detailed Item Cost** report is a vital analytical tool for manufacturing and supply chain finance professionals. It provides a granular breakdown of the cost structure for inventory items, detailing the specific components—such as material, labor, resources, and overhead—that comprise the total unit cost. This level of detail is essential for accurate product pricing, margin analysis, and cost variance investigation.

### Business Challenge
In complex manufacturing environments, understanding the "true" cost of a product is often challenging. Organizations struggle with:
*   **Margin Visibility:** Without a clear understanding of cost components, it is difficult to set prices that ensure profitability or to identify products that are eroding margins.
*   **Cost Driver Analysis:** When unit costs increase, finance teams need to pinpoint whether the rise is due to raw material price hikes, increased labor hours, or higher overhead allocations.
*   **Standard Cost Maintenance:** Validating that standard costs are correctly set up before a new period begins requires a detailed audit of all cost elements.
*   **Inventory Valuation:** Ensuring that the inventory value on the balance sheet accurately reflects the cost of goods requires rigorous validation of item costs.

### Solution
The **CST Detailed Item Cost** report solves these problems by offering deep visibility into item costing:
*   **Component-Level Breakdown:** Lists each item and breaks down its cost into specific elements (e.g., Material, Material Overhead, Resource, Outside Processing, Overhead), providing a complete DNA of the product cost.
*   **Cost Type Flexibility:** Allows users to analyze costs for different Cost Types (e.g., "Frozen" for current standard costs, "Pending" for future costs, or "Average" for actual costing), facilitating "what-if" analysis and period-end updates.
*   **Category Analysis:** Supports filtering by Item Categories, enabling category managers to review cost structures for entire product lines at once.
*   **Efficiency:** The "Exclude Items with no Cost Details" parameter helps keep the report focused on active, costed items, reducing noise in the data.

### Technical Architecture
The report extracts data from the Oracle Cost Management module, linking item definitions with their cost details.
*   **Core Tables:**
    *   `CST_ITEM_COSTS`: The header table for item costs, storing the total unit cost for an item in a specific organization and cost type.
    *   `CST_ITEM_COST_DETAILS`: The detail table that holds the individual cost elements (e.g., the specific cost of steel vs. plastic for a component).
    *   `CST_COST_TYPES`: Defines the set of costs being viewed (e.g., Frozen, Average, Pending).
    *   `MTL_SYSTEM_ITEMS_VL`: Provides item descriptions and attributes.
    *   `ORG_ORGANIZATION_DEFINITIONS`: Identifies the inventory organization.
*   **Key Logic:**
    *   The report joins item master data with cost tables based on `Inventory_Item_Id` and `Organization_Id`.
    *   It filters by the selected `Cost_Type_Id` to ensure the user sees the specific version of the cost they requested.
    *   It aggregates detailed costs to match the total unit cost found in the header table.

### Frequently Asked Questions
**Q: Can I use this report to compare my current standard costs with next year's proposed costs?**
A: Yes, you can run the report twice—once for the "Frozen" cost type (current) and once for your "Pending" cost type (proposed)—and compare the outputs to analyze the impact of cost changes.

**Q: Does this report show costs for all organizations?**
A: The report is typically run for a specific "Organization Code" to provide a focused view, as costs for the same item can vary significantly between different manufacturing plants or warehouses.

**Q: Why do some items appear with zero cost?**
A: This could happen if the item is new and hasn't been costed yet, or if it's an expense item. You can use the "Exclude Items with no Cost Details" parameter to hide these from the report.

**Q: Does it include overheads?**
A: Yes, the report details all cost elements, including material overheads and resource overheads, provided they are defined in the cost structure.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-detailed-item-cost)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
