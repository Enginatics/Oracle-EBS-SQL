# Case Study & Technical Analysis: INV Kanban Cards

## Executive Summary
The INV Kanban Cards report lists the kanban cards of production pull sequences in Oracle Inventory, one row per card. Each row shows the card number and type, the card status and supply status, the kanban size, the supplier or source of replenishment, and the replenishment cycles and last activity of the card. Materials planners and supply chain analysts use it to see which cards are waiting for supply, which cards are stalled, and how often each card has been replenished. The report runs in Excel through Blitz Report, and can optionally list the activity history of each card.

## Business Challenge
*   **Pull replenishment visibility:** Kanban cards signal when stock must be replenished, and a planner needs to know the status of every card at a glance.
*   **Stalled supply:** Cards that remain in an empty or in-process supply status show a replenishment problem that must be escalated to the supplier or production line.
*   **Replenishment history:** The number of replenishment cycles and the time since the last activity show whether a pull sequence is working as designed.
*   **Source traceability:** Each card's replenishment must be traced to the purchase order, requisition, move order or job that supplied it.

## The Solution
*   **Pull sequence base:** Production pull sequences are read with their item, subinventory, locator, source type, supplier, production line, kanban size and replenishment lead time.
*   **Card detail:** Cards are joined to their pull sequences, with their card type, status, supply status, error code, kanban size and print date.
*   **Activity summary:** The replenishment cycle count and the last activity date are derived from the card activity history.
*   **Activity detail:** When requested, each activity is listed with the document that replenished the card, which can be a purchase order, a release, a requisition, a move order or a job.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_KANBAN_PULL_SEQUENCES`: the pull sequence definitions, with source type, supplier, source organization, kanban size and lead time.
*   `MTL_KANBAN_CARDS`: the kanban cards linked to each pull sequence.
*   `MTL_KANBAN_CARD_ACTIVITY`: the activity history of each card, with the replenishing document type and ID.
*   `MTL_SYSTEM_ITEMS_VL`: the item number, description and unit of measure.
*   `MTL_ITEM_LOCATIONS_KFV`: the subinventory locator and the source locator.
*   `MTL_PARAMETERS`: the organization code and the source organization.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `WIP_LINES`: the production line of the pull sequence.
*   `PO_HEADERS_ALL`, `PO_RELEASES_ALL`, `PO_REQUISITION_HEADERS_ALL` and `MTL_TXN_REQUEST_HEADERS`: the documents that can replenish a card.
*   `WIP_ENTITIES`: the job or schedule that can replenish a card.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

### Logical Relationships
1.  `MTL_KANBAN_PULL_SEQUENCES` joins to `MTL_PARAMETERS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`, and only production sequences are kept by a condition that the kanban plan ID is -1.
2.  The pull sequence joins to `MTL_SYSTEM_ITEMS_VL` on organization and item, and to the supplier and supplier site through outer joins.
3.  Cards join to their pull sequence on the pull sequence ID, and card activity joins to the card on the card ID.
4.  Each activity's document type selects one of the document tables: 1 for purchase orders, 2 for releases, 3 for requisitions, 4 for move orders, and 5 to 8 for work in process entities.
5.  Output is ordered by organization, item, subinventory, card number and activity date descending.

## Parameters & Filtering
*   **Organization Code**, **Item** and **Subinventory:** select the organization, item and subinventory of the pull sequence.
*   **Source Type** and **Supplier:** limit the sequences by source of replenishment.
*   **Card Number**, **Card Status** and **Supply Status:** filter the cards.
*   **Pull Sequences Only:** when set, the output has one row per pull sequence and no card rows.
*   **Show Activity:** when Y, one row is added for each card activity.
*   **Activity Date From** and **Activity Date To:** bound the activity rows shown when Show Activity is used.

## Performance & Optimization
*   The card and activity subqueries are conditional on the Pull Sequences Only and Show Activity parameters, so the card tables are read only when the output needs them.
*   Replenishment cycles and the last activity date are scalar subqueries keyed on the card ID, which avoids a second grouped pass over the activity table.
*   The document lookups use a `CASE` on the document type, so each activity joins only to the table that matches its document type.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied before the pull sequence joins.

## FAQ
**Q: How do I see only the pull sequences, without the cards?**
A: Set the Pull Sequences Only parameter, which returns one row per pull sequence.

**Q: How is the number of replenishment cycles calculated?**
A: It is the count of distinct replenishment cycle IDs in the card activity history for each card.

**Q: Which documents are shown for a card activity?**
A: The purchase order, release, requisition, move order or work in process job that the activity references, depending on its document type.
