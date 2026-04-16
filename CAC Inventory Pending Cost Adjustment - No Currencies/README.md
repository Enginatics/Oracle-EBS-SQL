---
layout: default
title: 'CAC Inventory Pending Cost Adjustment - No Currencies | Oracle EBS SQL Report'
description: 'Report showing the potential standard cost changes for onhand and intransit inventory value which you own. If you enter a period name this report uses the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inventory, Pending, Cost, mtl_secondary_inventories, inv_organizations, cst_cost_group_accounts'
permalink: /CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/
---

# CAC Inventory Pending Cost Adjustment - No Currencies – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment-no-currencies/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing the potential standard cost changes for onhand and intransit inventory value which you own.  If you enter a period name this report uses the quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); and the To Currency Code and the Organization Code default from the organization code set for this session.  Unlike the CAC Inventory Pending Cost Adjustment report, this version does not display any cost differences due to changes in foreign currency rates (FX).  If you want to see the impact of FX changes, please use the CAC Inventory Pending Cost Adjustment report.

If using this report for reporting after the standard cost update has run this report requires both the before and after cost types available for reporting purposes.  Using the item cost copy please save your Frozen costs before running the standard cost update.

Parameters:
===========
Period Name (Closed):  to use the month-end quantities, choose a closed inventory accounting period (optional).
Cost Type (New):  enter the Cost Type that has the revised or new item costs (mandatory).
Cost Type (Old):  enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Only Items in New Cost Type:  enter Yes to only report the items in the New Cost Type.  Specify No if you want to use this report to reconcile overall inventory value (mandatory).
Include Items With No Quantities:  enter Yes to report items that do not have onhand quantities (mandatory).
Include Zero Item Cost Differences:  enter Yes to include items with a zero item cost difference (mandatory).
Item Number:  specific buy or make item you wish to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2008-2023 Douglas Volz Consulting, Inc
-- |  All rights reserved
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_std_cost_pending_adj_rept.sql
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 21 Nov 2010 Douglas Volz   Created initial Report for prior client
-- |     1.11 05 Jun 2022 Douglas Volz   Fix for category accounts (valuation accounts) and
-- |                                     added subinventory description.
-- |     1.12 23 Sep 2023 Douglas Volz   Add parameter to not include zero item cost differences,
-- |                                     removed tabs and added org access controls.
-- |     1.13 09 Nov 2023 Douglas Volz   Add item master and costing lot sizes, use default controls, 
-- |                                     based on rollup and shrinkage rate columns
-- |     1.14 04 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- +=============================================================================+*/



## Report Parameters
Period Name (Closed), Cost Type (New), Cost Type (Old), Category Set 1, Category Set 2, Category Set 3, Only Items in New Cost Type, Include Items With No Quantities, Include Zero Item Cost Differences, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-inventory-pending-cost-adjustment-no-currencies/) |
| Blitz Report™ XML Import | [CAC_Inventory_Pending_Cost_Adjustment_No_Currencies.xml](https://www.enginatics.com/xml/cac-inventory-pending-cost-adjustment-no-currencies/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-pending-cost-adjustment-no-currencies/](https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment-no-currencies/) |

## Case Study & Technical Analysis: CAC Inventory Pending Cost Adjustment - No Currencies

### Executive Summary
The **CAC Inventory Pending Cost Adjustment - No Currencies** report is a specialized version of the standard cost simulation tool. It calculates the revaluation impact of a pending standard cost update but explicitly *excludes* variances caused by foreign currency exchange rate fluctuations. This allows cost accountants to focus purely on the operational cost changes (e.g., material price, labor rate, overhead) without the noise of FX market volatility.

### Business Challenge
In global organizations, standard costs often include components sourced in foreign currencies.
*   **Signal vs. Noise**: When analyzing a cost update, a 5% increase in total inventory value might be 1% material price increase and 4% currency shift. Separating these is crucial for decision making.
*   **Operational Accountability**: Procurement teams are responsible for negotiated prices, not for the exchange rate. Reporting total variance muddies the water on performance.
*   **Revaluation Strategy**: Companies may choose to update operational costs quarterly but update currency rates monthly (or vice versa). This report supports that decoupled strategy.

### Solution
This report filters the revaluation analysis.
*   **FX Exclusion**: It compares the "Old" and "New" costs but suppresses differences that are solely due to the `Currency Conversion Rate` parameter changes.
*   **Operational Focus**: Highlights items where the base cost (in the functional currency) is changing due to BOM, Routing, or Item Price changes.
*   **Reconciliation**: Can be used in conjunction with the full "Pending Cost Adjustment" report to mathematically isolate the FX impact (Total Impact - No Currency Impact = FX Impact).

### Technical Architecture
The logic mirrors the standard Pending Cost Adjustment report but adds a filter:
*   **Cost Comparison**: Joins `cst_item_costs` for Old and New cost types.
*   **Logic**: The SQL likely includes a clause or calculation that neutralizes the exchange rate factor or filters out rows where the item cost in the *transaction currency* hasn't changed.
*   **Scope**: Covers On-hand and Intransit inventory.

### Parameters
*   **Cost Type (New/Old)**: (Mandatory) The scenarios to compare.
*   **Only Items in New Cost Type**: (Mandatory) Focuses the report.
*   **Include Zero Item Cost Differences**: (Mandatory) Toggle to show/hide unchanged items.

### Performance
*   **Efficient**: By filtering out currency-only changes, the output is often much smaller and easier to review than the full report.
*   **Pre-Update Check**: Essential to run *before* the Standard Cost Update to verify the intended operational changes.

### FAQ
**Q: Why would I ignore currency changes?**
A: If you are trying to validate that your new material prices were loaded correctly, currency fluctuations are just "noise" that makes it harder to spot data entry errors.

**Q: Does this report update the costs?**
A: No, it is a simulation/reporting tool only.

**Q: Can I see the FX impact separately?**
A: Not directly in this report. You would run this report and the standard report, then compare the totals.


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
