---
layout: default
last_modified_at: 2026-10-16
title: 'PA Project Asset Upload | Oracle EBS SQL Report'
description: 'PA Project Asset Upload ====================== Create, update, or delete project assets and their task assignments for Oracle Projects capital projects…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Project, Asset, pa_project_asset_assignments, pa_projects_all, hr_all_organization_units_vl'
permalink: /PA%20Project%20Asset%20Upload/
report_name: 'PA Project Asset Upload'
report_web_name: pa-project-asset-upload
---

# PA Project Asset Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Project Number

## Oracle EBS Tables Used
[pa_project_asset_assignments](https://www.enginatics.com/library/?pg=1&find=pa_project_asset_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [pa_project_assets_all](https://www.enginatics.com/library/?pg=1&find=pa_project_assets_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [fa_additions_v](https://www.enginatics.com/library/?pg=1&find=fa_additions_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Asset%20Upload/PA%20Project%20Asset%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-project-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload) |
| Blitz Report™ XML Import | [PA_Project_Asset_Upload.xml](https://www.enginatics.com/xml/pa-project-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload) |
| SQL Source | [PA Project Asset Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Asset%20Upload/PA%20Project%20Asset%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-project-asset-upload/](https://www.enginatics.com/reports/pa-project-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload) |

## Case Study & Technical Analysis: PA Project Asset Upload

### Executive Summary
The PA Project Asset Upload creates, updates and deletes project assets, and their asset-to-task assignments, for capital projects in Oracle Projects. It uses the public Project Asset API, so the spreadsheet loads assets through the same business rules as the Capital Assets form. Capital accountants and project controllers use it to load estimated and as-built assets for a project in bulk, to link them to top tasks or leaf tasks, and to maintain their descriptive flexfield values. The report runs in Excel via Blitz Report. Capitalization and reversal are not supported by this upload and must still be performed in the Capital Assets form.

### Business Challenge
*   **Bulk asset loading:** Capital projects often carry many estimated or as-built assets, and entering them one at a time is slow and error-prone.
*   **Asset-to-task traceability:** Each asset must be assigned to the task that incurs its cost, so the assignments must be correct before capitalization.
*   **Asset attributes:** Depreciation, expense account, location, employee and descriptive flexfield values must be consistent with the Fixed Assets book and the chart of accounts.
*   **Workflow boundaries:** Capitalization and reversal are workflow actions that remain in the form, so the upload must be kept to asset setup.

### The Solution
*   **Two-level row model:** Each row is one asset and assignment pair, and blank assignment columns create only the asset header.
*   **Public API processing:** Assets and assignments are created or updated through the public Projects asset API.
*   **Assignment control:** Top-task rollup or leaf-task assignments can be added, and existing assignments can be deleted.
*   **Reference data resolution:** Asset category, asset key, location, depreciation expense account and assigned employee are shown with readable segment and person names.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_PROJECT_ASSETS_ALL`: the project asset header, including asset type, name, units, estimated and actual cost, dates and flags.
*   `PA_PROJECT_ASSET_ASSIGNMENTS`: the asset-to-task assignments, with their descriptive flexfield values.
*   `PA_PROJECTS_ALL`: the project number and name.
*   `PA_TASKS`: the assigned task, with the top task identifier used to flag rollup assignments.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the project.
*   `FA_CATEGORIES_B_KFV`, `FA_ASSET_KEYWORDS_KFV`, `FA_LOCATIONS_KFV`, `FA_ADDITIONS_V`: asset category, asset key, location and parent asset in the Fixed Assets module.
*   `GL_CODE_COMBINATIONS_KFV`: the depreciation expense account.
*   `PER_ALL_PEOPLE_F`: the assigned employee, valid on the current date.

#### Logical Relationships
1. `PA_PROJECTS_ALL` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on organization, and to `PA_PROJECT_ASSETS_ALL` on project identifier.
2. Only assets of type AS-BUILT or ESTIMATED are included.
3. `PA_PROJECT_ASSETS_ALL` is outer joined to `PA_PROJECT_ASSET_ASSIGNMENTS` on project asset identifier, and the assignment to `PA_TASKS` on task identifier.
4. The category, asset key and location are outer joined from the Fixed Assets key-flexfield views on their identifiers.
5. The parent asset is outer joined to `FA_ADDITIONS_V`, and the depreciation expense account to `GL_CODE_COMBINATIONS_KFV`.
6. The assigned employee is outer joined to `PER_ALL_PEOPLE_F` with the effective date condition on the current date.

### Parameters & Filtering
*   **Upload Mode:** Create or Create, Update, which controls whether existing assets can be changed by the upload.
*   **Operating Unit:** Filters the project list of values to the chosen operating unit.
*   **Project Number:** Identifies the capital project to which the uploaded assets belong.

The SQL text does not reference these parameters through bind variables; the description states that the operating unit filters the project list of values and the project number identifies the project.

### Performance & Optimization
*   The query is restricted to one project's operating unit through the joins from the project header, so it reads only that project's assets.
*   Asset type filtering on AS-BUILT and ESTIMATED is applied in the main predicate, which excludes other asset types before the lookups.
*   Key-flexfield and employee lookups are outer joins on keyed identifiers, and the employee join is limited to the valid date range of the current day.
*   The assignment outer join returns one row per assignment, so an asset with several tasks appears on several rows, as described in the upload notes.

### FAQ
**Q: Can this upload capitalize or reverse project assets?**
A: No. The description states that capitalization and reversal are not supported and must be done in the Capital Assets form.

**Q: How do I change the descriptive flexfield on an existing asset assignment?**
A: The assignment has no update API, so the description says to delete the assignment and add it again with the new values.

**Q: How do I assign one asset to several tasks in the same upload?**
A: Repeat the asset columns on subsequent rows with different Task Numbers, leaving the asset header columns populated on each row.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-asset-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
