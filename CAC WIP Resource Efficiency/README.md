---
layout: default
title: 'CAC WIP Resource Efficiency | Oracle EBS SQL Report'
description: 'Report your resource efficiency variances for your open and closed WIP jobs. Resource efficiency measures the WIP routing requirements against the actual…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, WIP, Resource, Efficiency, wip_discrete_jobs, org_acct_periods, mtl_parameters'
permalink: /CAC%20WIP%20Resource%20Efficiency/
---

# CAC WIP Resource Efficiency – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-resource-efficiency/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report your resource efficiency variances for your open and closed WIP jobs.  Resource efficiency measures the WIP routing requirements against the actual applied resources.  This report replicates the Resource Section for the Oracle Discrete Job Value Report - Standard Costing.

If you leave the Cost Type parameter blank the report uses either your Costing Method Cost Type (Standard) or your Costing Method "Avg Rates" Cost Type (Average, FIFO, LIFO) for your resource rates.  If the WIP job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period.  Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities" to determine if completion or planned quantities are used for requirements.  If you choose Yes for including scrap, this report will automatically include the scrapped quantities as part of the resource quantity requirements.  And this report automatically includes WIP jobs which were either open during the reported accounting period or if closed, were closed doing the reporting period.

Parameters:
=========
Report Option:  You can choose to limit the report size with this parameter.  The choices are:  Open jobs, All jobs or Closed jobs. (mandatory)
Period Name:  Enter the Period_Name you wish to report for WIP Jobs (mandatory)
Cost Type:  Enter the resource rates cost type.  If left blank, the report uses the Costing Method rates cost type. (optional)
Include Scrap Quantities:  Include scrap for quantity requirements.  (mandatory)
Include Unreleased Jobs:  Include jobs which have not been released and are not started.  (mandatory)
Use Completion Quantities:  For Released jobs, use the completion quantities for resource variance calculations else use the planned start quantities (mandatory).
Category Set 1:  Choose any item category to report.  Does not limit what is reported.
Category Set 2:  Choose any item category to report.  Does not limit what is reported.
Class Code:  Specific WIP class code to report (optional).
Job Status:  Specific WIP job status to report (optional).
WIP Job:  Specific WIP job number to report (optional).
Resource Code:  Specific resource code to report (optional).
Outside Processing Item:  Specific outside processing component to report (optional).
Assembly Number:  Specific assembly to report (optional).
Organization Code:  Specific inventory organization you wish to report (optional)
Operating Unit:  Specific operating unit you wish to report (optional)
Ledger:  Specific ledger you wish to report (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2021 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged                                                               |
-- +=============================================================================+
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     28 Jan 2010 Douglas Volz   Initial Coding
-- |  1.25    12 Dec 2021 Douglas Volz   Added auto-charge, std rate and PO Currency Code columns.
-- +=============================================================================+*/

## Report Parameters
Report Option, Period Name, Cost Type, Include Scrap Quantities, Include Unreleased Jobs, Use Completion Quantities, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, Job Status, WIP Job, Resource Code, Outside Processing Item, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [wdj00](https://www.enginatics.com/library/?pg=1&find=wdj00), [wdj0](https://www.enginatics.com/library/?pg=1&find=wdj0), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [wdj](https://www.enginatics.com/library/?pg=1&find=wdj), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [wdj_assys](https://www.enginatics.com/library/?pg=1&find=wdj_assys), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Resource Efficiency 10-Jul-2022 170101.xlsx](https://www.enginatics.com/example/cac-wip-resource-efficiency/) |
| Blitz Report™ XML Import | [CAC_WIP_Resource_Efficiency.xml](https://www.enginatics.com/xml/cac-wip-resource-efficiency/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-resource-efficiency/](https://www.enginatics.com/reports/cac-wip-resource-efficiency/) |

## Executive Summary
The **CAC WIP Resource Efficiency** report analyzes the efficiency of labor and machine resources applied to Work in Process (WIP) jobs. It compares the *standard* resource requirements (based on the routing and completion quantity) against the *actual* resources charged to the job. This report is the primary tool for calculating and explaining the "Resource Efficiency Variance" component of manufacturing costs, helping management understand if production is taking more or less time than planned.

## Business Challenge
Resource costs (Labor and Overhead) are a significant component of manufacturing value.
*   **Efficiency Variance**: If a standard routing says an operation takes 1 hour, but it actually takes 1.5 hours, that is an unfavorable efficiency variance.
*   **Cost Control**: Consistently unfavorable variances indicate either shop floor inefficiencies (training, machine downtime) or incorrect standards (routings need updating).
*   **Valuation**: For open jobs, these variances sit in WIP inventory. For closed jobs, they hit the P&L.

Managers need to know *where* the inefficiencies are occurring—by Department, Resource, or specific Job.

## Solution
This report provides a detailed comparison of "Applied Resource Units" vs. "Standard Resource Units".

**Key Features:**
*   **Efficiency Calculation**: Calculates the variance in both units (hours) and value (currency).
*   **Open and Closed Jobs**:
    *   *Valuation*: Shows the efficiency variance embedded in open WIP jobs.
    *   *Variance*: Shows the final efficiency variance realized on closed jobs.
*   **Scrap Inclusion**: Can automatically include resources consumed by scrapped assemblies in the standard requirement (giving credit for work done on bad parts).
*   **Flexible Rates**: Can use either the standard cost rates or average rates depending on the cost type parameter.

## Architecture
The report joins `WIP_DISCRETE_JOBS` with `WIP_OPERATIONS` and `WIP_OPERATION_RESOURCES` to determine the standard requirements. It compares this to the actuals found in `WIP_TRANSACTIONS` (or aggregated transaction views).

**Key Tables:**
*   `WIP_DISCRETE_JOBS`: Job header.
*   `WIP_OPERATIONS`: The routing steps for the job.
*   `WIP_OPERATION_RESOURCES`: The resources (labor/machine) assigned to each step.
*   `WIP_TRANSACTIONS`: The actual resource charging history.
*   `BOM_DEPARTMENTS`: To group resources by department.

## Impact
*   **Performance Management**: Provides the data needed to hold production supervisors accountable for labor efficiency.
*   **Routing Accuracy**: Identifies operations where the standard times are consistently wrong, triggering engineering reviews.
*   **Profitability Analysis**: Helps quantify the financial impact of shop floor productivity (or lack thereof).


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
