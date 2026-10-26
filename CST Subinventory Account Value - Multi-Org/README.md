---
layout: default
last_modified_at: 2026-10-26
title: 'CST Subinventory Account Value - Multi-Org | Oracle EBS SQL Report'
description: 'Report: CST Subinventory Account Value - Multi-Org Description: Shows onhand inventory value broken down by GL account and cost element across multiple…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, R12 only, CST, Subinventory, Account, Value, cst_inv_qty_temp, cst_inv_cost_temp, mtl_parameters'
permalink: /CST%20Subinventory%20Account%20Value%20-%20Multi-Org/
report_name: 'CST Subinventory Account Value - Multi-Org'
report_web_name: cst-subinventory-account-value-multi-org
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Subinventory Account Value - Multi-Org – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-subinventory-account-value-multi-org/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
Report: CST Subinventory Account Value - Multi-Org

Description:
Shows onhand inventory value broken down by GL account and cost element across multiple organizations.

For each subinventory, the report unpivots inventory value into separate rows per cost element (Material, Material Overhead, Resource, Outside Processing, Overhead), each showing the GL account where that cost element is recorded.

Asset subinventories show 5 rows per item (one per cost element).
Expense subinventories show 1 row per item with total cost under the expense account.

Account determination follows Oracle standard costing rules:
- Standard costing: accounts from subinventory setup (mtl_secondary_inventories)
- Average/FIFO/LIFO costing: accounts from organization defaults (mtl_parameters)
- Cost group accounting: accounts from cost group accounts (cst_cost_group_accounts)

Corresponds to Oracle standard report: Subinventory Account Value Report (CSTRSAVR)

The report can be run across multiple Inventory Organizations.

DB package: XXEN_INV_VALUE

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Organization Code, Cost Type, As of Date, Costing Enabled Items Only, Item From, Item To, Category Set, Category From, Category To, Subinventory From, Subinventory To, Quantities By Revision, Negative Quantities Only, Include Expense Items, Include Zero Quantities

## Oracle EBS Tables Used
[cst_inv_qty_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_qty_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [cst_inv_cost_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_cost_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)

## Related Reports
[CST Inventory Value - Multi-Organization (Item Costs)](/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29/ "CST Inventory Value - Multi-Organization (Item Costs) Oracle EBS SQL Report"), [CST Inventory Value Report - by Subinventory (Item Cost)](/CST%20Inventory%20Value%20Report%20-%20by%20Subinventory%20%28Item%20Cost%29/ "CST Inventory Value Report - by Subinventory (Item Cost) Oracle EBS SQL Report"), [INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Subinventory%20Account%20Value%20-%20Multi-Org/CST%20Subinventory%20Account%20Value%20-%20Multi-Org.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Subinventory Account Value - Multi-Org 04-Apr-2026 010937.xlsx](https://www.enginatics.com/example/cst-subinventory-account-value-multi-org/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org) |
| Blitz Report™ XML Import | [CST_Subinventory_Account_Value_Multi_Org.xml](https://www.enginatics.com/xml/cst-subinventory-account-value-multi-org/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org) |
| SQL Source | [CST Subinventory Account Value - Multi-Org.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Subinventory%20Account%20Value%20-%20Multi-Org/CST%20Subinventory%20Account%20Value%20-%20Multi-Org.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-subinventory-account-value-multi-org/](https://www.enginatics.com/reports/cst-subinventory-account-value-multi-org/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org) |

## Case Study & Technical Analysis: CST Subinventory Account Value - Multi-Org

### Executive Summary
The CST Subinventory Account Value - Multi-Org report shows onhand inventory value by GL account and cost element across one or more Oracle Inventory organizations. It unpivots each subinventory's value into separate rows for Material, Material Overhead, Resource, Outside Processing and Overhead, and shows the GL account where each cost element is recorded. Cost accountants and inventory controllers use it to reconcile subinventory value with the general ledger at period close, and to check which account each subinventory's value is posted to. It corresponds to the standard Oracle report Subinventory Account Value Report (CSTRSAVR), extended to run across multiple organizations.

### Business Challenge
*   **Reconciling inventory to the ledger:** Period close requires the onhand value of each subinventory to tie to the inventory asset and expense accounts in the general ledger.
*   **Account visibility:** Teams need to know which GL account holds each cost element for each subinventory, which depends on the costing method and cost group setup.
*   **Asset versus expense subinventories:** Asset subinventories carry value across five cost elements, while expense subinventories carry a single total under an expense account, and both need to be reported correctly.

### The Solution
*   **Cost element unpivot:** Each item's value is split into up to five asset rows, one per cost element, or one expense row for expense subinventories.
*   **Costing-method account determination:** The account is taken from the subinventory setup under Standard costing, from the organization defaults under Average, FIFO or LIFO costing, and from cost group accounts where cost group accounting applies.
*   **Quantity and value filters:** Zero quantities, negative quantities and expense items can be included or excluded, and revision-level quantities can be shown.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_INV_QTY_TEMP`: the onhand quantity rows for the run, by organization, item, subinventory, revision and cost group.
*   `CST_INV_COST_TEMP`: the cost rows for the same items, with material, overhead, resource, outside processing and item cost values.
*   `MTL_PARAMETERS`: the organization parameters, including the primary cost method, cost group accounting flag and default accounts.
*   `MTL_SECONDARY_INVENTORIES`: the subinventory setup, including the asset flag, description and standard-costing accounts.
*   `MTL_SYSTEM_ITEMS_VL`: the item master, with item number, description, UOM, status, make-buy and planning attributes.
*   `MTL_CATEGORIES_B_KFV`: the item category in the selected category set.
*   `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`: cost groups and their account assignments.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations that hold each cost element's account.
*   `ORG_ORGANIZATION_DEFINITIONS`, `HR_ALL_ORGANIZATION_UNITS` and `GL_SETS_OF_BOOKS`: the organization, its operating unit and its ledger.

#### Logical Relationships
1.  The quantity and cost temporary tables are joined on organization, inventory item and cost source, with the cost source limited to cost sources 1 and 2.
2.  Each quantity row is joined to `MTL_PARAMETERS`, `MTL_SECONDARY_INVENTORIES`, `MTL_SYSTEM_ITEMS_VL` and `MTL_CATEGORIES_B_KFV`.
3.  Cost group accounts are joined through `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`, using the cost group from the quantity or cost row or the organization default.
4.  An inline row generator for cost elements 1 to 6 is joined to the grouped result, and a CASE expression picks the account and value for each element.
5.  Asset subinventories take elements 1 to 5 and expense subinventories take element 6. The account is then joined to `GL_CODE_COMBINATIONS_KFV`, and the organization to its ledger.

### Parameters & Filtering
*   **Ledger, Operating Unit and Organization Code:** Define the scope of organizations and their ledger.
*   **Cost Type and As of Date:** Identify the costing basis and the date of the valuation.
*   **Costing Enabled Items Only:** Restricts items to those with costing enabled.
*   **Item From and Item To, Category Set, Category From and Category To:** Restrict items by number range or category.
*   **Subinventory From and Subinventory To:** Restrict the subinventories.
*   **Quantities By Revision:** Shows revision-level rows where the item is revision controlled.
*   **Negative Quantities Only and Include Zero Quantities:** Control whether negative or zero quantity rows are returned.
*   **Include Expense Items:** Adds expense items to the output.

### Performance & Optimization
*   **Grouped aggregation first:** Quantities and values are summed per item, subinventory, revision and cost group in one grouped pass before the cost element split.
*   **Cost element expansion after aggregation:** The six-row element generator is joined after grouping, so each item is expanded only once per element rather than at the detail level.

### FAQ
**Q: Why does an asset subinventory show five rows for each item?**
A: Asset subinventories carry value across five cost elements, so each item produces one row for each of Material, Material Overhead, Resource, Outside Processing and Overhead.
**Q: Where does the account for a subinventory come from?**
A: Under Standard costing it comes from the subinventory setup, under Average, FIFO or LIFO it comes from the organization defaults, and under cost group accounting it comes from the cost group accounts.
**Q: Can I run the report for several organizations at once?**
A: Yes. The report is designed to run across multiple inventory organizations, and the Organization Code parameter controls which ones are included.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-subinventory-account-value-multi-org)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
