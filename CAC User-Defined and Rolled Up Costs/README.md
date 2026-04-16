---
layout: default
title: 'CAC User-Defined and Rolled Up Costs | Oracle EBS SQL Report'
description: 'Use this report to find items with both user-defined (manually entered) and rolled up costs, for material and other cost elements. Useful to find rolled…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, User-Defined, Rolled, Costs, bom_resources, cst_item_cost_details, mfg_lookups'
permalink: /CAC%20User-Defined%20and%20Rolled%20Up%20Costs/
---

# CAC User-Defined and Rolled Up Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Use this report to find items with both user-defined (manually entered) and rolled up costs, for material and other cost elements.  Useful to find rolled up assemblies where the item costs have been accidentally doubled-up.

Parameters:
===========
Cost Type: enter the cost type to report (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Assignment Set:  enter the sourcing rule assignment set, used when transferring items between inventory organizations on internal requisitions.
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2010-2023 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_user_defined_rolled_up_cost_rept.sql
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     29 Dec 2010 Douglas Volz   Create new report to find items with
-- |                                     both manually entered and rolled up material costs
-- |  1.1     24 May 2011 Douglas Volz   Bug fix for the resource code column
-- |  1.2     19 Oct 2019 Douglas Volz   Add columns for non-material costs
-- |  1.3     27 Jan 2020 Douglas Volz   Added Operating_Unit parameter and outer
-- |                                     join for Item_Type.
-- |  1.4     05 May 2021 Douglas Volz   Modify for multi-language tables.
-- |  1.5     12 Jan 2023 Douglas Volz   Correction for definition of manually entered 
-- |                                     material costs.
-- |  1.6     20 Nov 2023 Douglas Volz   Fix for Manual Other Costs and Rolled Up Other Costs columns.
-- |  1.7     05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- |  1.8     07 Jan 2024 Douglas Volz   Add onhand quantities, to help find valuation issues.  Remove tabs.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Assignment Set, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC User-Defined and Rolled Up Costs 12-Jan-2023 132132.xlsx](https://www.enginatics.com/example/cac-user-defined-and-rolled-up-costs/) |
| Blitz Report™ XML Import | [CAC_User_Defined_and_Rolled_Up_Costs.xml](https://www.enginatics.com/xml/cac-user-defined-and-rolled-up-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/](https://www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/) |

## Case Study & Technical Analysis: CAC User-Defined and Rolled Up Costs

### Executive Summary
The **CAC User-Defined and Rolled Up Costs** report is a data integrity tool for Standard Costing. It identifies items that have conflicting cost definitions: a manually entered ("User Defined") cost *and* a system-calculated ("Rolled Up") cost. This often indicates a setup error that leads to incorrect costing.

### Business Challenge
*   **Double Counting**: If you manually enter a $10 Material Cost for an assembly, and *also* roll up the $10 cost from its components, the system might value it at $20 (or ignore the rollup).
*   **Maintenance**: "Why isn't the cost updating when I change the component price?" (Answer: The "Based on Rollup" flag is off, or a user-defined cost is overriding it).
*   **Clean Up**: Identifying items that should be switched to "Based on Rollup".

### Solution
This report finds the intersection.
*   **Condition**: Items where `rollup_source_type = 'USER DEFINED'` AND `rollup_source_type = 'ROLLED UP'` (conceptually) exist for different cost elements or levels.
*   **Details**: Shows the specific cost elements (Material, Labor, etc.) and their source.
*   **Sourcing**: Checks if the item is "Buy" or "Make" (based on Sourcing Rules) to suggest the correct setup.

### Technical Architecture
*   **Tables**: `cst_item_costs`, `cst_item_cost_details`.
*   **Logic**: Analyzes the `rollup_source_type` column in the cost details table.

### Parameters
*   **Cost Type**: (Mandatory) The cost type to validate.

### Performance
*   **Moderate**: Scans the cost details table.

### FAQ
**Q: Is it ever valid to have both?**
A: Yes, for "Value Add". You might roll up the Material cost from components but manually enter a "Material Overhead" or "Labor" cost at the assembly level.


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
