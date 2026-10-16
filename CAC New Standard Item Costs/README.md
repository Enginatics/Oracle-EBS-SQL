---
layout: default
last_modified_at: 2026-10-16
title: 'CAC New Standard Item Costs | Oracle EBS SQL Report'
description: 'Report to show items which have recent item cost changes, including various item controls, last cost update submission, new standard item cost, prior item…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, New, Standard, Item, mtl_category_sets_vl, mtl_categories_v, cst_standard_costs'
permalink: /CAC%20New%20Standard%20Item%20Costs/
report_name: 'CAC New Standard Item Costs'
report_web_name: cac-new-standard-item-costs
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC New Standard Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-new-standard-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Update Date From, Cost Update Date To, From Cost Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [cst_standard_costs](https://www.enginatics.com/library/?pg=1&find=cst_standard_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20New%20Standard%20Item%20Costs/CAC%20New%20Standard%20Item%20Costs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-new-standard-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs) |
| Blitz Report™ XML Import | [CAC_New_Standard_Item_Costs.xml](https://www.enginatics.com/xml/cac-new-standard-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs) |
| SQL Source | [CAC New Standard Item Costs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20New%20Standard%20Item%20Costs/CAC%20New%20Standard%20Item%20Costs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-new-standard-item-costs/](https://www.enginatics.com/reports/cac-new-standard-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-new-standard-item-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
