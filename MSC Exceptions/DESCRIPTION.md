# MSC Exceptions - Case Study & Technical Analysis

## Executive Summary
The **MSC Exceptions** report is the primary alerting mechanism for the Advanced Supply Chain Planning (ASCP) engine. It highlights critical issues in the supply chain plan that require planner intervention, such as late orders, resource overloads, or material shortages.

## Business Challenge
ASCP plans are complex and cover the entire supply chain. Planners cannot review every single order. They need to know:
-   **Criticality:** "Which customer orders are in danger of being late?"
-   **Capacity:** "Which manufacturing lines are overloaded next week?"
-   **Data Quality:** "Which items have invalid lead times or missing costs?"

## Solution
The **MSC Exceptions** report filters the plan results into actionable alerts.

**Key Features:**
-   **Exception Groups:** Categorizes exceptions (e.g., "Late Sales Orders", "Resource Overloaded", "Material Shortage").
-   **Drill-Down:** Provides the specific details (Item, Order, Date, Quantity) for each exception.
-   **Prioritization:** Allows filtering by Exception Type and Planner to focus on the most urgent issues.

## Technical Architecture
The report queries the exception tables in the ASCP schema (often on a separate planning server).

### Key Tables and Views
-   **`MSC_EXCEPTION_DETAILS_V`**: The primary view for exception messages.
-   **`MSC_PLANS`**: Defines the plan being analyzed.
-   **`MSC_SYSTEM_ITEMS`**: Provides item details within the plan.
-   **`MSC_DEMANDS`**: Links exceptions to specific demand records.

### Core Logic
1.  **Exception Generation:** During the ASCP run, the engine identifies violations of constraints (time, capacity, material).
2.  **Storage:** These violations are stored in the exception tables with a specific Exception Type ID.
3.  **Reporting:** The report retrieves these records, joined with the relevant entity (Item, Resource, Order) for context.

## Business Impact
-   **Proactive Management:** Enables planners to fix problems before they impact the customer.
-   **Resource Optimization:** Helps identify bottlenecks (overloaded resources) and excess capacity.
-   **Plan Quality:** Highlights data issues that are causing poor planning results.
