# Case Study & Technical Analysis: OPM Batch Lot Genealogy

## Executive Summary
This report shows lot genealogy in Oracle Process Manufacturing (OPM) as a multi-level tree. It reproduces the Source and Where Used views of the Oracle Genealogy form: the Source tree walks from a lot through the batch that produced it to the ingredient lots, to any depth, and the Where Used tree walks from a lot through the batches that consumed it to the product lots. It is used by quality, recall and traceability teams in process industries, who must answer which raw material lots went into a finished lot, and which finished lots contain a given ingredient lot. Each row is a lot or batch with its level in the tree, its status and grade, its dates and the transaction that created the link.

## Business Challenge
*   **Traceability for recalls:** When an ingredient lot is found to be defective, every batch and finished lot that used it must be identified quickly.
*   **Origin of a lot:** The supplier, purchase order and supplier site of the lot must be known to contain a supplier issue.
*   **Multi-level chains:** A finished lot can be made from intermediate lots that were themselves made from other lots, so the chain must be followed through several levels.

## The Solution
*   Builds the genealogy tree from the `MTL_OBJECT_GENEALOGY` links, starting at the lot and walking up or down the chain to any depth, with the start lot at level 0.
*   Shows, for each lot or batch, its level, object type, lot status, grade, origination date and expiration date.
*   Shows the source of each lot, its trading partner and, for purchase order receipts, the supplier site, from the first transaction of the lot.
*   Shows the genealogy type and the transaction type, transaction date, quantity and unit of measure of the transaction that created the link.
*   Without an item or lot number, starts a tree only at lots that have no other lot above them in the chosen direction, so each chain is listed once.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_OBJECT_GENEALOGY`: the parent and child links between objects, with the genealogy type, origin transaction and end date.
*   `MTL_LOT_NUMBERS`: the lots, with the generic object identifier, status, grade, origination and expiration dates.
*   `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_LOT_NUMBERS`: the transactions that created the lot links, and the lot of each transaction.
*   `MTL_TRANSACTION_TYPES`: the transaction type name.
*   `WIP_ENTITIES` and `GME_BATCH_HEADER`: the batch identifier, batch number and WIP entity of a batch.
*   `MTL_SERIAL_NUMBERS`: serial numbers that are genealogy objects.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_PARAMETERS`: the item and organization.
*   `MTL_MATERIAL_STATUSES_VL`: the lot status.
*   `PO_HEADERS_ALL` and `AP_SUPPLIER_SITES_ALL`: the purchase order and the supplier site of a receipt.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. Active links are those whose end date is empty or in the future, so ended genealogy links are excluded.
2. A hierarchical CONNECT BY over the links walks the tree from the start objects, and the level and root are recorded.
3. The start objects are the lots that have no link above them in the chosen direction, or the lot named by the Item and Lot Number parameters.
4. Each object is joined to its lot, batch and serial number, and to its origin transaction through the lowest transaction identifier of the lot.
5. The tree is ordered by organization, item, starting lot, and the row number of the walk.

## Parameters & Filtering
*   **Organization Code:** selects the organization of the starting lot.
*   **Item:** selects the item of the starting lot, and restricts the trees to that item.
*   **Lot Number like:** selects starting lots by a lot number pattern.
*   **Direction:** chooses Source, which walks towards the ingredients, or Where Used, which walks towards the products.

## Performance & Optimization
*   Without an item or lot number, only the top lots of each chain start a tree, so a chain is not repeated for every lot inside it.
*   The origin transaction is found by a minimum-identifier subquery on each lot, which gives one origination transaction per lot.
*   The supplier site is looked up only for transactions whose source is a purchase order, so the purchase order tables are read only for receipts.

## FAQ
**Q: How do I find all lots that went into a finished lot?**
A: Enter the Item or Lot Number of the finished lot, and choose Source as the direction. The tree lists each ingredient lot and batch at its level.

**Q: How do I find all finished lots that contain an ingredient lot?**
A: Enter the ingredient lot number and choose Where Used. The tree lists the consuming batches and the product lots below them.

