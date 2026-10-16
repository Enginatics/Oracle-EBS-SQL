---
layout: default
last_modified_at: 2026-10-16
title: 'PA Revenue, Cost, Budgets by Resources | Oracle EBS SQL Report'
description: 'This Blitz Report is the implements the following standard oracle reports. - MGT: Task - Revenue, Cost, Budgets by Resources - MGT: Revenue, Cost, Budgets…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, R12 only, Revenue,, Cost,, Budgets, Resources, pa_proj_info_view, pa_projects, pa_project_types'
permalink: /PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/
report_name: 'PA Revenue, Cost, Budgets by Resources'
report_web_name: pa-revenue-cost-budgets-by-resources
module: 'Projects'
module_url: /modules/projects/
---

# PA Revenue, Cost, Budgets by Resources – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-revenue-cost-budgets-by-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
This Blitz Report is the implements the following standard oracle reports.

- MGT: Task - Revenue, Cost, Budgets by Resources
- MGT: Revenue, Cost, Budgets by Resources (Project Level)

The 'Report Level' parameter determines if the report is run at the Project Level or Task Level

Report Level Parameter:
Project - equivalent to running the MGT: Revenue, Cost, Budgets by Resources (Project Level) report
Task - equivalent to running the MGT: Task - Revenue, Cost, Budgets by Resources report

The report has been extended to pull in additional datapoints as displayed in the Project Status Inquiry Form.

Application: Projects
Source: MGT: Task - Revenue, Cost, Budgets by Resources (XML)
Short Name: PAXMGTSD_XML
DB package: PA_PAXMGTSD_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project Organization, Project Manager, Project Number, Project Name, Task Number, Report Level, Cost Budget Type, Revenue Budget Type, Period Name

## Oracle EBS Tables Used
[pa_proj_info_view](https://www.enginatics.com/library/?pg=1&find=pa_proj_info_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_projects](https://www.enginatics.com/library/?pg=1&find=pa_projects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_project_types](https://www.enginatics.com/library/?pg=1&find=pa_project_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_proj_invoice_summary_view](https://www.enginatics.com/library/?pg=1&find=pa_proj_invoice_summary_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_project_status_controls](https://www.enginatics.com/library/?pg=1&find=pa_project_status_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_project_accum_headers](https://www.enginatics.com/library/?pg=1&find=pa_project_accum_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_resource_list_assignments](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_resource_list_uses](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_uses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_budget_types](https://www.enginatics.com/library/?pg=1&find=pa_budget_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_resource_list_members](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_members&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_accum_rsrc_act_v](https://www.enginatics.com/library/?pg=1&find=pa_accum_rsrc_act_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_accum_rsrc_cmt_v](https://www.enginatics.com/library/?pg=1&find=pa_accum_rsrc_cmt_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_accum_rsrc_cost_bgt_v](https://www.enginatics.com/library/?pg=1&find=pa_accum_rsrc_cost_bgt_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [pa_accum_rsrc_rev_bgt_v](https://www.enginatics.com/library/?pg=1&find=pa_accum_rsrc_rev_bgt_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)

## Related Reports
[PA Revenue, Cost, Budgets by Work Breakdown Structure](/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/ "PA Revenue, Cost, Budgets by Work Breakdown Structure Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [PA Project Billing Status](/PA%20Project%20Billing%20Status/ "PA Project Billing Status Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-revenue-cost-budgets-by-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources) |
| Blitz Report™ XML Import | [PA_Revenue_Cost_Budgets_by_Resources.xml](https://www.enginatics.com/xml/pa-revenue-cost-budgets-by-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources) |
| SQL Source | [PA Revenue- Cost- Budgets by Resources.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-revenue-cost-budgets-by-resources/](https://www.enginatics.com/reports/pa-revenue-cost-budgets-by-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources) |

## Case Study & Technical Analysis: PA Revenue, Cost, Budgets by Resources Report

### Executive Summary

The PA Revenue, Cost, Budgets by Resources report is a powerful, consolidated financial analysis tool for Oracle Projects. It unifies actual costs, commitments, and budget information at both the project and task levels, broken down by resource. This report, an enhanced implementation of standard Oracle Projects reports, provides project managers, financial analysts, and executives with a critical, real-time view of project performance. It is indispensable for robust financial tracking, proactive management of project profitability, and informed decision-making.

### Business Challenge

Effective project financial management requires a clear, holistic understanding of a project's financial health. However, in standard Oracle Projects, this information is often fragmented and difficult to consolidate:

-   **Fragmented Financial View:** Project financial data (actual costs, open commitments, budget plan, and recognized revenue) resides in different tables and is typically viewed through separate reports or screens, making it challenging to get a single, consolidated picture.
-   **Lack of Real-time Performance Insight:** Without a unified report, project managers often lack immediate insight into how their project is performing against its budget or how commitments are impacting future cash flow.
-   **Tedious Reporting and Consolidation:** Manually extracting and consolidating actuals, budgets, and commitments into spreadsheets for variance analysis is a time-consuming, error-prone process, leading to delayed reporting.
-   **Difficulty at Different Levels:** Analyzing financial performance at both a high project level and a granular task level, broken down by specific resources (e.g., labor, materials), is a complex reporting requirement that standard tools often struggle to meet efficiently.

### The Solution

This report provides a dynamic and comprehensive financial dashboard for Oracle Projects, bringing together critical data points for superior project oversight.

-   **Unified Financial View:** It consolidates actual costs, recognized revenue, open commitments, and budget amounts into a single, cohesive report. This allows for immediate variance analysis and a complete understanding of project financial health.
-   **Flexible Reporting Level:** The crucial "Report Level" parameter allows users to switch between a summary view at the Project Level or a detailed breakdown at the Task Level, providing the right granularity of information for different stakeholders.
-   **Resource-Centric Analysis:** By categorizing financial data by resource (e.g., specific job roles, material types), project managers can quickly identify where costs are being incurred, where budget is being consumed, and how resources are impacting profitability.
-   **Enhanced Project Status Inquiry:** Beyond standard report data, it includes additional data points typically found in the Oracle Project Status Inquiry (PSI) form, enriching the analysis and providing a more complete picture of project performance.

### Technical Architecture (High Level)

The report is built upon a sophisticated SQL query that integrates data from various Oracle Projects accumulation and budget tables.

-   **Primary Tables/Views Involved:**
    -   `pa_projects_all` and `pa_tasks` (for project and task hierarchy details).
    -   `pa_project_accum_headers` (central table for project financial accumulations).
    -   `pa_accum_rsrc_act_v` (view for accumulated actuals by resource).
    -   `pa_accum_rsrc_cmt_v` (view for accumulated commitments by resource).
    -   `pa_accum_rsrc_cost_bgt_v` (view for cost budget by resource).
    -   `pa_accum_rsrc_rev_bgt_v` (view for revenue budget by resource).
    -   `pa_budget_types` and `pa_resource_list_members` (for budget type and resource definitions).
-   **Logical Relationships:** The core logic involves joining the project and task structures with the various resource-level accumulation views. These views provide pre-aggregated actual, commitment, cost budget, and revenue budget data. The report then dynamically filters and aggregates this information based on the chosen `Report Level` (Project or Task) and specified `Budget Types`.

### Parameters & Filtering

The report offers a robust set of parameters for precise data extraction and analysis:

-   **Organizational Filters:** `Operating Unit`, `Project Organization`, and `Project Manager` allow for drilling down into specific areas of responsibility.
-   **Project/Task Selection:** `Project Number`, `Project Name`, and `Task Number` enable users to target specific projects or elements within the project hierarchy.
-   **Report Level:** The critical parameter to toggle between `Project` summary and `Task` detail views.
-   **Budget Types:** `Cost Budget Type` and `Revenue Budget Type` allow for specifying which budget versions should be used for comparison (e.g., 'Approved Cost Budget', 'Forecast').
-   **Period Name:** Enables time-phased analysis for a specific accounting period.

### Performance & Optimization

The report is optimized to efficiently handle complex aggregations across multiple financial categories.

-   **Leveraging Accumulation Tables/Views:** The report utilizes Oracle Projects' pre-accumulated data in views like `pa_accum_rsrc_act_v`. This significantly speeds up the retrieval of summed actuals, commitments, and budgets, as the heavy lifting of aggregation is done by Oracle's processes, not during report execution.
-   **Indexed Joins:** The underlying queries are designed to use indexes on project, task, and resource IDs, ensuring fast joins between the various data sources.
-   **Controlled Data Volume:** Parameters like `Project Number` and `Period Name` allow users to limit the scope of the report, preventing it from attempting to process an excessively large dataset when detailed analysis is not required.

### FAQ

**1. What is the difference between "Actual Costs" and "Commitments"?**
   "Actual Costs" represent expenditures that have already been incurred and posted to the General Ledger (e.g., an approved supplier invoice or employee timesheet). "Commitments" represent future obligations or planned expenditures that have not yet become actuals (e.g., a purchase order that has been approved but not yet invoiced). This report allows you to view both for a holistic financial picture.

**2. How does the report determine which "Budget Type" to display?**
   The report uses the `Cost Budget Type` and `Revenue Budget Type` parameters. Users typically define different budget types (e.g., "Approved Budget," "Working Budget," "Forecast 1," "Forecast 2") to track different versions of their financial plans. The report allows you to select which specific budget version to compare against actuals and commitments.

**3. Can this report show variance between budget and actuals?**
   Yes, by showing budget amounts alongside actual costs and recognized revenue, the report inherently facilitates variance analysis. Users can easily export the data to Excel to calculate and visualize variances by resource, task, or project, and investigate where deviations from the plan are occurring.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-revenue-cost-budgets-by-resources)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
