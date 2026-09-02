---
layout: default
title: 'EAM PM Schedule Upload | Oracle EBS SQL Report'
description: 'EAM Preventive Maintenance Schedule Upload ========================================= Create or update Oracle EAM Preventive Maintenance schedule…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, EAM, Schedule, eam_pm_schedulings, csi_item_instances, mtl_eam_asset_activities'
permalink: /EAM%20PM%20Schedule%20Upload/
---

# EAM PM Schedule Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-pm-schedule-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Organization, Update Activities, Update Rules, Update Last Service

## Oracle EBS Tables Used
[eam_pm_schedulings](https://www.enginatics.com/library/?pg=1&find=eam_pm_schedulings), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [mtl_eam_asset_activities](https://www.enginatics.com/library/?pg=1&find=mtl_eam_asset_activities), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [eam_pm_set_names](https://www.enginatics.com/library/?pg=1&find=eam_pm_set_names), [eam_wo_statuses_v](https://www.enginatics.com/library/?pg=1&find=eam_wo_statuses_v), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [q_base](https://www.enginatics.com/library/?pg=1&find=q_base), [eam_pm_activities](https://www.enginatics.com/library/?pg=1&find=eam_pm_activities), [eam_pm_scheduling_rules](https://www.enginatics.com/library/?pg=1&find=eam_pm_scheduling_rules), [csi_counters_vl](https://www.enginatics.com/library/?pg=1&find=csi_counters_vl), [eam_pm_last_service](https://www.enginatics.com/library/?pg=1&find=eam_pm_last_service), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [EAM Asset Activity Association Upload](/EAM%20Asset%20Activity%20Association%20Upload/ "EAM Asset Activity Association Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/eam-pm-schedule-upload/) |
| Blitz Report™ XML Import | [EAM_PM_Schedule_Upload.xml](https://www.enginatics.com/xml/eam-pm-schedule-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/eam-pm-schedule-upload/](https://www.enginatics.com/reports/eam-pm-schedule-upload/) |



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
