---
layout: default
last_modified_at: 2026-10-26
title: 'MRP Master Schedule Upload | Oracle EBS SQL Report'
description: 'MRP Master Schedule Upload ========================== - Create new MDS/MPS schedule entries. - Create and Update existing schedule entries. Each row…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, MRP, Master, Schedule, mtl_parameters, mrp_schedule_designators, mrp_schedule_dates'
permalink: /MRP%20Master%20Schedule%20Upload/
report_name: 'MRP Master Schedule Upload'
report_web_name: mrp-master-schedule-upload
---

# MRP Master Schedule Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-master-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload).

## Overview
MRP Master Schedule Upload
==========================
- Create new MDS/MPS schedule entries.
- Create and Update existing schedule entries.

Each row stages one schedule entry into the MRP schedule interface (mrp_schedule_interface, process_status=2) for an existing schedule designator (MDS or MPS). The staged entries are loaded into the master schedule (mrp_schedule_dates) asynchronously by the customer's MRP Planning Manager.

Upload Modes
============
Create - opens an empty spreadsheet to enter new schedule entries against any accessible schedule designator.
Create and Update - downloads existing schedule entries for the selected schedule designators and lets the user add new entries and re-stage modifications. Existing entries are matched on the hidden Transaction Id.

Prerequisites
=============
- Schedule designators (Master Demand Schedule / Master Production Schedule) must be defined.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Default Workday Control, Organization Code, Schedule Type, Schedule Name, Planner, Item, Schedule Date From, Schedule Date To

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload), [mrp_schedule_designators](https://www.enginatics.com/library/?pg=1&find=mrp_schedule_designators&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload), [mrp_schedule_dates](https://www.enginatics.com/library/?pg=1&find=mrp_schedule_dates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [MRP Item Forecast Upload](/MRP%20Item%20Forecast%20Upload/ "MRP Item Forecast Upload Oracle EBS SQL Report"), [INV Item Supply/Demand](/INV%20Item%20Supply-Demand/ "INV Item Supply/Demand Oracle EBS SQL Report"), [MRP Item Forecast](/MRP%20Item%20Forecast/ "MRP Item Forecast Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [ENG Engineering Change Orders](/ENG%20Engineering%20Change%20Orders/ "ENG Engineering Change Orders Oracle EBS SQL Report"), [ENG Engineering Change Order Upload](/ENG%20Engineering%20Change%20Order%20Upload/ "ENG Engineering Change Order Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Master%20Schedule%20Upload/MRP%20Master%20Schedule%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/mrp-master-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload) |
| Blitz Report™ XML Import | [MRP_Master_Schedule_Upload.xml](https://www.enginatics.com/xml/mrp-master-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload) |
| SQL Source | [MRP Master Schedule Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Master%20Schedule%20Upload/MRP%20Master%20Schedule%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-master-schedule-upload/](https://www.enginatics.com/reports/mrp-master-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload) |

## Case Study & Technical Analysis: MRP Master Schedule Upload

### Executive Summary
MRP Master Schedule Upload creates and changes the entries of Oracle Master Demand Schedules and Master Production Schedules, the planned quantities by item and date that drive material requirements planning. Each row stages one schedule entry for an existing schedule designator, and the staged entries are loaded into the master schedule asynchronously by the MRP Planning Manager. Demand planners, production planners and supply chain analysts use it to load forecast quantities, revise planned production, and enter schedule changes for many items in one spreadsheet rather than one date at a time.

### Business Challenge
*   **Forecast Loading:** Demand forecasts for a planning horizon must be entered for many items and dates, which is slow in the schedule form.
*   **Frequent Revisions:** Planners revise schedule quantities often as orders and forecasts change, so the revision cycle needs a repeatable spreadsheet process.
*   **Schedule Consistency:** Entries must reference a valid schedule designator, item and organization, or the planning run rejects them.
*   **Traceability:** Revised entries must be matched to the entries they replace, so the history of a schedule stays clear.

### The Solution
*   **New and Existing Entries:** Create mode opens an empty sheet for new entries, while Create and Update downloads the existing entries of the selected designators.
*   **Matching On Transaction Identifier:** Existing entries are matched through a hidden transaction identifier, so a revised quantity updates the right entry.
*   **Staged Load:** Each row is written to the MRP schedule interface with a pending status, to be loaded by the planning manager process.
*   **Attributes:** Schedule comments and the fifteen user attribute columns are carried with each entry.

### Technical Architecture (High Level)
#### Primary Tables
*   `MRP_SCHEDULE_DESIGNATORS`: the master demand and master production schedule definitions, with their type and description.
*   `MRP_SCHEDULE_DATES`: the schedule entries, with the item, date, quantity, end date, comments and attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the items, with their concatenated segments, primary unit of measure and planner code.
*   `MTL_PARAMETERS`: the organizations that own the schedules.

#### Logical Relationships
1.  Each schedule designator in `MRP_SCHEDULE_DESIGNATORS` is joined to its organization in `MTL_PARAMETERS`.
2.  Schedule entries in `MRP_SCHEDULE_DATES` are joined to their designator on organization and schedule designator.
3.  Entries are restricted to schedule level 2, the item level of the schedule.
4.  Each entry is joined to `MTL_SYSTEM_ITEMS_VL` on organization and inventory item identifier to return the item, unit of measure and planner.
5.  The transaction identifier of each entry is returned as the key used when a row is matched on upload.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing entries are downloaded.
*   **Default Workday Control:** Sets the workday control value applied to new entries.
*   **Organization Code:** Restricts the schedules to one organization.
*   **Schedule Type:** Restricts the designators to master demand or master production schedules.
*   **Schedule Name:** Restricts the output to one schedule designator.
*   **Planner and Item:** Restrict the entries to items with one planner code or to one item.
*   **Schedule Date From and Schedule Date To:** Limit the entries to a date window.

### Performance & Optimization
*   **Designator Driven Extract:** The organization and designator relationship restricts the entries to the selected schedules before the item join.
*   **Item Level Restriction:** Only item level entries are read, which keeps the extract to the rows a planner maintains.
*   **Create Mode Suppression:** In Create mode the existing entries are not read, so the template is empty and the extract is minimal.
*   **Asynchronous Load:** The upload writes to an interface rather than to the master schedule directly, so the heavy loading work is done by the planning process.

### FAQ
**Q: Does the upload change the master schedule immediately?**
A: No. Each row is staged in the MRP schedule interface with a pending process status, and the MRP Planning Manager loads it into the master schedule.

**Q: How are changes to existing schedule entries matched?**
A: They are matched on the hidden transaction identifier of each downloaded entry, so the template must be the one downloaded for the schedule.

**Q: What are the prerequisites for the upload?**
A: The schedule designators, either master demand or master production schedules, must be defined before entries are uploaded.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-master-schedule-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
