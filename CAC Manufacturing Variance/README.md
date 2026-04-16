---
layout: default
title: 'CAC Manufacturing Variance | Oracle EBS SQL Report'
description: 'Report your summary or detail manufacturing variances for open and closed WIP jobs. If the job is open the Report Type column displays "Valuation", as…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Manufacturing, Variance, wip_discrete_jobs, org_acct_periods, mtl_parameters'
permalink: /CAC%20Manufacturing%20Variance/
---

# CAC Manufacturing Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-manufacturing-variance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report your summary or detail manufacturing variances for open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential variances are still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction.  You can report prior periods and the report will automatically adjust the assembly completion, assembly scrap, component issue and resource quantities to reflect the reported accounting period, as well as report only jobs which were open or closed during that prior period.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities".  And if you use Standard Costing, for standard discrete jobs this report also shows your configuration and method variances; the difference between your WIP BOM/routing and your standard BOM/routing.  Non-standard jobs usually do not have configuration variances, as they are "non-standard" without standard BOM or routing requirements.

Parameters:
==========
Report Option:  Open jobs, Closed jobs or All jobs.  Use this to limit the size of the report.  (mandatory)
Period Name:  the accounting period you wish to report.  (mandatory)
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type.
Include Scrap Quantities:  for calculating your completion quantities and component quantity requirements, include or exclude any scrapped assembly quantities.  (mandatory)
Include Unreleased Jobs:  include jobs which have not been released and are not started.  (mandatory)
Include Bulk Supply Items:  include Bulk items to match the results from the Oracle Discrete Job Value Report; exclude knowing that Bulk items are usually not issued to the WIP job.  (mandatory)
Use Completion Qtys:  for jobs in a released status, use the completion quantities for the material usage and configuration variance calculations.  Useful if you backflush your materials based on your completion quantities.  Complete, Complete - No Charges, Cancelled, Closed, Pending Close or Failed Close alway use the completion quantities in the variance calculations.  (mandatory)
Config/Lot Variances for Non-Std:  calculate configuration and lot variances for non-standard jobs.
Include Unimplemented ECOs:  include future BOM changes.
Alternate BOM Designator:  if you save your BOMs during your Cost Rollups (based on your Cost Type setups), use this parameter to get the correct BOMs for the configuration variance calculations.  If you leave this field blank the report uses the latest BOM component effectivity date up to the period close date.  (optional)
Category Set 1, 2, 3:  any item category to report (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number to report (optional)
Component Number:   specific component item to report (optional)
Outside Processing Item:  Specific outside processing component to report (optional).
Resource Code:  Specific resource code to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory org (optional).

-- |  Copyright 2011-25 Douglas Volz Consulting, Inc. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.36    21 Dec 2024 Douglas Volz   Fixes for Configuration and Method Variances.
-- |  1.37    02 Jan 2025 Douglas Volz    Add Scrap Variance column, to avoid double-counting assy scrap.
-- |  1.38    04 Feb 2025 Douglas Volz   Consolidate Summary and Detail reports into one report.


## Report Parameters
Report Mode, Report Option, Period Name, Cost Type, Include Scrap Quantities, Include Unreleased Jobs, Include Bulk Supply Items, Use Completion Quantities, Config/Lot Variances for Non-Std, Include Unimplemented ECOs, Alternate BOM Designator, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, Job Status, WIP Job, Component Number, Assembly Number, Outside Processing Item, Resource Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [wip_parameters](https://www.enginatics.com/library/?pg=1&find=wip_parameters), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [wdj0](https://www.enginatics.com/library/?pg=1&find=wdj0), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations), [wdj](https://www.enginatics.com/library/?pg=1&find=wdj), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-manufacturing-variance/) |
| Blitz Report™ XML Import | [CAC_Manufacturing_Variance.xml](https://www.enginatics.com/xml/cac-manufacturing-variance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-manufacturing-variance/](https://www.enginatics.com/reports/cac-manufacturing-variance/) |

## Case Study & Technical Analysis: CAC Manufacturing Variance

### Executive Summary
The **CAC Manufacturing Variance** report is the definitive tool for analyzing production performance in a Standard Costing environment. It calculates and categorizes the difference between the *Standard* cost of a job and the *Actual* input costs. It distinguishes between "Valuation" (potential variance in Open jobs) and "Variance" (realized P&L impact in Closed jobs).

### Business Challenge
Manufacturing variances are the primary indicator of shop floor efficiency.
*   **Usage Variance**: Did we use more material than the BOM specified? (Scrap/Theft/Yield).
*   **Efficiency Variance**: Did the operation take longer than the Routing specified? (Labor performance).
*   **Method Variance**: Did we use a non-standard BOM or Routing for this specific job?
*   **Timing**: Managers need to see these variances *before* the period closes to take corrective action.

### Solution
This report provides a granular breakdown of the variance.
*   **Categorization**: Splits variance into Material, Resource, Overhead, and Outside Processing buckets.
*   **Status Awareness**: Clearly separates Open jobs (WIP Balance) from Closed jobs (P&L Write-off).
*   **Scrap Handling**: Correctly accounts for assembly scrap to avoid double-counting variances.

### Technical Architecture
The report is a complex synthesis of WIP and Cost data:
*   **Tables**: `wip_discrete_jobs`, `wip_period_balances`, `wip_requirement_operations`.
*   **Calculation**:
    *   *Standard* = (Completed Qty * Standard Unit Cost)
    *   *Actual* = (Issued Material + Charged Resources)
    *   *Variance* = Actual - Standard
*   **Logic**: Includes logic to handle "Unreleased" jobs and "Bulk" supply items.

### Parameters
*   **Report Option**: (Mandatory) Open, Closed, or All jobs.
*   **Period Name**: (Mandatory) The accounting period.
*   **Include Scrap**: (Mandatory) Toggle to include scrap cost in the calculation.
*   **Use Completion Qtys**: (Mandatory) Determines how standard requirements are calculated for open jobs.

### Performance
*   **Heavy**: This is a calculation-intensive report. Running it for "All Jobs" over a long history can be slow.
*   **Optimization**: Filter by Organization and Period to keep performance high.

### FAQ
**Q: Why do I have a variance on an Open job?**
A: You don't technically have a "variance" yet; you have a "potential variance". If you issued all materials but haven't completed the assembly, the WIP value is high. The report estimates the variance assuming the current state is final.

**Q: What is a "Configuration Variance"?**
A: It occurs when the BOM used for the Job differs from the Standard BOM used for the Cost Rollup. E.g., substituting Part A for Part B.

**Q: Does this match the GL?**
A: For *Closed* jobs, the total variance should match the WIP Variance account postings in the GL. For *Open* jobs, it represents the WIP Inventory balance.


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
