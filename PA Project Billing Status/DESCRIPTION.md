# Case Study & Technical Analysis: PA Project Billing Status

## Executive Summary
The PA Project Billing Status report gives a billing overview of each project in Oracle Projects. For every project it shows the revenue recognized to date, the amount billed through released draft invoices, the unbilled receivable, the total funding and the funding still available. Project managers and billing controllers use it to see how far each project has been billed against its revenue, and where funding is close to exhaustion, before issuing the next invoice or raising a funding request. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Unbilled exposure:** Revenue recognized but not yet invoiced ties up working capital, and it must be visible for each project.
*   **Funding control:** Projects funded by a customer or agreement must not exceed their funding, so the available funding must be monitored.
*   **Invoice timing:** The date of the last released invoice shows whether a project is being billed regularly.
*   **Portfolio view:** Finance needs one line per project with its project manager, status and organization to review the billing position across the operating unit.

## The Solution
*   **Revenue and cost to date:** Revenue and raw cost are taken from the project-level inception-to-date accumulators.
*   **Billed amount:** Billed amount is the sum of draft invoice items on draft invoices that have been released.
*   **Unbilled receivable:** Unbilled receivable is the revenue to date less the released billed amount.
*   **Available funding:** Available funding is the total baselined funding less the revenue to date, so it shows the headroom left on the project.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_PROJECTS_ALL`: the project header, with number, name, status, organization, dates and currency.
*   `PA_PROJECT_TYPES_ALL`: the project type, which classifies the project.
*   `PA_PROJECT_STATUSES`: the project status name.
*   `PA_PROJECT_PLAYERS`: the project role assignments, used to find the project manager.
*   `PER_PEOPLE_X`: the project manager's name.
*   `PA_PROJECT_ACCUM_HEADERS` and `PA_PROJECT_ACCUM_ACTUALS`: the project accumulators that hold the inception-to-date revenue and raw cost.
*   `PA_DRAFT_INVOICES_ALL` and `PA_DRAFT_INVOICE_ITEMS`: the draft invoices, their release status and their invoice amounts.
*   `PA_SUMMARY_PROJECT_FUNDINGS`: the summary funding per project.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit and the carrying-out organization.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

### Logical Relationships
1.  `PA_PROJECTS_ALL` joins to `PA_PROJECT_TYPES_ALL` on the project type and operating unit, and to the operating unit name in `HR_ALL_ORGANIZATION_UNITS_VL`.
2.  Each project's status, carrying-out organization and project manager are resolved by correlated subqueries. The manager is the current project manager role in `PA_PROJECT_PLAYERS` joined to `PER_PEOPLE_X`.
3.  Revenue and raw cost are read from the accumulator actuals linked to the project-level accumulator header, where the task ID and resource list member ID are zero.
4.  Billed amount sums the draft invoice items of invoices with a released date.
5.  Funding is summed from `PA_SUMMARY_PROJECT_FUNDINGS`, and the last invoice date is the maximum invoice date of released draft invoices.

## Parameters & Filtering
*   **Operating Unit:** limits the projects to one organization within the accessible set.
*   **Project Type:** restricts the output to one project type.
*   **Project Status:** restricts the output to projects in one status.

## Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so only accessible projects are read.
*   Each total is a scalar subquery keyed on the project ID, so each project produces one row and no grouped join is needed.
*   The project-level accumulator is selected with task ID zero and resource list member ID zero, which avoids summing task and resource detail.
*   The unbilled and available funding columns reuse the same scalar subqueries, so the logic for revenue and billing is consistent across columns.

## FAQ
**Q: How is the unbilled receivable calculated?**
A: It is the revenue to date for the project less the billed amount on released draft invoices.

**Q: What does available funding show?**
A: The total baselined funding of the project less its revenue to date. Where no funding is recorded, the funding total is treated as zero, so the figure is the negative of the revenue to date.

**Q: Which invoices count as billed?**
A: Only draft invoices with a released date are counted in the billed amount and in the last invoice date.
