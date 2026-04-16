---
layout: default
title: 'CST Subinventory Account Value - Multi-Org | Oracle EBS SQL Report'
description: 'Report: CST Subinventory Account Value - Multi-Org Description: Shows onhand inventory value broken down by GL account and cost element across multiple…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Subinventory, Account, Value, cst_inv_qty_temp, cst_inv_cost_temp, mtl_parameters'
permalink: /CST%20Subinventory%20Account%20Value%20-%20Multi-Org/
---

# CST Subinventory Account Value - Multi-Org – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-subinventory-account-value-multi-org/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Ledger, Operating Unit, Organization Code, Cost Type, As of Date, Costing Enabled Items Only, Item From, Item To, Category Set, Category From, Category To, Subinventory From, Subinventory To, Quantities By Revision, Negative Quantities Only, Include Expense Items, Include Zero Quantities

## Oracle EBS Tables Used
[cst_inv_qty_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_qty_temp), [cst_inv_cost_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_cost_temp), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Subinventory Account Value - Multi-Org 04-Apr-2026 010937.xlsx](https://www.enginatics.com/example/cst-subinventory-account-value-multi-org/) |
| Blitz Report™ XML Import | [CST_Subinventory_Account_Value_Multi_Org.xml](https://www.enginatics.com/xml/cst-subinventory-account-value-multi-org/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-subinventory-account-value-multi-org/](https://www.enginatics.com/reports/cst-subinventory-account-value-multi-org/) |



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
