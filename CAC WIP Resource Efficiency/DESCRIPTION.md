# Executive Summary
The **CAC WIP Resource Efficiency** report analyzes the efficiency of labor and machine resources applied to Work in Process (WIP) jobs. It compares the *standard* resource requirements (based on the routing and completion quantity) against the *actual* resources charged to the job. This report is the primary tool for calculating and explaining the "Resource Efficiency Variance" component of manufacturing costs, helping management understand if production is taking more or less time than planned.

# Business Challenge
Resource costs (Labor and Overhead) are a significant component of manufacturing value.
*   **Efficiency Variance**: If a standard routing says an operation takes 1 hour, but it actually takes 1.5 hours, that is an unfavorable efficiency variance.
*   **Cost Control**: Consistently unfavorable variances indicate either shop floor inefficiencies (training, machine downtime) or incorrect standards (routings need updating).
*   **Valuation**: For open jobs, these variances sit in WIP inventory. For closed jobs, they hit the P&L.

Managers need to know *where* the inefficiencies are occurring—by Department, Resource, or specific Job.

# Solution
This report provides a detailed comparison of "Applied Resource Units" vs. "Standard Resource Units".

**Key Features:**
*   **Efficiency Calculation**: Calculates the variance in both units (hours) and value (currency).
*   **Open and Closed Jobs**:
    *   *Valuation*: Shows the efficiency variance embedded in open WIP jobs.
    *   *Variance*: Shows the final efficiency variance realized on closed jobs.
*   **Scrap Inclusion**: Can automatically include resources consumed by scrapped assemblies in the standard requirement (giving credit for work done on bad parts).
*   **Flexible Rates**: Can use either the standard cost rates or average rates depending on the cost type parameter.

# Architecture
The report joins `WIP_DISCRETE_JOBS` with `WIP_OPERATIONS` and `WIP_OPERATION_RESOURCES` to determine the standard requirements. It compares this to the actuals found in `WIP_TRANSACTIONS` (or aggregated transaction views).

**Key Tables:**
*   `WIP_DISCRETE_JOBS`: Job header.
*   `WIP_OPERATIONS`: The routing steps for the job.
*   `WIP_OPERATION_RESOURCES`: The resources (labor/machine) assigned to each step.
*   `WIP_TRANSACTIONS`: The actual resource charging history.
*   `BOM_DEPARTMENTS`: To group resources by department.

# Impact
*   **Performance Management**: Provides the data needed to hold production supervisors accountable for labor efficiency.
*   **Routing Accuracy**: Identifies operations where the standard times are consistently wrong, triggering engineering reviews.
*   **Profitability Analysis**: Helps quantify the financial impact of shop floor productivity (or lack thereof).
