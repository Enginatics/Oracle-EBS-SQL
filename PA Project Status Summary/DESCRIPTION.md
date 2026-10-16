# Case Study & Technical Analysis: PA Project Status Summary

## Executive Summary
The PA Project Status Summary report gives a project-level financial overview in Oracle Projects. For each project it shows the project manager, status, dates and organization, together with the actual raw cost, burdened cost, labor hours and revenue to date, the commitments, and the total of actuals and commitments. Project managers, controllers and portfolio reviewers use it to compare spend and revenue against commitments across projects, and to see the status and manager of each project in one list. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Spend visibility across projects:** Project actuals and commitments are held in separate accumulation tables, and combining them by hand for a portfolio review is time consuming.
*   **Commitment exposure:** Open purchase orders and other commitments can exceed the actual cost, so the total exposure must be visible next to the actuals.
*   **Ownership and status:** Reviewers need to know who manages each project and what its status is before reviewing the financials.
*   **Revenue and labor tracking:** Revenue and labor hours to date are needed alongside cost to assess project performance.

## The Solution
*   **Project-level totals:** Actuals and commitments are read from the project-level accumulation rows, with the task and resource list member set to zero.
*   **Combined totals:** Total raw and burdened cost add the commitments to the actuals for each project.
*   **Manager identification:** The project manager is the earliest-started active player with the project manager role.
*   **Status and organization:** The project status name and carrying out organization are shown with the project's start and completion dates.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_PROJECTS_ALL`: the project header, with number, name, type, status code, carrying out organization, dates and currency.
*   `PA_PROJECT_STATUSES`: the status names.
*   `PA_PROJECT_PLAYERS`: the project team members and their roles, used to find the project manager.
*   `PER_PEOPLE_X`: the project manager's full name.
*   `PA_PROJECT_ACCUM_HEADERS`: the accumulation header for each project, task and resource list member.
*   `PA_PROJECT_ACCUM_ACTUALS`: the actual cost, labor hours and revenue to date.
*   `PA_PROJECT_ACCUM_COMMITMENTS`: the commitment cost to date.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit and the carrying out organization names.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating unit access list for the session.

### Logical Relationships
1. `PA_PROJECTS_ALL` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on the operating unit, restricted by the access list.
2. A derived block selects the project manager from `PA_PROJECT_PLAYERS` with the PROJECT MANAGER role, active on the current date, using the earliest start date.
3. The project manager's person identifier is joined to `PER_PEOPLE_X` for the full name.
4. An actuals block joins `PA_PROJECT_ACCUM_ACTUALS` to `PA_PROJECT_ACCUM_HEADERS` and sums the inception-to-date figures per project, where the task and resource list member are zero.
5. A commitments block does the same for `PA_PROJECT_ACCUM_COMMITMENTS`, and both blocks are outer joined to the project.

## Parameters & Filtering
*   **Operating Unit:** Restricts the projects to one operating unit within the accessible set.
*   **Project Type:** Restricts the projects by project type.
*   **Project Status:** Restricts the projects by status.
*   **Project:** Restricts the output to one project.

The SQL text shown does not reference these parameters through bind variables, so the filtering is determined by the operating unit access list and the joins described above.

## Performance & Optimization
*   The actuals and commitments are pre-aggregated per project in inline views, so the outer query does not scan the accumulation detail for each project row.
*   The project manager block uses `min` with `keep (dense_rank first)` to choose one manager per project in a single pass.
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, which limits the project scan.
*   The accumulation headers are filtered on task zero and resource list member zero, which selects the project-level totals rather than task-level detail.

## FAQ
**Q: Why is the commitment total zero or blank for a project?**
A: The commitment columns come from an outer join to the project-level commitment accumulation, so a project without commitments shows no commitment value; the total then equals the actual cost.

**Q: Who is shown as project manager?**
A: The earliest-started active player with the PROJECT MANAGER role on the project, as of the current date.

**Q: Are the figures task-level or project-level?**
A: They are project-level, because the report uses only the accumulation rows with task zero and resource list member zero.
