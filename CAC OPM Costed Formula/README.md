---
layout: default
last_modified_at: 2026-10-19
title: 'CAC OPM Costed Formula | Oracle EBS SQL Report'
description: 'eport showing OPM formulas and item costs, by OPM Cost Component Class. The report automatically displays the first thirty Cost Components, sorted by…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, OPM, Costed, Formula, cm_cmpt_mst_vl, gem_lookups, gl_item_cst'
permalink: /CAC%20OPM%20Costed%20Formula/
report_name: 'CAC OPM Costed Formula'
report_web_name: cac-opm-costed-formula
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC OPM Costed Formula – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-opm-costed-formula/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
eport showing OPM formulas and item costs, by OPM Cost Component Class.   The report automatically displays the first thirty Cost Components, sorted by Usage Indicator (1-Material, 2-Overhead, 3-Resource, 4-Expense Alloc), then by the Cost Component Class.  With the "Other Costs" column summing up any other non-displayed Cost Component Classes.  For a different selection of Cost Component Classes, you may override any of the defaulted Cost Component Classes.  If you have fewer than thirty Cost Components the report automatically displays "Not Available", for the succeeding Cost Component columns.  And if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end item costs.

Note:  The Label Approval column is from a user-defined Formula field, attribute4.  Your use of these descriptive flexfields, may be different and may require you to customize this report.

General Parameters:
===================
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
OPM Calendar Code:  choose the OPM Calendar Code which corresponds to the inventory accounting period you wish to report (mandatory).
OPM Period Code:  enter the OPM Period Code related to the inventory accounting period and OPM Calendar Code you wish to report (mandatory).
Only Show Latest Version:  enter Yes to report the latest formula and recipe version.  Enter No to see all versions (mandatory).
Show More Details:  enter Yes to display Ingredient Scale Type, Contribute to Yield, Standard Lot Size and End Date (from the validity rule).  Mandatory.
Effective Date:  for material line items and validity rules, enter the last ending date to report.  Defaults to today's date (mandatory).
Status to Include:  to minimize the report size, specify the formula, recipe and validity rule statuses you wish to report (optional).
Product Category Set:  the Product category set you wish to report (optional).
Line Category Set 1:  for the formula line item numbers, the first item category set to report (optional).
Line Category Set 2:  for the formula line item numbers, the second item category set to report (optional)
Item Number:  specific Product, By-Product or Ingredient you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).
Cost Component 1 - 30:  the defaulted Cost Component Classes.  You may override these defaulted values.

-- | Version Modified on Modified by Description
-- | ======= =========== ==============
-- | 1.0     02 Jun 2024 Douglas Volz Initial Coding based on client's sample report.
-- | 1.1     03 Jun 2024 Douglas Volz UOM conversions for formula line quantities
-- | 1.2     08 Jun 2024 Douglas Volz Replaced Cost Component rownum sort logic.
-- | 1.3     12 Jun 2024 Douglas Volz Cleaned-up naming for Cost Component parameters, fixed item number parameter.
-- | 1.4     03 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs.
-- | 1.5     05 Aug 2024 Douglas Volz Add inventory organization access control security.
-- | 1.6     07 Aug 2024 Douglas Volz Not all formulas are assigned to classes, needs outer join.
-- | 1.7     08 Aug 2024 Douglas Volz Add item status and Make/Buy columns.
-- | 1.8     09 Aug 2024 Douglas Volz Add parameter "Show More Details" for Scale Type, Contribute to Yield, Std Lot Size and End Date.
-- | 1.9     17 Aug 2024 Douglas Volz Add parameters "Only Show Latest Version" and "Effective Date".
-- | 1.10    18 Aug 2024 Douglas Volz Restructured code.
-- | 1.11    07 Sep 2024 Douglas Volz Fixed Cost Component parameters, from lexicals to bind variables.
-- | 1.12    10 Sep 2024 Douglas Volz Add Std Lot Size UOM column.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, OPM Calendar Code, OPM Period Code, Only Show Latest Version, Show More Details, Effective Date, Status to Include, Product Category Set, Line Category Set 1, Line Category Set 2, Item Number, Organization Code, Operating Unit, Ledger, Cost Component 1, Cost Component 2, Cost Component 3, Cost Component 4, Cost Component 5, Cost Component 6, Cost Component 7, Cost Component 8, Cost Component 9, Cost Component 10, Cost Component 11, Cost Component 12, Cost Component 13, Cost Component 14, Cost Component 15, Cost Component 16, Cost Component 17, Cost Component 18, Cost Component 19, Cost Component 20, Cost Component 21, Cost Component 22, Cost Component 23, Cost Component 24, Cost Component 25, Cost Component 26, Cost Component 27, Cost Component 28, Cost Component 29, Cost Component 30

## Oracle EBS Tables Used
[cm_cmpt_mst_vl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gem_lookups](https://www.enginatics.com/library/?pg=1&find=gem_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gl_item_cst](https://www.enginatics.com/library/?pg=1&find=gl_item_cst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gl_item_dtl](https://www.enginatics.com/library/?pg=1&find=gl_item_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gmf_calendar_assignments](https://www.enginatics.com/library/?pg=1&find=gmf_calendar_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [cm_whse_asc](https://www.enginatics.com/library/?pg=1&find=cm_whse_asc&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [cm_cmpt_dtl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [cm_cmpt_mst_b](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [fm_form_mst_vl](https://www.enginatics.com/library/?pg=1&find=fm_form_mst_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [fm_matl_dtl](https://www.enginatics.com/library/?pg=1&find=fm_matl_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gmd_formula_class_vl](https://www.enginatics.com/library/?pg=1&find=gmd_formula_class_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)

## Related Reports
[CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC OPM Item Cost Detail](/CAC%20OPM%20Item%20Cost%20Detail/ "CAC OPM Item Cost Detail Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20Costed%20Formula/CAC%20OPM%20Costed%20Formula.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-opm-costed-formula/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula) |
| Blitz Report™ XML Import | [CAC_OPM_Costed_Formula.xml](https://www.enginatics.com/xml/cac-opm-costed-formula/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula) |
| SQL Source | [CAC OPM Costed Formula.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20Costed%20Formula/CAC%20OPM%20Costed%20Formula.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-opm-costed-formula/](https://www.enginatics.com/reports/cac-opm-costed-formula/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula) |

## Case Study & Technical Analysis: CAC OPM Costed Formula

### Executive Summary
The **CAC OPM Costed Formula** report is a "Standard Cost" report for Process Manufacturing. It displays the calculated cost of a Formula (Recipe), broken down by the OPM Cost Component Classes (e.g., Material, Labor, Overhead, Depreciation). It is the OPM equivalent of the "Indented Bill of Materials Cost" report.

### Business Challenge
*   **Cost Visibility**: Understanding the cost structure of a formula is complex. It involves Ingredients, Routings, Resources, and Overheads.
*   **Simulation**: "If the price of Corn goes up 10%, what happens to the cost of our Ethanol?"
*   **Validation**: Verifying that the "Rolled Up" cost matches expectations before freezing it for the period.

### Solution
This report flattens the cost structure.
*   **Components**: Columns for up to 30 Cost Component Classes (configurable).
*   **Context**: Shows the Formula Version, Recipe Version, and Validity Rules.
*   **Details**: Can show Ingredient Scale Type (Fixed/Proportional) and Yield factors.

### Technical Architecture
*   **Tables**: `fm_form_mst` (Formula), `cm_cmpt_dtl` (Cost Details), `gmf_period_statuses`.
*   **Pivot**: The SQL dynamically pivots the rows from the cost detail table into columns for the report.

### Parameters
*   **OPM Calendar/Period**: (Mandatory) The costing period.
*   **Effective Date**: (Mandatory) For selecting the active formula.
*   **Cost Components**: (Optional) You can map specific Component Classes to the 30 columns.

### Performance
*   **Complex**: OPM Costing data is highly normalized. The report performs significant aggregation and pivoting.

### FAQ
**Q: Why "30" components?**
A: OPM allows unlimited cost components, but a flat report needs a fixed number of columns. 30 covers 99% of use cases.

**Q: Does it show the Routing?**
A: It shows the *costs* derived from the routing (Resources), but not the operations themselves.

**Q: What is "Validity Rule"?**
A: It determines *when* and *for whom* a recipe is valid (e.g., "Recipe A is for Plant 1, Recipe B is for Plant 2").

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-costed-formula)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
