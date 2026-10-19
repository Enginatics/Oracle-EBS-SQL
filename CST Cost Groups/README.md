---
layout: default
last_modified_at: 2026-10-19
title: 'CST Cost Groups | Oracle EBS SQL Report'
description: 'Master data report that lists all item cost groups along with their corresponding GL posting codes and descriptions.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, CST, Cost, Groups, cst_cost_groups, hr_all_organization_units_vl, cst_cost_group_accounts'
permalink: /CST%20Cost%20Groups/
report_name: 'CST Cost Groups'
report_web_name: cst-cost-groups
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Cost Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-cost-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
Master data report that lists all item cost groups along with their corresponding GL posting codes and descriptions.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Cost Group Accounts Setup](/CAC%20Cost%20Group%20Accounts%20Setup/ "CAC Cost Group Accounts Setup Oracle EBS SQL Report"), [CAC Subinventory Accounts Setup](/CAC%20Subinventory%20Accounts%20Setup/ "CAC Subinventory Accounts Setup Oracle EBS SQL Report"), [CAC Category Accounts Setup](/CAC%20Category%20Accounts%20Setup/ "CAC Category Accounts Setup Oracle EBS SQL Report"), [CST Subinventory Account Value - Multi-Org](/CST%20Subinventory%20Account%20Value%20-%20Multi-Org/ "CST Subinventory Account Value - Multi-Org Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Cost%20Groups/CST%20Cost%20Groups.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Cost Groups 27-Jul-2018 134345.xlsx](https://www.enginatics.com/example/cst-cost-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups) |
| Blitz Report™ XML Import | [CST_Cost_Groups.xml](https://www.enginatics.com/xml/cst-cost-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups) |
| SQL Source | [CST Cost Groups.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Cost%20Groups/CST%20Cost%20Groups.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-cost-groups/](https://www.enginatics.com/reports/cst-cost-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups) |

## Executive Summary
The **CST Cost Groups** report is a master data configuration report that details the setup of Cost Groups within the organization. In Project Manufacturing or Weighted Average Costing environments, Cost Groups are used to segregate inventory costs for different projects or purposes within the same inventory organization. This report provides a clear view of the account mappings associated with each group.

## Business Challenge
Cost Groups allow for the same item to have different costs depending on who owns it (e.g., Project A vs. Project B).
*   **Account Mapping**: Each Cost Group has its own set of valuation accounts (Material, Material Overhead, WIP, etc.). Incorrect mapping leads to financial misstatements.
*   **Complexity Management**: As the number of projects or cost groups grows, maintaining visibility into the underlying account structure becomes difficult.
*   **Audit**: Verifying that specific projects are pointing to the correct GL accounts.

## Solution
This report lists all defined Cost Groups and their associated General Ledger accounts.

**Key Features:**
*   **Account Detail**: Shows the full GL account string for each cost element (Material, Resource, Overhead, etc.).
*   **Description**: Includes the description of the Cost Group for context.

## Architecture
The report queries `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`.

**Key Tables:**
*   `CST_COST_GROUPS`: Defines the cost group name and type.
*   `CST_COST_GROUP_ACCOUNTS`: Stores the GL account assignments for the group.

## Impact
*   **Configuration Validation**: Ensures that new Cost Groups are set up with the correct accounting rules.
*   **Troubleshooting**: Helps explain why inventory transactions for a specific project are hitting unexpected GL accounts.
*   **System Documentation**: Provides a reference for the financial structure of the manufacturing organization.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-cost-groups)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
