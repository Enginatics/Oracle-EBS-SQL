---
layout: default
last_modified_at: 2026-10-26
title: 'CRP Available Resources | Oracle EBS SQL Report'
description: 'Detail report showing the date range availability of each resource, as well as daily hours and unit capacity of the resource.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Capacity, Enginatics, CRP, Available, Resources, mtl_parameters, crp_available_resources, bom_departments'
permalink: /CRP%20Available%20Resources/
report_name: 'CRP Available Resources'
report_web_name: crp-available-resources
module: 'Capacity'
module_url: /modules/capacity/
---

# CRP Available Resources – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/crp-available-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources).
**Oracle EBS module:** [Capacity](/modules/capacity/ "Oracle EBS Capacity reports") · [all Capacity reports](/modules/capacity/)  

## Overview
Detail report showing the date range availability of each resource, as well as daily hours and unit capacity of the resource.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Plan, Department, Resource

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources), [crp_available_resources](https://www.enginatics.com/library/?pg=1&find=crp_available_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)

## Related Reports
[BOM Department Upload](/BOM%20Department%20Upload/ "BOM Department Upload Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [WIP Resource Transactions](/WIP%20Resource%20Transactions/ "WIP Resource Transactions Oracle EBS SQL Report"), [CST Department Overhead Rate Upload](/CST%20Department%20Overhead%20Rate%20Upload/ "CST Department Overhead Rate Upload Oracle EBS SQL Report"), [BOM Routings](/BOM%20Routings/ "BOM Routings Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CRP%20Available%20Resources/CRP%20Available%20Resources.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CRP Available Resources 14-May-2018 005901.xlsx](https://www.enginatics.com/example/crp-available-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources) |
| Blitz Report™ XML Import | [CRP_Available_Resources.xml](https://www.enginatics.com/xml/crp-available-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources) |
| SQL Source | [CRP Available Resources.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CRP%20Available%20Resources/CRP%20Available%20Resources.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/crp-available-resources/](https://www.enginatics.com/reports/crp-available-resources/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources) |

## Executive Summary
The **CRP Available Resources** report is a fundamental tool for Capacity Requirements Planning (CRP). It provides a detailed view of the available capacity for manufacturing resources (machines and labor) over a specified date range. By showing the daily hours and unit capacity for each resource, this report helps production planners identify potential bottlenecks and validate that the shop floor has the necessary bandwidth to meet the production schedule.

## Business Challenge
Manufacturing efficiency depends on balancing demand (production orders) with supply (resource capacity).
*   **Overbooking**: Scheduling more work than a machine can handle leads to missed deadlines and overtime costs.
*   **Underutilization**: Idle machines represent wasted capital and lost revenue potential.
*   **Visibility**: Planners need to know exactly how many hours a specific resource is available on a specific day, accounting for shifts, holidays, and maintenance.

## Solution
This report queries the CRP tables to present the calculated availability of resources.

**Key Features:**
*   **Daily Granularity**: Shows availability day-by-day, allowing for precise scheduling.
*   **Resource Specificity**: Drills down to the individual resource level within a department.
*   **Capacity Metrics**: Displays both "Daily Hours" (time available) and "Unit Capacity" (throughput potential).

## Architecture
The report pulls data from `CRP_AVAILABLE_RESOURCES`, which is populated by the planning engine (ASCP or MRP). It links to `BOM_DEPARTMENTS` and `BOM_RESOURCES` for descriptive details.

**Key Tables:**
*   `CRP_AVAILABLE_RESOURCES`: The core table storing the calculated capacity.
*   `BOM_DEPARTMENTS`: The manufacturing department owning the resource.
*   `BOM_RESOURCES`: The specific machine or labor code.

## Impact
*   **Realistic Scheduling**: Ensures that production plans are feasible based on actual shop floor constraints.
*   **Bottleneck Identification**: Highlights resources with limited availability that may constrain total output.
*   **Shift Management**: Helps managers decide if additional shifts or overtime are needed to meet demand.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=crp-available-resources)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
