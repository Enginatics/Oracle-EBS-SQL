---
layout: default
title: 'PA Task Upload | Oracle EBS SQL Report'
description: 'PA Task Upload ====================== Create new tasks or update existing task attributes within Oracle Projects using APIs paprojectpub.addtask and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Task, pa_projects_v, pa_tasks, hr_all_organization_units_vl'
permalink: /PA%20Task%20Upload/
---

# PA Task Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-task-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PA Task Upload
======================
Create new tasks or update existing task attributes within Oracle Projects using APIs pa_project_pub.add_task and pa_project_pub.update_task.

This upload does not create projects — it operates on tasks within existing projects.

Supported Actions:
- Create: Add new top-level tasks, child tasks under existing parents, or entire parent-child hierarchies
- Update: Modify attributes of existing tasks (organization, manager, work type, flags, schedules, etc.)

Report Parameters:
- Upload Mode: 'Create' for new tasks only, or 'Create, Update' for both
- Operating Unit: Filter download to a specific operating unit
- Project Number: Filter download to a specific project
- Project Name: Filter download to a specific project by name
- Project Type: Filter download to a specific project type
- Project Status: Filter download to a specific project status

Uploadable Columns:
- Task Identity: Task Number, Task Name, Long Task Name, Task Description
- Hierarchy: Parent Task Number (to create child tasks or reparent)
- Dates: Task Start Date, Task Completion Date
- Organization: Carrying Out Organization, Task Manager
- Classification: Service Type, Work Type
- Flags: Chargeable, Billable, Receive Project Invoice, Ready to Bill, Ready to Distribute, Limit to Txn Controls, Allow Cross Charge, Retirement Cost, Capital Interest (CINT) Eligible
- Labor Billing: Labor Schedule Type, Labor Std Bill Rate Schedule, Labor Schedule Fixed Date, Labor Schedule Discount, Employee Bill Rate Schedule, Labor Cost Multiplier
- Non-Labor Billing: NL Schedule Type, NL Bill Rate Org, NL Std Bill Rate Schedule, NL Schedule Fixed Date, NL Schedule Discount, Job Bill Rate Schedule, Non-Labor Std Bill Rate Schedule
- Burden Schedules: Cost/Revenue/Invoice Burden Schedule and Fixed Dates
- Transfer Pricing: Labor/NL TP Schedule and Fixed Dates, Intercompany Labor/NL TP Schedule and Fixed Dates, CC Process Labor/NL Flags
- Rate Info: Project Rate Type/Date, Task Functional Cost Rate Type/Date
- Revenue/Invoice: Invoice Method, Customer Name, Gen ETC Source Code, CINT Stop Date
- Address: Task Address
- DFF: Attribute Category, Attributes 1-10
- Publish Structure: Set to 'Yes' on the last task row of a project to publish the working structure version after upload

Structure Version Handling:
- For projects without workplan versioning: tasks are added/updated directly — no special handling needed
- For versioned projects with a WORKING structure version: the upload uses the WORKING version automatically
- For versioned projects with only a PUBLISHED version (no WORKING version): task add/update is NOT supported and records will be errored

Unsupported Project Configurations:
- Projects with workplan versioning enabled (Workplan Attributes > Enable Versioning = Yes) that have no WORKING structure version will fail with: "The structure version cannot be updated"
- This typically affects projects where:
  a) All structure versions have been published and none are in working/draft status
  b) Auto-publish is enabled and no manual working version has been created

Workaround for Unsupported Projects:
1. Navigate to Projects > Project Super User > Projects
2. Query the project and go to the Workplan tab
3. Click "Update Workplan" to create a new WORKING structure version
4. Re-run the upload — it will now pick up the WORKING version and succeed
5. After the upload completes, publish the working version from the Workplan tab if needed

Notes:
- To modify tasks on projects owned by other users, the profile option 'PA: Cross Project User -- Update' must be enabled at the responsibility level
- Tasks with existing expenditure items cannot have new subtasks created below them
- When updating tasks, the task number itself is not modified — only other attributes are updated
- The PM Product Code must be a valid value registered in the PA_LOOKUPS lookup type PM_PRODUCT_CODE (e.g., MSPROJECT, PRIMAVERA)

## Report Parameters
Upload Mode, Operating Unit, Project Number, Project Name, Project Type, Project Status

## Oracle EBS Tables Used
[pa_projects_v](https://www.enginatics.com/library/?pg=1&find=pa_projects_v), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [pa_project_parties](https://www.enginatics.com/library/?pg=1&find=pa_project_parties), [pa_work_types_vl](https://www.enginatics.com/library/?pg=1&find=pa_work_types_vl), [pa_std_bill_rate_schedules_all](https://www.enginatics.com/library/?pg=1&find=pa_std_bill_rate_schedules_all), [pa_ind_rate_schedules_all_bg](https://www.enginatics.com/library/?pg=1&find=pa_ind_rate_schedules_all_bg), [pa_cc_tp_schedules_bg](https://www.enginatics.com/library/?pg=1&find=pa_cc_tp_schedules_bg), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[PA Project Upload](/PA%20Project%20Upload/ "PA Project Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/pa-task-upload/) |
| Blitz Report™ XML Import | [PA_Task_Upload.xml](https://www.enginatics.com/xml/pa-task-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-task-upload/](https://www.enginatics.com/reports/pa-task-upload/) |



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
