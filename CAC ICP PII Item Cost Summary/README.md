---
layout: default
title: 'CAC ICP PII Item Cost Summary | Oracle EBS SQL Report'
description: 'Report to show item costs in any cost type, including the profit in inventory costs (also known as ICP or PII). For one or more inventory organizations. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, ICP, PII, Item, cst_item_cost_details, cst_cost_types, bom_resources'
permalink: /CAC%20ICP%20PII%20Item%20Cost%20Summary/
---

# CAC ICP PII Item Cost Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-item-cost-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show item costs in any cost type, including the profit in inventory costs (also known as ICP or PII).  For one or more inventory organizations.

/* +=============================================================================+
-- | Copyright 2009-2022 Douglas Volz Consulting, Inc.                           |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- The cost type you wish to report
-- |  p_pii_cost_type          -- The new PII Cost Type you wish to report
-- |  p_pii_sub_element        -- The sub-element or resource for profit in inventory,
-- |                              such as PII or ICP (mandatory)
-- |  p_ledger                 -- general ledger you wish to report, works with
-- |                              null or valid ledger names
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed resources
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
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
-- |                                    master, inventory orgs and operating units.
-- |  1.7     21 Jun 2020 Douglas Volz  Changed to multi-language views for item 
-- |                                    status and UOM.
-- |  1.8     24 Sep 2020 Douglas Volz  Added List Price to report
-- |  1.9     29 Jan 2021 Douglas Volz  Added item master dates and Inactive Items parameter
+=============================================================================+*/

## Report Parameters
Cost Type, PII Cost Type, PII Sub-Element, Include Inactive Items, Include Uncosted Items, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII Item Cost Summary 07-Jul-2022 143147.xlsx](https://www.enginatics.com/example/cac-icp-pii-item-cost-summary/) |
| Blitz Report™ XML Import | [CAC_ICP_PII_Item_Cost_Summary.xml](https://www.enginatics.com/xml/cac-icp-pii-item-cost-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-icp-pii-item-cost-summary/](https://www.enginatics.com/reports/cac-icp-pii-item-cost-summary/) |

## Case Study & Technical Analysis: CAC ICP PII Item Cost Summary

### Executive Summary
The **CAC ICP PII Item Cost Summary** report is a specialized costing tool designed to provide transparency into the composition of item costs, specifically isolating the **Intercompany Profit (ICP)** or **Profit in Inventory (PII)** component. While standard cost reports show the total value, this report breaks down the cost into "Gross Cost," "Profit Portion," and "Net Cost" (True Manufacturing Cost). This is essential for transfer pricing analysis and validating that profit margins are correctly embedded in the standard costs.

### Business Challenge
In multi-entity supply chains, items are often transferred between subsidiaries at a markup. The receiving organization sees this markup as part of their standard material cost.
*   **Visibility Gap:** Standard Oracle reports show the total cost (e.g., $110) but don't easily show how much of that is the original manufacturing cost ($100) vs. the intercompany markup ($10).
*   **Validation:** Finance teams need to verify that the profit amount (PII) stored in the system matches the agreed-upon transfer pricing policy.
*   **Audit Compliance:** Auditors require proof that the profit elimination calculations are based on accurate per-unit profit data.

### The Solution
This report solves the visibility gap by performing a dual-lookup for every item:
1.  **Standard Cost Retrieval:** It pulls the standard cost components (Material, Overhead, Resource, etc.) from the primary Cost Type.
2.  **Profit Isolation:** It simultaneously queries a specific "PII Cost Type" or looks for a specific "PII Sub-Element" to quantify the profit portion.
3.  **Net Cost Calculation:** It mathematically derives the Net Cost (Gross Cost - Profit) to show the underlying value of the inventory.

### Technical Architecture (High Level)
The query is a direct join against the Item Master and Costing tables, with a specific sub-query logic for PII.
*   **Primary Data Source:** `CST_ITEM_COSTS` (CIC) provides the main standard cost data.
*   **Profit Logic:** A correlated sub-query against `CST_ITEM_COST_DETAILS` (CICD) is used to fetch the specific value associated with the `PII Cost Type` and `PII Sub-Element`.
*   **Item Master Context:** Joins to `MTL_SYSTEM_ITEMS_VL` and various lookup tables provide context like Make/Buy codes, Item Status, and Category assignments.

### Parameters & Filtering
*   **Cost Type:** The primary cost type to report (usually "Frozen" or "Standard").
*   **PII Cost Type:** The specific cost type where the profit component is stored (or the cost type used for the sub-element lookup).
*   **PII Sub-Element:** The specific material overhead or resource sub-element that represents the profit (e.g., "ICP").
*   **Include Uncosted Items:** A flag to include items that exist in the item master but have zero cost, useful for identifying missing cost setups.
*   **Include Inactive Items:** Allows reporting on obsolete items that may still have residual inventory value.

### Performance & Optimization
*   **Efficient Joins:** The query uses standard joins between `CST_ITEM_COSTS` and `MTL_SYSTEM_ITEMS_B`, which are indexed and highly optimized in Oracle EBS.
*   **Scalar Sub-query:** The PII calculation is handled via a scalar sub-query in the SELECT clause, which is generally efficient when fetching a single aggregated value per row.

### FAQ
**Q: What if my profit is not stored in a specific sub-element?**
A: This report is designed for the common configuration where profit is tracked as a distinct cost element (usually Material Overhead). If profit is just "baked in" to the material cost without a separate tag, this report cannot isolate it without a reference "True Cost" cost type to compare against.

**Q: Can I use this for "What-If" analysis?**
A: Yes. By pointing the "Cost Type" parameter to a simulation cost type (e.g., "Pending"), you can see what the PII values *will be* after a cost update.

**Q: Why do I see "Net Item Cost"?**
A: Net Item Cost = Total Standard Cost - PII Amount. This represents the cost to the consolidated entity (the group), stripping out the internal artificial profit.


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
