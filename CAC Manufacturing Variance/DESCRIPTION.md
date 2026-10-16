# Case Study & Technical Analysis: CAC Manufacturing Variance

## Executive Summary
The **CAC Manufacturing Variance** report is the definitive tool for analyzing production performance in a Standard Costing environment. It calculates and categorizes the difference between the *Standard* cost of a job and the *Actual* input costs. It distinguishes between "Valuation" (potential variance in Open jobs) and "Variance" (realized P&L impact in Closed jobs).

## Business Challenge
Manufacturing variances are the primary indicator of shop floor efficiency.
*   **Usage Variance**: Did we use more material than the BOM specified? (Scrap/Theft/Yield).
*   **Efficiency Variance**: Did the operation take longer than the Routing specified? (Labor performance).
*   **Method Variance**: Did we use a non-standard BOM or Routing for this specific job?
*   **Timing**: Managers need to see these variances *before* the period closes to take corrective action.

## Solution
This report provides a granular breakdown of the variance.
*   **Categorization**: Splits variance into Material, Resource, Overhead, and Outside Processing buckets.
*   **Status Awareness**: Clearly separates Open jobs (WIP Balance) from Closed jobs (P&L Write-off).
*   **Scrap Handling**: Correctly accounts for assembly scrap to avoid double-counting variances.

## Technical Architecture
The report is a complex synthesis of WIP and Cost data:
*   **Tables**: `wip_discrete_jobs`, `wip_period_balances`, `wip_requirement_operations`.
*   **Calculation**:
    *   *Standard* = (Completed Qty * Standard Unit Cost)
    *   *Actual* = (Issued Material + Charged Resources)
    *   *Variance* = Actual - Standard
*   **Logic**: Includes logic to handle "Unreleased" jobs and "Bulk" supply items.

## Parameters
*   **Report Option**: (Mandatory) Open, Closed, or All jobs.
*   **Period Name**: (Mandatory) The accounting period.
*   **Include Scrap**: (Mandatory) Toggle to include scrap cost in the calculation.
*   **Use Completion Qtys**: (Mandatory) Determines how standard requirements are calculated for open jobs.

## Performance
*   **Heavy**: This is a calculation-intensive report. Running it for "All Jobs" over a long history can be slow.
*   **Optimization**: Filter by Organization and Period to keep performance high.

## FAQ
**Q: Why do I have a variance on an Open job?**
A: You don't technically have a "variance" yet; you have a "potential variance". If you issued all materials but haven't completed the assembly, the WIP value is high. The report estimates the variance assuming the current state is final.

**Q: What is a "Configuration Variance"?**
A: It occurs when the BOM used for the Job differs from the Standard BOM used for the Cost Rollup. E.g., substituting Part A for Part B.

**Q: Does this match the GL?**
A: For *Closed* jobs, the total variance should match the WIP Variance account postings in the GL. For *Open* jobs, it represents the WIP Inventory balance.
