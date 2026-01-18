
# Case Study & Technical Analysis: CAC WIP Material Usage Variance

## Executive Summary
The **CAC WIP Material Usage Variance** report is a deep-dive analytical tool for manufacturing cost control. It focuses specifically on the "Material" component of WIP variance, which is often the largest driver of manufacturing cost deviations.
Unlike the high-level "WIP Account Summary," this report drills down to the component level, comparing what *should* have been used (Standard Quantity) against what *was* actually used (Issued Quantity). It replicates and enhances the logic of the standard Oracle "Discrete Job Value Report" but in a flat, exportable format.

## Business Challenge
Material variance is a key performance indicator (KPI) for the shop floor, but it's hard to diagnose.
*   **Usage vs. Configuration:** If a job has a $1,000 variance, is it because the operator used 10 extra bolts (Usage), or because they substituted a more expensive steel grade (Configuration)?
*   **Timing Issues:** Standard reports often show the *current* state of the job. If you are analyzing last month's close, you need a report that "rolls back" the quantities to show the status *as of* that period end.
*   **Open vs. Closed:** Finance treats open jobs (Valuation) differently from closed jobs (Variance). Open job variances sit on the balance sheet; closed job variances hit the P&L.

## The Solution
This report provides a precise, component-level variance analysis.
*   **Variance Decomposition:**
    *   **Usage Variance:** `(Standard Qty - Actual Qty) * Standard Cost`. This highlights efficiency issues (scrap, theft, over-issue).
    *   **Configuration Variance:** Highlights when a component was not in the original BOM or was substituted.
*   **Time-Travel Logic:** The report uses transaction history (`MTL_MATERIAL_TRANSACTIONS`) to calculate the "Applied Quantity" and "Completed Quantity" exactly as they were at the end of the selected period. This makes it perfect for retrospective month-end analysis.
*   **Flexible Baselines:** The `Use Completion Quantities` parameter allows users to calculate standard requirements based on what was actually built, rather than what was planned. This is crucial for environments where yield varies significantly.

## Technical Architecture (High Level)
The query is complex because it must reconstruct the state of every job at a past point in time.
*   **CTEs for Job State:**
    *   `wdj00` & `wdj0`: These Common Table Expressions filter the jobs to be reported (Open, Closed, or All) and establish the job header details (Status, Quantities) relative to the reporting period.
*   **Component Logic:**
    *   It joins `WIP_REQUIREMENT_OPERATIONS` (the BOM) to determine the *Standard* requirement.
    *   It sums `MTL_MATERIAL_TRANSACTIONS` (the Issues/Returns) to determine the *Actual* usage.
*   **Costing Logic:** It joins to `CST_ITEM_COSTS` to value the quantities. It defaults to the organization's Costing Method but allows an optional `Cost Type` override for simulation.
*   **Variance Calculation:**
    *   `Target Qty = (Qty Completed + Qty Scrapped) * BOM Quantity per Assembly`.
    *   `Usage Variance = (Target Qty - Actual Issued Qty) * Item Cost`.

## Parameters & Filtering
*   **Report Option:** Toggle between Open (Valuation), Closed (Variance), or All.
*   **Period Name:** The anchor point for the "As of" calculation.
*   **Include Scrap/Unreleased:** Fine-tunes the requirement calculation.
*   **Use Completion Qtys:** Determines if the standard is based on the *Start* quantity or the *Completed* quantity.

## Performance & Optimization
*   **Materialized CTEs:** The `/*+ materialize */` hint in the initial CTEs forces the database to build the list of relevant jobs once, preventing repeated scans of the `WIP_DISCRETE_JOBS` table for each component calculation.
*   **Transaction Filtering:** The summation of material transactions is strictly bounded by the `Period Name` dates, ensuring the "As of" calculation is accurate and efficient.

## FAQ
**Q: Why does the report show "Valuation" for some rows and "Variance" for others?**
A: This depends on the job status *in the selected period*. If the job was Open, the variance is still "Valuation" (an asset/liability on the balance sheet). If the job Closed during the period, the variance is finalized and written off to the P&L.

**Q: How does it handle "Bulk" items?**
A: Bulk items (like grease or fasteners) are often expensed upon receipt and not issued to specific jobs. The `Include Bulk Supply Items` parameter allows you to exclude them to avoid showing massive "favorable" variances (since the system expects usage but sees zero issues).

**Q: Why is my "Standard Quantity" zero?**
A: This usually happens if the component was added to the job ad-hoc (not in the BOM). In this case, the entire cost of the issued material is treated as a variance.