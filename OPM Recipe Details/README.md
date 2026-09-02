---
layout: default
title: 'OPM Recipe Details | Oracle EBS SQL Report'
description: 'OPM (Process Manufacturing) recipe details combining recipe status, validity rules, preferences, formula product quantity and routing step / resource…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, OPM, Recipe, Details, gmd_recipes_vl, org_organization_definitions, gmd_recipe_validity_rules'
permalink: /OPM%20Recipe%20Details/
---

# OPM Recipe Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-recipe-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
OPM (Process Manufacturing) recipe details combining recipe status, validity rules, preferences, formula product quantity and routing step / resource quantities. Supports data cleaning before cost roll up. Optionally shows an item category code via the Category Set parameter.

## Report Parameters
Organization Code, Recipe, Item, Recipe Status, Category Set

## Oracle EBS Tables Used
[gmd_recipes_vl](https://www.enginatics.com/library/?pg=1&find=gmd_recipes_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gmd_recipe_validity_rules](https://www.enginatics.com/library/?pg=1&find=gmd_recipe_validity_rules), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl), [fm_rout_hdr](https://www.enginatics.com/library/?pg=1&find=fm_rout_hdr), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl), [fm_matl_dtl](https://www.enginatics.com/library/?pg=1&find=fm_matl_dtl), [gmd_operation_resources](https://www.enginatics.com/library/?pg=1&find=gmd_operation_resources), [gmd_operation_activities](https://www.enginatics.com/library/?pg=1&find=gmd_operation_activities), [gmd_operations_vl](https://www.enginatics.com/library/?pg=1&find=gmd_operations_vl), [fm_rout_dtl](https://www.enginatics.com/library/?pg=1&find=fm_rout_dtl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report"), [OPM Formula Where-Used](/OPM%20Formula%20Where-Used/ "OPM Formula Where-Used Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Recipe Details 05-Jun-2026 120000.xlsx](https://www.enginatics.com/example/opm-recipe-details/) |
| Blitz Report™ XML Import | [OPM_Recipe_Details.xml](https://www.enginatics.com/xml/opm-recipe-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-recipe-details/](https://www.enginatics.com/reports/opm-recipe-details/) |



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
