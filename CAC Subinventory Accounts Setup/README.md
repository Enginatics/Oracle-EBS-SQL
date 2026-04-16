---
layout: default
title: 'CAC Subinventory Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show accounts used for the subinventories; these valuation and expense accounts are used with Standard Costing. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Subinventory, Accounts, Setup, cst_cost_groups, mtl_secondary_inventories, mtl_parameters'
permalink: /CAC%20Subinventory%20Accounts%20Setup/
---

# CAC Subinventory Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-subinventory-accounts-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Subinventory Accounts Setup 10-Jul-2022 111226.xlsx](https://www.enginatics.com/example/cac-subinventory-accounts-setup/) |
| Blitz Report™ XML Import | [CAC_Subinventory_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-subinventory-accounts-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-subinventory-accounts-setup/](https://www.enginatics.com/reports/cac-subinventory-accounts-setup/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
