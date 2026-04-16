---
layout: default
title: 'CAC Cost vs. Planning Item Controls | Oracle EBS SQL Report'
description: 'Compare item make/buy controls vs. costing based on rollup controls, to find errors with your cost rollup results. There are twelve included reports, see…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Cost, vs., Planning, bom_structures_b, bom_operational_routings, mrp_sr_receipt_org'
permalink: /CAC%20Cost%20vs-%20Planning%20Item%20Controls/
---

# CAC Cost vs. Planning Item Controls – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-cost-vs-planning-item-controls/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Compare item make/buy controls vs. costing based on rollup controls, to find errors with your cost rollup results.  There are twelve included reports, see below description for more information.

Available Reports:
1.  Based on Rollup Yes - No BOMS
     Find make items where the item is set to be rolled up but there are no BOMs.  May roll up to a zero cost.
2.  Based on Rollup Yes - No Routing
     Find make items costs are based on the cost rollup, but there are no routings.
3.  Based on Rollup Yes - No Rollup
     Find make items where it is set to be rolled up but there are no rolled up costs
4.  Based on Rollup Yes - Buy Items
     Find buy items where the item is set to rolled up 
5.  Based on Rollup No - With BOMS
     Find make items where the item is not set to be rolled up but BOMS or routings exist.
6.  Based on Rollup No - With Sourcing Rules
     Find buy items where costs are not based on the cost rollup, but sourcing rules exist.
7.  Based on Rollup No - Make Items
     Find make items where the item is not set to rolled up, whether or not BOMs or routings exist. 
8.  Lot-Based Resources With Lot Size One
     Find make items where there are charges based on Lot but the lot size is one.  Duplicates the setup charges for each item you make.
9.  BOMs With No Components
     Find make items with BOMS that have no components.
10.  Item Costing vs. Item Asset Controls
        Find items where the item master costed flag (costed enabled) and the item asset flag do not match.
11.  Item Asset vs. Costing Asset Controls
        Find items where the item master asset and the costing asset flags do not match.
 12.  Based on Rollup No - Defaulted Costs
        Find items where the item is not rolled up but the defaulted flag says Yes

Parameters:
===========
Cost Type:  the Frozen or Pending cost type you wish to report (mandatory).
Assignment Set:  for your organization sourcing rules, enter an assignment set (optional).
Category Sets 1 - 3:  any item category you wish, typically the Cost or Product Line category sets (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2008-2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |  1.0     15 Oct 2008 Douglas Volz   Initial Coding
-- |  1.34    06 May 2021 Douglas Volz   Using a with statement, summarized report type queries for efficiency.
-- |  1.35    23 Apr 2022 Douglas Volz   Add new column "Defaulted Costs" and new report type "Based on
-- |                                     Rollup No - Defaulted Costs".  The defaulted flag indicates
-- |                                     whether the cost of the item is defaulted from the default cost
-- |                                     type during cost rollup.
-- |  1.36   07 Jan 2024 Douglas Volz    Add current onhand quantities, to help find valuation issues.  Remove
-- |                                     tabs, add operating unit and ledger security and inventory access controls.
-- |  1.37   10 Apr 2025 Douglas Volz    Added in new GL and OU security profiles.
-- |  1.38   13 Apr 2025 Douglas Volz    Fix ORA-43916 Collation Error for character expressions 'Y', 'N'.
-- +=============================================================================+*/


## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Assignment Set, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [rept](https://www.enginatics.com/library/?pg=1&find=rept), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Cost vs. Planning Item Controls 23-Jun-2022 145141.xlsx](https://www.enginatics.com/example/cac-cost-vs-planning-item-controls/) |
| Blitz Report™ XML Import | [CAC_Cost_vs_Planning_Item_Controls.xml](https://www.enginatics.com/xml/cac-cost-vs-planning-item-controls/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-cost-vs-planning-item-controls/](https://www.enginatics.com/reports/cac-cost-vs-planning-item-controls/) |

## Case Study & Technical Analysis: CAC Cost vs. Planning Item Controls

### Executive Summary
The **CAC Cost vs. Planning Item Controls** report is a comprehensive diagnostic tool designed to validate the integrity of standard cost rollups. It cross-references item master settings (Make/Buy codes, Asset flags) with Costing controls (Based on Rollup, Lot Size) and Manufacturing data (BOMs, Routings, Sourcing Rules). By identifying conflicting configurations—such as "Make" items with no BOMs, or "Buy" items set to roll up—this report helps prevent zero-cost items, incorrect valuations, and manufacturing variances.

### Business Challenge
In complex manufacturing environments, item attributes often drift out of sync with their physical reality or financial intent. Common issues include:
*   **Incomplete Setups:** A new "Make" item is created but the BOM is missing, leading to a zero standard cost.
*   **Conflicting Flags:** An item is set to "Based on Rollup" but is purchased from a supplier, causing the system to overwrite the purchase price with a calculated (and likely zero) value.
*   **Asset Mismatches:** An item is flagged as an Asset in the Item Master but as an Expense in the Costing table, causing accounting discrepancies.
*   **Lot Size Errors:** Using a Lot Size of 1 for items with Lot-Based resources results in massively inflated unit costs (allocating a full setup charge to a single unit).

### The Solution
This report acts as a "Health Check" for the costing process. It categorizes errors into 12 distinct types, allowing users to systematically fix data quality issues before running the Cost Rollup.
*   **Pre-Rollup Validation:** Running this report *before* a standard cost update prevents "garbage in, garbage out."
*   **Root Cause Analysis:** It pinpoints exactly *why* a cost might be wrong (e.g., "No Routing" vs. "No BOM").
*   **Policy Enforcement:** It ensures that financial policies (e.g., "All Make items must have a BOM") are technically enforced.

### Technical Architecture (High Level)
The report uses a Common Table Expression (CTE) named `rept` to gather all relevant item attributes and existence checks (BOM, Routing, Sourcing Rule) in one pass. It then uses a massive `UNION ALL` structure to classify items into specific error buckets.
*   **Data Gathering (CTE):**
    *   Joins `MTL_SYSTEM_ITEMS_VL`, `CST_ITEM_COSTS`, and `CST_COST_TYPES`.
    *   Performs scalar subqueries to check for the existence of BOMs (`BOM_STRUCTURES_B`), Routings (`BOM_OPERATIONAL_ROUTINGS`), and Sourcing Rules (`MRP_SOURCING_RULES`).
*   **Error Classification (Main Query):**
    *   **Logic:** Each `SELECT` statement in the `UNION ALL` represents a specific business rule violation.
    *   **Example:** `Based on Rollup Yes - No BOMs` selects items where `BASED_ON_ROLLUP_FLAG = 1` AND `PLANNING_MAKE_BUY_CODE = 1` (Make) AND `BOM = 'N'`.

### Parameters & Filtering
*   **Cost Type:** The target cost type to validate (e.g., "Pending" or "Frozen").
*   **Assignment Set:** Required to validate Sourcing Rules correctly.
*   **Category Sets:** Optional filters to focus on specific product lines.
*   **Item/Org/Operating Unit:** Standard filters for scope control.

### Performance & Optimization
*   **CTE Usage:** The `WITH` clause (CTE) is used to calculate the expensive existence checks (BOM/Routing lookups) once per item, rather than repeating them for every error condition.
*   **Scalar Subqueries:** The existence checks use `SELECT DISTINCT ...` with specific `WHERE` clauses to efficiently return 'Y'/'N' (or Organization Code in the latest version) without joining the full tables in the main body.
*   **Indexed Access:** The query relies on standard indexes for `INVENTORY_ITEM_ID` and `ORGANIZATION_ID` across all joined tables.

### FAQ
**Q: Why is "Lot Size 1" a problem?**
A: If you have a Setup resource (e.g., $100 per run) and a Lot Size of 1, the system calculates the unit cost as $100/1 = $100 per unit. If the typical run size is 1000, the unit cost *should* be $0.10. This is a common cause of massive cost overstatements.

**Q: What does "Based on Rollup" mean?**
A: This flag tells the Cost Rollup program, "Do not just copy the cost; calculate it by adding up the BOM and Routing." If this is set to Yes, the system *ignores* any manually entered cost and tries to calculate it.

**Q: Why do I see "Based on Rollup Yes - No Rollup"?**
A: This means the item *should* have rolled up (it's set to Yes), but the rollup process failed to generate a cost, likely because the BOM exists but has no active components, or the components themselves have no cost.

**Q: Can I ignore "Based on Rollup No - With BOMs"?**
A: Technically yes, but it's wasteful. If you have a BOM, you usually want the system to calculate the cost. If you set "Based on Rollup" to No, you are manually maintaining a cost for an item that could be calculated automatically.


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
