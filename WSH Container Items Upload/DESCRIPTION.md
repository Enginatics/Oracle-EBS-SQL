# Case Study & Technical Analysis: WSH Container Items Upload

## Executive Summary
The WSH Container Items Upload creates, updates and deletes container-item relationships in Oracle Shipping Execution, the data behind the Container-Item Relationships form under Container Load Details. A relationship states the maximum quantity of a load item that fits into a container item within one inventory organisation, and auto-pack uses the preferred container of each load item to plan shipments. It is written for shipping and warehouse administrators who maintain packaging standards for many items and containers, such as pallets, cartons and drums. The upload handles the preferred container flag as the form does, and it supports deletion of relationships. It sits in the Shipping area of Oracle EBS.

## Business Challenge
*   **Packaging standards at volume:** Every item that ships in a container needs a maximum load quantity per container, and a large catalogue makes manual entry impractical.
*   **Auto-pack reliability:** Auto-pack depends on the preferred container of each load item, and an incorrect preferred container produces wrong packing plans.
*   **Serial and indivisible items:** Items that are serial controlled or indivisible must have whole-number maximum quantities, so the file must be validated against item controls.
*   **Changing standards:** Packaging standards change with new containers and suppliers, and the old relationships must be updated or removed cleanly.

## The Solution
*   **One row per relationship:** Each row shows the container item, its container type, the load item, its unit of measure, the maximum quantity and the preferred flag.
*   **Preferred flag management:** Setting the preferred flag to Yes removes the flag from the load item's current preferred container, as the form does, and the message names that container.
*   **Clear conflict rule:** When several rows make different containers preferred for the same load item, the last row in the file wins.
*   **Quantity rules:** Maximum quantities are rounded to five decimals, and must be whole numbers for serial controlled and indivisible load items.
*   **Deletion and reassignment:** A relationship is deleted by entering Yes in the delete column, and changing the container or load item of a downloaded row moves that relationship.

## Technical Architecture (High Level)
### Primary Tables
*   `WSH_CONTAINER_ITEMS`: the container-item relationships, with the container item, load item, maximum load quantity, preferred flag and flexfield values.
*   `MTL_PARAMETERS`: the inventory organisations, with the master organisation used for the relationship.
*   `MTL_SYSTEM_ITEMS_VL`: the container and load item definitions, joined twice, once for each role.
*   `ORG_ACCESS_VIEW`: the organisations accessible to the current responsibility.

### Logical Relationships
1. `WSH_CONTAINER_ITEMS` joins to `MTL_PARAMETERS` on the master organisation identifier.
2. The container item joins to `MTL_SYSTEM_ITEMS_VL` on the master organisation and the container item identifier.
3. The load item joins to `MTL_SYSTEM_ITEMS_VL` on the master organisation and the load item identifier, so the two item roles are resolved separately.
4. Organisations are limited to those returned by `ORG_ACCESS_VIEW` for the current responsibility.
5. The result returns the original container and load identifiers so that a changed item can be matched back to its relationship on upload.

## Parameters & Filtering
*   **Upload Mode:** Chooses between create, update and delete operations.
*   **Organization Code:** Restricts the relationships to one inventory organisation.
*   **Container Type:** Restricts the container items to one container type, such as pallet or carton.
*   **Container Item:** Restricts the output to one container item.
*   **Load Item:** Restricts the output to one load item.
*   **Preferred Flag:** Restricts the output to relationships where the container is, or is not, the preferred container for the load item.

## Performance & Optimization
*   **Organisation filter first:** The query limits the relationships to the master organisations in the access view for the current responsibility before the item joins.
*   **Item joins by identifier:** Both item joins use the inventory item identifier and the master organisation, so each relationship resolves to one row per item role.
*   **Relationship-sized data:** The table holds packaging relationships rather than transactions, so the result is bounded by the number of items and containers configured.

## FAQ
**Q: How do I set the maximum quantity of a load item that fits in a container item in Oracle Shipping?**
A: Download the relationships for the organisation, enter the maximum quantity on the row for the container and load item, and upload the file.

**Q: What happens when I make a container preferred for a load item?**
A: The previous preferred container for that load item is unflagged, as the Container-Item Relationships form does, and the message column names the container that was changed.

**Q: How do I delete a container-item relationship?**
A: Enter Yes in the Delete Relationship column for that row and upload the file.
