---
layout: default
title: 'CAC New Standard Item Costs | Oracle EBS SQL Report'
description: 'Report to show items which have recent item cost changes, including various item controls, last cost update submission, new standard item cost, prior item…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, New, Standard, Item, mtl_category_sets_vl, mtl_categories_v, cst_standard_costs'
permalink: /CAC%20New%20Standard%20Item%20Costs/
---

# CAC New Standard Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-new-standard-item-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show items which have recent item cost changes, including various item controls, last cost update submission, new standard item cost, prior item cost and current (Frozen) item cost, by cost update date.  And whether or not BOMs, routings or (inventory organization) sourcing rules exist for the item.  As allowed with no onhand or intransit quantities, if an item cost has been directly entered into the Frozen Cost Type, the Cost Update Request Id, Cost Update Description, Cost Update Status and related cost update submission columns will be blank or empty.

Parameters:
Cost Update Date From:  starting cost update date, based on standard cost submission history (required).
Cost Update Date To: ending cost update date, based on standard cost submission history (required).
From Cost Type:  enter the cost type implemented by the Standard Cost Update into the Frozen costs (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_new_standard_item_cost_rept.sql
-- | 
-- | Version Modified on Modified by    Description
-- | ======= =========== ============== =========================================
-- |  1.0    29 Sep 2023 Douglas Volz   Initial coding based on the Cost Update
-- |                                    Submissions report.
-- |  1.1    30 Oct 2023 Douglas Volz   Added Item Created By, Last Updated By 
-- |                                    and BOM/Routing/Sourcing Rules exist columns.
-- |  1.2    22 Nov 2023 Douglas Volz   Add item master and costing lot sizes, and 
-- |                                    use default controls columns.
-- |  1.3    05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions. 
-- +=============================================================================+*/

## Report Parameters
Cost Update Date From, Cost Update Date To, From Cost Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v), [cst_standard_costs](https://www.enginatics.com/library/?pg=1&find=cst_standard_costs), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-new-standard-item-costs/) |
| Blitz Report™ XML Import | [CAC_New_Standard_Item_Costs.xml](https://www.enginatics.com/xml/cac-new-standard-item-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-new-standard-item-costs/](https://www.enginatics.com/reports/cac-new-standard-item-costs/) |

## Case Study & Technical Analysis: CAC New Standard Item Costs

### Executive Summary
The **CAC New Standard Item Costs** report is a change management tool for Standard Costing. It focuses specifically on the "Standard Cost Update" event—the moment when a "Pending" cost becomes "Frozen". It allows the finance team to review exactly what changed during the last cost roll.

### Business Challenge
*   **Impact Analysis**: "We just updated costs for 5,000 items. Which ones changed the most?"
*   **Audit**: Verifying that the cost update run on January 1st actually captured all the intended items.
*   **History**: Providing a historical record of cost changes for a specific item over time.

### Solution
This report links the Item to the Cost Update history.
*   **Event-Based**: Driven by the `Cost Update Date`, not the transaction date.
*   **Comparison**: Shows the New Cost vs. the Prior Cost (if available in the history tables).
*   **Context**: Includes the "Update Description" (e.g., "2024 Annual Standard Cost Update").

### Technical Architecture
*   **Tables**: `cst_standard_costs` (History), `cst_cost_updates` (Header), `cst_item_costs` (Current).
*   **Logic**: Filters for records linked to a specific Cost Update ID or Date range.

### Parameters
*   **Cost Update Date From/To**: (Mandatory) The date the update program was run.
*   **From Cost Type**: (Optional) The source cost type (e.g., Pending) used for the update.

### Performance
*   **Variable**: Depends on the number of items updated. A full annual roll might have 100,000 rows.

### FAQ
**Q: Does this show manual cost updates?**
A: If the manual update was done via the "Interface" or "Cost Update" screen, yes. If it was done via direct SQL (not recommended), it might not appear here.

**Q: Why is the "Prior Cost" zero?**
A: If it's a new item receiving its first standard cost, the prior cost is zero.


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
