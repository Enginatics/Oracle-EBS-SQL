# PA Project Budget - Case Study & Technical Analysis

## Executive Summary
The **PA Project Budget** report is a cornerstone of project financial management within Oracle Projects. It provides project managers and financial controllers with a detailed view of project budgets, enabling them to monitor planned spending against actual costs. By supporting multiple budget types (Cost, Revenue) and versions (Baselined, Current Working), this report ensures that organizations can maintain strict financial discipline over their project portfolios.

## Business Challenge
Project-driven organizations often struggle with:
*   **Budget Visibility:** Difficulty in accessing the latest approved budget figures across hundreds of active projects.
*   **Version Control:** Confusion arising from multiple budget versions (Original vs. Current vs. Draft).
*   **Granularity:** Inability to drill down from a project-level budget to specific tasks or resources.
*   **Variance Analysis:** Challenges in aligning budget lines with actual expenditure for timely variance reporting.

## Solution
This SQL-based report solves these challenges by extracting comprehensive budget details directly from the Oracle Projects schema. It allows users to:
*   **Compare Versions:** View different budget versions side-by-side to understand scope changes.
*   **Analyze by Resource:** Break down budgets by resource list members (Labor, Material, Equipment) to identify cost drivers.
*   **Track Status:** Filter budgets by status (Baselined, Submitted, Working) to ensure reporting on the correct data set.
*   **Integrate Actuals:** (Optional) Map budget lines to actuals for immediate performance assessment.

## Technical Architecture
The report leverages the core Oracle Projects budget model, linking projects, tasks, and resource assignments to budget lines.

### Key Tables & Views
| Table Name | Description |
| :--- | :--- |
| `PA_PROJECTS_ALL` | The master table for project definitions. |
| `PA_BUDGET_VERSIONS` | Stores header information for each budget version (e.g., Version Number, Status). |
| `PA_BUDGET_TYPES` | Defines the type of budget (e.g., Approved Cost, Approved Revenue). |
| `PA_RESOURCE_ASSIGNMENTS` | Links budget amounts to specific resources and tasks. |
| `PA_BUDGET_LINES` | Contains the periodic budget amounts (Raw Cost, Burdened Cost, Revenue) and dates. |
| `PA_TASKS` | Provides the Work Breakdown Structure (WBS) hierarchy. |

### Core Logic
1.  **Project & Task Context:** The query starts with `PA_PROJECTS_ALL` and joins to `PA_TASKS` to establish the WBS context.
2.  **Budget Version Selection:** It filters `PA_BUDGET_VERSIONS` based on the user's selection (e.g., "Current Baselined" or specific version number).
3.  **Resource Mapping:** `PA_RESOURCE_ASSIGNMENTS` connects the budget version to the specific resources being budgeted.
4.  **Line Detail:** `PA_BUDGET_LINES` provides the granular period-by-period financial data.

## FAQ
**Q: Does this report show both Cost and Revenue budgets?**
A: Yes, the report can be filtered by `Budget Type` to show Cost, Revenue, or both.

**Q: Can I see the "Original" budget vs the "Current" budget?**
A: Yes, the report parameters allow selection of specific budget versions or dynamic selection of the "Latest Baselined" version.

**Q: How are "Actuals" handled in this report?**
A: The report includes logic to fetch actuals matching the budget line datapoints, provided the Blitz Report Build Data is up to date.

**Q: Does it support multi-currency budgets?**
A: Yes, the underlying tables (`PA_BUDGET_LINES`) store amounts in transaction, project, and project functional currencies.
