---
layout: default
last_modified_at: 2026-10-26
title: 'PA Revenue, Cost, Budgets by Work Breakdown Structure | Oracle EBS SQL Report'
description: 'This Blitz report implements the standard Oracle report: MGT: Revenue, Cost, Budgets by Work Breakdown Structure (XML) The ''Report Level'' parameter…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, R12 only, Revenue,, Cost,, Budgets, Work, pa_proj_info_view, pa_projects, pa_project_types'
permalink: /PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/
report_name: 'PA Revenue, Cost, Budgets by Work Breakdown Structure'
report_web_name: pa-revenue-cost-budgets-by-work-breakdown-structure
module: 'Projects'
module_url: /modules/projects/
---

# PA Revenue, Cost, Budgets by Work Breakdown Structure – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-revenue-cost-budgets-by-work-breakdown-structure/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
This Blitz report implements the standard Oracle report: MGT: Revenue, Cost, Budgets by Work Breakdown Structure (XML)

The 'Report Level' parameter determines if the report is run at the Project Level or Task Level

Report Level Parameter:
Project - will pull back revenue, costs and budgets accumulated at the project level
Task - will pull back revenue, costs and budgets accumulated at the task level

The report has been extended to pull in additional datapoints as displayed in the Project Status Inquiry Form.

Application: Projects
Source: MGT: Revenue, Cost, Budgets by Work Breakdown Structure (XML)
Short Name: PAXBUBSS_XML
DB package: PA_PAXBUBSS_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project Organization, Project Manager, Project Number, Project Name, Project Type, Top Task, Report Level, Explode Subtasks, Cost Budget Type, Revenue Budget Type

## Oracle EBS Tables Used
[pa_proj_info_view](https://www.enginatics.com/library/?pg=1&find=pa_proj_info_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_projects](https://www.enginatics.com/library/?pg=1&find=pa_projects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_project_types](https://www.enginatics.com/library/?pg=1&find=pa_project_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_proj_invoice_summary_view](https://www.enginatics.com/library/?pg=1&find=pa_proj_invoice_summary_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_project_status_controls](https://www.enginatics.com/library/?pg=1&find=pa_project_status_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_project_accum_headers](https://www.enginatics.com/library/?pg=1&find=pa_project_accum_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_project_accum_actuals](https://www.enginatics.com/library/?pg=1&find=pa_project_accum_actuals&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_project_accum_commitments](https://www.enginatics.com/library/?pg=1&find=pa_project_accum_commitments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_project_accum_budgets](https://www.enginatics.com/library/?pg=1&find=pa_project_accum_budgets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [pa_budget_types](https://www.enginatics.com/library/?pg=1&find=pa_budget_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)

## Related Reports
[PA Revenue, Cost, Budgets by Resources](/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/ "PA Revenue, Cost, Budgets by Resources Oracle EBS SQL Report"), [PA Project Billing Status](/PA%20Project%20Billing%20Status/ "PA Project Billing Status Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [PA Project Upload](/PA%20Project%20Upload/ "PA Project Upload Oracle EBS SQL Report"), [PA Project Expenditure Items with WIP and INV Detail](/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/ "PA Project Expenditure Items with WIP and INV Detail Oracle EBS SQL Report"), [PA Event Upload](/PA%20Event%20Upload/ "PA Event Upload Oracle EBS SQL Report"), [AP Expense Report Upload](/AP%20Expense%20Report%20Upload/ "AP Expense Report Upload Oracle EBS SQL Report"), [PA Cost Audit](/PA%20Cost%20Audit/ "PA Cost Audit Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Revenue, Cost, Budgets by Work Breakdown Structure 07-Apr-2018 151227.xlsx](https://www.enginatics.com/example/pa-revenue-cost-budgets-by-work-breakdown-structure/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure) |
| Blitz Report™ XML Import | [PA_Revenue_Cost_Budgets_by_Work_Breakdown_Structure.xml](https://www.enginatics.com/xml/pa-revenue-cost-budgets-by-work-breakdown-structure/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure) |
| SQL Source | [PA Revenue- Cost- Budgets by Work Breakdown Structure.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-revenue-cost-budgets-by-work-breakdown-structure/](https://www.enginatics.com/reports/pa-revenue-cost-budgets-by-work-breakdown-structure/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure) |

## Case Study & Technical Analysis: PA Revenue, Cost, Budgets by Work Breakdown Structure Report

### Executive Summary

The PA Revenue, Cost, Budgets by Work Breakdown Structure report is a fundamental financial analysis and performance monitoring tool for Oracle Projects. It provides a consolidated view of project revenue, costs, and budgets aligned with the project's Work Breakdown Structure (WBS), at both project and task levels. This report is indispensable for project managers, portfolio managers, and financial controllers who need to track the financial performance of projects, identify budget variances, and ensure that projects remain on track and within financial targets, all organized by the structured WBS elements.

### Business Challenge

For projects to be successful, their financial performance must be continuously monitored against the plan, and this monitoring needs to be aligned with how the work itself is structured. Organizations often face several challenges in achieving this visibility:

-   **Fragmented WBS Financials:** While the WBS provides a logical hierarchy for managing project work, consolidating actual costs, recognized revenue, and approved budgets at each WBS element (tasks and subtasks) is often a manual and complex process.
-   **Lack of Drill-Down Capability:** Standard reporting often provides either a high-level project summary or overly granular transaction details, making it difficult to drill down through the WBS to identify where financial performance deviates from the plan.
-   **Inefficient Variance Analysis:** Without a consolidated view, comparing actual expenditures and revenue against the WBS-aligned budget requires significant manual effort, leading to delays in identifying and addressing financial overruns or underperformance.
-   **Supporting Project Governance:** Project steering committees and stakeholders require clear, WBS-driven financial reporting to make informed decisions about project funding, scope changes, and overall project health.

### The Solution

This report offers a powerful, hierarchical financial view of projects, seamlessly integrating financial data with the Work Breakdown Structure.

-   **WBS-Aligned Financials:** It presents revenue, costs, and budgets aggregated by each level of the Work Breakdown Structure, providing a clear and logical framework for financial analysis that mirrors the project's operational structure.
-   **Flexible Reporting Levels:** The "Report Level" parameter allows users to choose between a Project-level summary or a detailed Task-level breakdown. Furthermore, the "Explode Subtasks" parameter enables hierarchical viewing, allowing users to expand or collapse WBS elements to the desired level of detail.
-   **Comprehensive Performance Monitoring:** By consolidating actuals, commitments (where applicable), and budgets for both cost and revenue, the report serves as a complete dashboard for monitoring project financial performance.
-   **Accelerated Decision-Making:** With immediate access to WBS-aligned financial data, project managers can quickly identify problematic areas, such as tasks that are over budget, and take corrective action to keep the project financially healthy.

### Technical Architecture (High Level)

The report is built on an optimized SQL query that leverages Oracle Projects' accumulation tables to efficiently gather and present WBS-driven financial data.

-   **Primary Tables/Views Involved:**
    -   `pa_projects_all` and `pa_tasks` (to define the project and its hierarchical Work Breakdown Structure).
    -   `pa_project_accum_headers` (the central table for summarized project financial data).
    -   `pa_project_accum_actuals` (for actual costs and revenue accumulated by WBS element).
    -   `pa_project_accum_commitments` (for outstanding commitments by WBS element).
    -   `pa_project_accum_budgets` (for budget amounts by WBS element).
    -   `pa_budget_types` (for defining cost and revenue budget versions).
-   **Logical Relationships:** The report builds its structure from `pa_projects_all` and `pa_tasks` to create the WBS hierarchy. It then joins to the various `pa_project_accum_` tables, which store pre-calculated actuals, commitments, and budgets at the lowest task level. The report then dynamically sums or rolls up this data based on the `Report Level` and `Explode Subtasks` parameters to present the aggregated financial picture for each WBS element.

### Parameters & Filtering

The report offers a rich set of parameters to precisely control the scope and detail of the financial analysis:

-   **Organizational & Project Filters:** `Operating Unit`, `Project Organization`, `Project Manager`, `Project Number`, `Project Name`, and `Project Type` to narrow down the report's focus.
-   **WBS Control:** `Top Task` allows focusing on a specific branch of the WBS. `Report Level` (Project or Task) and `Explode Subtasks` are critical for controlling the hierarchical display.
-   **Budget Version Selection:** `Cost Budget Type` and `Revenue Budget Type` enable users to specify which versions of the project budget to include in the analysis (e.g., 'Approved Budget', 'Latest Forecast').

### Performance & Optimization

This report is designed for efficient processing of complex, hierarchical financial data.

-   **Leveraging Accumulation Tables:** By utilizing Oracle Projects' `pa_project_accum_*` tables, the report benefits from data that is already summarized and pre-calculated by Oracle's standard processes. This significantly reduces the processing load during report execution.
-   **Indexed WBS Navigation:** The queries are designed to efficiently navigate the WBS hierarchy using indexes on task and project IDs, ensuring rapid retrieval and aggregation of data, especially when using the `Explode Subtasks` option.
-   **Parameter-Driven Efficiency:** Limiting the report's scope using parameters like `Project Number` and `Top Task` significantly improves performance, allowing users to focus on specific areas of interest without processing unnecessary data.

### FAQ

**1. How does the "Explode Subtasks" parameter work?**
   When `Explode Subtasks` is set to 'Yes', the report will display the full hierarchy of tasks and subtasks below the selected project or top task. This allows for detailed financial analysis at every level of the Work Breakdown Structure. When set to 'No', it typically shows only the financial data at the level of the tasks directly under the selected project or parent task, without expanding further down the hierarchy.

**2. Can this report be used to track Earned Value Management (EVM) metrics?**
   While this report provides the foundational data (Planned Value from budget, Actual Cost from actuals), it does not directly calculate all standard EVM metrics like Earned Value, Cost Variance, or Schedule Variance. However, the data provided is perfectly suited to be exported to Excel for such calculations and further EVM analysis.

**3. What is the difference in data between this report and the "Revenue, Cost, Budgets by Resources" report?**
   The primary difference is the grouping of the data. This report (`by Work Breakdown Structure`) aggregates and presents financial information according to the project's task hierarchy (WBS). The `by Resources` report, in contrast, aggregates and presents the same financial information by the specific resources used (e.g., specific labor categories, types of materials, or equipment), regardless of where they fall in the WBS.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-work-breakdown-structure)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
