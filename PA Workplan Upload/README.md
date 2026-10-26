---
layout: default
last_modified_at: 2026-10-26
title: 'PA Workplan Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes the resource assignments of workplan tasks as on the Projects HTML workplan pages (Workplan > Tasks > Task Assignments)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Workplan, hr_all_organization_units_vl, pa_projects_all, pa_budget_versions'
permalink: /PA%20Workplan%20Upload/
report_name: 'PA Workplan Upload'
report_web_name: pa-workplan-upload
---

# PA Workplan Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-workplan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload).

## Overview
Creates, updates and deletes the resource assignments of workplan tasks as on the Projects HTML workplan pages (Workplan > Tasks > Task Assignments), using pa_task_assignments_pub.

The assignments are maintained on the current working workplan version, or on the published version when workplan versioning is disabled for the project. Planning resources come from the resource list of the workplan plan type. Planned cost of a rate based resource is calculated from the planned quantity.

The resource of an existing assignment cannot be changed: delete the assignment and create a new one. Publish Workplan publishes the workplan version once all rows of the project uploaded successfully.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Project Number, Task Number

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_budget_versions](https://www.enginatics.com/library/?pg=1&find=pa_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_proj_elem_ver_structure](https://www.enginatics.com/library/?pg=1&find=pa_proj_elem_ver_structure&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_fin_plan_types_vl](https://www.enginatics.com/library/?pg=1&find=pa_fin_plan_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_resource_assignments](https://www.enginatics.com/library/?pg=1&find=pa_resource_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_proj_elements](https://www.enginatics.com/library/?pg=1&find=pa_proj_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_resource_list_members](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_members&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [pa_resource_classes_vl](https://www.enginatics.com/library/?pg=1&find=pa_resource_classes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)

## Related Reports
[PA Budget Upload](/PA%20Budget%20Upload/ "PA Budget Upload Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Resources](/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/ "PA Revenue, Cost, Budgets by Resources Oracle EBS SQL Report"), [PA Project Budget](/PA%20Project%20Budget/ "PA Project Budget Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Work Breakdown Structure](/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/ "PA Revenue, Cost, Budgets by Work Breakdown Structure Oracle EBS SQL Report"), [PA Project Upload](/PA%20Project%20Upload/ "PA Project Upload Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PA Project Billing Status](/PA%20Project%20Billing%20Status/ "PA Project Billing Status Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Workplan%20Upload/PA%20Workplan%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-workplan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload) |
| Blitz Report™ XML Import | [PA_Workplan_Upload.xml](https://www.enginatics.com/xml/pa-workplan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload) |
| SQL Source | [PA Workplan Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Workplan%20Upload/PA%20Workplan%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-workplan-upload/](https://www.enginatics.com/reports/pa-workplan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-workplan-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
