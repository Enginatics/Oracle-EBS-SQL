---
layout: default
last_modified_at: 2026-10-16
title: 'WIP Move Transactions 11i | Oracle EBS SQL Report'
description: 'WIP move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, one row per transaction, as shown in the View Move…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Work in Process, Enginatics, WIP, Move, Transactions, 11i, mtl_parameters, wip_move_transactions, wip_move_txn_allocations'
permalink: /WIP%20Move%20Transactions%2011i/
report_name: 'WIP Move Transactions 11i'
report_web_name: wip-move-transactions-11i
module: 'Work in Process'
module_url: /modules/work-in-process/
---

# WIP Move Transactions 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-move-transactions-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i).
**Oracle EBS module:** [Work in Process](/modules/work-in-process/ "Oracle EBS Work in Process reports") · [all Work in Process reports](/modules/work-in-process/)  

## Overview
WIP move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, one row per transaction, as shown in the View Move Transactions form.

The report covers the data of the Oracle standard Move Transaction Report (WIPTSMOV): from and to operation, department and intraoperation step, transaction and primary quantity, reason and reference, over-completion and scrap account.

A repetitive move is shown once per repetitive schedule it was allocated to, with the schedule's first unit start date and the allocated quantity.

Quantity is in the unit of measure the transaction was entered in, Primary Quantity in the assembly's primary unit of measure. Transaction Day is the transaction date without the time, for daily totals.

Transactions still pending in the move transaction interface are not included.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Date From, Date To, Job, Line, Assembly, From Department, To Department, From Step, To Step, Reason

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [wip_move_transactions](https://www.enginatics.com/library/?pg=1&find=wip_move_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [wip_move_txn_allocations](https://www.enginatics.com/library/?pg=1&find=wip_move_txn_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [wip_repetitive_schedules](https://www.enginatics.com/library/?pg=1&find=wip_repetitive_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)

## Related Reports
[WIP Move Transactions](/WIP%20Move%20Transactions/ "WIP Move Transactions Oracle EBS SQL Report"), [INV Move Orders](/INV%20Move%20Orders/ "INV Move Orders Oracle EBS SQL Report"), [WIP Move Transaction Upload](/WIP%20Move%20Transaction%20Upload/ "WIP Move Transaction Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Move%20Transactions%2011i/WIP%20Move%20Transactions%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/wip-move-transactions-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i) |
| Blitz Report™ XML Import | [WIP_Move_Transactions_11i.xml](https://www.enginatics.com/xml/wip-move-transactions-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i) |
| SQL Source | [WIP Move Transactions 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Move%20Transactions%2011i/WIP%20Move%20Transactions%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-move-transactions-11i/](https://www.enginatics.com/reports/wip-move-transactions-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i) |

## Case Study & Technical Analysis: WIP Move Transactions 11i

### Executive Summary
The WIP Move Transactions 11i report lists the Oracle Work in Process move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, with one row per transaction. It matches the View Move Transactions form and carries the data of the standard Move Transaction Report (WIPTSMOV): the from and to operation, department and intraoperation step, the transaction and primary quantities, the reason and reference, and the over-completion and scrap accounts. Production supervisors and cost accountants use it to review the shop floor flow of a day or a week, to reconcile moves with the WIP valuation and to find moves that were over-completed or scrapped. It runs in Excel through Blitz Report.

### Business Challenge
*   **Shop floor visibility:** Moves record how many units passed each operation, and the supervisor must see the flow of work by department and step.
*   **Daily totals:** Production output is reported by day, and each move must be grouped by its transaction date without the time.
*   **Scrap and over-completion:** Scrapped and over-completed quantities post to specific accounts, and they must be reviewed for each job.
*   **Repetitive scheduling:** A repetitive move is allocated across several schedules, and each allocation must be read against its own first unit start date.

### The Solution
*   Lists each move transaction with its date, the transaction day, the job or repetitive schedule and its job type, line and assembly.
*   Shows the from and to operation sequence, operation code, department and intraoperation step, so the path of a move through the routing is visible.
*   Shows the transaction quantity in the entered unit of measure and the primary quantity in the assembly's primary unit, with the over-completion quantity.
*   Shows the reason, reference, source code, the scrap account and the user who created the move.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_MOVE_TRANSACTIONS`: one row per move transaction, with the from and to operation, department, step, quantities, reason, reference and accounts.
*   `WIP_MOVE_TXN_ALLOCATIONS`: the allocation of a repetitive move to each repetitive schedule.
*   `WIP_REPETITIVE_SCHEDULES`: the repetitive schedule, with its first unit start date and allocated quantity.
*   `WIP_ENTITIES`: the job or schedule name and its entity type.
*   `WIP_LINES`: the production line of the move.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly, with its concatenated segments and description.
*   `BOM_DEPARTMENTS`: the from and to departments.
*   `MTL_TRANSACTION_REASONS`: the reason of the move.
*   `MTL_PARAMETERS` and `ORG_ACCESS_VIEW`: the organization and the organizations of the responsibility.

#### Logical Relationships
1.  `WIP_MOVE_TRANSACTIONS` is joined to `WIP_MOVE_TXN_ALLOCATIONS` on the transaction id as an outer join, so a discrete move without allocations is still listed.
2.  The allocation is joined to `WIP_REPETITIVE_SCHEDULES` on the repetitive schedule id, which supplies the schedule start date.
3.  The move is joined to `WIP_ENTITIES` on the entity id, and to `WIP_LINES` on the line id and organization.
4.  The assembly is an outer join to `MTL_SYSTEM_ITEMS_VL` on the organization and primary item id.
5.  The from and to departments are joined to `BOM_DEPARTMENTS` on the department ids, and the reason to `MTL_TRANSACTION_REASONS`.

### Parameters & Filtering
*   **Organization Code:** restricts the moves to one inventory organization.
*   **Date From** and **Date To:** bound the transaction dates of the moves.
*   **Job** and **Line:** select one job or one production line.
*   **Assembly:** selects the moves of one item.
*   **From Department** and **To Department:** select the moves that started in, or arrived at, one department.
*   **From Step** and **To Step:** select the moves by intraoperation step.
*   **Reason:** selects the moves with one reason.

### Performance & Optimization
*   The organization access check is a subquery on `ORG_ACCESS_VIEW`, so the move table is read only for the responsibility's organizations.
*   The allocation and schedule joins are outer joins on keys, so a move returns one row for each allocation, and one row when it has none.
*   The department joins are inner joins on the department ids of the move, which removes moves without a valid from or to department.
*   Restricting Date From and Date To reduces the move rows first, because the move table grows with every transaction.

### FAQ
**Q: How do I total the moves of a day for a department?**
A: Use the Transaction Day column, which is the transaction date without the time, and sum the Primary Quantity column by To Department.

**Q: Why does a repetitive move appear more than once?**
A: A repetitive move is shown once for each repetitive schedule it was allocated to, with that schedule's first unit start date and the allocated quantity.

**Q: Are pending move transactions included?**
A: No. Transactions that are still pending in the move transaction interface are not included in the report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transactions-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
