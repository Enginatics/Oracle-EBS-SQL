---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Cost Group Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show the cost group accounts in use. If using Average Costing, FIFO Costing, LIFO Costing, WMS (Warehouse Management System) or Project…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Cost, Group, Accounts, cst_cost_groups, cst_cost_group_accounts, mtl_parameters'
permalink: /CAC%20Cost%20Group%20Accounts%20Setup/
report_name: 'CAC Cost Group Accounts Setup'
report_web_name: cac-cost-group-accounts-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Cost Group Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-cost-group-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show the cost group accounts in use.  If using Average Costing, FIFO Costing, LIFO Costing, WMS (Warehouse Management System) or Project Manufacturing, the Inventory Cost Processor uses the cost group valuation accounts as opposed to subinventory valuation accounts.

Parameters:
===========
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     04 Oct 2022 Douglas Volz   Initial Coding
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Subinventory Accounts Setup](/CAC%20Subinventory%20Accounts%20Setup/ "CAC Subinventory Accounts Setup Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Cost%20Group%20Accounts%20Setup/CAC%20Cost%20Group%20Accounts%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Cost Group Accounts Setup 04-Oct-2022 125021.xlsx](https://www.enginatics.com/example/cac-cost-group-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup) |
| Blitz Report™ XML Import | [CAC_Cost_Group_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-cost-group-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup) |
| SQL Source | [CAC Cost Group Accounts Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Cost%20Group%20Accounts%20Setup/CAC%20Cost%20Group%20Accounts%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-cost-group-accounts-setup/](https://www.enginatics.com/reports/cac-cost-group-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup) |

## Case Study & Technical Analysis: CAC Cost Group Accounts Setup

### Executive Summary
The **CAC Cost Group Accounts Setup** report is a critical configuration audit tool for organizations utilizing advanced costing methods such as Average, FIFO, LIFO, or Project Manufacturing. In these environments, inventory valuation is driven by "Cost Groups" rather than just Subinventories or Organizations. This report provides a comprehensive view of the General Ledger (GL) accounts assigned to each Cost Group, ensuring that financial reporting accurately reflects the segregation of inventory value.

### Business Challenge
Implementing and maintaining Cost Groups involves complex accounting rules. Challenges include:
*   **Valuation Segregation:** Ensuring that inventory owned by different projects or held for different purposes is valued in separate GL accounts.
*   **Variance Tracking:** Verifying that Purchase Price Variances (PPV) and Invoice Price Variances (IPV) are directed to the correct accounts for each Cost Group.
*   **WMS Integration:** In Warehouse Management Systems (WMS), items in the same subinventory might belong to different Cost Groups; incorrect account setup leads to commingled financial data.
*   **Project Accounting:** For Project Manufacturing, failing to map Cost Groups correctly can result in costs not flowing to the appropriate project tasks.

### The Solution
The **CAC Cost Group Accounts Setup** report addresses these challenges by:
*   **Unified Account View:** Displaying all valuation and variance accounts (Material, Overhead, WIP, Variance, etc.) for each Cost Group in a single list.
*   **Multi-Org Support:** allowing users to audit setups across multiple inventory organizations and operating units simultaneously.
*   **Detailed Segmentation:** Exposing the full accounting flexfield segments to validate that the correct cost centers and natural accounts are being used.
*   **Audit Trail:** Showing creation and update history to track who modified the Cost Group definitions.

### Technical Architecture (High Level)
The report utilizes a `UNION ALL` architecture to normalize the wide table structure of `CST_COST_GROUP_ACCOUNTS` into a readable row-based format.
*   **Core Tables:**
    *   `CST_COST_GROUPS`: Defines the Cost Group names and types.
    *   `CST_COST_GROUP_ACCOUNTS`: Stores the GL account IDs for each cost element and variance type.
*   **Account Types:** The query extracts and labels a wide range of accounts:
    *   Valuation Accounts (Material, Material Overhead, Resource, Overhead, OSP)
    *   Expense Accounts
    *   Bridging Accounts (for inter-org transfers)
    *   Variance Accounts (Average Cost Variance, Payables Variance)
    *   Encumbrance Accounts
*   **Joins:**
    *   `GL_CODE_COMBINATIONS` to resolve account IDs into segments.
    *   `HR_ORGANIZATION_INFORMATION` and `HR_ALL_ORGANIZATION_UNITS_VL` for organizational context.

### Parameters & Filtering
*   **Organization Code:** Filter by specific inventory organizations.
*   **Operating Unit:** Filter by financial operating unit.
*   **Ledger:** Filter by General Ledger set.

### Performance & Optimization
*   **Union All Strategy:** Similar to other setup reports, `UNION ALL` is used for efficiency as the datasets for each account type are mutually exclusive.
*   **Direct Joins:** The query joins directly on primary keys (`COST_GROUP_ID`, `ORGANIZATION_ID`), ensuring optimal performance.
*   **Security:** Incorporates standard Oracle security models (MOAC) to restrict data access based on user responsibilities.

### FAQ
**Q: What is a Cost Group?**
A: A Cost Group is a logical grouping of inventory items that share the same accounting and cost characteristics. It allows you to hold the same item at different costs within the same organization (e.g., "Project A" stock vs. "Common" stock).

**Q: Why are there so many account types?**
A: Cost Groups in Average/FIFO/LIFO costing must handle not just the inventory value, but also the variances that arise from purchasing and invoice matching. Each of these requires a specific GL account mapping.

**Q: Does this report show Standard Costing accounts?**
A: Generally, no. Standard Costing typically uses Subinventory or Organization-level accounts. Cost Groups are primarily used for Actual Costing (Average, FIFO, LIFO) or Project Manufacturing.

**Q: Can I see which items are in these Cost Groups?**
A: No, this report focuses purely on the *financial setup* of the Cost Group itself. To see item balances by Cost Group, you would use a report like "CST Inventory Value - Multi-Organization".

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-cost-group-accounts-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
