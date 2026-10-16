# Case Study & Technical Analysis: PA Employee Activity By Organization

## Executive Summary
This report summarizes labor hours by employee, project and task in Oracle Projects. For each combination it shows total hours, billable hours, non-billable hours, raw cost and burdened cost, in the project currency, and it reports the expenditure organization that incurred the labor. Project accountants and resource managers use it to see how much time each employee spent on each project task, and how much of that time was billed, when reconciling timesheets to project costs. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Timesheet to cost reconciliation:** Hours entered on timecards must agree with the labor cost recorded against each project and task.
*   **Billable versus non-billable time:** Project managers need to know how much effort was billed and how much was absorbed.
*   **Cross-organization labor:** Employees often work on projects owned by another operating unit, so the expenditure organization must be visible alongside the project operating unit.
*   **Cost visibility by task:** Budget owners need labor cost by task and expenditure type, not just by project.

## The Solution
*   **Hours by billing status:** Total hours are split into billable and non-billable hours using the billable flag of each expenditure item.
*   **Cost by employee:** Raw cost and burdened cost are summed for each employee, project and task.
*   **Two organizations:** The project operating unit and the expenditure organization are shown side by side, which separates the owner from the incurring unit.
*   **Labor transactions only:** Only standard and overtime labor expenditure items are included, based on the system linkage function.
*   **Project currency:** Amounts are stated in the currency of each project.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items, with quantity, billable flag, raw cost, burden cost and expenditure type.
*   `PA_EXPENDITURES_ALL`: the expenditure header, with the person who incurred the cost.
*   `PA_PROJECTS_ALL`: the project number, name, operating unit and currency.
*   `PA_TASKS`: the task number and name.
*   `PER_PEOPLE_X`: the employee number and full name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the project operating unit and the expenditure organization.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the session can access.
*   `DUAL`: used to add the current operating unit for release 11 sessions.

### Logical Relationships
1. `PA_EXPENDITURE_ITEMS_ALL` joins to `PA_EXPENDITURES_ALL` on expenditure id, which gives the person who incurred the cost.
2. The expenditure's incurring person id joins to `PER_PEOPLE_X` on person id.
3. The item joins to `PA_PROJECTS_ALL` on project id, and the project's organization id joins to `HR_ALL_ORGANIZATION_UNITS_VL`.
4. The item joins to `PA_TASKS` on task id, and its organization id joins to the expenditure organization in `HR_ALL_ORGANIZATION_UNITS_VL`.
5. The operating unit filter is an IN list on the access table, with the current operating unit added for release 11 sessions.

## Parameters & Filtering
*   **Operating Unit:** restricts the rows to one project operating unit.
*   **Project:** restricts the rows to one project.
*   **Date From and Date To:** bound the expenditure items by date.
*   **Employee:** restricts the rows to one employee.

## Performance & Optimization
*   The system linkage filter limits the item scan to standard and overtime labor, which avoids other expenditure types.
*   Operating unit access is enforced through the access table, so the report returns only the units the user can access.
*   Totals are summed with conditional expressions on the billable flag, so billable and non-billable hours come from one pass over the items.

## FAQ
**Q: What is the difference between the operating unit and the expenditure organization?**
A: The operating unit is the owner of the project. The expenditure organization is the unit that incurred the cost, and the two can differ.

**Q: Why do the billable and non-billable hours not add up to the total hours?**
A: Items whose billable flag is neither Y nor N are included in the total hours but not in either split.

**Q: Which cost currency is shown?**
A: The currency of the project, shown in the currency column for each row.
