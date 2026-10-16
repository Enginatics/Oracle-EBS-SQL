---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Category Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show the category accounts in use. If category accounts have been set up with your Subledger Accounting Rules, the Inventory Cost Processor can…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Category, Accounts, Setup, cst_cost_groups, mfg_lookups, mtl_secondary_inventories'
permalink: /CAC%20Category%20Accounts%20Setup/
report_name: 'CAC Category Accounts Setup'
report_web_name: cac-category-accounts-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Category Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-category-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show the category accounts in use.  If category accounts have been set up with your Subledger Accounting Rules, the Inventory Cost Processor can use them and bypass the organization accounts (Average, LIFO, FIFO Costing) or the subinventory accounts (Standard Costing).

/* +=============================================================================+
-- |  Copyright 2021 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_category_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating_Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for the subinventories
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     16 Aug 2021 Douglas Volz   Initial Coding
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Category%20Accounts%20Setup/CAC%20Category%20Accounts%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Category Accounts Setup 23-Jun-2022 144507.xlsx](https://www.enginatics.com/example/cac-category-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup) |
| Blitz Report™ XML Import | [CAC_Category_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-category-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup) |
| SQL Source | [CAC Category Accounts Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Category%20Accounts%20Setup/CAC%20Category%20Accounts%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-category-accounts-setup/](https://www.enginatics.com/reports/cac-category-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup) |

## Case Study & Technical Analysis: CAC Category Accounts Setup

### Executive Summary
The **CAC Category Accounts Setup** report is a configuration audit tool for Oracle Inventory and Cost Management. It provides a detailed view of the General Ledger (GL) accounts assigned to item categories. In Oracle EBS, category-level accounting allows for more granular financial tracking than organization or subinventory-level accounts, enabling businesses to drive accounting entries based on the specific type of material (e.g., Raw Materials vs. Finished Goods) regardless of where it is stored.

### Business Challenge
Configuring the accounting engine (SLA) and Cost Management rules requires precise setup. Common challenges include:
*   **Account Visibility:** It is difficult to see all accounts assigned to a category across different organizations in a single view.
*   **Inconsistent Setup:** Ensuring that all cost elements (Material, Overhead, Resource, etc.) have the correct accounts defined for every category.
*   **Troubleshooting:** Identifying why a specific transaction hit a particular GL account often requires checking if a category-specific override exists.
*   **Audit Compliance:** Verifying that high-value categories are mapped to the correct balance sheet and expense accounts.

### The Solution
The **CAC Category Accounts Setup** report solves these issues by:
*   **Consolidated View:** Listing all account assignments (Material, Overhead, WIP, etc.) for each category in a unified format.
*   **Granularity:** Showing the specific Cost Group and Subinventory associations if the category accounts are defined at that level.
*   **Validation:** Displaying the full accounting flexfield segments to ensure the correct cost centers and natural accounts are used.
*   **Change Tracking:** Including "Created By" and "Last Updated By" fields to audit who made changes to the setup and when.

### Technical Architecture (High Level)
The report uses a `UNION ALL` structure to normalize the data, as different account types are stored in columns but reported as rows.
*   **Primary Table:** `MTL_CATEGORY_ACCOUNTS` holds the mapping between categories and GL code combinations.
*   **Account Types:** The query explicitly selects and labels each account type:
    *   Material Account
    *   Material Overhead Account
    *   Resource Account
    *   Overhead Account
    *   Outside Processing Account
    *   Expense Account
    *   Bridging Account
*   **Joins:**
    *   `MTL_CATEGORIES_V` for category names.
    *   `GL_CODE_COMBINATIONS` for account segments.
    *   `CST_COST_GROUPS` to show cost group specific setups.
    *   `MTL_SECONDARY_INVENTORIES` to validate subinventory associations.

### Parameters & Filtering
The report is designed for broad or specific audits:
*   **Organization Code:** Filter by a specific inventory organization.
*   **Operating Unit:** Filter by the financial operating unit.
*   **Ledger:** Filter by the General Ledger set.

### Performance & Optimization
*   **Union All:** Uses `UNION ALL` instead of `UNION` to avoid expensive sorting/deduplication, as the datasets for each account type are distinct.
*   **Indexed Access:** Joins are performed on primary keys (`CATEGORY_ID`, `ORGANIZATION_ID`, `CODE_COMBINATION_ID`), ensuring fast retrieval even with large category sets.
*   **Security:** Implements standard Oracle MOAC (Multi-Org Access Control) to ensure users only see data for organizations they are authorized to access.

### FAQ
**Q: When does the system use Category Accounts?**
A: The Inventory Cost Processor looks for accounts in a specific hierarchy. If Subledger Accounting (SLA) rules are configured to use "Category Accounts," the system will prioritize these over Subinventory or Organization-level accounts.

**Q: Why do I see "Bridging Account"?**
A: The Bridging Account is typically used in average costing environments or specific inter-org transfer scenarios to bridge the gap between different valuation methods or organizations.

**Q: Can I see accounts for a specific Cost Group?**
A: Yes, the report includes a "Cost Group" column. If category accounts are defined specifically for a Cost Group (common in Project Manufacturing), it will be visible here.

**Q: What if a category has no accounts defined?**
A: It will not appear in this report. This report only lists *existing* records in `MTL_CATEGORY_ACCOUNTS`. If a category is missing, it means it falls back to the default Subinventory or Organization accounts.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-category-accounts-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
