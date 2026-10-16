---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Inventory Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts as setup in the inventory organization parameters. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Inventory, Accounts, Setup, mtl_parameters, gl_code_combinations, hr_organization_information'
permalink: /CAC%20Inventory%20Accounts%20Setup/
report_name: 'CAC Inventory Accounts Setup'
report_web_name: cac-inventory-accounts-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts as setup in the inventory organization parameters.

/* +=============================================================================+
-- |  Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_inv_accts_setup_rept.sql
-- |
-- |  Parameters:
-- |  p_account_group    -- The group of inventory organization parameter accounts
-- |                        you wish to report
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  Description:
-- |  Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts
-- |  as setup in the inventory organization parameters
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.11    06 Mar 2019 Douglas Volz   Added Cost Variance Account, used with Average, FIFO, LIFO
-- |  1.12    14 Mar 2019 Douglas Volz   Added Expense A/P Accrual Account, Retroactive Price
-- |                                     Adjustment Account, Receiving Clearing Account.
-- |  1.13    12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters,
-- |                                     an outer join to gcc in case of invalid accounts
-- |                                     and change to gl.short_name.
-- |  1.14    28 Feb 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Account Group, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [wsh_shipping_parameters](https://www.enginatics.com/library/?pg=1&find=wsh_shipping_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)

## Related Reports
[CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20Accounts%20Setup/CAC%20Inventory%20Accounts%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Accounts Setup 07-Jul-2022 143822.xlsx](https://www.enginatics.com/example/cac-inventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup) |
| Blitz Report™ XML Import | [CAC_Inventory_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-inventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup) |
| SQL Source | [CAC Inventory Accounts Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20Accounts%20Setup/CAC%20Inventory%20Accounts%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-accounts-setup/](https://www.enginatics.com/reports/cac-inventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup) |

## Case Study & Technical Analysis: CAC Inventory Accounts Setup

### Executive Summary
The **CAC Inventory Accounts Setup** report is a foundational configuration audit tool. It provides a detailed listing of the critical General Ledger accounts defined in the Inventory Organization Parameters. These accounts—including Valuation, Receiving, and Profit & Loss accounts—dictate how all inventory transactions are accounted for financially. This report is indispensable for system implementers, financial controllers, and auditors to verify the integrity of the financial-inventory bridge.

### Business Challenge
The financial accuracy of an Oracle EBS implementation hinges on the correct setup of Inventory Organization Parameters.
*   **Setup Errors:** Incorrect account assignments during implementation can lead to pervasive accounting errors that are difficult to unwind.
*   **Inconsistent Standards:** In multi-org environments, different organizations might inadvertently use different accounting standards or accounts for the same purpose.
*   **Troubleshooting:** When accounting entries look wrong, the first place to check is often the default accounts configured at the organization level.
*   **Change Management:** Tracking changes to these critical default accounts over time is difficult without a snapshot tool.

### The Solution
The **CAC Inventory Accounts Setup** report extracts and organizes these critical account definitions.
*   **Comprehensive Account View:** Reports on a wide range of accounts including Material, Overhead, Resource, Receiving, PPV, and COGS accounts.
*   **Grouped Reporting:** Allows users to report by "Account Group" (e.g., Valuation, Receiving, P&L) to focus on specific financial areas.
*   **Multi-Org Validation:** Enables side-by-side comparison of account setups across multiple organizations and ledgers, facilitating standardization.
*   **Detailed Segments:** Shows the full GL account string, ensuring complete visibility into the accounting flexfield segments.

### Technical Architecture (High Level)
The report queries the core inventory parameter table and resolves the account IDs into readable segments.

**Primary Tables Involved:**
*   `MTL_PARAMETERS`: The master table containing all configuration settings for an Inventory Organization, including the default account IDs.
*   `GL_CODE_COMBINATIONS`: Used to resolve the account IDs from `MTL_PARAMETERS` into readable account strings.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: Provides organization names.
*   `GL_LEDGERS`: Links the organization to its financial ledger.

**Logical Relationships:**
*   **Parameter to Account:** The `MTL_PARAMETERS` table has numerous columns (e.g., `material_account`, `ap_accrual_account`) that store `code_combination_id`s. The report joins each of these to `GL_CODE_COMBINATIONS` (often using outer joins to handle nulls) to retrieve the account details.
*   **Organization Hierarchy:** Links the inventory organization to its Operating Unit and Ledger to provide the full enterprise context.

### Parameters & Filtering
*   **Account Group:** A powerful filter that allows users to select a subset of accounts to view (e.g., only "Valuation" accounts or only "Receiving" accounts).
*   **Organization Code:** Filters for a specific inventory organization.
*   **Operating Unit:** Limits the report to organizations within a specific Operating Unit.
*   **Ledger:** Filters by the associated General Ledger.

### Performance & Optimization
*   **Setup Data Query:** Since this report queries configuration data rather than transaction history, it is extremely fast and lightweight.
*   **Efficient Decoding:** The report likely uses efficient SQL decoding or case statements to categorize accounts into groups, making the output user-friendly without heavy processing.

### FAQ
**Q: Which accounts are included in the "Valuation" group?**
A: Typically, this includes the asset accounts for Material, Material Overhead, Resource, Outside Processing, and Overhead.

**Q: Why are some accounts blank?**
A: Not all accounts are mandatory for all organizations. For example, a Standard Costing organization requires variance accounts, while an Average Costing organization might not use them in the same way.

**Q: Can this report detect invalid accounts?**
A: Yes, by showing the resolved account string, users can visually verify if an account is correct. Additionally, the report logic often handles "invalid" or missing account links gracefully to highlight setup gaps.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-accounts-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
