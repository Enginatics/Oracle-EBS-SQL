---
layout: default
title: 'WIP Job Upload | Oracle EBS SQL Report'
description: 'Upload to create and update WIP Discrete Jobs (Standard and Non-Standard) including operations, resources, and material requirements (components)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, WIP, Job, mtl_system_items_vl, mtl_item_locations_kfv, wip_schedule_groups'
permalink: /WIP%20Job%20Upload/
---

# WIP Job Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-job-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create and update WIP Discrete Jobs (Standard and Non-Standard) including operations, resources, and material requirements (components). Multiple inventory organizations can be combined in one upload file; the upload submits a separate WIP Mass Load run per organization.

Job headers support all standard fields including assembly, class code, status, quantities, dates, scheduling, BOM/routing references (non-standard jobs), completion subinventory/locator, schedule group, line, project/task, and descriptive flexfield attributes.

Operations, resources, and material requirements (components) can be added on new and existing jobs and modified on existing jobs. A single upload row can carry header, operation/resource, and component fields simultaneously, so compact entry does not require separate row types.

Explode Bom and Routing. By default, Bom and Routing are automatically exploded only for new jobs (create) where the job does not have detail entries (operations/resources/components) included in the upload. This is to preserve the manually entered details on upload. If uploading Job Details for a new job, then all the detail entries for the Job should be included in the upload. The Bom and Routing are not automatically re-exploded when updating an existing job. There is a hidden ‘Explode Bom and Routing’ column in the upload that can be used to override this default behaviour.

Scheduled Start and Completion Dates. For jobs with a routing (the assembly’s own routing for Standard jobs, or a Routing Reference for Non-Standard jobs), supply one of Scheduled Start Date or Scheduled Completion Date — providing the start forward-schedules, providing the completion backward-schedules. The system computes the other end from the routing lead times. If both are supplied, forward-scheduling from the start is used. For jobs without a routing, both dates are required and are stored verbatim. The same rules apply on update: changing only the start triggers a forward reschedule, changing only the completion triggers a backward reschedule.

Job creation supports both automatic job name generation (via the WIP Job Prefix profile and sequence) and manual job naming. The Upload Job Identifier column uniquely identifies a job in the upload and provides traceability between uploaded rows and the eventual job name when automatic naming is used. It must be unique per logical job within a single upload. For manual job naming, the Upload Job Identifier will also be used as the Job Name if a Job Name is not specifically entered in the upload.

Non-standard jobs without an assembly or routing reference cannot be updated through WIP Mass Load; such jobs must be edited in the Discrete Jobs form directly. The upload reports a clear error if attempted.

Processing uses the WIP Mass Load interface (wip_job_schedule_interface and wip_job_dtls_interface) with the WICMLP concurrent program. Validation errors are detected per job and cascaded to all rows of the affected job so the job is either processed in its entirety or not at all.


## Report Parameters
Upload Mode, Auto Generate Job Name, Download Operations, Download Components, Organization Code, Job, Job From, Job To, Job Status, Type, Assembly, Schedule Group, Build Sequence From, Build Sequence To, Class, Start Date From, Start Date To, Completion Date From, Completion Date To, Line, Project Number, Task Number

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [wip_schedule_groups](https://www.enginatics.com/library/?pg=1&find=wip_schedule_groups), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines), [pjm_projects_mtll_v](https://www.enginatics.com/library/?pg=1&find=pjm_projects_mtll_v), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [WSH Commercial Invoice](/WSH%20Commercial%20Invoice/ "WSH Commercial Invoice Oracle EBS SQL Report"), [PO Vendor Service Performance Analysis](/PO%20Vendor%20Service%20Performance%20Analysis/ "PO Vendor Service Performance Analysis Oracle EBS SQL Report"), [WIP Material Transaction Upload](/WIP%20Material%20Transaction%20Upload/ "WIP Material Transaction Upload Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/wip-job-upload/) |
| Blitz Report™ XML Import | [WIP_Job_Upload.xml](https://www.enginatics.com/xml/wip-job-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/wip-job-upload/](https://www.enginatics.com/reports/wip-job-upload/) |



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
