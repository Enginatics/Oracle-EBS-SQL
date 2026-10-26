---
layout: default
last_modified_at: 2026-10-26
title: 'OPM Formula Where-Used | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) formula where-used: lists which formulas consume a given ingredient item, with the ingredient quantity and UOM, the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, R12 only, OPM, Formula, Where-Used, fm_matl_dtl, mtl_system_items_vl, gmd_recipes_vl'
permalink: /OPM%20Formula%20Where-Used/
report_name: 'OPM Formula Where-Used'
report_web_name: opm-formula-where-used
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Formula Where-Used – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-formula-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
Oracle Process Manufacturing (OPM) formula where-used: lists which formulas consume a given ingredient item, with the ingredient quantity and UOM, the using formula and its status, the formula's primary product, and how many recipes use that formula. Supports ingredient impact analysis for substitution, supplier change and allergen / regulatory recall.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Ingredient Item, Formula Status

## Oracle EBS Tables Used
[fm_matl_dtl](https://www.enginatics.com/library/?pg=1&find=fm_matl_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [gmd_recipes_vl](https://www.enginatics.com/library/?pg=1&find=gmd_recipes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [fm_form_mst](https://www.enginatics.com/library/?pg=1&find=fm_form_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)

## Related Reports
[OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report"), [OPM Formula Details](/OPM%20Formula%20Details/ "OPM Formula Details Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [OPM Formula Upload](/OPM%20Formula%20Upload/ "OPM Formula Upload Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Formula%20Where-Used/OPM%20Formula%20Where-Used.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Formula Where-Used 05-Jun-2026 120002.xlsx](https://www.enginatics.com/example/opm-formula-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used) |
| Blitz Report™ XML Import | [OPM_Formula_Where_Used.xml](https://www.enginatics.com/xml/opm-formula-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used) |
| SQL Source | [OPM Formula Where-Used.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Formula%20Where-Used/OPM%20Formula%20Where-Used.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-formula-where-used/](https://www.enginatics.com/reports/opm-formula-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used) |

## Case Study & Technical Analysis: OPM Formula Where-Used

### Executive Summary
This report answers the question "which formulas use this ingredient?" in Oracle Process Manufacturing. For a given ingredient item it lists every formula that consumes it, with the quantity and unit of measure, the formula's version and status, its primary product, and the number of recipes built from that formula. Process manufacturing quality, regulatory and supply chain teams use it for impact analysis before a substitution, a supplier change or an allergen or regulatory recall. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Substitution impact:** Replacing an ingredient needs every formula that consumes it to be identified before the change is released.
*   **Supplier change control:** A new supplier of a raw material must be checked against all the formulas it touches.
*   **Recall scope:** An allergen or regulatory recall must reach every formula and recipe that contains the affected ingredient.
*   **Formula status:** Obsolete or on-hold formulas still consume ingredients in the data, and their status must be visible.

### The Solution
*   **Ingredient consumption:** The report selects each formula line where the item is an ingredient, identified by a negative line type.
*   **Quantity and unit:** The ingredient quantity, its unit of measure and its scrap factor are shown on each row.
*   **Formula identity:** The formula number, version and status name are returned so each usage can be judged.
*   **Primary product:** The item of the formula's product line is shown, so the consumer of the ingredient is identified.
*   **Recipe count:** The number of distinct recipes built from the formula shows how far the change would spread.

### Technical Architecture (High Level)
#### Primary Tables
*   `FM_MATL_DTL`: the formula material lines, with line type, quantity, unit of measure and scrap factor. Ingredient lines have a negative line type and product lines have a positive one.
*   `FM_FORM_MST`: the formula master, with formula number, version and status.
*   `MTL_SYSTEM_ITEMS_VL`: the ingredient and product item and its description.
*   `GMD_RECIPES_VL`: the recipes that use each formula, counted for the recipe count.
*   `GMD_STATUS_VL`: the status name of the formula.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. `FM_MATL_DTL` joins to `FM_FORM_MST` on formula id, and is restricted to ingredient lines with line type -1.
2. `FM_MATL_DTL` joins to `MTL_SYSTEM_ITEMS_VL` on inventory item id and organization id, which gives the ingredient item.
3. `FM_FORM_MST` joins to `GMD_STATUS_VL` on the formula status code, as an outer join.
4. The product item is a scalar subquery on the formula's product lines, with line type 1, and returns the first match.
5. The recipe count is a scalar subquery on `GMD_RECIPES_VL` counting distinct recipe ids for the formula.

### Parameters & Filtering
*   **Organization Code:** restricts the usages to one process manufacturing organization.
*   **Ingredient Item:** restricts the report to one ingredient.
*   **Formula Status:** restricts the formulas to one status.

### Performance & Optimization
*   The ingredient line filter on line type applies before the item and formula joins, so the report reads only consumption lines.
*   The organization access list limits the material detail rows to the organizations the responsibility can access.
*   The product item and recipe count are scalar subqueries keyed on the formula id, so they run once for each returned formula line.

### FAQ
**Q: How do I find every formula that uses a particular ingredient?**
A: Enter the item in Ingredient Item and leave the other parameters blank, or select the organization that holds the formula.

**Q: What does the recipes using column count?**
A: It counts the distinct recipes built from the formula, so it shows how many recipes a formula change would affect.

**Q: Why does a formula appear more than once?**
A: The report has one row per ingredient line, so a formula that uses the item in two lines appears twice.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-where-used)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
