# Case Study & Technical Analysis: CST Subinventory Account Value - Multi-Org

## Executive Summary
The CST Subinventory Account Value - Multi-Org report shows onhand inventory value by GL account and cost element across one or more Oracle Inventory organizations. It unpivots each subinventory's value into separate rows for Material, Material Overhead, Resource, Outside Processing and Overhead, and shows the GL account where each cost element is recorded. Cost accountants and inventory controllers use it to reconcile subinventory value with the general ledger at period close, and to check which account each subinventory's value is posted to. It corresponds to the standard Oracle report Subinventory Account Value Report (CSTRSAVR), extended to run across multiple organizations.

## Business Challenge
*   **Reconciling inventory to the ledger:** Period close requires the onhand value of each subinventory to tie to the inventory asset and expense accounts in the general ledger.
*   **Account visibility:** Teams need to know which GL account holds each cost element for each subinventory, which depends on the costing method and cost group setup.
*   **Asset versus expense subinventories:** Asset subinventories carry value across five cost elements, while expense subinventories carry a single total under an expense account, and both need to be reported correctly.

## The Solution
*   **Cost element unpivot:** Each item's value is split into up to five asset rows, one per cost element, or one expense row for expense subinventories.
*   **Costing-method account determination:** The account is taken from the subinventory setup under Standard costing, from the organization defaults under Average, FIFO or LIFO costing, and from cost group accounts where cost group accounting applies.
*   **Quantity and value filters:** Zero quantities, negative quantities and expense items can be included or excluded, and revision-level quantities can be shown.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_INV_QTY_TEMP`: the onhand quantity rows for the run, by organization, item, subinventory, revision and cost group.
*   `CST_INV_COST_TEMP`: the cost rows for the same items, with material, overhead, resource, outside processing and item cost values.
*   `MTL_PARAMETERS`: the organization parameters, including the primary cost method, cost group accounting flag and default accounts.
*   `MTL_SECONDARY_INVENTORIES`: the subinventory setup, including the asset flag, description and standard-costing accounts.
*   `MTL_SYSTEM_ITEMS_VL`: the item master, with item number, description, UOM, status, make-buy and planning attributes.
*   `MTL_CATEGORIES_B_KFV`: the item category in the selected category set.
*   `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`: cost groups and their account assignments.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations that hold each cost element's account.
*   `ORG_ORGANIZATION_DEFINITIONS`, `HR_ALL_ORGANIZATION_UNITS` and `GL_SETS_OF_BOOKS`: the organization, its operating unit and its ledger.

### Logical Relationships
1.  The quantity and cost temporary tables are joined on organization, inventory item and cost source, with the cost source limited to cost sources 1 and 2.
2.  Each quantity row is joined to `MTL_PARAMETERS`, `MTL_SECONDARY_INVENTORIES`, `MTL_SYSTEM_ITEMS_VL` and `MTL_CATEGORIES_B_KFV`.
3.  Cost group accounts are joined through `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`, using the cost group from the quantity or cost row or the organization default.
4.  An inline row generator for cost elements 1 to 6 is joined to the grouped result, and a CASE expression picks the account and value for each element.
5.  Asset subinventories take elements 1 to 5 and expense subinventories take element 6. The account is then joined to `GL_CODE_COMBINATIONS_KFV`, and the organization to its ledger.

## Parameters & Filtering
*   **Ledger, Operating Unit and Organization Code:** Define the scope of organizations and their ledger.
*   **Cost Type and As of Date:** Identify the costing basis and the date of the valuation.
*   **Costing Enabled Items Only:** Restricts items to those with costing enabled.
*   **Item From and Item To, Category Set, Category From and Category To:** Restrict items by number range or category.
*   **Subinventory From and Subinventory To:** Restrict the subinventories.
*   **Quantities By Revision:** Shows revision-level rows where the item is revision controlled.
*   **Negative Quantities Only and Include Zero Quantities:** Control whether negative or zero quantity rows are returned.
*   **Include Expense Items:** Adds expense items to the output.

## Performance & Optimization
*   **Grouped aggregation first:** Quantities and values are summed per item, subinventory, revision and cost group in one grouped pass before the cost element split.
*   **Cost element expansion after aggregation:** The six-row element generator is joined after grouping, so each item is expanded only once per element rather than at the detail level.

## FAQ
**Q: Why does an asset subinventory show five rows for each item?**
A: Asset subinventories carry value across five cost elements, so each item produces one row for each of Material, Material Overhead, Resource, Outside Processing and Overhead.
**Q: Where does the account for a subinventory come from?**
A: Under Standard costing it comes from the subinventory setup, under Average, FIFO or LIFO it comes from the organization defaults, and under cost group accounting it comes from the cost group accounts.
**Q: Can I run the report for several organizations at once?**
A: Yes. The report is designed to run across multiple inventory organizations, and the Organization Code parameter controls which ones are included.
