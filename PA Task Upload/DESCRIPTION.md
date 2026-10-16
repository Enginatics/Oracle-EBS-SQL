# Case Study & Technical Analysis: PA Task Upload

## Executive Summary
The PA Task Upload report creates new tasks and updates existing task attributes within Oracle Projects, using the public Projects APIs paprojectpub.addtask and paprojectpub.updatetask. It does not create projects. It works on the task structure of projects that already exist, and it can build parent and child task hierarchies. Project controllers, planners and implementation teams use it to set up work breakdown structures for many projects, and to maintain attributes such as carrying-out organization, task manager, work type, billing and burden schedules, and cross-charge settings in bulk.

## Business Challenge
*   **Work breakdown setup:** Each project needs a task hierarchy with correct parent links, and building it in the task form is slow when many projects share a template structure.
*   **Billing and cost configuration:** Each task carries labor and non-labor bill rate schedules, burden schedules, transfer price schedules and invoice methods, and these must be kept consistent across tasks.
*   **Organizational ownership:** Tasks need a carrying-out organization and a task manager, which determine who runs the work and who approves it.
*   **Workplan versioning:** Projects with workplan versioning need a working structure version before tasks can change, and this is easy to miss.

## The Solution
*   **Create and update in one file:** Create adds new top-level tasks, child tasks under existing parents, or whole hierarchies. Update changes attributes of existing tasks, but never the task number.
*   **Full task attribute coverage:** Dates, organization, manager, service and work type, billing flags, labor and non-labor schedules, burden schedules, transfer price schedules, rate types, capital interest and descriptive flexfield attributes can all be uploaded.
*   **Working structure handling:** For versioned projects, the upload uses the WORKING structure version automatically. Projects with only a published version are not supported and are errored.
*   **Publish on last row:** Setting Publish Structure to Yes on the last task row of a project publishes the working structure version after the upload.

## Technical Architecture (High Level)
### Primary Tables
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

### Logical Relationships
1.  `PA_PROJECTS_V` is joined to its tasks in `PA_TASKS`, and the parent task is outer joined through the parent task ID.
2.  Non-template projects are kept, and the project's operating unit is joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
3.  Each task's carrying-out organization and task manager are joined, the manager on the current effective date.
4.  Project manager is found through the project party with project role 1 and an open-ended or current end date.
5.  Each billing, burden and transfer price schedule ID is outer joined to its schedule table, and the rate types are joined to `GL_DAILY_CONVERSION_TYPES`.
6.  The task address and customer are reached through the party site, location and customer account tables.

## Parameters & Filtering
*   **Upload Mode:** Create returns only new tasks, and Create, Update returns existing tasks as well.
*   **Operating Unit:** Limits the download to one operating unit.
*   **Project Number and Project Name:** Limit the download to one project.
*   **Project Type and Project Status:** Restrict the projects by type or status.

## Performance & Optimization
*   **Template projects excluded:** The template flag test removes template projects, so only live projects are downloaded.
*   **Outer joins to schedules:** Each schedule and rate table is outer joined, so tasks without a schedule are still returned in full.
*   **Date-effective manager lookups:** Person records are restricted to the current date, so only the active manager row is joined.
*   **Project-level filters early:** The project filters act on the project view before the task join, which limits the task rows read.

## FAQ
**Q: Can this upload create a project?**
A: No. It operates on tasks within existing projects, so the project must already exist before its tasks are uploaded.
**Q: Why are my task changes rejected on a project with workplan versioning?**
A: The project needs a WORKING structure version. The description gives the steps: open the project's Workplan tab, use Update Workplan to create a working version, re-run the upload, and publish the working version afterwards if needed.
**Q: Can I change the task number of an existing task with this upload?**
A: No. The task number is not modified on update, and only other attributes change.
