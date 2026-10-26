---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Item Cost Summary | Oracle EBS SQL Report'
description: 'Report to show item costs in any cost type. For one or more inventory organizations. Parameters: =========== Cost Type: enter the cost type(s) you wish to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Item, Cost, Summary, mtl_parameters, hr_organization_information, hr_all_organization_units'
permalink: /CAC%20Item%20Cost%20Summary/
report_name: 'CAC Item Cost Summary'
report_web_name: cac-item-cost-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Item Cost Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.13    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Include Uncosted Items, Item Status to Exclude, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Item Cost Summary](/CAC%20ICP%20PII%20Item%20Cost%20Summary/ "CAC ICP PII Item Cost Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20Summary/CAC%20Item%20Cost%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost Summary 07-Jul-2022 150443.xlsx](https://www.enginatics.com/example/cac-item-cost-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Summary.xml](https://www.enginatics.com/xml/cac-item-cost-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary) |
| SQL Source | [CAC Item Cost Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20Summary/CAC%20Item%20Cost%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-item-cost-summary/](https://www.enginatics.com/reports/cac-item-cost-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
