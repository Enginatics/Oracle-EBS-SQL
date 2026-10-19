---
layout: default
last_modified_at: 2026-10-19
title: 'PA Project Expenditure Items with WIP and INV Detail | Oracle EBS SQL Report'
description: 'Project expenditure items showing WIP and inventory transaction details including transaction types, quantities, WIP job, assembly, department, resource…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, R12 only, Project, Expenditure, Items, WIP, pa_project_statuses, pa_system_linkages, pa_transaction_sources'
permalink: /PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/
report_name: 'PA Project Expenditure Items with WIP and INV Detail'
report_web_name: pa-project-expenditure-items-with-wip-and-inv-detail
module: 'Projects'
module_url: /modules/projects/
---

# PA Project Expenditure Items with WIP and INV Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-expenditure-items-with-wip-and-inv-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
Project expenditure items showing WIP and inventory transaction details including transaction types, quantities, WIP job, assembly, department, resource, and inventory item information.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project, Task, Date From, Date To, Expenditure Type, Expenditure Type Class, Job, Employee

## Oracle EBS Tables Used
[pa_project_statuses](https://www.enginatics.com/library/?pg=1&find=pa_project_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_system_linkages](https://www.enginatics.com/library/?pg=1&find=pa_system_linkages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_transaction_sources](https://www.enginatics.com/library/?pg=1&find=pa_transaction_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [wip_repetitive_items](https://www.enginatics.com/library/?pg=1&find=wip_repetitive_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PA Employee Activity By Organization](/PA%20Employee%20Activity%20By%20Organization/ "PA Employee Activity By Organization Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [PA Cost Audit](/PA%20Cost%20Audit/ "PA Cost Audit Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Project Expenditure Items with WIP and INV Detail 23-Mar-2026 081847.xlsx](https://www.enginatics.com/example/pa-project-expenditure-items-with-wip-and-inv-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail) |
| Blitz Report™ XML Import | [PA_Project_Expenditure_Items_with_WIP_and_INV_Detail.xml](https://www.enginatics.com/xml/pa-project-expenditure-items-with-wip-and-inv-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail) |
| SQL Source | [PA Project Expenditure Items with WIP and INV Detail.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-project-expenditure-items-with-wip-and-inv-detail/](https://www.enginatics.com/reports/pa-project-expenditure-items-with-wip-and-inv-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail) |

## Case Study & Technical Analysis: PA Project Expenditure Items with WIP and INV Detail

### Executive Summary
This report lists Oracle Projects expenditure items together with the manufacturing transaction behind each item where one exists. For an item raised from Work in Process it shows the WIP transaction, job, assembly, department and resource, and for an item raised from Inventory it shows the material transaction, its type, item and quantity. Project controllers use it to trace project costs back to the shop floor job or inventory movement behind them. It is an R12 report that runs in Excel through Blitz Report™.

### Business Challenge
*   **Cost traceability:** Project costs that come from manufacturing must be traced to the job, assembly and resource that incurred them, which the project ledger alone does not show.
*   **Inventory-driven costs:** Inventory material issued to a project must match the underlying inventory transaction.
*   **Reconciliation:** Project cost reports and manufacturing reports must agree, and differences need a common key to investigate.
*   **Project costing detail:** Labor and resource costs of a project need the department and resource that performed the work.

### The Solution
*   Shows each expenditure item with its operating unit, project number, name, status and type, task, expenditure type and class, and transaction source.
*   Attaches the WIP transaction for WIP-linked items, with its type, date, operation, department and resource.
*   Attaches the inventory material transaction for items whose linkage is WIP or INV from inventory, with its transaction type, date, item, quantity and unit of measure.
*   Shows the job, job type, assembly and accounting class, with quantity, currency, raw and burdened costs.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items, with quantity, cost, currency, date, type and the original transaction reference.
*   `PA_EXPENDITURES_ALL`: the expenditure header, supplying the expenditure group and the person who incurred it.
*   `PA_EXPENDITURE_TYPES`: the expenditure type and its category.
*   `PA_PROJECTS_ALL`, `PA_PROJECT_STATUSES` and `PA_TASKS`: the project, its status and its tasks.
*   `PA_SYSTEM_LINKAGES` and `PA_TRANSACTION_SOURCES`: the linkage function and the transaction source descriptions.
*   `PER_PEOPLE_X`: the employee who incurred the expenditure.
*   `WIP_TRANSACTIONS`, `WIP_ENTITIES`, `WIP_DISCRETE_JOBS` and `WIP_REPETITIVE_ITEMS`: the WIP transaction, the job or schedule, and its accounting class.
*   `BOM_DEPARTMENTS` and `BOM_RESOURCES`: the department and resource of a WIP transaction.
*   `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_TYPES`: the inventory material transaction and its type.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly of the job and the inventory item of the material transaction.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units accessible to the user.

#### Logical Relationships
1.  Each expenditure item joins to its header, expenditure type, project, task and accessible operating unit.
2.  The WIP transaction is found by converting the original transaction reference to a number, and only for items whose linkage function is WIP and whose transaction source is Work In Process.
3.  The WIP entity of the transaction or material transaction identifies the job, and its primary item gives the assembly.
4.  The inventory material transaction is found by the same conversion, for WIP or INV linkages whose source is not Work In Process.
5.  Department and resource are joined to the WIP transaction and to the expenditure item's WIP resource.
6.  The results are ordered by operating unit, project number, task number and expenditure item date.

### Parameters & Filtering
*   **Operating Unit**, **Project** and **Task:** restrict the items to one unit, project or task.
*   **Date From** and **Date To:** bound the expenditure item dates.
*   **Expenditure Type** and **Expenditure Type Class:** restrict the items by type and by the system linkage class.
*   **Job** and **Employee:** restrict the items to one WIP job or to one employee.

### Performance & Optimization
*   The WIP and inventory links compare a converted number from the original transaction reference with a transaction identifier, so each item is matched on a key.
*   The operating unit restriction through `MO_GLOB_ORG_ACCESS_TMP` limits the items to the units the user can access.
*   The manufacturing joins are outer joins on identifiers, so items with no WIP or inventory transaction are still listed.
*   The project, task and date parameters are the main levers on run time, because they limit the expenditure items that are matched.

### FAQ
**Q: How is a project expenditure item matched to its WIP transaction?**
A: The report converts the original transaction reference of the expenditure item to a number and matches it to the WIP transaction identifier, for items whose linkage function is WIP and whose source is Work In Process.

**Q: Which items show an inventory transaction?**
A: Items whose linkage function is WIP or INV, and whose transaction source is not Work In Process, show the matching material transaction, its type, date, item and quantity.

**Q: Can an item be listed without a manufacturing transaction?**
A: Yes, the manufacturing joins are outer joins, so items that have no WIP or inventory transaction are still listed with blank manufacturing columns.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-expenditure-items-with-wip-and-inv-detail)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
