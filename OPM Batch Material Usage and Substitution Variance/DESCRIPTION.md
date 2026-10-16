# Case Study & Technical Analysis: OPM Batch Material Usage and Substitution Variance

## Executive Summary
This report compares planned and actual ingredient consumption for each Oracle Process Manufacturing (OPM) production batch. For every batch material line it shows the planned quantity, the actual quantity, the usage variance and its percentage, the remaining quantity, the scrap factor, and an indicator where the ingredient was substituted. Production planners, cost accountants and plant managers use it to see over-consumption and material substitutions at the batch line level. It is an R12 report that runs in Excel through Blitz Report™.

## Business Challenge
*   **Yield and cost control:** Ingredients consumed above the planned quantity raise the cost of each batch, and the overrun must be identified batch by batch.
*   **Substitution traceability:** When a material is replaced by another item, the substitution must be visible so that the cost and quality impact can be assessed.
*   **Remaining material:** Planned material that was not consumed needs to be seen, since it affects inventory and the reconciliation of the batch.
*   **Scrap assessment:** The scrap factor applied to each ingredient must be compared with the consumption actually achieved.

## The Solution
*   Returns one row per batch ingredient with the batch number, batch status and actual completion date, together with the item and its description.
*   Calculates the usage variance as actual quantity less planned quantity, and expresses it as a percentage of the planned quantity.
*   Calculates the remaining quantity as planned less actual, and shows the scrap factor and the original quantity of the ingredient.
*   Marks a line as a substitution where the original quantity is present and differs from the planned quantity.

## Technical Architecture (High Level)
### Primary Tables
*   `GME_MATERIAL_DETAILS`: the material lines of each batch, with the planned, actual and original quantities, the unit of measure, the scrap factor and the line type.
*   `GME_BATCH_HEADER`: the batch header, with the batch number, batch status and actual completion date.
*   `MTL_SYSTEM_ITEMS_VL`: the item number and description of each ingredient.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code of each batch.
*   `ORG_ACCESS_VIEW`: the organizations that the current responsibility can access.

### Logical Relationships
1.  Each material line in `GME_MATERIAL_DETAILS` is joined to its batch header on the batch identifier.
2.  Only lines with line type -1 are kept, which selects the ingredient lines of each batch.
3.  Each line is joined to its item in `MTL_SYSTEM_ITEMS_VL` on item and organization.
4.  Each line is joined to its organization definition to give the organization code.
5.  The organization restriction uses `ORG_ACCESS_VIEW` for the current responsibility and application.
6.  Results are ordered by organization code, batch number and item.

## Parameters & Filtering
*   **Organization Code:** limits the batches to one OPM organization.
*   **Batch Number:** selects one or more batches.
*   **Ingredient Item:** restricts the lines to one ingredient.
*   **Batch Status:** filters the batches by their status.
*   **Actual Completion Date From** and **To:** select batches by their actual completion date.
*   **Show only variances:** limits the output to lines that show a variance, so that lines consumed exactly as planned are omitted.

## Performance & Optimization
*   The line type filter is applied on the material table, so only ingredient lines reach the batch and item joins.
*   The organization access restriction is a single subquery on `ORG_ACCESS_VIEW` evaluated against the session responsibility, which keeps the organization list short.
*   The variance percentage is guarded against division by zero with a null-if function on the planned quantity, so a zero-planned line returns a blank rather than an error.
*   Joins to items and organizations are keyed lookups, so the cost grows mainly with the number of batch ingredient lines in the selected completion date window.

## FAQ
**Q: How is the usage variance percentage calculated?**
A: It is the actual quantity less the planned quantity, divided by the planned quantity and multiplied by 100, rounded to two decimal places.

**Q: How does the report identify a material substitution?**
A: A line is marked as a substitution when its original quantity is present and differs from the planned quantity, which is the condition the report uses for the substitution indicator.

**Q: Which lines appear in the output?**
A: Only ingredient lines, identified by line type -1 in the batch material details, appear, and the Show only variances parameter can remove lines consumed exactly as planned.
