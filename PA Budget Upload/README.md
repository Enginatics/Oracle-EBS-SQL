---
layout: default
last_modified_at: 2026-10-19
title: 'PA Budget Upload | Oracle EBS SQL Report'
description: 'The PA Budget Upload supports the creation/update of standard project budgets. At this stage it does not support the creation/update of Financial Plan…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Budget, hr_all_organization_units_vl, pa_projects_all, pa_budget_versions'
permalink: /PA%20Budget%20Upload/
report_name: 'PA Budget Upload'
report_web_name: pa-budget-upload
---

# PA Budget Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-budget-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload).

## Overview
The PA Budget Upload supports the creation/update of standard project budgets. 

At this stage it does not support the creation/update of Financial Plan Budgets.

The PA Budget Upload allows users to:

- Create new working budgets.

When creating a new working budget, any existing working budget for the specified Project and Budget Type will be overwritten.

The upload allows the user to create a working budget either by entering the data directly into an empty upload excel file, or by copying a prior version of the budget and modifying this in the upload excel file.

- Update existing working budgets.

This option allows for the update of an existing working budget. In this mode the existing budget is retained, and the update mode allows for individual budget lines to be added, updated, and/or deleted from the existing working budget.

- Additionally, the upload allows users to Baseline a Working Budget.

Working Budgets can be uploaded against the Projects belonging to the Operating Units accessible to the responsibility in which the PA Budget Upload process is run.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Product Source, Copy Existing Budget, Operating Unit, Project Number, Project Name, Budget Type, Budget Version, Task Number, Task Name, Resource Alias, Period From, Period To, Budget Line Start Date, Budget Line End Date, Budget Line Active On Date, Sort Precedence 1, Sort Precedence 2, Sort Precedence 3

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_budget_versions](https://www.enginatics.com/library/?pg=1&find=pa_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_budget_types](https://www.enginatics.com/library/?pg=1&find=pa_budget_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_budget_entry_methods](https://www.enginatics.com/library/?pg=1&find=pa_budget_entry_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_resource_lists](https://www.enginatics.com/library/?pg=1&find=pa_resource_lists&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_resource_assignments](https://www.enginatics.com/library/?pg=1&find=pa_resource_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_budget_lines](https://www.enginatics.com/library/?pg=1&find=pa_budget_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [pa_resource_list_members](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_members&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)

## Related Reports
[PA Project Budget](/PA%20Project%20Budget/ "PA Project Budget Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Resources](/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/ "PA Revenue, Cost, Budgets by Resources Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Work Breakdown Structure](/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/ "PA Revenue, Cost, Budgets by Work Breakdown Structure Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Budget%20Upload/PA%20Budget%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-budget-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload) |
| Blitz Report™ XML Import | [PA_Budget_Upload.xml](https://www.enginatics.com/xml/pa-budget-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload) |
| SQL Source | [PA Budget Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Budget%20Upload/PA%20Budget%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-budget-upload/](https://www.enginatics.com/reports/pa-budget-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload) |

## Case Study & Technical Analysis: PA Budget Upload

### Executive Summary
The PA Budget Upload creates and updates standard working budgets on Oracle Projects, the project budgets used to plan cost and revenue by task and resource. The upload can create a new working budget, either from an empty file or by copying a prior version, update the lines of an existing working budget by adding, changing or deleting them, and baseline a working budget. Financial Plan budgets are not supported. The upload works only on projects belonging to the operating units accessible to the responsibility from which it is run, and it sits in the Projects module.

### Business Challenge
*   **Annual budget loading:** Each planning cycle requires budgets for many projects, and entering budget lines individually is slow.
*   **Revising budgets without losing history:** Budget changes need to be applied to an existing working budget line by line, while keeping the existing budget in place.
*   **Consistent resource structure:** Budget lines must reference the correct resource alias and task, so the budget matches the resource list used for the project.

### The Solution
*   **Create from scratch or copy:** A new working budget can be entered in an empty file or created from a copy of a prior version, which is then edited in the file.
*   **Line-level update:** In update mode, individual budget lines can be added, changed or flagged for deletion, while the rest of the working budget is retained.
*   **Resource and task context:** Each line shows the task number and name, the resource alias path from the resource list and the period, with raw cost, burdened cost, revenue and quantity.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_PROJECTS_ALL`: the projects that carry the budgets.
*   `PA_BUDGET_VERSIONS`: the budget header, holding the version name, status, entry method, resource list and change reason.
*   `PA_RESOURCE_LISTS`: the resource list the budget is based on.
*   `PA_RESOURCE_ASSIGNMENTS`: the resource assignments that link a budget to tasks and resources.
*   `PA_BUDGET_LINES`: the budget lines, with period, dates, cost, revenue and quantity.
*   `PA_TASKS`: the project tasks referenced by the assignments.
*   `PA_RESOURCE_LIST_MEMBERS`: the resource list members, traversed as a hierarchy to build the alias path.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating units of the projects.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the organisations accessible to the current user.

#### Logical Relationships
1. `PA_PROJECTS_ALL` joins to `PA_BUDGET_VERSIONS` on the project identifier, and the operating unit is joined through `HR_ALL_ORGANIZATION_UNITS_VL`.
2. Budget versions join to `PA_BUDGET_TYPES`, `PA_BUDGET_ENTRY_METHODS` and `PA_RESOURCE_LISTS` on their code and identifier columns.
3. Budget versions join to `PA_RESOURCE_ASSIGNMENTS` as an outer join, on the version and project identifiers.
4. Assignments join to `PA_BUDGET_LINES` as an outer join on the resource assignment identifier, and to `PA_TASKS` on the task identifier.
5. The resource alias path is built from `PA_RESOURCE_LIST_MEMBERS` by a hierarchical query, and joined to the assignment on the resource list member identifier.

### Parameters & Filtering
*   **Upload Mode:** Chooses between create and update. Update returns budgets whose status is working or submitted, and create returns budgets only when copying is selected.
*   **Product Source:** Restricts the budgets to one source product code.
*   **Copy Existing Budget:** Controls whether an existing budget is returned as the template for a new one.
*   **Operating Unit:** Restricts the output to projects in one operating unit.
*   **Project Number and Project Name:** Identify the projects whose budgets are returned.
*   **Budget Type and Budget Version:** Select one budget type and version.
*   **Resource Alias:** Restricts the lines to one resource from the resource list.
*   **Period From and Period To:** Bound the periods of the budget lines.

### Performance & Optimization
*   **Status-based driver:** Update mode is limited to working and submitted budget versions, so baselined budgets are not returned for editing.
*   **Organisation access filter:** Projects are restricted to the operating units accessible to the current user, so only permitted budgets are read.
*   **Outer joins for new lines:** Assignments and lines are attached with outer joins, so a budget version without lines still appears and can be populated.

### FAQ
**Q: How do I load a new working budget for many projects in Oracle Projects?**
A: Run PA Budget Upload in create mode, enter the budget lines in the file, and upload it. Any existing working budget for the same project and budget type is overwritten.

**Q: Can I change one line of an existing budget without replacing it?**
A: Yes. In update mode the existing budget is retained, and individual lines can be added, updated or flagged for deletion.

**Q: Does this upload handle Financial Plan budgets?**
A: No. The description states that the upload supports standard project budgets only, and does not create or update Financial Plan budgets at this stage.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-budget-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
