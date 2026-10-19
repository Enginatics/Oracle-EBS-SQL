---
layout: default
last_modified_at: 2026-10-19
title: 'CAC Inventory Organization Summary | Oracle EBS SQL Report'
description: 'Report to show inventory org names, summary org controls, org hierarchy, operating unit and Ledger, and whether or not the Org should be rolled up for…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Inventory, Organization, Summary, fnd_product_groups, hrfv_organization_hierarchies, mtl_parameters'
permalink: /CAC%20Inventory%20Organization%20Summary/
report_name: 'CAC Inventory Organization Summary'
report_web_name: cac-inventory-organization-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory Organization Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-organization-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show inventory org names, summary org controls, org hierarchy, operating unit and Ledger, and whether or not the Org should be rolled up for costing, based on the existence of BOMs, routings or org-level sourcing rules.
Note:  this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.

Parameters:
==========
Assignment Set:  choose the Assignment Set to report for sourcing rules.  You may leave this value null and the report still works (optional).
Hierarchy Name:  select the organization hierarchy used to open and close your inventory organizations (optional).  If you leave this field blank the report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010-2025 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     14 Apr 2010 Douglas Volz Initial Coding
-- | 1.19    09 Jul 2019 Douglas Volz Changed Org Hierarchy logic to look only for Hierarchy 
-- |                                  Names with "Open" or "Close" or "Period" in it.
-- |                                  For the 2nd union all, added an Outer Join to OU:
-- |                                  and haou2.organization_id (+) = to_number(hoi.org_information3)
-- |                                  ... found an inventory org in Vision with no OU
-- | 1.20    16 Jan 2020 Douglas Volz Added Ledger, Operating Unit and Org Code parameters.
-- | 1.21    02 Feb 2020 Douglas Volz Added max material and WIP transaction dates and removed
-- |                                  flv.source_lang joins, not needed.
-- | 1.22    08 Mar 2020 Douglas Volz Checking for a routing for the parent org
-- | 1.23    07 Apr 2020 Douglas Volz Consolidated two (union all) statements into one.
-- | 1.24    27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- |                                  inventory orgs and operating units.
-- | 1.25    29 Jun 2022 Douglas Volz Fixed indicator for category accounts.
-- | 1.26    09 Sep 2022 Douglas Volz Added indicator for PAC Enabled.
-- | 1.27    13 Jul 2023 Douglas Volz Added condition to avoid SQL error, single-row subquery
-- |                                  returns more than one row. 
-- | 1.28    01 Nov 2024 Douglas Volz Added BOM Parameters, Use Phantom Routing column.
-- | 1.29    01 Jan 2025 Douglas Volz Added WIP Parameters, Record Scrap column.
-- | 1.30    15 Feb 2025 Douglas Volz Added Oracle Release Number.
+=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Assignment Set, Hierarchy Name, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[fnd_product_groups](https://www.enginatics.com/library/?pg=1&find=fnd_product_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [hrfv_organization_hierarchies](https://www.enginatics.com/library/?pg=1&find=hrfv_organization_hierarchies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [org_access](https://www.enginatics.com/library/?pg=1&find=org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [oe_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=oe_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [cst_cost_group_assignments](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [gmd_recipes_b](https://www.enginatics.com/library/?pg=1&find=gmd_recipes_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [bom_parameters](https://www.enginatics.com/library/?pg=1&find=bom_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [gl_item_cst](https://www.enginatics.com/library/?pg=1&find=gl_item_cst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [wip_parameters](https://www.enginatics.com/library/?pg=1&find=wip_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [pjm_org_parameters](https://www.enginatics.com/library/?pg=1&find=pjm_org_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [wsm_parameters](https://www.enginatics.com/library/?pg=1&find=wsm_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [cst_ap_po_reconciliation](https://www.enginatics.com/library/?pg=1&find=cst_ap_po_reconciliation&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [cst_margin_summary](https://www.enginatics.com/library/?pg=1&find=cst_margin_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20Organization%20Summary/CAC%20Inventory%20Organization%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Organization Summary 19-Oct-2022 172501.xlsx](https://www.enginatics.com/example/cac-inventory-organization-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary) |
| Blitz Report™ XML Import | [CAC_Inventory_Organization_Summary.xml](https://www.enginatics.com/xml/cac-inventory-organization-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary) |
| SQL Source | [CAC Inventory Organization Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20Organization%20Summary/CAC%20Inventory%20Organization%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-organization-summary/](https://www.enginatics.com/reports/cac-inventory-organization-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary) |

## Case Study & Technical Analysis: CAC Inventory Organization Summary

### Executive Summary
The **CAC Inventory Organization Summary** is a strategic infrastructure report that provides a bird's-eye view of the Oracle Inventory landscape. It documents the configuration of every inventory organization, including its relationship to Operating Units and Ledgers, its costing method, and its place within the period-close hierarchy. This report is essential for System Administrators and Global Process Owners managing complex, multi-org environments.

### Business Challenge
In large Oracle EBS implementations, the number of inventory organizations can grow into the hundreds.
*   **Configuration Drift**: It becomes difficult to ensure that all "European Distribution Centers" are set up with identical parameters.
*   **Period Close Management**: Identifying which organizations belong to which "Period Control" hierarchy is critical for ensuring a smooth month-end close.
*   **Costing Consistency**: Verifying that all manufacturing plants are using the correct Costing Method (e.g., Standard vs. Average) requires tedious manual checking.

### Solution
This report automates the documentation of the inventory topology.
*   **Hierarchy Visualization**: Identifies the "Hierarchy Name" used for opening/closing periods, grouping organizations logically.
*   **Control Parameters**: Displays key settings like Costing Method, General Ledger link, and Operating Unit assignment.
*   **Rollup Logic**: Indicates if the org should be included in cost rollups based on the presence of BOMs or Routings.

### Technical Architecture
The report queries the fundamental definition tables of Oracle Inventory:
*   **Org Definitions**: `hr_all_organization_units` and `mtl_parameters`.
*   **Hierarchy**: `per_organization_structures` and `per_org_structure_versions` (implied) to resolve the hierarchy relationships.
*   **Business Logic**: Contains logic to "guess" the correct hierarchy by looking for keywords like "Close" or "Period" if the user doesn't specify one.

### Parameters
*   **Hierarchy Name**: (Optional) The specific hierarchy to analyze.
*   **Assignment Set**: (Optional) To check for sourcing rule existence.
*   **Org Code**: (Optional) Filter for specific orgs.

### Performance
*   **Fast**: This is a metadata report. It runs extremely fast as it queries setup tables rather than transaction tables.

### FAQ
**Q: What is the "Rollup" column?**
A: It's a derived flag that suggests whether this organization *should* be part of a standard cost rollup, usually based on whether it has manufacturing data (BOMs/Routings).

**Q: Why is the Hierarchy Name blank?**
A: If the organization is not assigned to the hierarchy specified (or found), the column will be blank.

**Q: Can I use this to find inactive orgs?**
A: Yes, the report typically includes the "Date To" or active status of the organization.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-organization-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
