# Case Study & Technical Analysis: INV Item Subinventory Upload

## Executive Summary
The INV Item Subinventory Upload is a Blitz Report upload for the item-to-subinventory assignments in Oracle Inventory. It creates, updates and deletes the assignment of an item to a storage subinventory, together with the optional tie of that item-subinventory to a stock locator. Inventory and supply chain planners use it to maintain min-max planning parameters, lot sizing, lead times, sourcing and PAR levels for many items at once, across all accessible inventory organizations. Rows are applied through the same rules as the Item Subinventories form, so the validations of the form apply to each change. The workflow runs in Excel through Blitz Report.

## Business Challenge
*   **Bulk setup of item subinventories:** Each item must be assigned to the storage subinventories where it is stocked, and the planning values of each assignment must be set consistently, which is slow to do form by form.
*   **Min-max replenishment:** Planners need Min-Max planning enabled, with minimum and maximum quantities, on the right subinventories, and the change must be reviewable before it is loaded.
*   **Locator control:** Stock locators must be tied to the item-subinventory so that picking and put-away can target a physical location.
*   **Sourcing and lead times:** Source type, source organization, source subinventory and processing lead times determine replenishment, and they must be maintained together.

## The Solution
*   **Keyed rows:** Each row is one organization, item, subinventory and optional locator combination. Existing rows are downloaded with their current values, and the upload processes only the cells that have changed.
*   **Header once per triple:** When several rows share the same organization, item and subinventory, the header is processed on the first row only, and the following rows contribute only their locator tie.
*   **Locator handling:** A blank Locator column processes only the header. A populated Locator column processes the header, if not already processed in the run, and the locator tie.
*   **Controlled deletion:** A Delete Option chooses between deleting the whole item-subinventory assignment, which cascades to its locator ties, and deleting only the locator assignment.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_ITEM_SUB_INVENTORIES`: the item-subinventory assignment, with its min-max quantities, lot sizing, lead times, source fields and flexfield attributes.
*   `MTL_SECONDARY_INVENTORIES`: the subinventory master, supplying its description and the storage subinventory filter.
*   `MTL_SECONDARY_LOCATORS`: the locator ties of the subinventory, with the PAR level (maximum quantity) of each locator.
*   `MTL_ITEM_LOCATIONS_KFV`: the stock locator concatenated name and description.
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the on-hand quantity of the item in the subinventory, shown for reference.
*   `MTL_SYSTEM_ITEMS_VL`: the item number, description and primary unit of measure.
*   `MTL_PARAMETERS`: the organization code of the item and of the source organization.
*   `ORG_ACCESS_VIEW`: the inventory organizations available to the current responsibility.

### Logical Relationships
1.  `MTL_ITEM_SUB_INVENTORIES` joins to `MTL_PARAMETERS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  The assignment joins to `MTL_SYSTEM_ITEMS_VL` on the item and organization, and to `MTL_SECONDARY_INVENTORIES` on the organization and subinventory name.
3.  The source organization is an outer join to `MTL_PARAMETERS`, so assignments without a source organization are kept.
4.  Locator ties come from `MTL_SECONDARY_LOCATORS` on the item, organization and subinventory, and their names come from `MTL_ITEM_LOCATIONS_KFV`. These are included only when Download Locators is Y.
5.  The on-hand value is a correlated sum over `MTL_ONHAND_QUANTITIES_DETAIL` for the same item and subinventory.

## Parameters & Filtering
*   **Upload Mode:** sets the download or upload action.
*   **Organization Code:** selects the inventory organization.
*   **Subinventory:** limits the rows to one subinventory.
*   **Item:** limits the rows to one item.
*   **Download Locators:** when Y, the locator ties of each assignment are included, and when blank they are suppressed to avoid duplicate header rows.
*   **Min-Max Planned Only:** limits the output to assignments with Min-Max planning enabled, which is the planning code 2 in the item-subinventory record.

## Performance & Optimization
*   The locator join is conditional on the Download Locators parameter, so the locator tables are read only when they are needed.
*   The on-hand quantity is a scalar subquery keyed on organization, item and subinventory, so it returns one value per assignment.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, which limits the rows that reach the item and subinventory joins.
*   Outer joins to the source organization and locator tables keep assignments that have no source or locator, so the upload file is complete.

## FAQ
**Q: Why does a row sometimes show no changes to header cells?**
A: When several rows share an organization, item and subinventory, header cells on the second and later rows are ignored, so only the locator cells on those rows are processed.

**Q: How do I change an organization, item, subinventory or locator on an existing row?**
A: Those key columns are read-only on existing rows. Delete the row and create a new one with the new key values.

**Q: Which subinventories can be assigned?**
A: The description states that only storage subinventories can hold item assignments, so receiving subinventories are not selectable.
