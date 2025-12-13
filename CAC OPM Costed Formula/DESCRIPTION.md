# Case Study & Technical Analysis: CAC OPM Costed Formula

## Executive Summary
The **CAC OPM Costed Formula** report is a "Standard Cost" report for Process Manufacturing. It displays the calculated cost of a Formula (Recipe), broken down by the OPM Cost Component Classes (e.g., Material, Labor, Overhead, Depreciation). It is the OPM equivalent of the "Indented Bill of Materials Cost" report.

## Business Challenge
*   **Cost Visibility**: Understanding the cost structure of a formula is complex. It involves Ingredients, Routings, Resources, and Overheads.
*   **Simulation**: "If the price of Corn goes up 10%, what happens to the cost of our Ethanol?"
*   **Validation**: Verifying that the "Rolled Up" cost matches expectations before freezing it for the period.

## Solution
This report flattens the cost structure.
*   **Components**: Columns for up to 30 Cost Component Classes (configurable).
*   **Context**: Shows the Formula Version, Recipe Version, and Validity Rules.
*   **Details**: Can show Ingredient Scale Type (Fixed/Proportional) and Yield factors.

## Technical Architecture
*   **Tables**: `fm_form_mst` (Formula), `cm_cmpt_dtl` (Cost Details), `gmf_period_statuses`.
*   **Pivot**: The SQL dynamically pivots the rows from the cost detail table into columns for the report.

## Parameters
*   **OPM Calendar/Period**: (Mandatory) The costing period.
*   **Effective Date**: (Mandatory) For selecting the active formula.
*   **Cost Components**: (Optional) You can map specific Component Classes to the 30 columns.

## Performance
*   **Complex**: OPM Costing data is highly normalized. The report performs significant aggregation and pivoting.

## FAQ
**Q: Why "30" components?**
A: OPM allows unlimited cost components, but a flat report needs a fixed number of columns. 30 covers 99% of use cases.

**Q: Does it show the Routing?**
A: It shows the *costs* derived from the routing (Resources), but not the operations themselves.

**Q: What is "Validity Rule"?**
A: It determines *when* and *for whom* a recipe is valid (e.g., "Recipe A is for Plant 1, Recipe B is for Plant 2").
