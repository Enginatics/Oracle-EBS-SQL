---
layout: default
last_modified_at: 2026-10-19
title: 'WIP Job Upload | Oracle EBS SQL Report'
description: 'Upload to create and update WIP Discrete Jobs (Standard and Non-Standard) including operations, resources, and material requirements (components)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, WIP, Job, mtl_system_items_vl, mtl_item_locations_kfv, wip_schedule_groups'
permalink: /WIP%20Job%20Upload/
report_name: 'WIP Job Upload'
report_web_name: wip-job-upload
---

# WIP Job Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload).

## Overview
Upload to create and update WIP Discrete Jobs (Standard and Non-Standard) including operations, resources, and material requirements (components). Multiple inventory organizations can be combined in one upload file; the upload submits a separate WIP Mass Load run per organization.

Job headers support all standard fields including assembly, class code, status, quantities, dates, scheduling, BOM/routing references (non-standard jobs), completion subinventory/locator, schedule group, line, project/task, and descriptive flexfield attributes.

Operations, resources, and material requirements (components) can be added on new and existing jobs and modified on existing jobs. A single upload row can carry header, operation/resource, and component fields simultaneously, so compact entry does not require separate row types.

Explode Bom and Routing. By default, Bom and Routing are automatically exploded only for new jobs (create) where the job does not have detail entries (operations/resources/components) included in the upload. This is to preserve the manually entered details on upload. If uploading Job Details for a new job, then all the detail entries for the Job should be included in the upload. The Bom and Routing are not automatically re-exploded when updating an existing job. There is a hidden ‘Explode Bom and Routing’ column in the upload that can be used to override this default behaviour.

Scheduled Start and Completion Dates. For jobs with a routing (the assembly’s own routing for Standard jobs, or a Routing Reference for Non-Standard jobs), supply one of Scheduled Start Date or Scheduled Completion Date — providing the start forward-schedules, providing the completion backward-schedules. The system computes the other end from the routing lead times. If both are supplied, forward-scheduling from the start is used. For jobs without a routing, both dates are required and are stored verbatim. The same rules apply on update: changing only the start triggers a forward reschedule, changing only the completion triggers a backward reschedule.

Job creation supports both automatic job name generation (via the WIP Job Prefix profile and sequence) and manual job naming. The Upload Job Identifier column uniquely identifies a job in the upload and provides traceability between uploaded rows and the eventual job name when automatic naming is used. It must be unique per logical job within a single upload. For manual job naming, the Upload Job Identifier will also be used as the Job Name if a Job Name is not specifically entered in the upload.

Non-standard jobs without an assembly or routing reference cannot be updated through WIP Mass Load; such jobs must be edited in the Discrete Jobs form directly. The upload reports a clear error if attempted.

Processing uses the WIP Mass Load interface (wip_job_schedule_interface and wip_job_dtls_interface) with the WICMLP concurrent program. Validation errors are detected per job and cascaded to all rows of the affected job so the job is either processed in its entirety or not at all.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Auto Generate Job Name, Download Operations, Download Components, Organization Code, Job, Job From, Job To, Job Status, Type, Assembly, Schedule Group, Build Sequence From, Build Sequence To, Class, Start Date From, Start Date To, Completion Date From, Completion Date To, Line, Project Number, Task Number

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_schedule_groups](https://www.enginatics.com/library/?pg=1&find=wip_schedule_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [pjm_projects_mtll_v](https://www.enginatics.com/library/?pg=1&find=pjm_projects_mtll_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)

## Related Reports
[WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Job%20Upload/WIP%20Job%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/wip-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload) |
| Blitz Report™ XML Import | [WIP_Job_Upload.xml](https://www.enginatics.com/xml/wip-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload) |
| SQL Source | [WIP Job Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Job%20Upload/WIP%20Job%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-job-upload/](https://www.enginatics.com/reports/wip-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload) |

## Case Study & Technical Analysis: WIP Job Upload

### Executive Summary
The WIP Job Upload creates and updates Oracle Work in Process discrete jobs, both standard and non-standard, together with their operations, resources and material requirements (components). Several inventory organizations can be combined in one file, and the upload submits a separate WIP Mass Load run for each organization. Production planners and manufacturing engineers use it to release large numbers of jobs from a schedule, to load job details from a planning spreadsheet and to change the dates, quantities and status of existing jobs. Blitz Report downloads the jobs with their details, so the spreadsheet can be edited and uploaded again.

### Business Challenge
*   **Mass job release:** A production schedule can call for hundreds of jobs, each with operations, resources and components, and entering them in the Discrete Jobs form is slow.
*   **Complete job detail:** The operations, resources and components of a job must all be entered, or the job's cost and material picture is incomplete.
*   **Scheduling accuracy:** A job scheduled from its routing needs a start or completion date, and the other end must be calculated from the routing lead times.
*   **Traceability:** Uploaded rows must be traceable to the job name that Oracle assigns, so the spreadsheet and the system can be reconciled.

### The Solution
*   Downloads the discrete jobs of the selected organizations, with the header fields, the operations and resources of each job, and the components when Download Components is set.
*   Accepts header, operation, resource and component fields in one upload row, so detail can be entered without separate row types.
*   Explodes the bill of material and routing for new jobs that have no detail lines in the upload, and keeps manually entered detail unchanged.
*   Schedules a job forward from its start date or backward from its completion date, using the routing lead times, and stores the dates verbatim for jobs without a routing.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_ENTITIES`: the job entity and its name, which is the job name in the system.
*   `WIP_DISCRETE_JOBS`: the job header, with type, status, quantities, dates, assembly, routing reference, schedule group, line, project and task.
*   `WIP_OPERATIONS` and `WIP_OPERATION_RESOURCES`: the operations of a job and the resources each operation uses.
*   `WIP_REQUIREMENT_OPERATIONS`: the material requirements of a job, the components.
*   `BOM_STANDARD_OPERATIONS`, `BOM_DEPARTMENTS`, `BOM_RESOURCES` and `CST_ACTIVITIES`: the operation codes, departments, resource codes and activities.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_ITEM_LOCATIONS_KFV`: the assembly, component and locator names.
*   `WIP_SCHEDULE_GROUPS`, `WIP_LINES`, `PJM_PROJECTS_MTLL_V` and `PA_TASKS`: the schedule group, line, project and task.
*   `MTL_PARAMETERS` and `ORG_ACCESS_VIEW`: the organization code and the organizations of the responsibility.

#### Logical Relationships
1.  `MTL_PARAMETERS` is joined to `WIP_DISCRETE_JOBS` on the organization id, and the job to `WIP_ENTITIES` on the entity id.
2.  Operations are outer joined to the job, and resources to the operations, on entity, operation sequence and organization.
3.  Components are read from `WIP_REQUIREMENT_OPERATIONS` for the same job, excluding supply type 6 and operation sequence zero.
4.  The operation branch and the component branch are combined with UNION ALL, so a header-only job still returns one row.
5.  The assembly, routing reference and BOM reference are scalar lookups on `MTL_SYSTEM_ITEMS_VL` through the inventory item ids.

### Parameters & Filtering
*   **Upload Mode** and **Auto Generate Job Name:** control whether jobs are created, updated or both, and whether job names are generated.
*   **Download Operations** and **Download Components:** choose whether operation, resource and component rows are included.
*   **Organization Code**, **Job**, **Job From** and **Job To**, **Job Status** and **Type** select the jobs.
*   **Assembly**, **Class**, **Schedule Group**, **Line**, **Project Number** and **Task Number** select jobs by item, class and scheduling attributes.

### Performance & Optimization
*   The organization access check is a subquery on `ORG_ACCESS_VIEW`, so each run reads only the organizations of the responsibility.
*   Operation and resource joins are switched on only when Download Operations is Y, so a header-only download skips the detail tables.
*   Component rows are read only when Download Components is Y, which keeps large material requirement sets out of a header download.
*   Lookups for assembly, item, schedule group and project are scalar subqueries on keys, so each job row adds a fixed number of lookups.

### FAQ
**Q: How do I release many jobs with their operations and components in one file?**
A: Download with Download Operations and Download Components set to Y, add the rows for the new jobs, and upload. Each job's rows are processed together, so a job is either processed in full or not at all.

**Q: Why are the operations of a new job not exploded automatically?**
A: By default the bill of material and routing are exploded only for new jobs with no detail lines in the upload. The hidden Explode Bom and Routing column overrides this default.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-job-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
