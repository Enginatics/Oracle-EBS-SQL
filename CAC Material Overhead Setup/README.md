---
layout: default
title: 'CAC Material Overhead Setup | Oracle EBS SQL Report'
description: 'Report to show the material overhead sub-element definition and the default material overheads, if any. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Material, Overhead, Setup, gl_code_combinations, fnd_lookup_values, mfg_lookups'
permalink: /CAC%20Material%20Overhead%20Setup/
---

# CAC Material Overhead Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-material-overhead-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the material overhead sub-element definition and the default material overheads, if any.

/* +=============================================================================+
-- |  Copyright 2011 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_mtl_ovhd_setup_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_only_active      -- include only active material overhead codes.  Enter
-- |                        Yes (Yes) to return only active (non-disabled) material 
-- |                        overhead codes.  Enter No (No) to get all material 
-- |                        overhead codes.
-- |
-- |  Description:
-- |  Report to show the material overhead sub-element definition and the default
-- |  material overheads, if any.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     05 Apr 2011 Douglas Volz   Initial Coding 
-- |  1.1     21 Feb 2016 Douglas Volz   Modified Chart of Accounts to match client's COA
-- |  1.2     17 Jul 2018 Douglas Volz   Modified Chart of Accounts to match client's COA
-- |  1.3     16 Jan 2020 Douglas Volz   Add inventory org and operating unit parameters.
-- |  1.4      8 Apr 2020 Douglas Volz   Fix for p_only_active parameter conditions and
-- |                                     changed from fnd_lookup_values to mfg_lookups
-- |                                     sys_yes_no for the Functional Currency column.
-- |                                     Was duplicating rows.
-- |  1.5     28 Apr 2020 Douglas Volz   Changed to multi-language views for the
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/

## Report Parameters
Active Only, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_item_overhead_defaults](https://www.enginatics.com/library/?pg=1&find=cst_item_overhead_defaults), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [mtl_category_sets_tl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_tl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Material Overhead Setup 24-Jun-2022 080352.xlsx](https://www.enginatics.com/example/cac-material-overhead-setup/) |
| Blitz Report™ XML Import | [CAC_Material_Overhead_Setup.xml](https://www.enginatics.com/xml/cac-material-overhead-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-material-overhead-setup/](https://www.enginatics.com/reports/cac-material-overhead-setup/) |


## Case Study & Technical Analysis: CAC Material Overhead Setup

### Executive Summary
The **CAC Material Overhead Setup** report is a configuration audit tool for the Cost Management module. It provides a detailed view of how Material Overheads (MOH) are defined and defaulted within the system.
Material Overheads are indirect costs (like freight, handling, or purchasing administrative costs) applied to items as they are received into inventory. This report ensures that:
1.  **Cost Recovery:** Overhead rates are correctly set to recover indirect expenses.
2.  **Consistency:** Default rules (e.g., "All items in the 'Electronics' category get a 5% surcharge") are applied consistently across organizations.
3.  **Account Accuracy:** The absorption accounts defined for these overheads map to the correct General Ledger accounts.

### Business Challenge
Managing Material Overheads can be complex, especially in large organizations with multiple inventory sites.
*   **Invisible Costs:** Unlike the material cost itself (which is often the PO price), overheads are calculated internally. If the setup is wrong, the inventory value is wrong, but it might not be obvious until a margin analysis is done.
*   **Defaulting Logic:** Oracle allows overheads to be defaulted at the Item, Category, or Organization level. Troubleshooting why a specific item has a specific overhead rate requires seeing these defaulting rules clearly.
*   **Inactive Codes:** Over time, organizations accumulate "dead" overhead codes that clutter the system. Identifying and filtering these out is necessary for system hygiene.

### The Solution
This report flattens the complex relationship between Resources, Overheads, and Defaulting Rules into a single, readable view.
*   **Resource Definition:** It lists the fundamental setup of the overhead resource (Code, UOM, Absorption Account).
*   **Defaulting Rules:** It exposes the logic used to apply these overheads automatically. It shows if the default is based on:
    *   **Item:** Specific rate for a specific item.
    *   **Category:** Rate applied to a whole family of items.
    *   **Organization:** Blanket rate for the whole warehouse.
*   **Rate Visibility:** It displays the actual `Default_Rate_or_Amount` and the `Basis_Type` (e.g., "Item" means a fixed $ amount per unit, "Total Value" means a % of the item cost).

### Technical Architecture (High Level)
The query is built around the `BOM_RESOURCES` table, which is where Material Overheads are defined as "Resources" with a type of "Material Overhead".
*   **CTE/Subquery Structure:** The core logic (aliased as `br_rept_sum`) likely unions two datasets:
    1.  **Resources with Defaults:** Joins `BOM_RESOURCES` to `CST_ITEM_OVERHEAD_DEFAULTS` to show specific rates.
    2.  **Resources without Defaults:** Selects from `BOM_RESOURCES` alone to show defined overheads that have no automatic defaulting rules (these might be applied manually).
*   **Aggregation:** The `SUM(default_rate_or_amount)` suggests that if there are multiple default lines (though rare for a single resource/level combo), they are aggregated.
*   **Organization Context:** It joins to `HR_ORGANIZATION_INFORMATION` and `MTL_PARAMETERS` to resolve Organization Codes and Operating Units, ensuring the report is readable by business users.

### Parameters & Filtering
*   **Active Only (Yes/No):** Allows users to hide disabled overhead codes (`disable_date` is not null).
*   **Organization Code:** Filter by specific inventory organization.
*   **Operating Unit / Ledger:** High-level filtering for multi-entity reporting.

### Performance & Optimization
*   **Pre-Aggregation:** The inner query (`br_rept_sum`) handles the heavy lifting of joining resources to defaults and aggregating rates. This ensures the outer query only has to join to the lookup and organization tables once per resource/default combination.
*   **Lookup Optimization:** Uses `MFG_LOOKUPS` and `FND_LOOKUP_VALUES` to decode system codes (like `Basis_Type`) into user-friendly text.

### FAQ
**Q: What is the difference between "Item" basis and "Total Value" basis?**
A: "Item" basis means a fixed dollar amount is added to every unit received (e.g., $10 handling fee per unit). "Total Value" basis means a percentage is applied to the cost of the item (e.g., 5% freight charge on the PO price).

**Q: Why do I see multiple lines for the same Overhead Code?**
A: You might have different default rules for different categories. For example, "Freight" might be 5% for "Hardware" but 10% for "Chemicals". Each rule appears as a row.

**Q: If I change the rate here, does it update existing inventory?**
A: No. This report shows the *Setup* and *Defaults*. Changing a default only affects *future* item definitions or cost updates. To change the value of existing inventory, you must run a Standard Cost Update.

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
