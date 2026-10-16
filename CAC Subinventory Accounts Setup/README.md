---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Subinventory Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show accounts used for the subinventories; these valuation and expense accounts are used with Standard Costing. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Subinventory, Accounts, Setup, cst_cost_groups, mtl_secondary_inventories, mtl_parameters'
permalink: /CAC%20Subinventory%20Accounts%20Setup/
report_name: 'CAC Subinventory Accounts Setup'
report_web_name: cac-subinventory-accounts-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Subinventory Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-subinventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show accounts used for the subinventories; these valuation and expense accounts are used with Standard Costing.

/* +=============================================================================+
-- |  Copyright 2009 - 22 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_subinv_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for the subinventories
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     28 Mar 2011 Douglas Volz   Minor column heading changes
-- |  1.2     30 Mar 2011 Douglas Volz   Minor column heading changes for Inv Asset,
-- |                                     added quantity tracked and disable date
-- |                                     columns
-- |  1.3     23 Dec 2014 Douglas Volz   Added DFFs for "Use Item Type Accounts".
-- |                                     For OPM orgs, the ICP valuation reports use
-- |                                     this to indicate if the Item Type accounts
-- |                                     or the subinventory valuation accounts are 
-- |                                     displayed on the report. 
-- |  1.4     07 Oct 2015 Douglas Volz   Removed above DFFs for "Use Item Type Accounts",
-- |                                     changed COA to match new client.  Also added
-- |                                     Cost Group Name and accounts. Replaced OOD
-- |                                     with mtl_parameters and mp.organization_name with
-- |                                     haou.name.  And removed prior client's organization
-- |                                     restrictions.   
-- |  1.5     11 Nov 2016 Douglas Volz   Modified chart of accounts for client 
-- |  1.6     28 Mar 2017 Douglas Volz   Added Creation Date, Last Update Date, Created
-- |                                     By, Last Updated By  
-- |  1.7     02 Feb 2020 Douglas Volz   Added Operating Unit and Org Code Parameters
-- |                                     and added outer join to gcc.code_combinations_id 
-- |  1.8     29 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.9     10 Jul 2022 Douglas Volz   Account Type column now uses a lookup code.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Category Accounts Setup](/CAC%20Category%20Accounts%20Setup/ "CAC Category Accounts Setup Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Subinventory%20Accounts%20Setup/CAC%20Subinventory%20Accounts%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Subinventory Accounts Setup 10-Jul-2022 111226.xlsx](https://www.enginatics.com/example/cac-subinventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup) |
| Blitz Report™ XML Import | [CAC_Subinventory_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-subinventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup) |
| SQL Source | [CAC Subinventory Accounts Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Subinventory%20Accounts%20Setup/CAC%20Subinventory%20Accounts%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-subinventory-accounts-setup/](https://www.enginatics.com/reports/cac-subinventory-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup) |

## Case Study & Technical Analysis: CAC Subinventory Accounts Setup

### Executive Summary
The **CAC Subinventory Accounts Setup** report is a configuration audit tool for Inventory Valuation. In Oracle EBS, you can track inventory value at the Organization level or the Subinventory level. If using Subinventory-level tracking, this report validates that the GL accounts for each subinventory are defined correctly.

### Business Challenge
*   **Valuation Granularity**: "We want to track 'Raw Materials' separately from 'Finished Goods' on the Balance Sheet." This requires Subinventory-level accounts.
*   **Expense Subinventories**: "Why is the 'Floor Stock' subinventory showing up as an Asset?" (Answer: It's mapped to an Asset account instead of an Expense account).
*   **Setup Errors**: Missing accounts cause transaction errors.

### Solution
This report lists the account mapping.
*   **Accounts**: Material, Overhead, Resource, Outside Processing, Expense.
*   **Attributes**: Shows if the subinventory is "Asset" or "Expense" (Quantity Tracked / Asset Inventory flags).
*   **Context**: Organization and Subinventory Name.

### Technical Architecture
*   **Tables**: `mtl_secondary_inventories`, `gl_code_combinations`.
*   **Logic**: Simple dump of the subinventory definition table.

### Parameters
*   **Organization Code**: (Optional) Filter by plant.

### Performance
*   **Fast**: Configuration data.

### FAQ
**Q: What happens if the accounts are blank?**
A: If the subinventory accounts are blank, the system defaults to the Organization-level accounts defined in `mtl_parameters`.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-subinventory-accounts-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
