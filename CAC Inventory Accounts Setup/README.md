---
layout: default
title: 'CAC Inventory Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts as setup in the inventory organization parameters. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Inventory, Accounts, Setup, mtl_parameters, gl_code_combinations, hr_organization_information'
permalink: /CAC%20Inventory%20Accounts%20Setup/
---

# CAC Inventory Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-accounts-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Account Group, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Accounts Setup 07-Jul-2022 143822.xlsx](https://www.enginatics.com/example/cac-inventory-accounts-setup/) |
| Blitz Report™ XML Import | [CAC_Inventory_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-inventory-accounts-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-accounts-setup/](https://www.enginatics.com/reports/cac-inventory-accounts-setup/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
