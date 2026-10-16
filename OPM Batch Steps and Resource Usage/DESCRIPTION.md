# Case Study & Technical Analysis: OPM Batch Steps and Resource Usage

## Executive Summary
The OPM Batch Steps and Resource Usage report shows each routing step of a Process Manufacturing production batch, together with the resources used on that step. For every step it gives the status, planned and actual step quantity and dates, and for every resource (machine or labor) it gives the planned and actual usage, the usage variance, the resource count and the usage unit of measure. Production supervisors and plant engineers use it to review batch execution and to analyse how efficiently machines and labor were used against plan. It is an operational review tool for Oracle Process Manufacturing (OPM) and runs in Excel through Blitz Report™.

## Business Challenge
*   **Batch execution review:** Supervisors need to see whether each batch step was completed on plan, both in quantity and in time, and which steps are still open.
*   **Resource efficiency:** Machine and labor usage must be compared with plan to find steps that consume more resource time than expected.
*   **Variance analysis:** Usage differences must be quantified per resource, so that the root cause of an overrun can be traced to a step and a batch.
*   **Cross-plant comparison:** Plants in the same enterprise need the same measures for the same batch steps, so results can be compared.

## The Solution
*   **Step-level plan and actual:** Each batch step shows its planned and actual quantity, start date and completion date.
*   **Resource-level usage:** Each resource on a step shows its planned and actual usage, count and usage unit of measure.
*   **Calculated usage variance:** The variance is actual usage minus planned usage, rounded to six decimal places, so overruns are positive and underruns negative.
*   **Decoded status:** The step status is shown with its meaning from the step status lookup.

## Technical Architecture (High Level)
### Primary Tables
*   `GME_BATCH_HEADER`: the production batch header, with the batch number and organization.
*   `GME_BATCH_STEPS`: the routing steps of each batch, with step number, status, quantities and dates.
*   `GME_BATCH_STEP_RESOURCES`: the resources used on each step, with planned and actual usage and counts.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code and name for the batch's organization.
*   `ORG_ACCESS_VIEW`: the organizations available to the current responsibility.

### Logical Relationships
1.  `GME_BATCH_HEADER` is restricted to the organizations in `ORG_ACCESS_VIEW` for the current responsibility.
2.  `GME_BATCH_STEPS` is joined to the batch header on the batch ID.
3.  `GME_BATCH_STEP_RESOURCES` is outer joined to each step on the batch step ID, so steps with no resource still appear.
4.  `GME_BATCH_HEADER` is joined to `ORG_ORGANIZATION_DEFINITIONS` on the organization ID to show the organization code.
5.  The result is ordered by organization code, batch number, step number and resource code.

## Parameters & Filtering
*   **Organization Code:** Limits the batches to one OPM organization.
*   **Batch Number:** Selects one or more batches.
*   **Resource:** Restricts the output to one resource, which is useful for resource-efficiency analysis.
*   **Step Status:** Restricts the steps to the selected status.

## Performance & Optimization
*   **Organization access first:** The batch header filter through `ORG_ACCESS_VIEW` limits the batches to those the responsibility can see before the step join.
*   **Outer join to resources:** Resource rows are outer joined, so steps without resources are kept, and the step list is not reduced by resource data.
*   **Variance in the select list:** The variance is computed from the two usage columns in the same row, so no separate pass is needed.
*   **Explicit ordering:** The output is sorted on organization, batch, step and resource, which lets each batch be read in routing order.

## FAQ
**Q: How do I find steps where a resource used more time than planned?**
A: Look at the Usage Variance column. A positive value means the actual usage is above plan, and the Resource and Step Status parameters help narrow the list.
**Q: Are steps without resources included?**
A: Yes. The resource join is an outer join, so a step with no resource usage still appears, with blank resource columns.
**Q: Which organizations does the report cover?**
A: It covers only the organizations that the current responsibility can access through the organization access view.
