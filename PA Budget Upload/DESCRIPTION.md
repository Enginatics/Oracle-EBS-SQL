# Case Study & Technical Analysis: PA Budget Upload

## Executive Summary
The PA Budget Upload creates and updates standard working budgets on Oracle Projects, the project budgets used to plan cost and revenue by task and resource. The upload can create a new working budget, either from an empty file or by copying a prior version, update the lines of an existing working budget by adding, changing or deleting them, and baseline a working budget. Financial Plan budgets are not supported. The upload works only on projects belonging to the operating units accessible to the responsibility from which it is run, and it sits in the Projects module.

## Business Challenge
*   **Annual budget loading:** Each planning cycle requires budgets for many projects, and entering budget lines individually is slow.
*   **Revising budgets without losing history:** Budget changes need to be applied to an existing working budget line by line, while keeping the existing budget in place.
*   **Consistent resource structure:** Budget lines must reference the correct resource alias and task, so the budget matches the resource list used for the project.

## The Solution
*   **Create from scratch or copy:** A new working budget can be entered in an empty file or created from a copy of a prior version, which is then edited in the file.
*   **Line-level update:** In update mode, individual budget lines can be added, changed or flagged for deletion, while the rest of the working budget is retained.
*   **Resource and task context:** Each line shows the task number and name, the resource alias path from the resource list and the period, with raw cost, burdened cost, revenue and quantity.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_PROJECTS_ALL`: the projects that carry the budgets.
*   `PA_BUDGET_VERSIONS`: the budget header, holding the version name, status, entry method, resource list and change reason.
*   `PA_RESOURCE_LISTS`: the resource list the budget is based on.
*   `PA_RESOURCE_ASSIGNMENTS`: the resource assignments that link a budget to tasks and resources.
*   `PA_BUDGET_LINES`: the budget lines, with period, dates, cost, revenue and quantity.
*   `PA_TASKS`: the project tasks referenced by the assignments.
*   `PA_RESOURCE_LIST_MEMBERS`: the resource list members, traversed as a hierarchy to build the alias path.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating units of the projects.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the organisations accessible to the current user.

### Logical Relationships
1. `PA_PROJECTS_ALL` joins to `PA_BUDGET_VERSIONS` on the project identifier, and the operating unit is joined through `HR_ALL_ORGANIZATION_UNITS_VL`.
2. Budget versions join to `PA_BUDGET_TYPES`, `PA_BUDGET_ENTRY_METHODS` and `PA_RESOURCE_LISTS` on their code and identifier columns.
3. Budget versions join to `PA_RESOURCE_ASSIGNMENTS` as an outer join, on the version and project identifiers.
4. Assignments join to `PA_BUDGET_LINES` as an outer join on the resource assignment identifier, and to `PA_TASKS` on the task identifier.
5. The resource alias path is built from `PA_RESOURCE_LIST_MEMBERS` by a hierarchical query, and joined to the assignment on the resource list member identifier.

## Parameters & Filtering
*   **Upload Mode:** Chooses between create and update. Update returns budgets whose status is working or submitted, and create returns budgets only when copying is selected.
*   **Product Source:** Restricts the budgets to one source product code.
*   **Copy Existing Budget:** Controls whether an existing budget is returned as the template for a new one.
*   **Operating Unit:** Restricts the output to projects in one operating unit.
*   **Project Number and Project Name:** Identify the projects whose budgets are returned.
*   **Budget Type and Budget Version:** Select one budget type and version.
*   **Resource Alias:** Restricts the lines to one resource from the resource list.
*   **Period From and Period To:** Bound the periods of the budget lines.

## Performance & Optimization
*   **Status-based driver:** Update mode is limited to working and submitted budget versions, so baselined budgets are not returned for editing.
*   **Organisation access filter:** Projects are restricted to the operating units accessible to the current user, so only permitted budgets are read.
*   **Outer joins for new lines:** Assignments and lines are attached with outer joins, so a budget version without lines still appears and can be populated.

## FAQ
**Q: How do I load a new working budget for many projects in Oracle Projects?**
A: Run PA Budget Upload in create mode, enter the budget lines in the file, and upload it. Any existing working budget for the same project and budget type is overwritten.

**Q: Can I change one line of an existing budget without replacing it?**
A: Yes. In update mode the existing budget is retained, and individual lines can be added, updated or flagged for deletion.

**Q: Does this upload handle Financial Plan budgets?**
A: No. The description states that the upload supports standard project budgets only, and does not create or update Financial Plan budgets at this stage.
