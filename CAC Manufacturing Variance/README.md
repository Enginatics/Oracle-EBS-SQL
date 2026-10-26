---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Manufacturing Variance | Oracle EBS SQL Report'
description: 'Report your summary or detail manufacturing variances for open and closed WIP jobs. If the job is open the Report Type column displays "Valuation", as…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Manufacturing, Variance, bom_alternate_designators_vl, mtl_material_transactions, mtl_parameters'
permalink: /CAC%20Manufacturing%20Variance/
report_name: 'CAC Manufacturing Variance'
report_web_name: cac-manufacturing-variance
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Manufacturing Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-manufacturing-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report your summary or detail manufacturing variances for open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential variances are still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction.  You can report prior periods and the report will automatically adjust the assembly completion, assembly scrap, component issue and resource quantities to reflect the reported accounting period, as well as report only jobs which were open or closed during that prior period.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities".  And if you use Standard Costing, for standard discrete jobs this report also shows your configuration and method variances; the difference between your WIP BOM/routing and your standard BOM/routing.  Non-standard jobs usually do not have configuration variances, as they are "non-standard" without standard BOM or routing requirements.

-- |  Copyright 2011-25 Douglas Volz Consulting, Inc. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.36    21 Dec 2024 Douglas Volz   Fixes for Configuration and Method Variances.
-- |  1.37    02 Jan 2025 Douglas Volz    Add Scrap Variance column, to avoid double-counting assy scrap.
-- |  1.38    04 Feb 2025 Douglas Volz   Consolidate Summary and Detail reports into one report.
-- |  1.39    24 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Mode, Report Option, Period Name, Cost Type, Include Scrap Quantities, Include Unreleased Jobs, Include Bulk Supply Items, Use Completion Quantities, Config/Lot Variances for Non-Std, Include Unimplemented ECOs, Alternate BOM Designator, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, Job Status, WIP Job, Component Number, Assembly Number, Outside Processing Item, Resource Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[bom_alternate_designators_vl](https://www.enginatics.com/library/?pg=1&find=bom_alternate_designators_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_parameters](https://www.enginatics.com/library/?pg=1&find=wip_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_standard_costs](https://www.enginatics.com/library/?pg=1&find=cst_standard_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_operation_sequences](https://www.enginatics.com/library/?pg=1&find=bom_operation_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_operation_resources](https://www.enginatics.com/library/?pg=1&find=bom_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_parameters](https://www.enginatics.com/library/?pg=1&find=bom_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)

## Related Reports
[CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Manufacturing%20Variance/CAC%20Manufacturing%20Variance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-manufacturing-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance) |
| Blitz Report™ XML Import | [CAC_Manufacturing_Variance.xml](https://www.enginatics.com/xml/cac-manufacturing-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance) |
| SQL Source | [CAC Manufacturing Variance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Manufacturing%20Variance/CAC%20Manufacturing%20Variance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-manufacturing-variance/](https://www.enginatics.com/reports/cac-manufacturing-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-manufacturing-variance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
