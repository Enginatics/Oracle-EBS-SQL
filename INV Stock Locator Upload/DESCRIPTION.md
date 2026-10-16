# Case Study & Technical Analysis: INV Stock Locator Upload

## Executive Summary
INV Stock Locator Upload creates, updates and deletes stock locators in Oracle Inventory, the physical positions inside a subinventory where material is stored. It is used by warehouse managers, inventory administrators and implementation teams who need to set up rack, bin and aisle structures in bulk, change locator attributes such as picking order and capacity, or retire locators that are no longer used. The upload downloads existing locators with their segments, descriptions and physical attributes, and writes changes back through the standard locator setup.

## Business Challenge
*   **Warehouse Layout Setup:** A new warehouse may need hundreds of locators defined across subinventories, which is slow to enter one at a time.
*   **Picking Efficiency:** Picking and dropping orders decide the travel path of warehouse staff, and they must be maintained for every locator.
*   **Capacity Data:** Maximum units, volume and weight limits per locator are needed for put-away rules and must be kept current.
*   **Status Control:** Locators that are disabled or no longer needed must be ended without losing their history.

## The Solution
*   **Segment Expansion:** The concatenated locator and each of its segments are shown in separate columns, so the locator structure is readable in Excel.
*   **Physical Attributes:** Maximum units, volume, weight, pick unit of measure and dimensions are provided as columns, with their units.
*   **Status and Type:** Locator type and status are returned as text, so they can be set in the template.
*   **Delete Option:** A delete column removes a locator when set to Yes.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_ITEM_LOCATIONS_KFV`: the stock locators with their subinventory, segments, physical attributes, picking and dropping order, and the descriptive flexfield values.
*   `MTL_PARAMETERS`: the organization that owns each locator.
*   `MTL_MATERIAL_STATUSES_VL`: the material status names that the locator status identifier refers to.
*   `ORG_ACCESS_VIEW`: the organizations available to the current responsibility.

### Logical Relationships
1.  Each locator in `MTL_ITEM_LOCATIONS_KFV` is joined to its organization in `MTL_PARAMETERS` on the organization identifier.
2.  The organization is restricted to those returned by `ORG_ACCESS_VIEW` for the current responsibility.
3.  The locator status identifier is outer joined to `MTL_MATERIAL_STATUSES_VL`, so the status name is returned.
4.  The concatenated locator and each segment, up to twenty, are produced by the flexfield expansion function, with the number of segments limiting how many segment columns are populated.
5.  The locator type code is converted to its meaning through the Blitz Report™ meaning function.

## Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing locators are downloaded.
*   **Organization Code:** Restricts the locators to one organization.
*   **Subinventory:** Restricts the locators to one subinventory.
*   **Locator and Locator From and Locator To:** Match one locator or a range of locator values.
*   **Locator Type:** Restricts the output to one locator type.
*   **Status:** Restricts the output to locators with one material status.

## Performance & Optimization
*   **Organization Filter Before Locators:** The organization access check limits the locator scan to permitted organizations before the flexfield functions are evaluated.
*   **Segment Count Guard:** Each segment column is populated only when the segment count is at least its position, so unused segment columns return blank values.
*   **Status Outer Join:** The status is an outer join, so locators without a status still appear in the output.
*   **Flexfield Function Cost:** Concatenated and segment values are computed by the flexfield function on each row, so the extract cost grows with the number of locators returned.

## FAQ
**Q: How do I enter a locator whose segment contains the delimiter character?**
A: Precede each delimiter character and each backslash in the segment value with a backslash. The description gives an example with a period as the delimiter.

**Q: Can I end a locator without losing its record?**
A: Use the disable date column to end the locator, rather than deleting it, so the record remains for history.

**Q: How do I see the capacity of each locator?**
A: The maximum units, maximum volume and maximum weight columns return the capacity values held on each locator, with their units of measure.
