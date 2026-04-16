---
layout: default
title: 'PA Project Budget | Oracle EBS SQL Report'
description: 'Report of Standard Project Budgets. This report does not include Financial Plan Budgets. In addition to the budget details, the report will also display…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Project, Budget, hr_all_organization_units_vl, pa_projects_all, pa_budget_versions'
permalink: /PA%20Project%20Budget/
---

# PA Project Budget – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-budget/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report of Standard Project Budgets. This report does not include Financial Plan Budgets.
In addition to the budget details, the report will also display the actuals matching the budget line datapoints.
Note: Inclusion of actuals data requires Blitz Report Build Data later than 04-APR-2025 03:21:50


## Report Parameters
Operating Unit, Project Number, Project Name, Budget Type, Budget Status, Latest Budget Version, Budget Version, Task Number, Task Name, Resource Alias, Period From, Period To, Budget Line Start Date, Budget Line End Date, Budget Line Active On Date, Show DFF Attributes, Show Actuals, Sort Precedence 1, Sort Precedence 2, Sort Precedence 3

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_budget_versions](https://www.enginatics.com/library/?pg=1&find=pa_budget_versions), [pa_budget_types](https://www.enginatics.com/library/?pg=1&find=pa_budget_types), [pa_budget_entry_methods](https://www.enginatics.com/library/?pg=1&find=pa_budget_entry_methods), [pa_resource_lists](https://www.enginatics.com/library/?pg=1&find=pa_resource_lists), [pa_resource_assignments](https://www.enginatics.com/library/?pg=1&find=pa_resource_assignments), [pa_budget_lines](https://www.enginatics.com/library/?pg=1&find=pa_budget_lines), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [pa_resource_list_members](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_members), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PA Project Budget Upload](/PA%20Project%20Budget%20Upload/ "PA Project Budget Upload Oracle EBS SQL Report"), [PA Budget Upload](/PA%20Budget%20Upload/ "PA Budget Upload Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Project Budget 04-Apr-2026 023352.xlsx](https://www.enginatics.com/example/pa-project-budget/) |
| Blitz Report™ XML Import | [PA_Project_Budget.xml](https://www.enginatics.com/xml/pa-project-budget/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-project-budget/](https://www.enginatics.com/reports/pa-project-budget/) |

## PA Project Budget - Case Study & Technical Analysis

### Executive Summary
The **PA Project Budget** report is a cornerstone of project financial management within Oracle Projects. It provides project managers and financial controllers with a detailed view of project budgets, enabling them to monitor planned spending against actual costs. By supporting multiple budget types (Cost, Revenue) and versions (Baselined, Current Working), this report ensures that organizations can maintain strict financial discipline over their project portfolios.

### Business Challenge
Project-driven organizations often struggle with:
*   **Budget Visibility:** Difficulty in accessing the latest approved budget figures across hundreds of active projects.
*   **Version Control:** Confusion arising from multiple budget versions (Original vs. Current vs. Draft).
*   **Granularity:** Inability to drill down from a project-level budget to specific tasks or resources.
*   **Variance Analysis:** Challenges in aligning budget lines with actual expenditure for timely variance reporting.

### Solution
This SQL-based report solves these challenges by extracting comprehensive budget details directly from the Oracle Projects schema. It allows users to:
*   **Compare Versions:** View different budget versions side-by-side to understand scope changes.
*   **Analyze by Resource:** Break down budgets by resource list members (Labor, Material, Equipment) to identify cost drivers.
*   **Track Status:** Filter budgets by status (Baselined, Submitted, Working) to ensure reporting on the correct data set.
*   **Integrate Actuals:** (Optional) Map budget lines to actuals for immediate performance assessment.

### Technical Architecture
The report leverages the core Oracle Projects budget model, linking projects, tasks, and resource assignments to budget lines.

#### Key Tables & Views
| Table Name | Description |
| :--- | :--- |
| `PA_PROJECTS_ALL` | The master table for project definitions. |
| `PA_BUDGET_VERSIONS` | Stores header information for each budget version (e.g., Version Number, Status). |
| `PA_BUDGET_TYPES` | Defines the type of budget (e.g., Approved Cost, Approved Revenue). |
| `PA_RESOURCE_ASSIGNMENTS` | Links budget amounts to specific resources and tasks. |
| `PA_BUDGET_LINES` | Contains the periodic budget amounts (Raw Cost, Burdened Cost, Revenue) and dates. |
| `PA_TASKS` | Provides the Work Breakdown Structure (WBS) hierarchy. |

#### Core Logic
1.  **Project & Task Context:** The query starts with `PA_PROJECTS_ALL` and joins to `PA_TASKS` to establish the WBS context.
2.  **Budget Version Selection:** It filters `PA_BUDGET_VERSIONS` based on the user's selection (e.g., "Current Baselined" or specific version number).
3.  **Resource Mapping:** `PA_RESOURCE_ASSIGNMENTS` connects the budget version to the specific resources being budgeted.
4.  **Line Detail:** `PA_BUDGET_LINES` provides the granular period-by-period financial data.

### FAQ
**Q: Does this report show both Cost and Revenue budgets?**
A: Yes, the report can be filtered by `Budget Type` to show Cost, Revenue, or both.

**Q: Can I see the "Original" budget vs the "Current" budget?**
A: Yes, the report parameters allow selection of specific budget versions or dynamic selection of the "Latest Baselined" version.

**Q: How are "Actuals" handled in this report?**
A: The report includes logic to fetch actuals matching the budget line datapoints, provided the Blitz Report Build Data is up to date.

**Q: Does it support multi-currency budgets?**
A: Yes, the underlying tables (`PA_BUDGET_LINES`) store amounts in transaction, project, and project functional currencies.


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
