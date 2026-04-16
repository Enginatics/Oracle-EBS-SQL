---
layout: default
title: 'CAC Load More4Apps Buy Item Costs | Oracle EBS SQL Report'
description: 'Report to fetch all buy items (based on rollup = No). Used as a source of item costs for buy items which you wish to edit or change using the More4Apps…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Load, More4Apps, Buy, bom_resources, mtl_system_items_vl, mtl_item_status_vl'
permalink: /CAC%20Load%20More4Apps%20Buy%20Item%20Costs/
---

# CAC Load More4Apps Buy Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-load-more4apps-buy-item-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to fetch all buy items (based on rollup = No).   Used as a source of item costs for buy items which you wish to edit or change using the More4Apps Item Cost Wizard or similar tool.  You can over-ride the Make Buy Code by removing the defaulted value, but the Oracle Item Cost Interface works best for Buy Items; it does not work well with rolled-up costs and accordingly, this report only downloads items whose costs are not based on the cost rollup.

This report approximates the layout for the More4Apps Item Cost Wizard; run this report to get your Buy Item costs into Excel, make your changes in Excel then paste these revised costs into the More4Apps Item Cost Wizard.  Columns needed for the More4Apps Item Cost Wizard:  Org Code, Cost Type, Item Number, Based on Rollup, Lot Size, Mfg Shrinkage, Cost Element, Sub-Element, Basis Type and Rate or Amount.  The additional columns, Currency Code, UOM Code, Make Buy Code and Inventory Asset, are for reference purposes.

Parameters:
===========
From Cost Type:  enter the cost type you are downloading from (mandatory).
To Cost Type:  enter the cost type you are planning to upload back into the More4Apps Item Cost Wizard.  This Cost Type will show up on the report output (mandatory).
Item Status to Exclude:  enter the item number status you want to exclude.  Defaulted to 'Inactive' (optional).
Make or Buy:  enter the type of item you wish to report.  Defaulted to Buy Items, as the Oracle Item Cost Interface works best with items that you purchase, as opposed to rolled up costs (optional).
Cost Element:  enter the specific cost element you wish to download; for Buy Items typically the Material and Material Overhead Cost Elements (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2017 - 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_load_m4app_buy_item_costs.sql
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    07 Jun 2017 Douglas Volz  Initial Coding
-- |  1.1    16 Jun 2017 Douglas Volz  Only report based on rollup = No
-- |  1.2    12 Nov 2018 Douglas Volz  Remove prior client org restriction and
-- |                                   add Ledger parameter.
-- |  1.3    27 Jan 2020 Douglas Volz  Added Operating Unit parameter.
-- |  1.4    06 Jul 2022 Douglas Volz  Changed to multi-language views for the item
-- |                                   master and inventory orgs.
-- |  1.5    21 Oct 2023 Douglas Volz  Added UOM Code, Make Buy Code and Inventory
-- |                                   Asset columns; added Item Status, Make Buy
-- |                                   and Cost Element parameters, removed tabs
-- |                                   and added org access controls.
-- |  1.6    05 Dec 2023 Douglas Volz  Added G/L and Operating Unit security restrictions.
-- +=============================================================================+*/


## Report Parameters
From Cost Type, To Cost Type, Item Status to Exclude, Make or Buy, Cost Element, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Load More4Apps Buy Item Costs 24-Jun-2022 051540.xlsx](https://www.enginatics.com/example/cac-load-more4apps-buy-item-costs/) |
| Blitz Report™ XML Import | [CAC_Load_More4Apps_Buy_Item_Costs.xml](https://www.enginatics.com/xml/cac-load-more4apps-buy-item-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-load-more4apps-buy-item-costs/](https://www.enginatics.com/reports/cac-load-more4apps-buy-item-costs/) |

## Case Study & Technical Analysis: CAC Load More4Apps Buy Item Costs

### Executive Summary
The **CAC Load More4Apps Buy Item Costs** report is a data migration and maintenance utility. It is specifically designed to support the "More4Apps Item Cost Wizard", a popular third-party tool for mass-updating Oracle data. This report extracts existing "Buy" item costs into the exact format required for re-upload, streamlining the standard cost update process.

### Business Challenge
Updating Standard Costs for thousands of purchased items is a massive manual effort.
*   **Data Entry**: Manually typing new costs into Oracle forms is slow and error-prone.
*   **Formatting**: Extracting data from Oracle and re-formatting it for upload tools often involves complex VLOOKUPs and data cleansing.
*   **Scope**: Users need to filter for only "Buy" items (where the cost is manually maintained) and ignore "Make" items (where the cost is rolled up).

### Solution
This report automates the "Extract" phase of the ETL (Extract-Transform-Load) process.
*   **Targeted Scope**: Filters for `Based on Rollup = No` to isolate Buy items.
*   **Tool-Ready**: The column layout (Org, Item, Cost Type, Element, Rate) matches the More4Apps template.
*   **Context**: Includes current costs to serve as a baseline for the new year's pricing.

### Technical Architecture
The report queries the cost details table:
*   **Table**: `cst_item_cost_details`.
*   **Logic**: It flattens the cost structure to show the specific rates and amounts for Material and Material Overhead.
*   **Filter**: Excludes rolled-up items to prevent overwriting calculated costs.

### Parameters
*   **From Cost Type**: (Mandatory) The source data (e.g., Frozen).
*   **To Cost Type**: (Mandatory) The target cost type for the upload (e.g., Pending).
*   **Make or Buy**: (Optional) Defaults to 'Buy'.

### Performance
*   **Fast**: Optimized for bulk data extraction.
*   **Volume**: Can handle tens of thousands of rows easily.

### FAQ
**Q: Can I use this without More4Apps?**
A: Yes, it produces a clean CSV/Excel file that can be used as a source for Oracle WebADI or the standard Interface Table (`cst_item_cst_dtls_interface`).

**Q: Why exclude "Make" items?**
A: "Make" items usually have their costs calculated via the Cost Rollup routine based on their BOM and Routing. Manually uploading a cost for a Make item overrides this calculation, which is usually not desired.

**Q: Does it handle OSP?**
A: Yes, if the OSP cost is maintained as a static value (not rolled up), it will be included.


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
