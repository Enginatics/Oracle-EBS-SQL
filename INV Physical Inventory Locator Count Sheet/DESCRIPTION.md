# Case Study & Technical Analysis: INV Physical Inventory Locator Count Sheet

## Executive Summary
This report produces a locator-based count sheet for a physical inventory in Oracle Inventory. It lists every active stock locator of the subinventories that are quantity tracked, with the items, revisions, lots and license plate numbers on hand in each locator, and leaves blank columns for the counted quantity, the counter and comments. It is an alternative to printed physical inventory tags, and it is used by warehouse supervisors and inventory controllers who want their counters to walk the stores by locator. A locator without stock is listed once with a blank item, so stock found in a location the system considers empty can be recorded.

## Business Challenge
*   **Counting by location:** Counters need a sheet that follows the physical layout of the warehouse, locator by locator, rather than a list of items.
*   **Finding unexpected stock:** Stock can be present in locators that the system shows as empty, and these locations must be on the sheet.
*   **Project and task stock:** Material held in project and task logical locators must be counted against the physical locator where it sits.
*   **Blind counts:** Some organizations do not want counters to see the system quantity, because it can influence the count.

## The Solution
*   Lists each active stock locator of the quantity tracked subinventories of the chosen organization, with its subinventory, locator description and status.
*   Shows one row per item, revision, lot and license plate number on hand in the locator, with the lot expiration date, serial control indicator and primary unit of measure.
*   Shows the project and task of the stock where it is held in a project or task logical locator, against the physical locator.
*   Includes the live system quantity only when Show System Quantity is set, so the sheet can be produced as a blind count.
*   Leaves the Count Quantity, Counted By and Count Comments columns blank for the counter to complete.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_PARAMETERS`: the inventory organizations.
*   `MTL_SECONDARY_INVENTORIES`: the subinventories, with the quantity tracked flag and disable date.
*   `MTL_ITEM_LOCATIONS_KFV` and `MTL_ITEM_LOCATIONS`: the locators, with their concatenated segments, status and project and task.
*   `MTL_MATERIAL_STATUSES_VL`: the locator status.
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the on hand quantities by locator, item, revision, lot and license plate.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its primary unit of measure and serial control.
*   `MTL_LOT_NUMBERS`: the lot expiration date.
*   `WMS_LICENSE_PLATE_NUMBERS`: the license plate number.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `MTL_PARAMETERS` is joined to `MTL_SECONDARY_INVENTORIES` on organization, and restricted to subinventories that are quantity tracked and not disabled.
2. The subinventory is joined to its active locators in `MTL_ITEM_LOCATIONS_KFV`, and the locator status is outer joined.
3. The locator is joined to `MTL_ITEM_LOCATIONS` to obtain its project and task.
4. The on hand detail is outer joined to the locator, so empty locators remain on the sheet.
5. The item, lot and license plate are outer joined from the on hand detail, giving one row per on hand combination.

## Parameters & Filtering
*   **Organization Code:** selects the organization, limited to organizations the responsibility can access.
*   **Physical Inventory:** selects the physical inventory that the count sheet belongs to.
*   **Subinventory** and **Locator:** limit the count sheet to a subinventory or a locator.
*   **Show System Quantity:** when set, shows the live on hand quantity of each row. When blank, the sheet is a blind count.

## Performance & Optimization
*   The organization restriction uses `ORG_ACCESS_VIEW` for the responsibility, so only the organizations the user can access are read.
*   Locators are restricted to active subinventories and to active locators, through their disable dates, which reduces the number of rows before the on hand join.
*   The on hand detail is aggregated by locator, item, revision, lot, license plate and unit of measure, which gives one count line for each combination.
*   The sort is by organization, subinventory, locator, item, revision, lot and license plate, so the counters can follow the warehouse walk.

## FAQ
**Q: How do I produce a blind count sheet?**
A: Leave the Show System Quantity parameter blank. The sheet then shows no system quantity for the counter to compare.

**Q: What happens to stock held in a project or task locator?**
A: It is shown against its physical locator, with the project and task columns filled in.

**Q: How are the counts loaded back?**
A: The completed counts can be loaded with the INV Physical Inventory Tag Count Upload with a blank tag number, which needs a physical inventory that allows dynamic tags.
