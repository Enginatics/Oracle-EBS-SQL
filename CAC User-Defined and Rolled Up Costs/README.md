---
layout: default
last_modified_at: 2026-10-26
title: 'CAC User-Defined and Rolled Up Costs | Oracle EBS SQL Report'
description: 'Use this report to find items with both user-defined (manually entered) and rolled up costs, for material and other cost elements. Useful to find rolled…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, User-Defined, Rolled, Costs, cst_item_cost_details, bom_resources, bom_structures_b'
permalink: /CAC%20User-Defined%20and%20Rolled%20Up%20Costs/
report_name: 'CAC User-Defined and Rolled Up Costs'
report_web_name: cac-user-defined-and-rolled-up-costs
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC User-Defined and Rolled Up Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.10    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Assignment Set, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/CAC%20User-Defined%20and%20Rolled%20Up%20Costs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC User-Defined and Rolled Up Costs 12-Jan-2023 132132.xlsx](https://www.enginatics.com/example/cac-user-defined-and-rolled-up-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs) |
| Blitz Report™ XML Import | [CAC_User_Defined_and_Rolled_Up_Costs.xml](https://www.enginatics.com/xml/cac-user-defined-and-rolled-up-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs) |
| SQL Source | [CAC User-Defined and Rolled Up Costs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/CAC%20User-Defined%20and%20Rolled%20Up%20Costs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/](https://www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-user-defined-and-rolled-up-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
