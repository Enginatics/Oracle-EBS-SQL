# Case Study & Technical Analysis: OPM Batch Details and Status Summary

## Executive Summary
The OPM Batch Details and Status Summary report lists the production batches of Oracle Process Manufacturing, one row per batch. For each batch it shows the status and type, the recipe and version it was made from, the primary product, the planned and actual output quantity, the planned and actual start and completion dates, and whether the batch finished on or before its planned completion date. Production supervisors and plant planners use it to review batch execution against plan, to confirm which batches are still pending or released, and to report on on-time completion. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Plan versus actual output:** Plant managers need the planned and actual product quantity of each batch to measure yield and throughput.
*   **Schedule adherence:** Batches that finish after their planned completion date must be identified to explain delays in the production schedule.
*   **Recipe traceability:** Each batch must be traceable to the recipe and recipe version that governed its production, which matters for quality and regulatory records.
*   **Planned production view:** Planners need the batches that are pending or released, with their planned dates, to see the load on each organization.

## The Solution
*   **Batch header base:** The report starts from the batch header of each organization, which holds the batch number, status, type and planned and actual dates.
*   **Product summary:** The primary product is identified from the first product line of each batch, and its planned and actual quantities are summed from the material lines of type product.
*   **Recipe linkage:** The batch is linked through its recipe validity rule to the recipe and its version number.
*   **On-time flag:** The completed on time indicator is Yes when the actual completion date is on or before the planned completion date.

## Technical Architecture (High Level)
### Primary Tables
*   `GME_BATCH_HEADER`: the production batch header, with batch number, status, type, recipe validity rule and planned and actual dates.
*   `GME_MATERIAL_DETAILS`: the batch material lines, used for the product lines with their planned and actual quantities and units.
*   `GMD_RECIPE_VALIDITY_RULES`: the link between the batch and the recipe.
*   `GMD_RECIPES_VL`: the recipe number and version.
*   `MTL_SYSTEM_ITEMS_VL`: the product item number and description.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

### Logical Relationships
1.  `GME_BATCH_HEADER` joins to `ORG_ORGANIZATION_DEFINITIONS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  An inline view takes the material lines of type 1 (product) and groups them by batch, returning the first product item, the summed planned and actual quantities, and the unit of the first line.
3.  The batch joins to that inline view on the batch ID, and the product item joins to `MTL_SYSTEM_ITEMS_VL` on item and organization.
4.  The batch joins to `GMD_RECIPE_VALIDITY_RULES` on the recipe validity rule ID, and that joins to `GMD_RECIPES_VL` on the recipe ID.
5.  Output is ordered by organization code and batch number.

## Parameters & Filtering
*   **Organization Code:** selects the process manufacturing organization.
*   **Batch Number:** selects one batch.
*   **Product Item:** limits the batches to one product.
*   **Batch Status:** limits the output to batches in one status, such as pending or released.
*   **Actual Start Date From** and **Actual Start Date To:** bound the actual start date of the batch.

## Performance & Optimization
*   The product quantities are pre-aggregated in an inline view grouped by batch, so the material table is read once for each batch rather than once per output row.
*   The first product line is selected with `KEEP (DENSE_RANK FIRST)` on the line number, which avoids a second join to the material table.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied to the batch header before the inline view joins.
*   Recipe and product joins are outer joins, so batches without a recipe or product line are still listed.

## FAQ
**Q: How is the on-time completion flag determined?**
A: The flag is Yes when the actual completion date is on or before the planned completion date, and blank otherwise.

**Q: Which quantity is shown as the batch output?**
A: The planned product quantity and the actual product quantity are the sums of the product lines of the batch, in the unit of its first product line.

**Q: What is the difference between a Batch and a Firm Planned Order in this report?**
A: The batch type column shows Batch for batch type 0 and Firm Planned Order for batch type 10.
