---
layout: default
title: 'PA Project Asset Upload | Oracle EBS SQL Report'
description: 'PA Project Asset Upload ====================== Create, update, or delete project assets and their task assignments for Oracle Projects capital projects…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Project, Asset, pa_projects_all, hr_all_organization_units_vl, pa_project_assets_all'
permalink: /PA%20Project%20Asset%20Upload/
---

# PA Project Asset Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-asset-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PA Project Asset Upload
======================
Create, update, or delete project assets and their task assignments for Oracle Projects capital projects, using the public API pa_project_assets_pub.

Supported Actions:
- Create / Update project asset (ESTIMATED or AS-BUILT types only — RETIREMENT_ADJUSTMENT is excluded)
- Add / Delete asset-to-task assignment (top-task rollup or leaf-task)

Row Structure (bundled parent-child):
- One row per (asset, assignment) pair
- Leave Assignment Task Number blank on a row to create/update just the asset header with no assignment
- For multiple assignments on the same asset, repeat the asset columns on subsequent rows with different Task Numbers

Report Parameters:
- Upload Mode: 'Create' or 'Create, Update'
- Operating Unit: filters Project LOV
- Project Number: the capital project (pa_projects_all.segment1) to which uploaded assets belong

Notes:
- Capitalization and Reversal are NOT supported via this upload — use the Capital Assets form for those workflow actions
- The Depreciation Expense Account KFF is resolved against the chart of accounts of the project's ledger
- Asset-to-task assignments do not support an update API — to modify an existing assignment DFF, delete and re-add

## Report Parameters
Upload Mode, Operating Unit, Project Number

## Oracle EBS Tables Used
[pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [pa_project_assets_all](https://www.enginatics.com/library/?pg=1&find=pa_project_assets_all), [pa_project_asset_assignments](https://www.enginatics.com/library/?pg=1&find=pa_project_asset_assignments), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv), [fa_additions_v](https://www.enginatics.com/library/?pg=1&find=fa_additions_v), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/pa-project-asset-upload/) |
| Blitz Report™ XML Import | [PA_Project_Asset_Upload.xml](https://www.enginatics.com/xml/pa-project-asset-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-project-asset-upload/](https://www.enginatics.com/reports/pa-project-asset-upload/) |



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
