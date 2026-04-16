---
layout: default
title: 'CAC OPM Batch Material Summary | Oracle EBS SQL Report'
description: 'Report showing Batch materials in summary for each product, byproduct and ingredient. Displaying batches which were open during the monthly inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, OPM, Batch, Material, gme_batch_header, gme_material_details, mtl_uom_conversions_view'
permalink: /CAC%20OPM%20Batch%20Material%20Summary/
---

# CAC OPM Batch Material Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-opm-batch-material-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing Batch materials in summary for each product, byproduct and ingredient.  Displaying batches which were open during the monthly inventory accounting period or batches which were closed during the monthly inventory accounting period.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end item costs.

Parameters:
==========
Period Name:  enter the monthly inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; if Cost Type is not entered the report will use the Cost Type from your Fiscal Policies (optional).
OPM Calendar Code:  choose the OPM Calendar Code which corresponds to the period costs you wish to report (mandatory).
OPM Period Code:  enter the OPM Period Code which corresponds to the period costs and OPM Calendar Code you wish to report (mandatory).
Category Sets 1 - 3:  enter up to three item category sets you wish to report (optional).
Item Number:  specific Product, By-Product or Ingredient you wish to report (optional).
Batch Number: enter any batch number which is open or was closed within the date range of the OPM Period Code and Calendar Code (optional).
Batch Status:  to minimize the report size, specify the batch statuses you wish to report (optional).
Batch Number From:  (optional).
Batch Number To:  (optional).
Organization Code:  enter the inventory organization(s), defaults to your session's inventory organization (optional).
Operating Unit:  enter the operating unit(s) you wish to report (optional).
Ledger:  enter the ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2025 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     22 Jan 2025 Douglas Volz Initial Coding based on client's sample report.
-- +=============================================================================*/


## Report Parameters
Period Name, Cost Type, OPM Calendar Code, OPM Period Code, Batch Status, Batch Number, Batch Number From, Batch Number To, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header), [gme_material_details](https://www.enginatics.com/library/?pg=1&find=gme_material_details), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view), [item_cost](https://www.enginatics.com/library/?pg=1&find=item_cost), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies), [gmf_calendar_assignments](https://www.enginatics.com/library/?pg=1&find=gmf_calendar_assignments), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [gem_lookups](https://www.enginatics.com/library/?pg=1&find=gem_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-opm-batch-material-summary/) |
| Blitz Report™ XML Import | [CAC_OPM_Batch_Material_Summary.xml](https://www.enginatics.com/xml/cac-opm-batch-material-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-opm-batch-material-summary/](https://www.enginatics.com/reports/cac-opm-batch-material-summary/) |

## Case Study & Technical Analysis: CAC OPM Batch Material Summary

### Executive Summary
The **CAC OPM Batch Material Summary** report is a production analysis tool for Oracle Process Manufacturing (OPM). It summarizes the material activity (Ingredients consumed, Products yielded) for production batches. This is the OPM equivalent of a "Material Usage" report in Discrete manufacturing.

### Business Challenge
*   **Yield Analysis**: In chemical/food production, the ratio of Ingredients In to Product Out is the primary efficiency metric.
*   **Variance**: Did we use more Sugar than the Formula called for?
*   **Period Close**: Verifying that all material transactions for the period have been recorded against the batches.

### Solution
This report aggregates the details.
*   **Structure**: Groups by Batch, then by Line Type (Ingredient, Product, By-product).
*   **Quantities**: Shows Plan Qty, Actual Qty, and Variance.
*   **Valuation**: Uses the OPM Cost Type to value the material flows.

### Technical Architecture
*   **Tables**: `gme_batch_header`, `gme_material_details`.
*   **Costing**: Joins to `item_cost` (OPM Costing table) or `gmf_period_balances`.
*   **Logic**: Filters for batches active in the specified OPM Period.

### Parameters
*   **Period Name**: (Mandatory) Inventory Period.
*   **OPM Calendar/Period**: (Mandatory) OPM Costing Period.
*   **Cost Type**: (Optional) For valuation.

### Performance
*   **Batch Volume**: OPM environments can have high batch volumes. Filtering by Status (e.g., Closed) helps.

### FAQ
**Q: Does this show "WIP" value?**
A: No, this shows the *Material* flow (Issues and Completions). For the value of the Batch itself (WIP), use the "OPM WIP Account Value" report.

**Q: What is a "By-product"?**
A: A secondary item produced by the process (e.g., Skim Milk produced when making Cream). It typically has a negative cost or a recovery value.


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
