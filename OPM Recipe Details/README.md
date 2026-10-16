---
layout: default
last_modified_at: 2026-10-16
title: 'OPM Recipe Details | Oracle EBS SQL Report'
description: 'OPM (Process Manufacturing) recipe details combining recipe status, validity rules, preferences, formula product quantity and routing step / resource…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, R12 only, OPM, Recipe, Details, gmd_recipes_vl, org_organization_definitions, gmd_recipe_validity_rules'
permalink: /OPM%20Recipe%20Details/
report_name: 'OPM Recipe Details'
report_web_name: opm-recipe-details
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Recipe Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-recipe-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
OPM (Process Manufacturing) recipe details combining recipe status, validity rules, preferences, formula product quantity and routing step / resource quantities. Supports data cleaning before cost roll up. Optionally shows an item category code via the Category Set parameter.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Recipe, Item, Recipe Status, Category Set

## Oracle EBS Tables Used
[gmd_recipes_vl](https://www.enginatics.com/library/?pg=1&find=gmd_recipes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [gmd_recipe_validity_rules](https://www.enginatics.com/library/?pg=1&find=gmd_recipe_validity_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [fm_rout_hdr](https://www.enginatics.com/library/?pg=1&find=fm_rout_hdr&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [fm_matl_dtl](https://www.enginatics.com/library/?pg=1&find=fm_matl_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [gmd_operation_resources](https://www.enginatics.com/library/?pg=1&find=gmd_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [gmd_operation_activities](https://www.enginatics.com/library/?pg=1&find=gmd_operation_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [gmd_operations_vl](https://www.enginatics.com/library/?pg=1&find=gmd_operations_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [fm_rout_dtl](https://www.enginatics.com/library/?pg=1&find=fm_rout_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)

## Related Reports
[OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report"), [OPM Formula Where-Used](/OPM%20Formula%20Where-Used/ "OPM Formula Where-Used Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Recipe%20Details/OPM%20Recipe%20Details.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Recipe Details 05-Jun-2026 120000.xlsx](https://www.enginatics.com/example/opm-recipe-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details) |
| Blitz Report™ XML Import | [OPM_Recipe_Details.xml](https://www.enginatics.com/xml/opm-recipe-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details) |
| SQL Source | [OPM Recipe Details.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Recipe%20Details/OPM%20Recipe%20Details.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-recipe-details/](https://www.enginatics.com/reports/opm-recipe-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details) |

## Case Study & Technical Analysis: OPM Recipe Details

### Executive Summary
The OPM Recipe Details report combines the recipe header, its validity rules, the formula product, and the routing steps and resource usage of Oracle Process Manufacturing (OPM) recipes into one list. It is designed for data cleaning before a cost roll up: process costing analysts and production planners use it to find recipes whose status, validity rule, product quantity, routing step or resource usage is incomplete or inconsistent. An optional category set parameter adds the item category code for each recipe item. The report runs in Excel via Blitz Report, and it excludes recipes with recipe status code 1000.

### Business Challenge
*   **Cost roll up readiness:** Process cost roll ups depend on consistent recipe, formula and routing data, and gaps must be found before the roll up is run.
*   **Validity rule coverage:** A recipe applies to items through validity rules with their own status, effective start date and standard quantity, and each rule must be correct for the item and organization.
*   **Routing and resource detail:** Each routing step carries a step quantity, and each resource carries a process quantity and usage, which must be checked against the recipe.
*   **Category based reporting:** Recipes are often grouped by item category, and the category code needs to be visible alongside the recipe.

### The Solution
*   **Recipe-to-rule view:** Each recipe is shown with each of its validity rules, including preference, start date, status, standard quantity and unit of measure.
*   **Product line in context:** The formula product line, with its item, quantity and unit of measure, appears beside the recipe.
*   **Routing detail:** Routing steps and their resources are shown with step quantities, process quantities, resource usage and their units.
*   **Optional category:** The category code of the recipe item in the selected category set is added when a Category Set is entered.

### Technical Architecture (High Level)
#### Primary Tables
*   `GMD_RECIPES_VL`: the recipe header, with recipe number, description, version, status, owner organization, routing and formula identifiers.
*   `GMD_RECIPE_VALIDITY_RULES`: the validity rules that link a recipe to an item in an organization.
*   `GMD_STATUS_VL`: the recipe and validity rule status meanings.
*   `MTL_SYSTEM_ITEMS_VL`: the item number, status, description and weight unit for each validity rule.
*   `ORG_ORGANIZATION_DEFINITIONS`: the owner organization of the recipe.
*   `FM_ROUT_HDR`, `FM_ROUT_DTL`: the routing header and its steps.
*   `FM_MATL_DTL`: the formula material lines, used here for the product line.
*   `GMD_OPERATIONS_VL`, `GMD_OPERATION_ACTIVITIES`, `GMD_OPERATION_RESOURCES`: operations and their resource usage.
*   `MTL_ITEM_CATEGORIES`, `MTL_CATEGORIES_B_KFV`, `MTL_CATEGORY_SETS_VL`: the optional category assignment.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

#### Logical Relationships
1. `GMD_RECIPES_VL` is joined to `ORG_ORGANIZATION_DEFINITIONS` on the owner organization.
2. `GMD_RECIPE_VALIDITY_RULES` is joined to the recipe on recipe identifier and to the organization on organization identifier.
3. `MTL_SYSTEM_ITEMS_VL` is joined to the validity rule on inventory item and organization.
4. `FM_ROUT_HDR` is outer joined on the recipe's routing identifier, and the routing detail block is outer joined on the same identifier.
5. The formula product block, from `FM_MATL_DTL` with line type 1, is outer joined on the recipe's formula identifier.
6. The category block joins item categories to the named category set and is outer joined on organization and item.
7. Recipe and validity rule statuses are outer joined to `GMD_STATUS_VL`.

### Parameters & Filtering
*   **Organization Code:** Limits the recipes to one owner organization, within the responsibility's accessible organizations.
*   **Recipe:** Restricts the output to one recipe number.
*   **Item:** Restricts the output to recipes for one item.
*   **Recipe Status:** Restricts the output to recipes in one status.
*   **Category Set:** Names the category set whose category code is shown for each item. The category block is only applied to the rows where the category set matches.

### Performance & Optimization
*   Organizations are restricted through an `IN` subquery on `ORG_ACCESS_VIEW`, which limits the recipe scan to the permitted owner organizations.
*   Recipes with status code 1000 are excluded in the main predicate, so their validity rules and routing detail are not returned.
*   The category, product and routing blocks are inline views joined as outer joins, so each recipe validity rule is extended by at most one category, one product line and the routing detail rows.
*   The routing detail is a non-correlated inline view joined through the routing identifier, so it is evaluated once for the routings it contains.
*   Results are ordered by organization code and recipe number.

### FAQ
**Q: Why is a recipe with status 1000 missing from the report?**
A: The report excludes recipes whose recipe status code is 1000 in its main predicate.

**Q: How do I see the item category for each recipe?**
A: Enter the name of the category set in the Category Set parameter; the category code is then returned for each item.

**Q: What does the validity rule status show?**
A: It shows the status meaning of each validity rule, read from the same status lookup as the recipe status.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-recipe-details)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
