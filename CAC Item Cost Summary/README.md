---
layout: default
title: 'CAC Item Cost Summary | Oracle EBS SQL Report'
description: 'Report to show item costs in any cost type. For one or more inventory organizations. Parameters: =========== Cost Type: enter the cost type(s) you wish to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Item, Cost, Summary, cst_item_costs, cst_cost_types, mtl_system_items_vl'
permalink: /CAC%20Item%20Cost%20Summary/
---

# CAC Item Cost Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show item costs in any cost type.  For one or more inventory organizations.

Parameters:
===========
Cost Type:  enter the cost type(s) you wish to report (mandatory).
Include Uncosted Items:  enter Yes to include non-costed items, enter No to exclude them (mandatory).
Item Status to Exclude:  enter the item status you wish to exclude, defaulted to Inactive (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2009-2024 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Description:
-- | Report to show item costs in any cost type
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     08 Nov 2010 Douglas Volz  Updated with additional columns and parameters
-- |  1.3     07 Feb 2011 Douglas Volz  Added COGS and Revenue default accounts
-- |  1.4     15 Nov 2016 Douglas Volz  Added category information
-- |  1.5     27 Jan 2020 Douglas Volz  Added Org Code and Operating Unit parameters
-- |  1.6     27 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units
-- |  1.7     21 Jun 2020 Douglas Volz  Changed to multi-language views for item 
-- |                                    status and UOM
-- |  1.8     24 Sep 2020 Douglas Volz  Added List Price and Market Price to report
-- |  1.9     29 Jan 2021 Douglas Volz  Added item master dates and Inactive Items parameter
-- |  1.10    22 Nov 2023 Douglas Volz  Add item master std lot size, costing lot size,
-- |                                    remove tabs and add org access controls
-- |  1.11    05 Dec 2023 Douglas Volz  Added G/L and Operating Unit security restrictions.
-- |  1.12    30 Jun 2024 Douglas Volz  Reinstalled missing parameter for Item Status to Exclude
-- |                                    and commented out G/L and Operating Unit security restrictions.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Include Uncosted Items, Item Status to Exclude, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost Summary 07-Jul-2022 150443.xlsx](https://www.enginatics.com/example/cac-item-cost-summary/) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Summary.xml](https://www.enginatics.com/xml/cac-item-cost-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-cost-summary/](https://www.enginatics.com/reports/cac-item-cost-summary/) |

## Case Study & Technical Analysis: CAC Item Cost Summary

### Executive Summary
The **CAC Item Cost Summary** report is the workhorse of cost reporting. It provides a straightforward, comprehensive list of item costs for a specified Cost Type and Organization. It is the "go-to" report for answering basic questions about inventory value, standard costs, and item attributes.

### Business Challenge
Users need a simple, reliable way to extract cost data.
*   **Accessibility**: Navigating screen-by-screen to check costs is inefficient.
*   **Attribute Context**: Knowing the cost is not enough; users also need to know the Item Status, Make/Buy code, and Default Accounts to understand the context.
*   **Uncosted Items**: Identifying items that have been created but not yet costed (Cost = 0) is a critical maintenance task.

### Solution
This report provides a flat, filterable list of item costs.
*   **Comprehensive**: Includes Unit Cost, Material Cost, Material Overhead, Resource, OSP, and Overhead buckets.
*   **Context Rich**: Includes Inventory Asset Flag, Planning Make/Buy Code, and Default COGS/Sales accounts.
*   **Maintenance Aid**: The "Include Uncosted Items" parameter helps identify gaps in the costing setup.

### Technical Architecture
The report queries the primary costing view:
*   **Core Table**: `cst_item_costs`.
*   **Item Details**: Joins to `mtl_system_items` for descriptions and control flags.
*   **Account Resolution**: Joins to `gl_code_combinations` to show the default accounts associated with the item.

### Parameters
*   **Cost Type**: (Mandatory) The cost type to display (e.g., Frozen, Pending, Average).
*   **Include Uncosted Items**: (Mandatory) Toggle to show items with no cost record.
*   **Item Status to Exclude**: (Optional) Filter out Inactive or Obsolete items.

### Performance
*   **Scalable**: Designed to handle large item masters.
*   **Indexed**: Efficiently filters by Organization and Cost Type.

### FAQ
**Q: Does this show the breakdown of resources?**
A: No, it shows the *total* Resource cost. For a breakdown by specific resource (e.g., Labor vs. Machine), use the "Item Cost & Routing" report.

**Q: Why is the cost zero?**
A: Either the item is new and hasn't been costed, or it is an Expense item (Inventory Asset Flag = No) which is not tracked with a value in inventory.

**Q: Can I use this for Average Costing?**
A: Yes, simply select the "Average" cost type.


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
