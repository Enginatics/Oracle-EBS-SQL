---
layout: default
last_modified_at: 2026-10-16
title: 'EAM PM Schedule Upload 11i | Oracle EBS SQL Report'
description: 'EAM Preventive Maintenance Schedule Upload ========================================= Create or update Oracle EAM Preventive Maintenance schedule…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, EAM, Schedule, 11i, eam_pm_schedulings, mtl_eam_asset_activities, mtl_serial_numbers'
permalink: /EAM%20PM%20Schedule%20Upload%2011i/
report_name: 'EAM PM Schedule Upload 11i'
report_web_name: eam-pm-schedule-upload-11i
---

# EAM PM Schedule Upload 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-pm-schedule-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i).

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

The upload saves schedules and rules as the Preventive Maintenance form does: a changed rule is updated in place, Delete Rule removes it, and a rule row without a rule id is added. Rule Last Service Reading is read-only.

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization, Update Activities, Update Rules, Update Last Service

## Oracle EBS Tables Used
[eam_pm_schedulings](https://www.enginatics.com/library/?pg=1&find=eam_pm_schedulings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [mtl_eam_asset_activities](https://www.enginatics.com/library/?pg=1&find=mtl_eam_asset_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [mtl_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_serial_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [eam_pm_set_names](https://www.enginatics.com/library/?pg=1&find=eam_pm_set_names&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [eam_pm_scheduling_rules](https://www.enginatics.com/library/?pg=1&find=eam_pm_scheduling_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [eam_meters](https://www.enginatics.com/library/?pg=1&find=eam_meters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [eam_pm_last_service](https://www.enginatics.com/library/?pg=1&find=eam_pm_last_service&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)

## Related Reports
[EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [EAM Work Orders 11i](/EAM%20Work%20Orders%2011i/ "EAM Work Orders 11i Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Organization Parameters](/INV%20Organization%20Parameters/ "INV Organization Parameters Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20PM%20Schedule%20Upload%2011i/EAM%20PM%20Schedule%20Upload%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eam-pm-schedule-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i) |
| Blitz Report™ XML Import | [EAM_PM_Schedule_Upload_11i.xml](https://www.enginatics.com/xml/eam-pm-schedule-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i) |
| SQL Source | [EAM PM Schedule Upload 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20PM%20Schedule%20Upload%2011i/EAM%20PM%20Schedule%20Upload%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-pm-schedule-upload-11i/](https://www.enginatics.com/reports/eam-pm-schedule-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i) |

## Case Study & Technical Analysis: EAM PM Schedule Upload 11i

### Executive Summary
The EAM PM Schedule Upload 11i creates and maintains Preventive Maintenance (PM) schedule definitions in Oracle Enterprise Asset Management. Each spreadsheet can carry the PM header, its activity group, its scheduling rules and optional last-service readings for an asset or asset group. Maintenance planners and EAM implementation teams use it to set up or revise recurring maintenance programs for many assets at once, following the same rules as the Preventive Maintenance form. The report runs in Excel via Blitz Report. Uploading a schedule does not create work orders; the "XMLSG - Create Preventive Maintenance Work Order" concurrent program must be run afterwards.

### Business Challenge
*   **Large maintenance programs:** Defining day-interval, runtime-meter and list-date schedules one at a time through the form is slow across a fleet of assets.
*   **Rule consistency:** Each PM schedule combines a header, activities and rules, and inconsistent setup produces missed or duplicated services.
*   **Meter-based scheduling:** Runtime and meter rules depend on meter readings and last-service values that must be recorded accurately before scheduling works.
*   **Set name governance:** Shared PM set names must be reused or created consistently across organizations.

### The Solution
*   **Hierarchical row model:** Header, activity, rule and last-service columns share one spreadsheet, and the upload infers the object level from which column groups are populated.
*   **Form-equivalent processing:** A changed rule is updated in place, a Delete Rule entry removes a rule, and a rule row without a rule identifier is added.
*   **Set name handling:** An existing set name can be referenced, or a new one created with its description, end date and local flag.
*   **Selective child download:** Update Activities, Update Rules and Update Last Service control which child details appear in the downloaded template.

### Technical Architecture (High Level)
#### Primary Tables
*   `EAM_PM_SCHEDULINGS`: the PM schedule header, including type, effective dates, rescheduling point and scheduling method.
*   `EAM_PM_SCHEDULING_RULES`: the day interval, runtime meter and list date rules attached to a schedule.
*   `EAM_PM_LAST_SERVICE`: last-service meter readings and work order links for each activity association.
*   `EAM_PM_SET_NAMES`: the named sets that group PM schedules.
*   `MTL_EAM_ASSET_ACTIVITIES`: the activity associations that link a maintenance object to a PM activity.
*   `MTL_SERIAL_NUMBERS`, `MTL_SYSTEM_ITEMS_B_KFV`: the asset numbers and the asset or asset group items.
*   `EAM_METERS`: the meter definitions referenced by rules and last-service readings.
*   `WIP_ENTITIES`: the work order entity referenced by last-service rows.
*   `MFG_LOOKUPS`: the work order status meanings.
*   `MTL_PARAMETERS`, `ORG_ACCESS_VIEW`: the EAM-enabled organizations and the responsibility security.

#### Logical Relationships
1. `EAM_PM_SCHEDULINGS` is joined to `MTL_EAM_ASSET_ACTIVITIES` on activity_association_id, which gives the maintenance object and the activity.
2. The maintenance object is resolved to an asset through `MTL_SERIAL_NUMBERS` for asset-type objects, or to an asset group item through `MTL_SYSTEM_ITEMS_B_KFV` for group-type objects.
3. `MTL_PARAMETERS` is joined on organization and restricted to EAM-enabled organizations in `ORG_ACCESS_VIEW`.
4. `EAM_PM_SET_NAMES` is joined on set_name_id, and `MFG_LOOKUPS` (WIP_JOB_STATUS) supplies the work order status.
5. Rules from `EAM_PM_SCHEDULING_RULES` and `EAM_METERS` are unioned to the header, as are last-service rows from `EAM_PM_LAST_SERVICE` joined to `WIP_ENTITIES` and `EAM_METERS`, each with a row sort that orders the output.

### Parameters & Filtering
*   **Upload Mode:** Create returns an empty spreadsheet for new schedules, and Create, Update downloads existing schedules for editing.
*   **Organization:** Restricts the schedules to an EAM-enabled organization that the responsibility can access.
*   **Update Activities:** Includes the activity group rows in the template; the SQL applies it through a bind comparison, and it defaults to Yes in the upload.
*   **Update Rules:** When Y, the day interval, runtime meter and list date rules of each schedule are included.
*   **Update Last Service:** When Y, the last-service readings per meter are included.

PM templates (the tmpl_flag condition) are excluded from the download.

### Performance & Optimization
*   The base query filters out template schedules and restricts organizations to EAM-enabled ones that the responsibility can access, before any child rows are added.
*   The header is produced once per schedule, and the activity, rule and last-service sections are each added by a separate `UNION ALL` branch that is switched off by its bind flag.
*   Asset and asset group item descriptions are resolved with left joins to `MTL_SYSTEM_ITEMS_B_KFV`, so schedules without an asset still appear.

### FAQ
**Q: Why is no work order created after a PM schedule upload?**
A: The upload saves the schedule only. The description states that the "XMLSG - Create Preventive Maintenance Work Order" concurrent program must be scheduled and run afterwards.

**Q: How do I delete a scheduling rule through the upload?**
A: Enter Yes in the Delete Rule column on the rule row, using the rule identifier from the downloaded template.

**Q: Can a new PM set name be created during the upload?**
A: Yes. Enter a new Set Name with Set Name Description, End Date and Local Flag, and the upload creates it through the EAM set name API.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-pm-schedule-upload-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
