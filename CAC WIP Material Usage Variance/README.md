---
layout: default
last_modified_at: 2026-10-16
title: 'CAC WIP Material Usage Variance | Oracle EBS SQL Report'
description: 'Report your material usage variances for your open and closed WIP jobs. This report replicates the Material Variance Section for the Oracle Discrete Job…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, WIP, Material, Usage, wip_discrete_jobs, org_acct_periods, mtl_parameters'
permalink: /CAC%20WIP%20Material%20Usage%20Variance/
report_name: 'CAC WIP Material Usage Variance'
report_web_name: cac-wip-material-usage-variance
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Material Usage Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-material-usage-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report your material usage variances for your open and closed WIP jobs.  This report replicates the Material Variance Section for the Oracle Discrete Job Value - Standard Costing report.

If the job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction.  You can report prior periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect the quantities for the specified accounting period, as well as report only jobs which were open or closed during that prior period.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities".  

Parameters:
==========
Report Option:  Open jobs, Closed jobs or All jobs.  Use this to limit the size of the report.  (mandatory)
Period Name:  the accounting period you wish to report.  (mandatory)
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type. (optional)
Include Scrap Quantities:  for calculating your completion quantities and component quantity requirements, include or exclude any scrapped assembly quantities.  (mandatory)
Include Unreleased Jobs:  include jobs which have not been released and are not started.  (mandatory)
Include Bulk Supply Items:  include Bulk items to match the results from the Oracle Discrete Job Value Report; exclude knowing that Bulk items are usually not issued to the WIP job.  (mandatory)
Use Completion Qtys:  for jobs in a released status, use the completion quantities for the material usage and configuration variance calculations.  Useful if you backflush your materials based on your completion quantities.  Complete, Complete - No Charges, Cancelled, Closed, Pending Close or Failed Close alway use the completion quantities for the variance calculations.  (mandatory)
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number you wish to report (optional)
Component Number:   specific component item you wish to report (optional)
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is acknowledged.
-- +=============================================================================+
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.0     12 Oct 2020 Douglas Volz    Initial Coding Based on ICP WIP Component 
-- |                                      Variances and ICP WIP Component Valuation
-- |  1.24     02 Feb 2022 Douglas Volz   Fix for non-standard jobs, there are no rows in wip_operations if there is no routing.
-- |  1.25     20 Jun 2024 Douglas Volz   Remove tabs, reinstall parameters and inventory org access controls.
-- |  ======= =========== =============== =========================================

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Option, Period Name, Cost Type, Include Scrap Quantities, Include Unreleased Jobs, Include Bulk Supply Items, Use Completion Quantities, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, Job Status, WIP Job, Component Number, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_cst_actual_cost_details](https://www.enginatics.com/library/?pg=1&find=mtl_cst_actual_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)

## Related Reports
[CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Material Relief](/CAC%20WIP%20Material%20Relief/ "CAC WIP Material Relief Oracle EBS SQL Report"), [CAC WIP Period Balances to Accounting Activity Reconciliation](/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/ "CAC WIP Period Balances to Accounting Activity Reconciliation Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Material%20Usage%20Variance/CAC%20WIP%20Material%20Usage%20Variance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Material Usage Variance 10-Jul-2022 165408.xlsx](https://www.enginatics.com/example/cac-wip-material-usage-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance) |
| Blitz Report™ XML Import | [CAC_WIP_Material_Usage_Variance.xml](https://www.enginatics.com/xml/cac-wip-material-usage-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance) |
| SQL Source | [CAC WIP Material Usage Variance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Material%20Usage%20Variance/CAC%20WIP%20Material%20Usage%20Variance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-material-usage-variance/](https://www.enginatics.com/reports/cac-wip-material-usage-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance) |

## Case Study & Technical Analysis: CAC WIP Material Usage Variance

### Executive Summary
The **CAC WIP Material Usage Variance** report is a deep-dive analytical tool for manufacturing cost control. It focuses specifically on the "Material" component of WIP variance, which is often the largest driver of manufacturing cost deviations.
Unlike the high-level "WIP Account Summary," this report drills down to the component level, comparing what *should* have been used (Standard Quantity) against what *was* actually used (Issued Quantity). It replicates and enhances the logic of the standard Oracle "Discrete Job Value Report" but in a flat, exportable format.

### Business Challenge
Material variance is a key performance indicator (KPI) for the shop floor, but it's hard to diagnose.
*   **Usage vs. Configuration:** If a job has a $1,000 variance, is it because the operator used 10 extra bolts (Usage), or because they substituted a more expensive steel grade (Configuration)?
*   **Timing Issues:** Standard reports often show the *current* state of the job. If you are analyzing last month's close, you need a report that "rolls back" the quantities to show the status *as of* that period end.
*   **Open vs. Closed:** Finance treats open jobs (Valuation) differently from closed jobs (Variance). Open job variances sit on the balance sheet; closed job variances hit the P&L.

### The Solution
This report provides a precise, component-level variance analysis.
*   **Variance Decomposition:**
    *   **Usage Variance:** `(Standard Qty - Actual Qty) * Standard Cost`. This highlights efficiency issues (scrap, theft, over-issue).
    *   **Configuration Variance:** Highlights when a component was not in the original BOM or was substituted.
*   **Time-Travel Logic:** The report uses transaction history (`MTL_MATERIAL_TRANSACTIONS`) to calculate the "Applied Quantity" and "Completed Quantity" exactly as they were at the end of the selected period. This makes it perfect for retrospective month-end analysis.
*   **Flexible Baselines:** The `Use Completion Quantities` parameter allows users to calculate standard requirements based on what was actually built, rather than what was planned. This is crucial for environments where yield varies significantly.

### Technical Architecture (High Level)
The query is complex because it must reconstruct the state of every job at a past point in time.
*   **CTEs for Job State:**
    *   `wdj00` & `wdj0`: These Common Table Expressions filter the jobs to be reported (Open, Closed, or All) and establish the job header details (Status, Quantities) relative to the reporting period.
*   **Component Logic:**
    *   It joins `WIP_REQUIREMENT_OPERATIONS` (the BOM) to determine the *Standard* requirement.
    *   It sums `MTL_MATERIAL_TRANSACTIONS` (the Issues/Returns) to determine the *Actual* usage.
*   **Costing Logic:** It joins to `CST_ITEM_COSTS` to value the quantities. It defaults to the organization's Costing Method but allows an optional `Cost Type` override for simulation.
*   **Variance Calculation:**
    *   `Target Qty = (Qty Completed + Qty Scrapped) * BOM Quantity per Assembly`.
    *   `Usage Variance = (Target Qty - Actual Issued Qty) * Item Cost`.

### Parameters & Filtering
*   **Report Option:** Toggle between Open (Valuation), Closed (Variance), or All.
*   **Period Name:** The anchor point for the "As of" calculation.
*   **Include Scrap/Unreleased:** Fine-tunes the requirement calculation.
*   **Use Completion Qtys:** Determines if the standard is based on the *Start* quantity or the *Completed* quantity.

### Performance & Optimization
*   **Materialized CTEs:** The `/*+ materialize */` hint in the initial CTEs forces the database to build the list of relevant jobs once, preventing repeated scans of the `WIP_DISCRETE_JOBS` table for each component calculation.
*   **Transaction Filtering:** The summation of material transactions is strictly bounded by the `Period Name` dates, ensuring the "As of" calculation is accurate and efficient.

### FAQ
**Q: Why does the report show "Valuation" for some rows and "Variance" for others?**
A: This depends on the job status *in the selected period*. If the job was Open, the variance is still "Valuation" (an asset/liability on the balance sheet). If the job Closed during the period, the variance is finalized and written off to the P&L.

**Q: How does it handle "Bulk" items?**
A: Bulk items (like grease or fasteners) are often expensed upon receipt and not issued to specific jobs. The `Include Bulk Supply Items` parameter allows you to exclude them to avoid showing massive "favorable" variances (since the system expects usage but sees zero issues).

**Q: Why is my "Standard Quantity" zero?**
A: This usually happens if the component was added to the job ad-hoc (not in the BOM). In this case, the entire cost of the issued material is treated as a variance.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-usage-variance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
