# Case Study & Technical Analysis: OPM Recipe Upload

## Executive Summary
The OPM Recipe Upload maintains process manufacturing recipes in Oracle Process Manufacturing (OPM), the Recipe Management structure that defines how a product is made. A recipe is downloaded as a multi-row structure covering the recipe header, validity rules, routing steps, step materials, process losses, customers, organisation activities and organisation resources, and each row is typed so that the user can see which part of the recipe it belongs to.
## Business Challenge
*   **Complex recipe structure:** A recipe spans a header, validity rules, steps, materials, losses and resources, and keying each part in the form is slow and error prone.
*   **Versioning and validity:** Products are made by a recipe under specific validity rules, such as organisation, quantity range and dates, and those rules must be correct for each product.
*   **Customer-specific and organisation-specific data:** Some recipes apply to particular customers or organisations, and the upload must maintain those links.

## The Solution
*   **Typed rows:** Each row carries a row type of Recipe, Validity Rule, Routing Step, Step Material, Process Loss, Customer, Org Operation or Org Resource, so the file reads as the recipe's structure.
*   **Recipe header detail:** The header returns organisation, recipe number and version, formula, routing, status, yield, process loss, owner and flexfield values.
*   **Validity rule detail:** Each validity rule shows its use, product, revision, preference, standard, minimum and maximum quantities, detail unit of measure and effective dates.
*   **Step and material detail:** Routing steps show the operation and version, step quantity and yield, and step materials show the item, line type and transfer and delay values.

## Technical Architecture (High Level)
### Primary Tables
*   `GMD_RECIPES_VL`: the recipe header, used as the root of every row type.
*   `GMD_RECIPE_VALIDITY_RULES`: the validity rules that define where and how a recipe applies.
*   `GMD_RECIPE_ROUTING_STEPS`: the recipe's routing steps with step quantity and operation yield.
*   `GMD_RECIPE_STEP_MATERIALS`: the materials consumed or produced in each step.
*   `GMD_RECIPE_PROCESS_LOSS`: the process loss definitions for the recipe.
*   `GMD_RECIPE_CUSTOMERS`: the customers associated with the recipe.
*   `GMD_RECIPE_ORGN_ACTIVITIES` and `GMD_RECIPE_ORGN_RESOURCES`: the organisation-level activities and resources of the recipe.
*   `GMD_OPERATIONS_VL` and `GMD_OPERATION_ACTIVITIES`: the operations and their activities.
*   `FM_FORM_MST_B`, `FM_ROUT_DTL` and `FM_MATL_DTL`: the formula, routing detail and formula material lines the recipe is built from.
*   `MTL_PARAMETERS`, `MTL_SYSTEM_ITEMS_VL` and `HZ_CUST_ACCOUNTS`: the organisation, item and customer references.
*   `ORG_ACCESS_VIEW`: the organisations accessible to the current responsibility.

### Logical Relationships
1. Each recipe in `GMD_RECIPES_VL` links to its owner organisation in `MTL_PARAMETERS`, and only recipes not marked for deletion are returned.
2. Validity rules join to the recipe on the recipe identifier and to `MTL_SYSTEM_ITEMS_VL` for the product.
3. Routing steps join `FM_ROUT_DTL` to the recipe's routing and then to `GMD_RECIPE_ROUTING_STEPS` on the routing step identifier.
4. Step materials join to the recipe and to the routing step, and their item is resolved through `FM_MATL_DTL` and `MTL_SYSTEM_ITEMS_VL`.
5. Process losses, customers and organisation activities join to the recipe, with activities linked to `GMD_OPERATION_ACTIVITIES` by operation line.
6. Organisation resources join to the recipe and the operation activity in the same way as activities.
7. The row types are combined with `union all` and ordered by recipe, version, row type, step, product and validity rule.

## Parameters & Filtering
*   **Upload Mode:** Chooses whether the file is used to create or update recipes. Every row type is returned only when the mode includes update.
*   **Organization Code:** Restricts the recipes to one owner organisation.
*   **Recipe:** Restricts the recipes to one recipe number.

## Performance & Optimization
*   **Organisation access filter:** Each branch of the union is restricted to owner organisations in `ORG_ACCESS_VIEW` for the current responsibility, so recipes outside the user's access are not read.
*   **Mode check first:** The condition on the upload mode is applied to every branch, so downloads that do not require the detail rows return only the header rows.

## FAQ
**Q: How do I download a recipe with its routing steps and materials in OPM?**
A: Set the Recipe and Organization Code parameters and run the report in update mode. The Routing Step and Step Material rows show each step and its materials.

**Q: What does a Validity Rule row represent?**
A: A validity rule defines the product, organisation, quantity range, revision and effective dates for which a recipe applies, and each one is a separate row under its recipe.

**Q: Which columns identify the step a material belongs to?**
A: The step column holds the routing step number, and the material rows carry the same recipe and routing step identifiers.
