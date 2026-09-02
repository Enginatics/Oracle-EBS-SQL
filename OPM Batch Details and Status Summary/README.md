---
layout: default
title: 'OPM Batch Details and Status Summary | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) batch details and status summary: one row per production batch showing batch status and type, recipe, primary product…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, OPM, Batch, Details, Status, gme_batch_header, org_organization_definitions, gmd_recipe_validity_rules'
permalink: /OPM%20Batch%20Details%20and%20Status%20Summary/
---

# OPM Batch Details and Status Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-batch-details-and-status-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Oracle Process Manufacturing (OPM) batch details and status summary: one row per production batch showing batch status and type, recipe, primary product and planned/actual output quantity, planned versus actual start and completion dates, and whether the batch completed on time. Set a pending/released status with plan-date filters for a planned-production view.

## Report Parameters
Organization Code, Batch Number, Product Item, Batch Status, Actual Start Date From, Actual Start Date To

## Oracle EBS Tables Used
[gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gmd_recipe_validity_rules](https://www.enginatics.com/library/?pg=1&find=gmd_recipe_validity_rules), [gmd_recipes_vl](https://www.enginatics.com/library/?pg=1&find=gmd_recipes_vl), [gme_material_details](https://www.enginatics.com/library/?pg=1&find=gme_material_details), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OPM Batch Yield Variance](/OPM%20Batch%20Yield%20Variance/ "OPM Batch Yield Variance Oracle EBS SQL Report"), [OPM Batch Material Usage and Substitution Variance](/OPM%20Batch%20Material%20Usage%20and%20Substitution%20Variance/ "OPM Batch Material Usage and Substitution Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Batch Details and Status Summary 05-Jun-2026 120004.xlsx](https://www.enginatics.com/example/opm-batch-details-and-status-summary/) |
| Blitz Report™ XML Import | [OPM_Batch_Details_and_Status_Summary.xml](https://www.enginatics.com/xml/opm-batch-details-and-status-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-batch-details-and-status-summary/](https://www.enginatics.com/reports/opm-batch-details-and-status-summary/) |



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
