# Case Study & Technical Analysis: WSH Pick Confirm Upload

## Executive Summary
The WSH Pick Confirm Upload confirms released sales order pick tasks in bulk from Excel in Oracle Shipping Execution. Warehouse operators download the released-to-warehouse lines of an organization, correct the picked quantity, subinventory, locator and lot where the pick differs, enter the license plate number in WMS-enabled organizations, and upload the result. Each pick task is confirmed through the standard pick confirm API, which moves the material to the staging subinventory and sets the delivery line to Staged/Pick Confirmed. The upload can also ship confirm a delivery once its last released line has been confirmed. The report runs in Excel via Blitz Report, and serial controlled items are not supported.

## Business Challenge
*   **High pick volume:** Confirming pick tasks one at a time in the mobile or forms interface is slow when a wave or a pick list covers many lines.
*   **Pick differences:** Operators often pick a different quantity, lot, subinventory or locator from the one allocated, and each difference must be recorded accurately.
*   **Staging and LPN control:** Material must be moved to the staging subinventory and packed into license plates in WMS organizations before shipping.
*   **Shipping cut-off:** Deliveries should be ship confirmed as soon as their last line is picked, while unpicked quantities are backordered.

## The Solution
*   **Pre-filled allocations:** The download creates one row per pick allocation, and one row per allocated lot for lot controlled items, with the allocated values filled in.
*   **Overwrite where needed:** Operators overwrite the allocation where the pick differs, enter the LPN and upload.
*   **Confirm all option:** The Confirm All Downloaded Lines parameter pre-flags every row so an unchanged pick list can be uploaded as it is.
*   **Ship confirmation:** The Ship Confirm parameter ship confirms a delivery when its last released line has been confirmed, and backorders any unpicked quantity.
*   **LPN creation:** Unknown LPN names are created as new license plates in the organization.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_MATERIAL_TRANSACTIONS_TEMP`: the pending move order transactions, one per pick allocation, with subinventory, locator, quantity and staging details.
*   `MTL_TRANSACTION_LOTS_TEMP`: the lot allocations of lot controlled pick allocations.
*   `MTL_TXN_REQUEST_LINES`, `MTL_TXN_REQUEST_HEADERS`: the move order lines and headers, which carry the move order number.
*   `WSH_DELIVERY_DETAILS`: the delivery lines, with the released status and the move order line link.
*   `WSH_DELIVERY_ASSIGNMENTS`, `WSH_NEW_DELIVERIES`: the delivery assignment and the delivery.
*   `WSH_DELIVERY_LEGS`, `WSH_TRIP_STOPS`, `WSH_TRIPS`: the trip that the delivery belongs to.
*   `OE_ORDER_HEADERS_ALL`, `OE_ORDER_LINES_ALL`: the sales order and line.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL`: the customer and ship-to site.
*   `WMS_DISPATCHED_TASKS`: the dispatched WMS task and its status.
*   `WMS_LICENSE_PLATE_NUMBERS`: the license plate used for the transfer.
*   `MTL_ITEM_LOCATIONS_KFV`, `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`: the locator, item and organization.

### Logical Relationships
1. `MTL_PARAMETERS` is joined to `MTL_MATERIAL_TRANSACTIONS_TEMP` on organization, restricted to sales order transactions by transaction source type.
2. `MTL_MATERIAL_TRANSACTIONS_TEMP` is joined to `WSH_DELIVERY_DETAILS` on move order line, with the line in released status.
3. `WSH_DELIVERY_DETAILS` is joined to `OE_ORDER_LINES_ALL`, then to `OE_ORDER_HEADERS_ALL`, the customer account, the party and the ship-to site.
4. `WSH_DELIVERY_DETAILS` is outer joined to `WSH_DELIVERY_ASSIGNMENTS` and `WSH_NEW_DELIVERIES` to find the delivery.
5. The lot allocations, move order lines and WMS dispatched tasks are outer joined on the transaction temporary identifier.
6. The pick and staging locators and the transfer license plate are outer joined on their identifiers.
7. The trip name is a `listagg` over distinct trip names reached through the delivery legs and trip stops.

## Parameters & Filtering
*   **Organization Code:** Restricts the download to one organization.
*   **Order Number, Delivery, Trip, Move Order, Customer, Item:** Restrict the downloaded lines to the chosen sales order, delivery, trip, pick slip or move order, customer or item.
*   **Confirm All Downloaded Lines:** When set, every downloaded row is pre-flagged for upload.
*   **Ship Confirm:** When set, the upload ship confirms a delivery once its last released line has been confirmed.

## Performance & Optimization
*   The main extraction joins the pending move order transactions to the released delivery lines, so only released lines with allocations are read.
*   Lot, WMS task and move order lookups are outer joins on the transaction identifier, so lines without lots or tasks are kept without duplication beyond the lot rows.
*   The trip name aggregation runs as a correlated subquery over distinct delivery and trip pairs, which is evaluated per delivery row.

## FAQ
**Q: Why does one order line appear on several rows?**
A: One row is created per pick allocation, and per allocated lot for lot controlled items, so a line picked from several locations or lots appears several times.

**Q: How do I pick an unchanged pick list quickly?**
A: Set Confirm All Downloaded Lines so every row is pre-flagged, then upload the file without changes.

**Q: Are serial controlled items supported?**
A: No. The description states that serial controlled items are not supported by this upload.
