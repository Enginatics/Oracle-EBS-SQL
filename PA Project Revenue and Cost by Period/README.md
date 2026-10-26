---
layout: default
last_modified_at: 2026-10-26
title: 'PA Project Revenue and Cost by Period | Oracle EBS SQL Report'
description: 'Revenue, raw cost, burdened cost and margin per project and top task for each GL or PA period, in the project functional currency. Cost is taken from the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, Project, Revenue, Cost, Period, pa_cost_distribution_lines_all, pa_tasks, pa_draft_revenues_all'
permalink: /PA%20Project%20Revenue%20and%20Cost%20by%20Period/
report_name: 'PA Project Revenue and Cost by Period'
report_web_name: pa-project-revenue-and-cost-by-period
module: 'Projects'
module_url: /modules/projects/
---

# PA Project Revenue and Cost by Period – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-revenue-and-cost-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
Revenue, raw cost, burdened cost and margin per project and top task for each GL or PA period, in the project functional currency.

Cost is taken from the raw cost distribution lines of all expenditure items, revenue from the released draft revenue of expenditure items and events. Period Basis decides whether amounts are assigned to periods by their GL date and the ledger's accounting periods, or by their PA date and the PA periods. A date range that starts or ends inside a period includes only part of that period.

Event revenue entered at project level shows a blank top task. Run over all periods, the totals agree with the inception-to-date actuals of Update Project Summary Amounts as of its last run.

The templates Pivot: by Period and Pivot: by Year show projects against periods or fiscal years.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project Type, Project Status, Project, Period Basis, Date From, Date To

## Oracle EBS Tables Used
[pa_cost_distribution_lines_all](https://www.enginatics.com/library/?pg=1&find=pa_cost_distribution_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_draft_revenues_all](https://www.enginatics.com/library/?pg=1&find=pa_draft_revenues_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_cust_rev_dist_lines_all](https://www.enginatics.com/library/?pg=1&find=pa_cust_rev_dist_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_cust_event_rdl_all](https://www.enginatics.com/library/?pg=1&find=pa_cust_event_rdl_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_project_statuses](https://www.enginatics.com/library/?pg=1&find=pa_project_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [pa_implementations_all](https://www.enginatics.com/library/?pg=1&find=pa_implementations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [XLA Distribution Links Summary](/XLA%20Distribution%20Links%20Summary/ "XLA Distribution Links Summary Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Revenue%20and%20Cost%20by%20Period/PA%20Project%20Revenue%20and%20Cost%20by%20Period.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Project Revenue and Cost by Period 21-Oct-2026 031539.xlsx](https://www.enginatics.com/example/pa-project-revenue-and-cost-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period) |
| Blitz Report™ XML Import | [PA_Project_Revenue_and_Cost_by_Period.xml](https://www.enginatics.com/xml/pa-project-revenue-and-cost-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period) |
| SQL Source | [PA Project Revenue and Cost by Period.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Revenue%20and%20Cost%20by%20Period/PA%20Project%20Revenue%20and%20Cost%20by%20Period.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-project-revenue-and-cost-by-period/](https://www.enginatics.com/reports/pa-project-revenue-and-cost-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-revenue-and-cost-by-period)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
