---
layout: default
last_modified_at: 2026-10-19
title: 'CST Historical WIP Standard Cost Adjustment | Oracle EBS SQL Report'
description: 'WIP standard cost adjustment details recorded by a completed standard cost update, based on Oracle''s Historical WIP Standard Cost Adjustment Report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, CST, Historical, WIP, Standard, gl_code_combinations_kfv, cst_cost_updates, cst_cost_types'
permalink: /CST%20Historical%20WIP%20Standard%20Cost%20Adjustment/
report_name: 'CST Historical WIP Standard Cost Adjustment'
report_web_name: cst-historical-wip-standard-cost-adjustment
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Historical WIP Standard Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
WIP standard cost adjustment details recorded by a completed standard cost update, based on Oracle's Historical WIP Standard Cost Adjustment Report (CSTCUSJA).

The report shows one line per WIP discrete job, transaction type, item or resource operation and cost element, with the old and new unit costs, adjustment quantity and adjustment value, and the WIP job's valuation and standard cost adjustment accounts.

The Cost Update parameter offers the completed standard cost updates of the selected organization that saved their adjustment details, matching Oracle's View Cost Update History form. Oracle's Delete Snapshot option is deliberately not included, so the stored adjustment details are never removed by this report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Cost Update

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [cst_std_cost_adj_values](https://www.enginatics.com/library/?pg=1&find=cst_std_cost_adj_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)

## Related Reports
[CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Period Balances to Accounting Activity Reconciliation](/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/ "CAC WIP Period Balances to Accounting Activity Reconciliation Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Historical%20WIP%20Standard%20Cost%20Adjustment/CST%20Historical%20WIP%20Standard%20Cost%20Adjustment.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Historical WIP Standard Cost Adjustment 05-Aug-2026 123629.xlsx](https://www.enginatics.com/example/cst-historical-wip-standard-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment) |
| Blitz Report™ XML Import | [CST_Historical_WIP_Standard_Cost_Adjustment.xml](https://www.enginatics.com/xml/cst-historical-wip-standard-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment) |
| SQL Source | [CST Historical WIP Standard Cost Adjustment.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Historical%20WIP%20Standard%20Cost%20Adjustment/CST%20Historical%20WIP%20Standard%20Cost%20Adjustment.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/](https://www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment) |

## Case Study & Technical Analysis: CST Historical WIP Standard Cost Adjustment

### Executive Summary
This report shows the work in process standard cost adjustments recorded by a completed standard cost update. For each WIP discrete job, transaction type, item or resource operation and cost element, it gives the old and new unit cost, the adjustment quantity and the adjustment value, together with the valuation accounts of the job. It is written for cost accountants and manufacturing finance teams who must explain how open WIP values moved when a standard cost update was run, and who need the detail for period close review and audit. It follows Oracle's Historical WIP Standard Cost Adjustment Report (CSTCUSJA), with the stored adjustment details left untouched.

### Business Challenge
*   **Explaining WIP value movement:** A standard cost update changes the value of open jobs, and finance must explain each adjustment by job, operation and cost element.
*   **Tracing the accounts:** Each adjustment must be posted to the job's material, resource, overhead and standard cost adjustment accounts, which must be visible for review.
*   **Audit evidence:** The adjustment detail has to be kept for audit, so it must be viewed without being deleted.
*   **Choosing the right update:** An organization may run several cost updates for different cost types, so the report must target a specific completed update.

### The Solution
*   Reads the adjustment values saved by one completed standard cost update, and lists them by job, transaction type, operation, resource and cost element.
*   Shows the old and new unit cost for each line, rounded to the precision of the ledger currency, and the adjustment quantity and value.
*   Resolves the material, material overhead, resource, outside processing, overhead and standard cost adjustment accounts of each job into concatenated account segments.
*   Matches Oracle's View Cost Update History form by offering only completed cost updates that saved their adjustment details, and it does not offer the Delete Snapshot option.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_COST_UPDATES`: the standard cost update, with its status, range option, description and date.
*   `CST_COST_TYPES`: the cost type of the update.
*   `CST_STD_COST_ADJ_VALUES`: the stored adjustment values, by job, operation, resource, cost element and transaction type.
*   `WIP_ENTITIES` and `WIP_DISCRETE_JOBS`: the job name, class, assembly and accounts.
*   `MTL_SYSTEM_ITEMS_VL`: the item and the assembly of the job.
*   `BOM_RESOURCES` and `CST_COST_ELEMENTS`: the resource code and the cost element name.
*   `ORG_ORGANIZATION_DEFINITIONS`, `GL_LEDGERS` and `FND_CURRENCIES`: the organization, the ledger and the currency precision used for rounding.
*   `GL_CODE_COMBINATIONS_KFV`: the account descriptions.

#### Logical Relationships
1. `CST_COST_UPDATES` is restricted to completed updates, and joined to the cost type and to the organization.
2. The organization's ledger supplies the currency, and the currency precision controls rounding.
3. `CST_STD_COST_ADJ_VALUES` is joined to the update, and filtered to the job-level transaction types that changed cost.
4. The job is joined through the organization and WIP entity to `WIP_ENTITIES` and `WIP_DISCRETE_JOBS`, and the assembly through the primary item.
5. Resource and cost element details are joined through the resource and cost element identifiers.
6. An inner query computes the adjustment values per line. An outer query groups them and computes the unit costs and the accounts.

### Parameters & Filtering
*   **Organization Code:** selects the inventory organization whose WIP jobs were adjusted.
*   **Cost Update:** selects one completed standard cost update of that organization that saved its adjustment details.

### Performance & Optimization
*   The adjustment rows are restricted to the selected cost update and to jobs that have at least one changed unit cost, through a correlated IN subquery, so unchanged jobs are not listed.
*   For some transaction types the adjustment quantity is multiplied by a factor of one half, and the report divides the quantity by two for the operation rows that are counted twice, so the quantity is not overstated.
*   Rounding uses the extended or standard precision of the ledger currency, so the values follow the rounding of the currency.
*   Account names are resolved through scalar subqueries on the code combination identifier for each output row.

### FAQ
**Q: Which cost update should I choose?**
A: Choose the completed cost update for the cost type and date you are reviewing. Only updates that saved their adjustment details are offered.

**Q: Why does the report show the old and new unit cost for an operation?**
A: Each line shows the unit cost of the cost element for the operation or resource, rounded to the ledger's precision. Quantity and value are shown with the adjustment.

**Q: Does this report delete the adjustment history?**
A: No. Oracle's Delete Snapshot option is deliberately not included, so the stored adjustment details are never removed by this report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-historical-wip-standard-cost-adjustment)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
