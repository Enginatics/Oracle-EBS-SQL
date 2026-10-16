# Case Study & Technical Analysis: OPM Formula Where-Used

## Executive Summary
This report answers the question "which formulas use this ingredient?" in Oracle Process Manufacturing. For a given ingredient item it lists every formula that consumes it, with the quantity and unit of measure, the formula's version and status, its primary product, and the number of recipes built from that formula. Process manufacturing quality, regulatory and supply chain teams use it for impact analysis before a substitution, a supplier change or an allergen or regulatory recall. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Substitution impact:** Replacing an ingredient needs every formula that consumes it to be identified before the change is released.
*   **Supplier change control:** A new supplier of a raw material must be checked against all the formulas it touches.
*   **Recall scope:** An allergen or regulatory recall must reach every formula and recipe that contains the affected ingredient.
*   **Formula status:** Obsolete or on-hold formulas still consume ingredients in the data, and their status must be visible.

## The Solution
*   **Ingredient consumption:** The report selects each formula line where the item is an ingredient, identified by a negative line type.
*   **Quantity and unit:** The ingredient quantity, its unit of measure and its scrap factor are shown on each row.
*   **Formula identity:** The formula number, version and status name are returned so each usage can be judged.
*   **Primary product:** The item of the formula's product line is shown, so the consumer of the ingredient is identified.
*   **Recipe count:** The number of distinct recipes built from the formula shows how far the change would spread.

## Technical Architecture (High Level)
### Primary Tables
*   `FM_MATL_DTL`: the formula material lines, with line type, quantity, unit of measure and scrap factor. Ingredient lines have a negative line type and product lines have a positive one.
*   `FM_FORM_MST`: the formula master, with formula number, version and status.
*   `MTL_SYSTEM_ITEMS_VL`: the ingredient and product item and its description.
*   `GMD_RECIPES_VL`: the recipes that use each formula, counted for the recipe count.
*   `GMD_STATUS_VL`: the status name of the formula.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `FM_MATL_DTL` joins to `FM_FORM_MST` on formula id, and is restricted to ingredient lines with line type -1.
2. `FM_MATL_DTL` joins to `MTL_SYSTEM_ITEMS_VL` on inventory item id and organization id, which gives the ingredient item.
3. `FM_FORM_MST` joins to `GMD_STATUS_VL` on the formula status code, as an outer join.
4. The product item is a scalar subquery on the formula's product lines, with line type 1, and returns the first match.
5. The recipe count is a scalar subquery on `GMD_RECIPES_VL` counting distinct recipe ids for the formula.

## Parameters & Filtering
*   **Organization Code:** restricts the usages to one process manufacturing organization.
*   **Ingredient Item:** restricts the report to one ingredient.
*   **Formula Status:** restricts the formulas to one status.

## Performance & Optimization
*   The ingredient line filter on line type applies before the item and formula joins, so the report reads only consumption lines.
*   The organization access list limits the material detail rows to the organizations the responsibility can access.
*   The product item and recipe count are scalar subqueries keyed on the formula id, so they run once for each returned formula line.

## FAQ
**Q: How do I find every formula that uses a particular ingredient?**
A: Enter the item in Ingredient Item and leave the other parameters blank, or select the organization that holds the formula.

**Q: What does the recipes using column count?**
A: It counts the distinct recipes built from the formula, so it shows how many recipes a formula change would affect.

**Q: Why does a formula appear more than once?**
A: The report has one row per ingredient line, so a formula that uses the item in two lines appears twice.
