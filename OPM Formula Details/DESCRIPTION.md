# Case Study & Technical Analysis: OPM Formula Details

## Executive Summary
The OPM Formula Details report lists the Product Development formulas of Oracle Process Manufacturing (OPM), one row per formula line. Each row shows the ingredient, product or by-product line with its quantity, unit of measure, scrap factor, scale type, planned product percentage and whether the line contributes to yield, together with the formula header totals and status. Process engineers and R&D formulation teams use it to review formulas before they are released to recipes, and data quality analysts use it to find lines with missing or inconsistent values before a cost roll up. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Formulation review:** Formulas are built line by line, and reviewers need to see the full ingredient and product mix of each version in one place.
*   **Yield and scrap accuracy:** Scrap factors, planned product percentages and yield contribution flags drive material requirements and yield calculations, so errors here propagate into costs and plans.
*   **Status control:** Formulas move through statuses such as draft and approved, and reviewers need to see which version is in which state.
*   **Data quality:** Formula lines with missing scale types, units or items create problems later in batch creation and costing.

## The Solution
*   **Line-level view:** Each formula line is returned with its line number, item, item description, quantity and unit of measure.
*   **Line type labels:** The numeric line type is shown as Ingredient, Product or By-Product.
*   **Header context:** The formula number, version, description, status and total input and output quantities are repeated on every line.
*   **Yield and scale information:** Scale type is translated to its meaning, and the yield contribution indicator is shown as Yes or No.

## Technical Architecture (High Level)
### Primary Tables
*   `FM_FORM_MST`: the formula header, with formula number, version, description, status and total quantities.
*   `FM_MATL_DTL`: the formula material lines, with line type, line number, quantity, UOM, scrap factor, scale type, product percentage and yield flag.
*   `MTL_SYSTEM_ITEMS_VL`: the item number and description for each line.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `GMD_STATUS_VL`: the formula status meaning.
*   `GEM_LOOKUPS`: the scale type meaning, from the SCALE_TYPE lookup.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

### Logical Relationships
1. `FM_FORM_MST` is joined to `FM_MATL_DTL` on formula identifier, so each formula line carries its header.
2. `FM_MATL_DTL` is joined to `MTL_SYSTEM_ITEMS_VL` on inventory item and organization.
3. `FM_MATL_DTL` is joined to `ORG_ORGANIZATION_DEFINITIONS` on organization.
4. `GMD_STATUS_VL` is outer joined on the formula status code.
5. `GEM_LOOKUPS` is outer joined on the SCALE_TYPE lookup type and the line's scale type code.

## Parameters & Filtering
*   **Organization Code:** Limits the formulas to one organization. The organization access view restricts the lines to the responsibility's organizations.
*   **Formula:** Restricts the output to one formula number.
*   **Item:** Restricts the output to lines for one item.
*   **Formula Status:** Restricts the output to formulas in one status.
*   **Line Type:** Restricts the output to ingredients, products or by-products.

## Performance & Optimization
*   Organization access is applied as an `IN` subquery on `ORG_ACCESS_VIEW`, so the material detail scan is limited to the permitted organizations.
*   The status and scale type lookups are outer joins on key columns, so each line resolves to at most one meaning per lookup.
*   The query uses no aggregation or analytic functions; totals come from the header columns rather than from summing the lines.
*   Results are ordered by organization code, formula number, version and line number, so the sort is performed on the full result set.

## FAQ
**Q: What do the line types Ingredient, Product and By-Product mean in this report?**
A: The line type is shown from the material detail line type code: -1 is Ingredient, 1 is Product and 2 is By-Product.

**Q: How can I find formula lines that do not contribute to yield?**
A: The Contributes To Yield column shows Yes or No for each line, so the lines marked No can be filtered in Excel.

**Q: Which formula versions are included?**
A: Each formula version is a separate header row in FM_FORM_MST, and each version's lines are returned with the version number shown.
