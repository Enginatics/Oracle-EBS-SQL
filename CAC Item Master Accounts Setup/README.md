---
layout: default
title: 'CAC Item Master Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show item master accounts and related information by item. / +=============================================================================+ --…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Item, Master, Accounts, gl_ledgers, org_organization_definitions, hr_all_organization_units_vl'
permalink: /CAC%20Item%20Master%20Accounts%20Setup/
---

# CAC Item Master Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-master-accounts-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show item master accounts and related information by item.

/* +=============================================================================+
-- |  Copyright 2011 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_master_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_include_non_costed_items -- Yes/No flag to include or not include non-costed items
-- |  p_item_number      -- Enter the specific inventory organization code
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- | Description:
-- | Report to show item master accounts and related information
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    30 Mar 2011 Douglas Volz  Initial Coding
-- |  1.1    18 Nov 2012 Douglas Volz  Removed client-specific org conditions
-- |  1.2    12 Feb 2013 Douglas Volz  Changed inventory category to be more generic
-- |  1.3    16 Nov 2015 Douglas Volz  Modified for client's chart of accounts
-- |  1.4    21 Feb 2017 Douglas Volz  Modified for client's chart of accounts and
-- |                                   added parameters to this report
-- |  1.5    17 Jul 2018 Douglas Volz  Modified for client's chart of accounts and
-- |                                   modified to use the default category for Inventory
-- |  1.6    12 Jan 2019 Douglas Volz  Use gl short_name, modify for any two categories,
-- |                                   and add operating unit parameter.
-- |  1.7    28 Apr 2020 Douglas Volz  Changed to multi-language views for the
-- |                                   inventory orgs and operating units.
-- |  1.8    29 Apr 2022 Douglas Volz  Modify summary report into the detailed report.
-- +=============================================================================+*/

## Report Parameters
Category Set 1, Category Set 2, Category Set 3, Item, Include Non-Costed Items, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Items Without This Level Material Overhead](/CAC%20Items%20Without%20This%20Level%20Material%20Overhead/ "CAC Items Without This Level Material Overhead Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC ICP PII Item Cost Summary](/CAC%20ICP%20PII%20Item%20Cost%20Summary/ "CAC ICP PII Item Cost Summary Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Master Accounts Setup 26-Jun-2023 171002.xlsx](https://www.enginatics.com/example/cac-item-master-accounts-setup/) |
| Blitz Report™ XML Import | [CAC_Item_Master_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-item-master-accounts-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-master-accounts-setup/](https://www.enginatics.com/reports/cac-item-master-accounts-setup/) |

## Case Study & Technical Analysis: CAC Item Master Accounts Setup

### Executive Summary
The **CAC Item Master Accounts Setup** report is a configuration audit tool. It lists the General Ledger accounts defined at the Item level (Sales, Cost of Goods Sold, Expense, Encumbrance). This is critical for validating that new items have been set up with the correct accounting drivers before transactions occur.

### Business Challenge
In Oracle EBS, the "Item" is a key driver for accounting logic.
*   **Wrong COGS**: If the COGS account on the item is wrong, every shipment will post to the wrong GL account, requiring manual journal corrections.
*   **Inconsistency**: Similar items (e.g., two types of Laptops) should map to the same Revenue account. Inconsistencies lead to messy financial reporting.
*   **Setup Gaps**: New items often get created without all the necessary accounts populated.

### Solution
This report dumps the accounting attributes for review.
*   **Full Visibility**: Shows the concatenated segments (e.g., 01-000-5000-000) for Sales, COGS, and Expense accounts.
*   **Category Context**: Includes Item Categories to help group similar items and spot outliers (e.g., a "Service" item with a "Hardware" revenue account).
*   **Multi-Org**: Can be run for a specific organization or across the enterprise.

### Technical Architecture
The report joins the Item Master to the GL Code Combinations:
*   **Tables**: `mtl_system_items` and `gl_code_combinations`.
*   **Logic**: It retrieves the `code_combination_id` for each account type (sales_account, cost_of_sales_account, expense_account) and resolves it to the user-friendly segment string.

### Parameters
*   **Organization Code**: (Optional) The inventory org to audit.
*   **Item Number**: (Optional) Specific item check.
*   **Category Set**: (Optional) To filter by product line or asset class.

### Performance
*   **Fast**: This is a straightforward metadata query.
*   **Volume**: Can be large if run for "All Items" in a large master.

### FAQ
**Q: Does this show Subinventory accounts?**
A: No, this report focuses on the *Item Master* accounts. Subinventory accounts are a separate setup (though they override item accounts in some transactions).

**Q: What if the account is blank?**
A: If the account field is null in the database, it will show as blank. This usually indicates a setup deficiency, unless the organization uses Subinventory-level accounting exclusively.

**Q: Can I see the account description?**
A: The standard output shows the account *numbers* (segments). You would typically cross-reference this with your Chart of Accounts to verify the meaning.


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
