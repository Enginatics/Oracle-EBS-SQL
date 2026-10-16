# Case Study & Technical Analysis: PA Project Subledger Detail by Expenditure Type

## Executive Summary
The PA Project Subledger Detail by Expenditure Type report summarizes the project cost distribution lines of Oracle Projects by project, task, expenditure type and General Ledger account. For each group it shows the raw cost, the burden cost and the total cost of the lines that have been transferred or accepted. Project accountants use it to reconcile the costs held in Projects with the GL account balances they have been posted to, and to explain the burden applied to each expenditure type. The report runs in Excel through Blitz Report, so the reconciliation can be filtered by GL date and account.

## Business Challenge
*   **Projects to GL reconciliation:** Project cost must agree with the General Ledger, and the reconciliation needs the cost grouped by account as well as by project and task.
*   **Burden analysis:** The difference between raw cost and burdened cost, which comes from overhead and burden rules, must be visible by expenditure type.
*   **Transfer status control:** Only lines that have been transferred to the GL or accepted should be counted in the subledger view, so that unposted or rejected lines do not distort the totals.
*   **Expenditure type reporting:** Costs must be reported by expenditure category and system linkage, for management reporting on labor, material and other cost types.

## The Solution
*   **Raw and burden cost:** Raw cost is the amount of each distribution line, and burden cost is the burdened amount, summed by group.
*   **Total cost:** Total cost is the raw cost plus the burden adjustment, which is the burdened cost less the raw amount of each line.
*   **Transfer status filter:** Only distribution lines with a transfer status of accepted or transferred are included.
*   **Account grouping:** The debit account of each distribution line is resolved to its concatenated GL segments and description, so the output reconciles to the GL by account.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_COST_DISTRIBUTION_LINES_ALL`: the cost distribution lines, with the amount, burdened cost, transfer status and debit code combination.
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure item that the distribution line came from, with its expenditure type and system linkage function.
*   `PA_PROJECTS_ALL`: the project number and name.
*   `PA_TASKS`: the task number and name.
*   `PA_EXPENDITURE_TYPES`: the expenditure type category.
*   `GL_CODE_COMBINATIONS_KFV`: the GL account concatenated segments and description.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

### Logical Relationships
1.  `PA_COST_DISTRIBUTION_LINES_ALL` joins to `PA_EXPENDITURE_ITEMS_ALL` on the expenditure item ID.
2.  The expenditure item joins to `PA_PROJECTS_ALL` on the project ID, to `PA_TASKS` on the task ID, and to `PA_EXPENDITURE_TYPES` on the expenditure type.
3.  The distribution line joins to `GL_CODE_COMBINATIONS_KFV` on the debit code combination ID, as an outer join so that lines without an account are kept.
4.  The project joins to `HR_ALL_ORGANIZATION_UNITS_VL` on the organization ID, which is the operating unit.
5.  The rows are grouped by operating unit, project, task, expenditure type, category, system linkage, GL account and account description, and ordered by the same keys.

## Parameters & Filtering
*   **Operating Unit:** limits the output to one organization within the accessible set.
*   **Project:** restricts the output to one project.
*   **GL Date From** and **GL Date To:** bound the GL date of the cost lines.
*   **Expenditure Type:** restricts the output to one expenditure type.
*   **Account:** restricts the output to one GL account.

## Performance & Optimization
*   Only distribution lines of line type R are read, and only lines with an accepted or transferred status are summed.
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, which limits the project set before the cost aggregation.
*   The aggregation is a single `GROUP BY` over the distribution lines, so the database returns one row per project, task, expenditure type and account.
*   The account lookup is an outer join on the code combination ID, so the GL table is read only for the grouped output.

## FAQ
**Q: Which cost lines are included in this report?**
A: Cost distribution lines of line type R whose transfer status is A (accepted) or V (transferred).

**Q: How is total cost calculated?**
A: Total cost is the raw cost plus the difference between the burdened cost and the raw amount, so it equals the burdened cost where a burden is applied.

**Q: How can I reconcile this report to the General Ledger?**
A: Compare the total cost for each GL account with the project cost in the GL account balance for the same period, using the GL Date From and GL Date To parameters.
