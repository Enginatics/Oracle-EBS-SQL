# Case Study & Technical Analysis: INV Lot Upload

## Executive Summary
The INV Lot Upload creates and updates inventory lots in Oracle Inventory, following the logic of the Lot Numbers form. A row updates a lot when its organization code, item and lot number already exist, and creates it otherwise. Inventory and quality teams use the upload to load lot master data from suppliers and manufacturing, to set expiration and retest dates for shelf-life items and to correct lot status and grade. Blitz Report downloads the lots of the selected organizations, with their dates, status, attributes and on-hand quantity, so that the spreadsheet shows the current state before changes are made.

## Business Challenge
*   **Lot master data:** Lots received from suppliers or created in manufacturing need their origination, grade and dates recorded, and entering them one at a time is slow.
*   **Shelf-life control:** Expiration, expiration action and retest dates drive the usability of the stock, and a wrong date can release expired material.
*   **Lot status and grade:** Quarantine, release and grading decisions change the availability of a lot, and they must be applied across the items that use them.
*   **Global attributes:** A change to a lot in one organization must sometimes be applied to the same lot in all organizations, as the form does with the global lot attributes profile.

## The Solution
*   Downloads the lots of the selected organizations with the item, its shelf-life control, the parent lot, status, grade, origination type and all the date fields.
*   Shows the lot attributes, the descriptive flexfield values of the lot and the on-hand quantity of the lot across subinventories.
*   Creates a new lot with the item defaults for status, grade and origination, and with the current date as origination date when the column is blank.
*   Applies the expiration and retest dates only where the item is under shelf-life control, and applies a changed date or grade to the same lot in all organizations when the global lot attributes profile is Yes.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_LOT_NUMBERS`: the lot master, with its organization, item, parent lot, status, grade, origination, dates and attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the item, its shelf-life control code and its description.
*   `MTL_PARAMETERS`: the inventory organization code.
*   `MTL_MATERIAL_STATUSES_VL`: the lot status code linked to the lot's status id.
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the on-hand quantity of each lot, summed across subinventories for the download.
*   `ORG_ACCESS_VIEW`: the organizations that the responsibility can access.

### Logical Relationships
1.  `MTL_PARAMETERS` is joined to `MTL_SYSTEM_ITEMS_VL` on the organization id, and `MTL_SYSTEM_ITEMS_VL` to `MTL_LOT_NUMBERS` on the organization id and inventory item id.
2.  The lot status is a scalar lookup on `MTL_MATERIAL_STATUSES_VL` through the status id of the lot.
3.  The on-hand quantity is a correlated subquery on `MTL_ONHAND_QUANTITIES_DETAIL` matching the organization, item and lot number.
4.  Organizations are restricted by a subquery on `ORG_ACCESS_VIEW`, using the responsibility application and responsibility id of the session.
5.  The flexfield values for the lot attributes and the lot descriptive flexfield are decoded from the attribute category of each lot.

## Parameters & Filtering
*   **Upload Mode:** controls whether lots are downloaded for update, creation or both.
*   **Organization Code** and **Item:** select the organization and item whose lots are listed.
*   **Lot Number:** selects one lot.
*   **Expiration Date From** and **Expiration Date To:** bound the expiration dates of the lots.
*   **Expiring Within Days:** selects the lots that expire within the number of days entered.

## Performance & Optimization
*   The on-hand subquery is correlated on organization, item and lot, so it reads only the detail rows of each lot listed.
*   The flexfield decoding runs once per lot row, and is applied to the attribute category of each lot rather than to all lots.
*   The organization access subquery limits the lot scan to the responsibility's organizations before the item and lot joins.
*   Narrowing by Organization Code and Item is the most effective way to keep a large lot population manageable in Excel.

## FAQ
**Q: How does the upload decide whether to create or update a lot?**
A: It matches the organization code, item and lot number. If the lot exists, the row updates it; if not, the row creates it.

**Q: Why can I not change the expiration date of an item?**
A: Expiration, expiration action and retest dates can be changed only for items under shelf-life control, and the expiration date of such an item cannot be cleared.

**Q: Can Parent Lot be changed on an existing lot?**
A: No. Parent Lot can only be entered for a new lot.
