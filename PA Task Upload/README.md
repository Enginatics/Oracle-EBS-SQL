---
layout: default
last_modified_at: 2026-10-16
title: 'PA Task Upload | Oracle EBS SQL Report'
description: 'PA Task Upload ====================== Create new tasks or update existing task attributes within Oracle Projects using APIs paprojectpub.addtask and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Task, pa_projects_v, pa_tasks, hr_all_organization_units_vl'
permalink: /PA%20Task%20Upload/
report_name: 'PA Task Upload'
report_web_name: pa-task-upload
---

# PA Task Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-task-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Project Number, Project Name, Project Type, Project Status

## Oracle EBS Tables Used
[pa_projects_v](https://www.enginatics.com/library/?pg=1&find=pa_projects_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [pa_project_parties](https://www.enginatics.com/library/?pg=1&find=pa_project_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [pa_work_types_vl](https://www.enginatics.com/library/?pg=1&find=pa_work_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [pa_std_bill_rate_schedules_all](https://www.enginatics.com/library/?pg=1&find=pa_std_bill_rate_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [pa_ind_rate_schedules_all_bg](https://www.enginatics.com/library/?pg=1&find=pa_ind_rate_schedules_all_bg&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [pa_cc_tp_schedules_bg](https://www.enginatics.com/library/?pg=1&find=pa_cc_tp_schedules_bg&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)

## Related Reports
[PA Project Upload](/PA%20Project%20Upload/ "PA Project Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Task%20Upload/PA%20Task%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-task-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload) |
| Blitz Report™ XML Import | [PA_Task_Upload.xml](https://www.enginatics.com/xml/pa-task-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload) |
| SQL Source | [PA Task Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Task%20Upload/PA%20Task%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-task-upload/](https://www.enginatics.com/reports/pa-task-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload) |

## Case Study & Technical Analysis: PA Task Upload

### Executive Summary
The PA Task Upload report creates new tasks and updates existing task attributes within Oracle Projects, using the public Projects APIs paprojectpub.addtask and paprojectpub.updatetask. It does not create projects. It works on the task structure of projects that already exist, and it can build parent and child task hierarchies. Project controllers, planners and implementation teams use it to set up work breakdown structures for many projects, and to maintain attributes such as carrying-out organization, task manager, work type, billing and burden schedules, and cross-charge settings in bulk.

### Business Challenge
*   **Work breakdown setup:** Each project needs a task hierarchy with correct parent links, and building it in the task form is slow when many projects share a template structure.
*   **Billing and cost configuration:** Each task carries labor and non-labor bill rate schedules, burden schedules, transfer price schedules and invoice methods, and these must be kept consistent across tasks.
*   **Organizational ownership:** Tasks need a carrying-out organization and a task manager, which determine who runs the work and who approves it.
*   **Workplan versioning:** Projects with workplan versioning need a working structure version before tasks can change, and this is easy to miss.

### The Solution
*   **Create and update in one file:** Create adds new top-level tasks, child tasks under existing parents, or whole hierarchies. Update changes attributes of existing tasks, but never the task number.
*   **Full task attribute coverage:** Dates, organization, manager, service and work type, billing flags, labor and non-labor schedules, burden schedules, transfer price schedules, rate types, capital interest and descriptive flexfield attributes can all be uploaded.
*   **Working structure handling:** For versioned projects, the upload uses the WORKING structure version automatically. Projects with only a published version are not supported and are errored.
*   **Publish on last row:** Setting Publish Structure to Yes on the last task row of a project publishes the working structure version after the upload.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_PROJECTS_V`: the project, with its number, name, type and status, and its template flag.
*   `PA_TASKS`: the task rows, with the task number, hierarchy level, dates, organization, flags, schedules and flexfield attributes.
*   `PA_PROJECT_PARTIES`: the project manager, read from the project party role.
*   `PA_WORK_TYPES_VL`: the work type name.
*   `PA_STD_BILL_RATE_SCHEDULES_ALL` and `PA_IND_RATE_SCHEDULES_ALL_BG`: the standard bill rate schedules and the indirect burden schedules.
*   `PA_CC_TP_SCHEDULES_BG`: the transfer price schedules.
*   `GL_DAILY_CONVERSION_TYPES`: the project and task rate types.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit, carrying-out organization and non-labor bill rate organization.
*   `PER_ALL_PEOPLE_F`: the task manager and project manager, effective on the current date.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the customer and address on a task.

#### Logical Relationships
1.  `PA_PROJECTS_V` is joined to its tasks in `PA_TASKS`, and the parent task is outer joined through the parent task ID.
2.  Non-template projects are kept, and the project's operating unit is joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
3.  Each task's carrying-out organization and task manager are joined, the manager on the current effective date.
4.  Project manager is found through the project party with project role 1 and an open-ended or current end date.
5.  Each billing, burden and transfer price schedule ID is outer joined to its schedule table, and the rate types are joined to `GL_DAILY_CONVERSION_TYPES`.
6.  The task address and customer are reached through the party site, location and customer account tables.

### Parameters & Filtering
*   **Upload Mode:** Create returns only new tasks, and Create, Update returns existing tasks as well.
*   **Operating Unit:** Limits the download to one operating unit.
*   **Project Number and Project Name:** Limit the download to one project.
*   **Project Type and Project Status:** Restrict the projects by type or status.

### Performance & Optimization
*   **Template projects excluded:** The template flag test removes template projects, so only live projects are downloaded.
*   **Outer joins to schedules:** Each schedule and rate table is outer joined, so tasks without a schedule are still returned in full.
*   **Date-effective manager lookups:** Person records are restricted to the current date, so only the active manager row is joined.
*   **Project-level filters early:** The project filters act on the project view before the task join, which limits the task rows read.

### FAQ
**Q: Can this upload create a project?**
A: No. It operates on tasks within existing projects, so the project must already exist before its tasks are uploaded.
**Q: Why are my task changes rejected on a project with workplan versioning?**
A: The project needs a WORKING structure version. The description gives the steps: open the project's Workplan tab, use Update Workplan to create a working version, re-run the upload, and publish the working version afterwards if needed.
**Q: Can I change the task number of an existing task with this upload?**
A: No. The task number is not modified on update, and only other attributes change.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-task-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
