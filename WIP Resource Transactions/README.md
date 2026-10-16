---
layout: default
last_modified_at: 2026-10-16
title: 'WIP Resource Transactions | Oracle EBS SQL Report'
description: 'WIP resource, overhead and outside processing transactions, one row per transaction, as shown in the View Resource Transactions form. Quantity is in the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Work in Process, Enginatics, WIP, Resource, Transactions, mtl_parameters, wip_transactions, wip_entities'
permalink: /WIP%20Resource%20Transactions/
report_name: 'WIP Resource Transactions'
report_web_name: wip-resource-transactions
module: 'Work in Process'
module_url: /modules/work-in-process/
---

# WIP Resource Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-resource-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions).
**Oracle EBS module:** [Work in Process](/modules/work-in-process/ "Oracle EBS Work in Process reports") · [all Work in Process reports](/modules/work-in-process/)  

## Overview
WIP resource, overhead and outside processing transactions, one row per transaction, as shown in the View Resource Transactions form.

Quantity is in the unit of measure the transaction was entered in, Primary Quantity in the resource's unit of measure.

Transactions still pending in the resource transaction interface are not included.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Date From, Date To, Job, Line, Assembly, Department, Resource, Resource Type, Employee Number, Activity, Reason, PO Number, Transferred to Projects, Transaction Type, Include Variance Transactions

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [WIP Move Transactions](/WIP%20Move%20Transactions/ "WIP Move Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Resource%20Transactions/WIP%20Resource%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WIP Resource Transactions 03-Oct-2026 091404.xlsx](https://www.enginatics.com/example/wip-resource-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions) |
| Blitz Report™ XML Import | [WIP_Resource_Transactions.xml](https://www.enginatics.com/xml/wip-resource-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions) |
| SQL Source | [WIP Resource Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Resource%20Transactions/WIP%20Resource%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-resource-transactions/](https://www.enginatics.com/reports/wip-resource-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions) |

## Case Study & Technical Analysis: WIP Resource Transactions

### Executive Summary
WIP Resource Transactions lists the Work in Process resource, overhead and outside processing transactions, one row for each transaction, as shown in the View Resource Transactions form. It gives the job, line, assembly, operation, department, resource, employee, activity, quantity, rate and amount of each charge posted to production. Cost accountants, production controllers and plant managers use it to review labour and machine time booked against jobs, to check standard versus actual rates, and to confirm which charges were transferred to projects.

### Business Challenge
*   **Labor and Machine Costing:** Production costs depend on the time booked against each resource, and cost accountants need the detail behind the totals.
*   **Standard Versus Actual:** Variances between standard and actual resource rates must be identified to explain cost movements.
*   **Outside Processing:** Work sent to suppliers must be traced to the purchase order that paid for it.
*   **Project Billing:** Charges on project-based jobs must be transferred to projects, and the transfer status must be visible.

### The Solution
*   **Transaction Detail:** Each transaction is listed with its type, job, line, assembly, operation, department, resource and charge basis.
*   **Quantity and Rate:** Transaction quantity, primary quantity, usage rate, actual rate and standard rate are shown together, so variances are visible.
*   **Employee and Activity:** The employee number and name, the activity, and the reason are returned for each transaction.
*   **Project Transfer Status:** The transferred to projects value shows whether a charge was transferred, not transferred or not applicable.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_TRANSACTIONS`: the resource, overhead and outside processing transactions, with quantities, rates, dates and source references.
*   `WIP_ENTITIES`: the jobs and schedules, with their names and entity types.
*   `WIP_LINES`: the production lines.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly items.
*   `BOM_DEPARTMENTS`: the departments.
*   `BOM_RESOURCES`: the resources, with their codes, descriptions and types.
*   `CST_ACTIVITIES`: the cost activities.
*   `PER_ALL_PEOPLE_F`: the employees, effective on the transaction date.
*   `MTL_TRANSACTION_REASONS`: the transaction reasons.
*   `PO_HEADERS_ALL`: the purchase orders for outside processing.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the projects and tasks for project-related charges.
*   `MTL_PARAMETERS`: the organizations.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

#### Logical Relationships
1.  Each transaction in `WIP_TRANSACTIONS` is joined to its organization in `MTL_PARAMETERS`, restricted to organizations the user can access.
2.  Transactions are joined to their job in `WIP_ENTITIES`, and outer joined to their line in `WIP_LINES`.
3.  The assembly is outer joined to `MTL_SYSTEM_ITEMS_VL` on the organization and inventory item.
4.  The department is outer joined to `BOM_DEPARTMENTS` using the charge department when present, otherwise the department.
5.  The resource, activity, reason, purchase order, project and task are outer joined to their definition tables.
6.  The employee is outer joined to `PER_ALL_PEOPLE_F` on the employee identifier, with the transaction date falling in the person's effective period.

### Parameters & Filtering
*   **Organization Code:** Restricts the transactions to one organization.
*   **Date From and Date To:** Limit the transactions to a transaction date window.
*   **Job, Line and Assembly:** Select transactions for one job, production line or assembly.
*   **Department and Resource and Resource Type:** Select transactions for one department, resource or resource type.
*   **Employee Number:** Restricts the output to one employee.
*   **Activity and Reason:** Restrict the output to one cost activity or one transaction reason.
*   **PO Number:** Restricts the output to outside processing charges on one purchase order.
*   **Transferred to Projects:** Filters the transactions by their project transfer status.
*   **Transaction Type:** Restricts the output to one transaction type.
*   **Include Variance Transactions:** Controls whether variance transactions are included.

### Performance & Optimization
*   **Organization Access First:** The organization restriction is applied before the transaction join, so only permitted organizations are scanned.
*   **Transaction Type List:** Only the resource, overhead and outside processing transaction types are read, which limits the transaction table scan.
*   **Date Driven Employee Join:** The employee join is limited to the person's effective period, so each transaction matches one employee record.
*   **Outer Joins for Optional Sources:** Purchase order, project and task joins are optional, so transactions without them still appear.

### FAQ
**Q: What is the difference between Quantity and Primary Quantity?**
A: Quantity is in the unit of measure the transaction was entered in. Primary Quantity is in the resource's unit of measure.

**Q: Why are some pending transactions missing?**
A: Transactions still pending in the resource transaction interface are not included in the report.

**Q: How do I check outside processing charges for one purchase order?**
A: Enter the purchase order number in the PO Number parameter. The transactions for that order are returned with their quantities and amounts.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-resource-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
