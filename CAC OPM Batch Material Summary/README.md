---
layout: default
last_modified_at: 2026-10-16
title: 'CAC OPM Batch Material Summary | Oracle EBS SQL Report'
description: 'Report showing Batch materials in summary for each product, byproduct and ingredient. Displaying batches which were open during the monthly inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, OPM, Batch, Material, gl_item_cst, cm_mthd_mst, gmf_period_statuses'
permalink: /CAC%20OPM%20Batch%20Material%20Summary/
report_name: 'CAC OPM Batch Material Summary'
report_web_name: cac-opm-batch-material-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC OPM Batch Material Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-opm-batch-material-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Cost Type, OPM Calendar Code, OPM Period Code, Batch Status, Batch Number, Batch Number From, Batch Number To, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_item_cst](https://www.enginatics.com/library/?pg=1&find=gl_item_cst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gmf_calendar_assignments](https://www.enginatics.com/library/?pg=1&find=gmf_calendar_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [cm_whse_asc](https://www.enginatics.com/library/?pg=1&find=cm_whse_asc&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [cm_cmpt_dtl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [cm_cmpt_mst_b](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gme_material_details](https://www.enginatics.com/library/?pg=1&find=gme_material_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gem_lookups](https://www.enginatics.com/library/?pg=1&find=gem_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)

## Related Reports
[CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20Batch%20Material%20Summary/CAC%20OPM%20Batch%20Material%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-opm-batch-material-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary) |
| Blitz Report™ XML Import | [CAC_OPM_Batch_Material_Summary.xml](https://www.enginatics.com/xml/cac-opm-batch-material-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary) |
| SQL Source | [CAC OPM Batch Material Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20Batch%20Material%20Summary/CAC%20OPM%20Batch%20Material%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-opm-batch-material-summary/](https://www.enginatics.com/reports/cac-opm-batch-material-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-batch-material-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
