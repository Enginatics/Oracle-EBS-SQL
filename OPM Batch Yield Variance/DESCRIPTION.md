# Case Study & Technical Analysis: OPM Batch Yield Variance

## Executive Summary
This report measures batch yield in Oracle Process Manufacturing (OPM). For each completed batch it compares the planned and actual output of every product and by-product with the total planned and actual batch input, and reports the quantity variance, the variance percentage and the planned and actual yield percentage. Yield is the key production efficiency measure for process plants, and this report gives production managers, plant controllers and quality engineers the batch-level evidence behind a yield trend. It is used to find the batches and products where more material was lost or produced than the formula expected, which supports decisions on formula tuning, equipment maintenance and cost of goods review.

## Business Challenge
*   **Yield losses are hidden in batch data:** A batch can complete with output below the formula target, and the loss is only visible when planned and actual quantities are compared.
*   **By-products need the same view:** By-products and products have to be measured against their own plan, not only the main product.
*   **Comparing batches on one basis:** Yield must be calculated against the same input basis for every batch, so that batches of different sizes can be compared.
*   **Tracing a variance to a recipe:** The recipe and version used for a batch must be visible to explain why its yield differs.

## The Solution
*   Lists each completed product or by-product line of a batch, with its planned and actual quantity, unit of measure and the variance in quantity and percentage.
*   Calculates the planned and actual input quantity of each batch as the sum of its ingredient lines, and expresses the planned and actual yield of each output as a percentage of that input.
*   Shows the batch number, batch status, actual start and completion dates, and the recipe number and version from the recipe validity rule.
*   Classifies each output line as a Product or a By-Product, so main output and secondary output can be read separately.

## Technical Architecture (High Level)
### Primary Tables
*   `GME_BATCH_HEADER`: the batch, with batch number, status, organization, recipe validity rule, and actual start and completion dates.
*   `GME_MATERIAL_DETAILS`: the material lines of a batch, with the line type, planned and actual quantity, and unit of measure.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `GMD_RECIPE_VALIDITY_RULES` and `GMD_RECIPES_VL`: the recipe and the version used for the batch.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `GME_BATCH_HEADER` is restricted to organizations the responsibility can access, and joined to its material lines in `GME_MATERIAL_DETAILS`.
2. Output lines are the material lines with line type 1 for products or 2 for by-products.
3. Each material line is joined to its item in `MTL_SYSTEM_ITEMS_VL` on item and organization.
4. An inline view sums the planned and actual quantities of the ingredient lines, which have line type -1, for each batch.
5. The batch is joined to the recipe validity rule, and then to the recipe, so the recipe number and version are shown.
6. The inline input totals are joined to the batch, so each output row carries the input basis of its batch.

## Parameters & Filtering
*   **Organization Code:** limits the batches to one organization.
*   **Batch Number:** selects one batch.
*   **Product Item:** selects a product item.
*   **Batch Status:** selects batches by their status.
*   **Actual Completion Date From** and **Actual Completion Date To:** bound the completion date of the batch.

## Performance & Optimization
*   The ingredient totals are computed once per batch in an inline view, so the input basis is not recalculated for each output line.
*   The output lines are restricted to product and by-product types at the start, so ingredient lines are used only for the totals.
*   Variance and yield percentages are computed with null-safe division on the planned values, so a line with no planned quantity does not stop the report.
*   The recipe lookups are outer joins, so batches without a recipe validity rule still appear in the report.

## FAQ
**Q: How is planned yield calculated?**
A: Planned yield percentage is the planned output quantity of the line divided by the planned input quantity of the batch, multiplied by 100.

**Q: What does a negative quantity variance mean?**
A: The actual output of the line is lower than the planned output. The variance percentage shows the size of the shortfall against the plan.

**Q: Can I report only completed batches?**
A: Yes. Use the Batch Status parameter and the Actual Completion Date range to limit the report to completed batches.
