---
layout: default
title: 'CAC Item vs. Component Include in Rollup Controls | Oracle EBS SQL Report'
description: 'Use this report to find items where the item master default setting for include in rollup does not match the BOM component include in rollup setting. This…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Item, vs., Component, fnd_lookups, bom_structures_b, bom_operational_routings'
permalink: /CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/
---

# CAC Item vs. Component Include in Rollup Controls – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-vs-component-include-in-rollup-controls/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Use this report to find items where the item master default setting for include in rollup does not match the BOM component include in rollup setting.  This report includes items which are available for costing, where the inventory costing enabled flag is Yes.  And excludes inactive items.  (This report was removed from the Cost vs. Planning Item Control Report, for performance reasons.)

/* +=============================================================================+
-- |  Copyright 2021 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_item_include_in_bom_ctrls_repts.sql
-- |
-- |  Parameters:
-- |
-- |  p_cost_type	-- Desired cost type, mandatory
-- |  p_assignment_set	-- The assignment set you wish to report (optional)
-- |  p_item_number	-- Specific item number, to get all values enter a
-- |			   null value or blank value
-- |  p_org_code        -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit  -- Operating_Unit you wish to report, leave blank for all
-- |                       operating units (optional) 
-- |  p_ledger          -- general ledger you wish to report, leave blank for all
-- |                       ledgers (optional)
-- |
-- |  Description:
-- |  Use the below SQL scripts to find items where the item default include in
-- |  rollup does not match the BOM component include in rollup.  (Removed from
-- |  the Cost vs. Planning Item Control Report, for performance reasons.)
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 May 2021 Douglas Volz   Initial Coding, based on the Cost vs.
-- |                                     Planning Item Control Report, version 33.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Assignment Set, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item vs. Component Include in Rollup Controls 24-Jun-2022 050039.xlsx](https://www.enginatics.com/example/cac-item-vs-component-include-in-rollup-controls/) |
| Blitz Report™ XML Import | [CAC_Item_vs_Component_Include_in_Rollup_Controls.xml](https://www.enginatics.com/xml/cac-item-vs-component-include-in-rollup-controls/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-vs-component-include-in-rollup-controls/](https://www.enginatics.com/reports/cac-item-vs-component-include-in-rollup-controls/) |

## Case Study & Technical Analysis: CAC Item vs. Component Include in Rollup Controls

### Executive Summary
The **CAC Item vs. Component Include in Rollup Controls** report is a specialized diagnostic tool for the Cost Rollup process. It identifies a specific configuration conflict: items where the "Include in Rollup" flag on the Item Master contradicts the settings on the Bill of Materials (BOM). This mismatch is a common cause of incorrect standard costs.

### Business Challenge
The Cost Rollup process relies on clear instructions: "Should I calculate the cost of this sub-assembly?"
*   **The Conflict**: The Item Master says "Yes, roll me up," but the BOM Component line says "No, don't include me."
*   **The Result**: The system might skip the item during the rollup, resulting in a zero cost or an outdated cost for the parent assembly.
*   **Root Cause**: Often happens when items are copied or when engineering changes (ECOs) are applied inconsistently.

### Solution
This report finds the contradictions.
*   **Logic**: It looks for items where `mtl_system_items.default_include_in_rollup_flag` does not match the effective component usage in `bom_components_b`.
*   **Scope**: Focuses on "Make" items and active BOMs.
*   **Actionable**: The output provides a "To Do" list for the Cost Accountant or Master Data team to align the settings.

### Technical Architecture
The report joins the Item Master to the BOM structure:
*   **Tables**: `mtl_system_items`, `bom_structures_b`, `bom_components_b`.
*   **Filter**: It specifically looks for the condition where the flags differ.
*   **Context**: Includes Cost Type and Category information to help prioritize the fix.

### Parameters
*   **Cost Type**: (Mandatory) The cost type being analyzed.
*   **Organization Code**: (Optional) The manufacturing org.

### Performance
*   **Targeted**: Because it filters for a specific error condition, the output is usually small and the report runs quickly.
*   **Complex Join**: It does traverse the BOM hierarchy, so it's more complex than a simple item list.

### FAQ
**Q: Which setting wins?**
A: The Cost Rollup generally respects the *Component* flag when rolling up a specific structure, but the *Item* flag controls whether the item *itself* is selected for rollup. A mismatch creates ambiguity and unexpected results.

**Q: Should they always match?**
A: In 99% of cases, yes. If an item is a phantom or a sub-assembly that needs costing, both flags should be consistent.

**Q: Does this fix the data?**
A: No, it is a reporting tool. You must manually update the Item Master or the BOM to resolve the conflict.


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
