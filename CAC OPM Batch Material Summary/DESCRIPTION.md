# Case Study & Technical Analysis: CAC OPM Batch Material Summary

## Executive Summary
The **CAC OPM Batch Material Summary** report is a production analysis tool for Oracle Process Manufacturing (OPM). It summarizes the material activity (Ingredients consumed, Products yielded) for production batches. This is the OPM equivalent of a "Material Usage" report in Discrete manufacturing.

## Business Challenge
*   **Yield Analysis**: In chemical/food production, the ratio of Ingredients In to Product Out is the primary efficiency metric.
*   **Variance**: Did we use more Sugar than the Formula called for?
*   **Period Close**: Verifying that all material transactions for the period have been recorded against the batches.

## Solution
This report aggregates the details.
*   **Structure**: Groups by Batch, then by Line Type (Ingredient, Product, By-product).
*   **Quantities**: Shows Plan Qty, Actual Qty, and Variance.
*   **Valuation**: Uses the OPM Cost Type to value the material flows.

## Technical Architecture
*   **Tables**: `gme_batch_header`, `gme_material_details`.
*   **Costing**: Joins to `item_cost` (OPM Costing table) or `gmf_period_balances`.
*   **Logic**: Filters for batches active in the specified OPM Period.

## Parameters
*   **Period Name**: (Mandatory) Inventory Period.
*   **OPM Calendar/Period**: (Mandatory) OPM Costing Period.
*   **Cost Type**: (Optional) For valuation.

## Performance
*   **Batch Volume**: OPM environments can have high batch volumes. Filtering by Status (e.g., Closed) helps.

## FAQ
**Q: Does this show "WIP" value?**
A: No, this shows the *Material* flow (Issues and Completions). For the value of the Batch itself (WIP), use the "OPM WIP Account Value" report.

**Q: What is a "By-product"?**
A: A secondary item produced by the process (e.g., Skim Milk produced when making Cream). It typically has a negative cost or a recovery value.
