---
layout: default
last_modified_at: 2026-10-16
title: 'WIP Move Transactions | Oracle EBS SQL Report'
description: 'WIP move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, one row per transaction, as shown in the View Move…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Work in Process, Enginatics, WIP, Move, Transactions, mtl_parameters, wip_move_transactions, wip_move_txn_allocations'
permalink: /WIP%20Move%20Transactions/
report_name: 'WIP Move Transactions'
report_web_name: wip-move-transactions
module: 'Work in Process'
module_url: /modules/work-in-process/
---

# WIP Move Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-move-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions).
**Oracle EBS module:** [Work in Process](/modules/work-in-process/ "Oracle EBS Work in Process reports") · [all Work in Process reports](/modules/work-in-process/)  

## Overview
WIP move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, one row per transaction, as shown in the View Move Transactions form.

The report covers the data of the Oracle standard Move Transaction Report (WIPTSMOV): from and to operation, department and intraoperation step, transaction and primary quantity, reason and reference, over-completion, scrap account and the employee who performed the move.

A repetitive move is shown once per repetitive schedule it was allocated to, with the schedule's first unit start date and the allocated quantity.

Quantity is in the unit of measure the transaction was entered in, Primary Quantity in the assembly's primary unit of measure. Transaction Day is the transaction date without the time, for daily totals.

Transactions still pending in the move transaction interface are not included.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Date From, Date To, Job, Line, Assembly, From Department, To Department, From Step, To Step, Reason, Employee Number

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [wip_move_transactions](https://www.enginatics.com/library/?pg=1&find=wip_move_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [wip_move_txn_allocations](https://www.enginatics.com/library/?pg=1&find=wip_move_txn_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [wip_repetitive_schedules](https://www.enginatics.com/library/?pg=1&find=wip_repetitive_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)

## Related Reports
[WIP Move Transactions 11i](/WIP%20Move%20Transactions%2011i/ "WIP Move Transactions 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Move%20Transactions/WIP%20Move%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WIP Move Transactions 14-Oct-2026 104342.xlsx](https://www.enginatics.com/example/wip-move-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions) |
| Blitz Report™ XML Import | [WIP_Move_Transactions.xml](https://www.enginatics.com/xml/wip-move-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions) |
| SQL Source | [WIP Move Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Move%20Transactions/WIP%20Move%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-move-transactions/](https://www.enginatics.com/reports/wip-move-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions) |

## Case Study & Technical Analysis: WIP Move Transactions

### Executive Summary
The WIP Move Transactions report lists the work in process move transactions of an organization, one row per transaction, as shown in the View Move Transactions form. It covers discrete jobs, lot based jobs, repetitive schedules and flow schedules. Each row shows the operation and department the assembly moved from and to, the intraoperation step, the quantity moved in the entered and primary units, any over-completion and scrap account, the reason and reference, and the employee who performed the move. Production supervisors and cost accountants use it to review shop floor activity by day, to trace quantities through operations, and to investigate scrap and over-completion. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Shop floor traceability:** Supervisors need to see which operation and department an assembly was moved through, and by whom, to resolve questions about where a job is.
*   **Daily production reporting:** Output must be totaled by day, so that daily production and labor reporting can be reconciled.
*   **Scrap and over-completion control:** Scrap and over-completed quantities must be visible with their scrap account and reason, so they can be reviewed and costed.
*   **Repetitive allocation:** Repetitive moves are split across the schedules they were allocated to, and each allocation must be visible with its quantity and start date.

### The Solution
*   **Move detail:** Each move transaction is shown with its from and to operation, department, intraoperation step, transaction and primary quantities, and units of measure.
*   **Allocation split:** Repetitive moves are joined to their allocations, so a move that spans several repetitive schedules appears once per schedule with the allocated quantity.
*   **Daily totals:** The transaction day is the transaction date without the time, so users can total the moves by day.
*   **Scrap and over-completion:** The over-completion flag, over-completed quantities and the scrap account are shown with the move.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_MOVE_TRANSACTIONS`: the move transaction header, with the from and to operation, department, step, quantities, reason, reference and scrap account.
*   `WIP_MOVE_TXN_ALLOCATIONS`: the allocation of a repetitive move to a schedule and quantity.
*   `WIP_REPETITIVE_SCHEDULES`: the repetitive schedule, with its first unit start date.
*   `WIP_ENTITIES`: the job or schedule name and entity type.
*   `WIP_LINES`: the production line.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly number and description.
*   `BOM_DEPARTMENTS`: the from and to departments.
*   `MTL_TRANSACTION_REASONS`: the transaction reason name.
*   `PER_ALL_PEOPLE_F`: the employee who performed the move.
*   `MTL_PARAMETERS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

#### Logical Relationships
1.  `MTL_PARAMETERS` joins to `WIP_MOVE_TRANSACTIONS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  Each move joins to its allocations as an outer join, so moves that are not repetitive are kept once.
3.  The allocation joins to `WIP_REPETITIVE_SCHEDULES` on the schedule ID, as an outer join.
4.  The move joins to `WIP_ENTITIES` on the job ID, to `WIP_LINES` on the line ID, and to `MTL_SYSTEM_ITEMS_VL` on the primary item.
5.  The from and to departments join to `BOM_DEPARTMENTS`, the reason to `MTL_TRANSACTION_REASONS`, and the employee to `PER_ALL_PEOPLE_F` by a transaction date that falls within the person's effective dates.

### Parameters & Filtering
*   **Organization Code:** selects the organization.
*   **Date From** and **Date To:** bound the transaction date of the moves.
*   **Job:**, **Line** and **Assembly:** select a job, a production line or an assembly.
*   **From Department** and **To Department:** select the departments the move came from and went to.
*   **From Step** and **To Step:** select the intraoperation step at each end of the move.
*   **Reason:** selects the transaction reason.
*   **Employee Number:** selects the moves performed by one employee.

### Performance & Optimization
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied first, so the move table is read only for accessible organizations.
*   Allocations are outer joined to the move, so each move is read once and the allocations expand it only for repetitive moves.
*   The employee join uses the transaction date range against the person's effective dates, so each move matches the employee record that was effective when it was made.
*   The department, reason and line joins are keyed on primary identifiers, so each adds at most one row to a move.

### FAQ
**Q: Why does one move appear more than once?**
A: A repetitive move is shown once for each repetitive schedule it was allocated to, with the allocated quantity and the first unit start date of that schedule.

**Q: What is the difference between Quantity and Primary Quantity?**
A: Quantity is in the unit of measure the transaction was entered in, and Primary Quantity is in the primary unit of measure of the assembly.

**Q: Which transactions are not in the report?**
A: The description states that transactions still pending in the move transaction interface are not included.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
