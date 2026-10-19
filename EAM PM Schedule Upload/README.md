---
layout: default
last_modified_at: 2026-10-19
title: 'EAM PM Schedule Upload | Oracle EBS SQL Report'
description: 'EAM Preventive Maintenance Schedule Upload ========================================= Create or update Oracle EAM Preventive Maintenance schedule…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, EAM, Schedule, eam_pm_activities, eam_pm_schedulings, csi_item_instances'
permalink: /EAM%20PM%20Schedule%20Upload/
report_name: 'EAM PM Schedule Upload'
report_web_name: eam-pm-schedule-upload
---

# EAM PM Schedule Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-pm-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload).

## Overview
EAM Preventive Maintenance Schedule Upload
=========================================
Create or update Oracle EAM Preventive Maintenance schedule definitions, including:
  - PM Schedule header (asset or asset group, activity, schedule name, set name, type, rescheduling point, etc.)
  - Activity group (for Rule Based schedules: list of activities with interval multiples)
  - Scheduling rules: Day Interval, Runtime / Meter, and List Date rules
  - Optional Last Service info (per meter)

Row Model
=========
Each spreadsheet row can contain PM header values plus any populated child-object columns. The upload infers the object levels from populated column groups:
  - Header columns identify and define the PM schedule.
  - Act Activity columns add PM activity-group entries. If no Act Activity is entered for a new Rule Based schedule, the header Activity is used as the first activity entry.
  - Rule columns add Day Interval, Runtime Meter, or List Date scheduling rules.
  - LSI columns add optional last-service readings.

Act Last Svc Start and Act Last Svc End show the last service dates that work order completion records on the activity association. They are read-only and not uploaded.

The upload saves schedules, activities and rules as the Preventive Maintenance form does: a changed rule is updated in place, Delete Rule removes it, and a rule row without a rule id is added. Rule Last Service Reading is derived from the last service information on save and is read-only.

Rows belonging to the same PM must repeat the same Organization Code + Schedule Name + Asset + Activity and remain contiguous. The header is processed once per PM; repeated rows are used for additional activities, rules, and last-service readings.

Upload Modes
============
Create - empty spreadsheet for new PM schedules.
Create, Update - downloads existing PM schedules for review/edit and allows adding new ones.

IMPORTANT on Update
-------------------
In Create, Update mode, use Update Activities / Update Rules / Update Last Service to include those child details in the downloaded template. Update Activities defaults to Yes; the other child sections are optional.

PM Set Name
===========
- Reference an existing Set Name, or
- Enter a new Set Name together with Set Name Description / End Date / Local Flag; the upload will auto-create it via EAM_SetName_PUB.

After Upload
============
Schedule and run the "XMLSG - Create Preventive Maintenance Work Order" concurrent program - uploading a PM schedule alone does not generate work orders.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization, Update Activities, Update Rules, Update Last Service

## Oracle EBS Tables Used
[eam_pm_activities](https://www.enginatics.com/library/?pg=1&find=eam_pm_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [eam_pm_schedulings](https://www.enginatics.com/library/?pg=1&find=eam_pm_schedulings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [mtl_eam_asset_activities](https://www.enginatics.com/library/?pg=1&find=mtl_eam_asset_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [eam_pm_set_names](https://www.enginatics.com/library/?pg=1&find=eam_pm_set_names&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [eam_wo_statuses_v](https://www.enginatics.com/library/?pg=1&find=eam_wo_statuses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [eam_pm_scheduling_rules](https://www.enginatics.com/library/?pg=1&find=eam_pm_scheduling_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [csi_counters_vl](https://www.enginatics.com/library/?pg=1&find=csi_counters_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [eam_pm_last_service](https://www.enginatics.com/library/?pg=1&find=eam_pm_last_service&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)

## Related Reports
[EAM PM Schedule Upload 11i](/EAM%20PM%20Schedule%20Upload%2011i/ "EAM PM Schedule Upload 11i Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM Work Orders 11i](/EAM%20Work%20Orders%2011i/ "EAM Work Orders 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20PM%20Schedule%20Upload/EAM%20PM%20Schedule%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eam-pm-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload) |
| Blitz Report™ XML Import | [EAM_PM_Schedule_Upload.xml](https://www.enginatics.com/xml/eam-pm-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload) |
| SQL Source | [EAM PM Schedule Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20PM%20Schedule%20Upload/EAM%20PM%20Schedule%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-pm-schedule-upload/](https://www.enginatics.com/reports/eam-pm-schedule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload) |

## Case Study & Technical Analysis: EAM PM Schedule Upload

### Executive Summary
This upload creates and updates Oracle Enterprise Asset Management preventive maintenance schedules. A schedule covers the header for an asset or asset group, its activity group, its scheduling rules and optional last service readings. Maintenance planners use it to set up or revise the service plan for a plant's equipment in one workbook, rather than through the Preventive Maintenance form asset by asset. It is used by EAM administrators and planners who maintain large fleets of meter-based and calendar-based services. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Large service plans:** Each asset can carry several activities, each with its own interval, and maintaining them one at a time is slow.
*   **Mixed scheduling rules:** Runtime or meter intervals, day intervals and fixed list dates must be combined correctly on one schedule.
*   **Continuity of service history:** Last service readings and dates determine when the next service falls due, and they must be carried into the new schedule.
*   **Set name governance:** Schedules that share a set name must reference a consistent set, which may need to be created on the fly.

### The Solution
*   **Row model by column group:** A row can hold header values, an activity entry, a scheduling rule and a last service reading, and the upload infers the level from the populated columns.
*   **Activity entries:** Each Act Activity column adds an activity to a rule-based schedule, with its interval multiple and repeat flag.
*   **Scheduling rules:** Day Interval, Runtime Meter and List Date rules are added, changed in place, or removed with Delete Rule.
*   **Last service readings:** Last service readings are uploaded per meter, and the last service dates recorded by work order completion are shown read only.
*   **Set name creation:** A new Set Name can be entered with its description, end date and local flag, and the upload creates it.

### Technical Architecture (High Level)
#### Primary Tables
*   `EAM_PM_SCHEDULINGS`: the PM schedule header, with type, scheduling method, rescheduling point, base date, base reading and effectivity dates.
*   `EAM_PM_ACTIVITIES`: the activity associations of each schedule, with the activity association id.
*   `EAM_PM_SCHEDULING_RULES`: the day interval, meter and list date rules attached to a schedule.
*   `EAM_PM_LAST_SERVICE`: the last service readings and previous readings per meter and work order job.
*   `EAM_PM_SET_NAMES`: the PM set names.
*   `MTL_EAM_ASSET_ACTIVITIES`: the activities defined for an asset.
*   `CSI_ITEM_INSTANCES` and `MTL_SYSTEM_ITEMS_B_KFV`: the asset instance and the asset group or activity item.
*   `CSI_COUNTERS_VL`: the meters used by runtime rules and last service readings.
*   `EAM_WO_STATUSES_V` and `WIP_ENTITIES`: the work order status for generation and the job for a last service reading.

#### Logical Relationships
1. `EAM_PM_SCHEDULINGS` is the header source. Its activity association id falls back to the first activity of the schedule when none is set.
2. The header joins to `CSI_ITEM_INSTANCES` for asset maintenance objects, and to `MTL_SYSTEM_ITEMS_B_KFV` for asset groups.
3. The activity joins through `MTL_EAM_ASSET_ACTIVITIES` to the activity item, on activity association and organization.
4. Rule rows join `EAM_PM_SCHEDULING_RULES` to the header on schedule id, and the meter joins to `CSI_COUNTERS_VL` as an outer join.
5. Last service rows join `EAM_PM_LAST_SERVICE` on the activity association, and the job joins to `WIP_ENTITIES` as an outer join.
6. The three row sets are combined with UNION ALL, and each set is included only when its update flag is Y.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing schedules.
*   **Organization:** restricts the schedules to one organization, limited to those the responsibility can access.
*   **Update Activities:** includes the activity rows in the download, and defaults to Yes.
*   **Update Rules:** includes the scheduling rule rows in the download.
*   **Update Last Service:** includes the last service rows in the download.

### Performance & Optimization
*   The organization test on `ORG_ACCESS_VIEW` limits every block to the organizations the responsibility can access.
*   Each child block is included only when its parameter is Y, so a header-only download does not read rules or last service data.
*   The activity lookup falls back to a minimum activity association id per schedule, which gives each schedule one deterministic header row.

### FAQ
**Q: Why do my work orders not appear after I upload a schedule?**
A: Uploading a schedule does not generate work orders. Run the Create Preventive Maintenance Work Order concurrent program after the upload.

**Q: How do I remove a scheduling rule?**
A: Set Delete Rule on the rule row. A changed rule is updated in place, and a rule row without a rule id is added.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
