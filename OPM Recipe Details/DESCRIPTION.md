# Case Study & Technical Analysis: OPM Recipe Details

## Executive Summary
The OPM Recipe Details report combines the recipe header, its validity rules, the formula product, and the routing steps and resource usage of Oracle Process Manufacturing (OPM) recipes into one list. It is designed for data cleaning before a cost roll up: process costing analysts and production planners use it to find recipes whose status, validity rule, product quantity, routing step or resource usage is incomplete or inconsistent. An optional category set parameter adds the item category code for each recipe item. The report runs in Excel via Blitz Report, and it excludes recipes with recipe status code 1000.

## Business Challenge
*   **Cost roll up readiness:** Process cost roll ups depend on consistent recipe, formula and routing data, and gaps must be found before the roll up is run.
*   **Validity rule coverage:** A recipe applies to items through validity rules with their own status, effective start date and standard quantity, and each rule must be correct for the item and organization.
*   **Routing and resource detail:** Each routing step carries a step quantity, and each resource carries a process quantity and usage, which must be checked against the recipe.
*   **Category based reporting:** Recipes are often grouped by item category, and the category code needs to be visible alongside the recipe.

## The Solution
*   **Recipe-to-rule view:** Each recipe is shown with each of its validity rules, including preference, start date, status, standard quantity and unit of measure.
*   **Product line in context:** The formula product line, with its item, quantity and unit of measure, appears beside the recipe.
*   **Routing detail:** Routing steps and their resources are shown with step quantities, process quantities, resource usage and their units.
*   **Optional category:** The category code of the recipe item in the selected category set is added when a Category Set is entered.

## Technical Architecture (High Level)
### Primary Tables
*   `GMD_RECIPES_VL`: the recipe header, with recipe number, description, version, status, owner organization, routing and formula identifiers.
*   `GMD_RECIPE_VALIDITY_RULES`: the validity rules that link a recipe to an item in an organization.
*   `GMD_STATUS_VL`: the recipe and validity rule status meanings.
*   `MTL_SYSTEM_ITEMS_VL`: the item number, status, description and weight unit for each validity rule.
*   `ORG_ORGANIZATION_DEFINITIONS`: the owner organization of the recipe.
*   `FM_ROUT_HDR`, `FM_ROUT_DTL`: the routing header and its steps.
*   `FM_MATL_DTL`: the formula material lines, used here for the product line.
*   `GMD_OPERATIONS_VL`, `GMD_OPERATION_ACTIVITIES`, `GMD_OPERATION_RESOURCES`: operations and their resource usage.
*   `MTL_ITEM_CATEGORIES`, `MTL_CATEGORIES_B_KFV`, `MTL_CATEGORY_SETS_VL`: the optional category assignment.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

### Logical Relationships
1. `GMD_RECIPES_VL` is joined to `ORG_ORGANIZATION_DEFINITIONS` on the owner organization.
2. `GMD_RECIPE_VALIDITY_RULES` is joined to the recipe on recipe identifier and to the organization on organization identifier.
3. `MTL_SYSTEM_ITEMS_VL` is joined to the validity rule on inventory item and organization.
4. `FM_ROUT_HDR` is outer joined on the recipe's routing identifier, and the routing detail block is outer joined on the same identifier.
5. The formula product block, from `FM_MATL_DTL` with line type 1, is outer joined on the recipe's formula identifier.
6. The category block joins item categories to the named category set and is outer joined on organization and item.
7. Recipe and validity rule statuses are outer joined to `GMD_STATUS_VL`.

## Parameters & Filtering
*   **Organization Code:** Limits the recipes to one owner organization, within the responsibility's accessible organizations.
*   **Recipe:** Restricts the output to one recipe number.
*   **Item:** Restricts the output to recipes for one item.
*   **Recipe Status:** Restricts the output to recipes in one status.
*   **Category Set:** Names the category set whose category code is shown for each item. The category block is only applied to the rows where the category set matches.

## Performance & Optimization
*   Organizations are restricted through an `IN` subquery on `ORG_ACCESS_VIEW`, which limits the recipe scan to the permitted owner organizations.
*   Recipes with status code 1000 are excluded in the main predicate, so their validity rules and routing detail are not returned.
*   The category, product and routing blocks are inline views joined as outer joins, so each recipe validity rule is extended by at most one category, one product line and the routing detail rows.
*   The routing detail is a non-correlated inline view joined through the routing identifier, so it is evaluated once for the routings it contains.
*   Results are ordered by organization code and recipe number.

## FAQ
**Q: Why is a recipe with status 1000 missing from the report?**
A: The report excludes recipes whose recipe status code is 1000 in its main predicate.

**Q: How do I see the item category for each recipe?**
A: Enter the name of the category set in the Category Set parameter; the category code is then returned for each item.

**Q: What does the validity rule status show?**
A: It shows the status meaning of each validity rule, read from the same status lookup as the recipe status.
