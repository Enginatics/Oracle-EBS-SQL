---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Where Used by Cost Type | Oracle EBS SQL Report'
description: 'Report to download the single-level bills of materials and related component information, by organization by cost type. And while exploding the bills of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Where, Used, Cost, mtl_onhand_quantities_detail, mtl_parameters, mtl_system_items_vl'
permalink: /CAC%20Where%20Used%20by%20Cost%20Type/
report_name: 'CAC Where Used by Cost Type'
report_web_name: cac-where-used-by-cost-type
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Where Used by Cost Type – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-where-used-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to download the single-level bills of materials and related component information, by organization by cost type.  And while exploding the bills of material you can also compare with two cost types, as well as limit the report to only assemblies and component items with a zero item cost.

/* +=============================================================================+
-- |  Copyright 2013 - 2019 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_where_used_by_cost_type_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- Cost type costs to report, enter a cost type name.
-- |                              Required.
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
-- |  p_assembly_number        -- Enter the specific assembly number you wish to report (optional)
-- |  p_component_number       -- Enter the specific component number you wish to report (optional)
-- |  p_only_zero_costs        -- Show assemblies and components with a zero cost (optional)
-- |  p_include_expense_items  -- Yes/No flag to include or not include non-asset (not valued)
-- |  p_include_uncosted_items -- Yes/No flag to include or not costing not enabled items (optional)
-- |  p_org_code               -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     08-Jun-2017 Douglas Volz   Initial Coding based on xxx_sl_bom_extract.sql
-- |  1.1     05-Nov-2018 Douglas Volz   Modified to client's item categories, don't
-- |                                     report obsolete items and remove location info.
-- |  1.2     03 Sep 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                     and item categories for cost and inventory.
-- |  1.3     27 Jan 2020 Douglas Volz   Added Operating Unit and Ledger parameters.
-- |  1.4     13 Jul 2020 Douglas Volz   Added item costs, parameters for components
-- |                                     and assemblies at a zero item cost, and
-- |                                     changed to multi-language views for translation.
-- |  1.5     24 Aug 2020 Douglas Volz   Component WIP Supply Type not always populated,
-- |                                     needed to add an outer join on the lookup code.
-- |  1.6     01 Sep 2020 Douglas Volz   Revision to avoid getting other cost type
-- |                                     entries for non-asset and uncosted items.
-- |  1.7     14 Sep 2020 Douglas Volz   Revision for faster queries by item number.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Comparison Cost Type, Category Set 1, Category Set 2, Category Set 3, Only Zero Item Costs, Include Unimplemented ECOs, Assembly Number, Component Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Where%20Used%20by%20Cost%20Type/CAC%20Where%20Used%20by%20Cost%20Type.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Where Used by Cost Type 10-Jul-2022 111949.xlsx](https://www.enginatics.com/example/cac-where-used-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type) |
| Blitz Report™ XML Import | [CAC_Where_Used_by_Cost_Type.xml](https://www.enginatics.com/xml/cac-where-used-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type) |
| SQL Source | [CAC Where Used by Cost Type.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Where%20Used%20by%20Cost%20Type/CAC%20Where%20Used%20by%20Cost%20Type.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-where-used-by-cost-type/](https://www.enginatics.com/reports/cac-where-used-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type) |

## Case Study & Technical Analysis: CAC Where Used by Cost Type

### Executive Summary
The **CAC Where Used by Cost Type** report is a "Costed Bill of Materials" tool. It performs a single-level explosion of the BOM, displaying the parent Assembly and the child Component, along with their respective costs. It is essential for analyzing cost drivers and the impact of component price changes.

### Business Challenge
*   **Impact Analysis**: "The price of Copper just went up 20%. Which products use Copper, and how much does it contribute to their total cost?"
*   **Make vs. Buy**: Comparing the cost of the component (if bought) to the value it adds to the assembly.
*   **Zero Cost Audit**: Finding components with Zero Cost that are being used in active assemblies (which causes under-costing).

### Solution
This report links BOMs to Costs.
*   **Structure**: `Assembly` -> `Component`.
*   **Quantities**: Component Quantity per Assembly.
*   **Costs**: Shows the Unit Cost of the Component and the Unit Cost of the Assembly.
*   **Extended Value**: `Component Qty * Component Cost` = Contribution to Assembly.

### Technical Architecture
*   **Tables**: `bom_structures_b`, `bom_components_b`, `cst_item_costs`.
*   **Logic**: Single-level join (not a recursive explosion).

### Parameters
*   **Cost Type**: (Mandatory) The cost type to report.
*   **Component Number**: (Optional) "Show me all assemblies using this component."

### Performance
*   **Fast**: Single-level joins are much faster than recursive BOM explosions.

### FAQ
**Q: Does it show Phantom items?**
A: Yes, it shows the immediate component. If the component is a Phantom, it is listed. To see the *ingredients* of the Phantom, you would need a multi-level report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-where-used-by-cost-type)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
