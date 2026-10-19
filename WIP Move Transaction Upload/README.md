---
layout: default
last_modified_at: 2026-10-19
title: 'WIP Move Transaction Upload | Oracle EBS SQL Report'
description: 'Creates move transactions as in the Move Transactions form: moves between operations and intraoperation steps, including moves into and out of Reject and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, WIP, Move, Transaction, wip_operations, mtl_parameters, wip_discrete_jobs'
permalink: /WIP%20Move%20Transaction%20Upload/
report_name: 'WIP Move Transaction Upload'
report_web_name: wip-move-transaction-upload
---

# WIP Move Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-move-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload).

## Overview
Creates move transactions as in the Move Transactions form: moves between operations and intraoperation steps, including moves into and out of Reject and Scrap, Move and completion transactions and Return and move transactions, for discrete jobs and for the repetitive schedules of a line and assembly. Each row is posted immediately, with backflush, completion, outside processing and autocharge resources as for a move entered in the form.

Upload Mode Create opens an empty sheet. Create, Update downloads the Queue, Run and To move steps of the selected jobs and schedules that hold a quantity, with their Available quantity, as new move rows: enter To Step and Quantity on the rows to move, rows left unchanged are not uploaded. An existing move is never updated; correct it with another move, for example a backward move or a Return and move transaction.

Completions, returns and overcompletions follow the Transaction Types and Allow Overcompletion parameters, not the function Move Transactions is launched from. A .csv or plain .xlsx file, and an add-in upload of a sheet another user downloaded, run with the parameter defaults of the template named in the upload, else with the parameter defaults.

With E-Records and E-Signatures set to Yes, discrete job moves create e-records as in the Move Transactions form, also where the move or material processing profiles are set to background, where the form creates none. A move that needs an e-signature is refused and has to be entered in the form. With the parameter cleared, moves are posted without e-records, as through the WIP move interface.

Not supported: operations added on the fly, manual resource transactions, serialized jobs and backflush lot and serial entry. A move fails when a backflush component is serial controlled, or lot controlled with a lot that cannot be derived; derived lots are not verified. Mandatory quality collection plans are not enforced, as by the WIP move interface, and No Move shop floor statuses always apply, also for users of the form function that overrides them.

To enter descriptive flexfield values, add the Move Attribute Category and Move Attribute1-15 columns, which show the segment prompts, to a template of your own.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Sales Order, Order Line, Line, Assembly, Job, Transaction Types, Allow Overcompletion, E-Records and E-Signatures

## Oracle EBS Tables Used
[wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [wip_repetitive_schedules](https://www.enginatics.com/library/?pg=1&find=wip_repetitive_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)

## Related Reports
[CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Move%20Transaction%20Upload/WIP%20Move%20Transaction%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WIP Move Transaction Upload 15-Oct-2026 194318.xlsx](https://www.enginatics.com/example/wip-move-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload) |
| Blitz Report™ XML Import | [WIP_Move_Transaction_Upload.xml](https://www.enginatics.com/xml/wip-move-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload) |
| SQL Source | [WIP Move Transaction Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Move%20Transaction%20Upload/WIP%20Move%20Transaction%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-move-transaction-upload/](https://www.enginatics.com/reports/wip-move-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload) |

## Case Study & Technical Analysis: WIP Move Transaction Upload

### Executive Summary
WIP Move Transaction Upload creates move transactions in Oracle Work in Process, the transactions that move completed quantities from one operation or intraoperation step to the next along a discrete job or repetitive schedule. It mirrors the Move Transactions form for moves between operations, moves into and out of Reject and Scrap, move and completion transactions, and return and move transactions. Shop floor supervisors, production planners and manufacturing accountants use it to post large volumes of moves at the end of a shift, or to post moves for a set of jobs in one spreadsheet, while keeping backflush, completion and resource charging consistent with the form.

### Business Challenge
*   **Shop Floor Volume:** A plant can record hundreds of moves each shift, and entering each one in the form delays reporting.
*   **Job Status Visibility:** Planners need to see how much quantity sits in each queue, run and move step before deciding what to move.
*   **Consistent Charging:** Moves must trigger the same backflush, completion and resource charges as the form, or costs are misstated.
*   **Compliance Records:** Where electronic records and signatures apply, the upload must create the same records as the form.

### The Solution
*   **Available Quantity Download:** In Create and Update mode the queue, run and to move steps that hold a quantity are downloaded with their available quantity, so the user enters only the quantity to move.
*   **Move Rows:** Each row is posted as a move, with the from and to operation and step, the quantity and the transaction date.
*   **Parameter Control:** Transaction types and overcompletion settings are controlled by parameters rather than by the function used to launch the upload.
*   **Record Creation:** With E-Records and E-Signatures set to Yes, discrete job moves create electronic records as the form does.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_DISCRETE_JOBS`: the discrete jobs, with their status, bill revision and primary item.
*   `WIP_ENTITIES`: the job and schedule entity names and descriptions.
*   `WIP_REPETITIVE_SCHEDULES`: the repetitive schedules, with their status, bill revision and first unit start date.
*   `WIP_LINES`: the production lines of repetitive schedules.
*   `WIP_OPERATIONS`: the operations of each job or schedule, with the operation sequence, the department, the standard operation and the quantities in queue, running and waiting to move.
*   `BOM_STANDARD_OPERATIONS`: the standard operation codes.
*   `BOM_DEPARTMENTS`: the department codes.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly items.
*   `MTL_PARAMETERS`: the organizations.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

#### Logical Relationships
1.  Discrete jobs in `WIP_DISCRETE_JOBS` are joined to their entity in `WIP_ENTITIES` and to their assembly in `MTL_SYSTEM_ITEMS_VL`.
2.  Operations in `WIP_OPERATIONS` are joined to each job and to their standard operation and department.
3.  Each operation is expanded with a row generator into one row for each intraoperation step, queue, run and to move, and the quantity for that step is chosen by decode.
4.  The next operation of the job, the to step, is found by a correlated subquery for the first count point that follows the current operation.
5.  Repetitive schedules in `WIP_REPETITIVE_SCHEDULES` are joined to `WIP_LINES` and to their operations in the same way, with the quantities summed across the schedule's operations.
6.  The discrete and repetitive branches are combined with UNION ALL, and each row is numbered to give the upload row.

### Parameters & Filtering
*   **Organization Code:** Restricts the jobs and schedules to one organization.
*   **Sales Order, Order Line, Line, Assembly and Job:** Select the jobs and schedules to download, by sales order, line, assembly or job name.
*   **Transaction Types:** Controls the transaction type applied to the moves.
*   **Allow Overcompletion:** Controls whether moves that exceed the job quantity are allowed.
*   **E-Records and E-Signatures:** Controls whether electronic records are created for discrete job moves.

### Performance & Optimization
*   **Released Jobs Only:** Discrete jobs are restricted to released and completed status types, and repetitive schedules to the same status types, so closed work is not downloaded.
*   **Positive Availability Filter:** Only steps with a quantity greater than zero are returned, which keeps the download to actionable rows.
*   **Row Generator Expansion:** The intraoperation steps are produced by a row generator, so one operation becomes three rows without repeated table reads.
*   **Serialized and Operation Exclusions:** Serialized jobs and operations that are not standard operations are excluded at the join level, which keeps the set limited to supported work.

### FAQ
**Q: Can I update a move I entered earlier with this upload?**
A: No. An existing move is never updated. Correct it with another move, such as a backward move or a Return and move transaction.

**Q: Which rows are uploaded?**
A: Only rows where To Step and Quantity have been entered are uploaded. Rows left unchanged are not uploaded.

**Q: Are operations added on the fly supported?**
A: No. The description lists operations added on the fly as not supported, along with manual resource transactions and serialized jobs.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-move-transaction-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
