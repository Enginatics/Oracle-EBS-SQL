# Case Study & Technical Analysis: INV Serial Numbers

## Executive Summary
This report lists every serial number in Oracle Inventory, in any status, with one row per serial. For each serial it shows the current organization, subinventory and locator, the material status, the last transaction source and type, the customer of a serial issued on a sales order, and the genealogy parent. Inventory controllers and service teams use it to locate a specific unit, to confirm which customer holds a serial, or to check the status of serialized stock across the organizations they can access. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Locating serialized stock:** Serialized items must be traced to the organization, subinventory and locator where each unit sits.
*   **Customer serial visibility:** Warranty and service claims need the customer that a serial was shipped to, which is held on the sales order rather than on the serial.
*   **Genealogy questions:** Assemblies built from serialized components need the parent serial to be traced.
*   **Status checks:** Units can be defined, in stores, issued, in transit, in receiving or in WIP, and each state needs a different follow up.

## The Solution
*   **Current location:** The current organization, subinventory, locator and license plate are returned for each serial.
*   **Last transaction:** The last source type, source document, transaction type and date show how the serial last moved.
*   **Customer of issued serials:** For a serial issued on a sales order, the sold-to customer and account number are returned, and they are blank when the order no longer exists.
*   **Genealogy parent:** The parent item and parent serial number are returned through the genealogy relationship.
*   **Source document reference:** The source document is chosen by source type, whether a sales order, job, purchase order, requisition or move request.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_SERIAL_NUMBERS`: the serial record, with status, current organization, subinventory, locator and last transaction.
*   `MTL_PARAMETERS` and `MTL_SYSTEM_ITEMS_VL`: the organization and the serialized item.
*   `MTL_OBJECT_GENEALOGY`: the parent object of each serial.
*   `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_TYPES`: the last transaction and its type.
*   `MTL_TXN_SOURCE_TYPES`: the name of the last source type.
*   `MTL_SALES_ORDERS`, `OE_ORDER_HEADERS_ALL` and `OE_TRANSACTION_TYPES_TL`: the sales order, its order header and the transaction type name used to match the order.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the sold-to customer.
*   `WIP_ENTITIES`, `PO_HEADERS_ALL`, `PO_REQUISITION_HEADERS_ALL` and `MTL_TXN_REQUEST_HEADERS`: the source documents of the last transaction.
*   `MTL_ITEM_LOCATIONS_KFV`, `MTL_MATERIAL_STATUSES_VL` and `WMS_LICENSE_PLATE_NUMBERS`: the locator, material status and license plate.
*   `AP_SUPPLIERS`: the original supplier of the serial.

### Logical Relationships
1. `MTL_PARAMETERS` restricts the organizations to those the responsibility can access, and `MTL_SERIAL_NUMBERS` joins on the current organization.
2. The parent serial is found by a subquery on `MTL_OBJECT_GENEALOGY` for the serial's generation object, with an active parent of object type 2.
3. The order header is matched to the sales order by order number, and the customer is reached through the sold-to customer id.
4. The last source document is selected by a CASE on the last transaction source type, so each source type joins only to its own table.
5. The last transaction joins to `MTL_MATERIAL_TRANSACTIONS` and then to `MTL_TRANSACTION_TYPES`, as outer joins.

## Parameters & Filtering
*   **Organization Code:** restricts the serials to one organization.
*   **Item and Serial Number like:** select one item or a serial number pattern.
*   **Current Status:** restricts the serials to one status such as defined, in stores or issued.
*   **Subinventory and Lot Number:** narrow the serials to a subinventory or a lot.
*   **Last Source Type:** restricts the serials to those last moved from one source type.
*   **Sales Order and Customer:** restrict the serials to one sales order or customer.
*   **Ship Date From / Ship Date To:** bound the serials by ship date.
*   **DFF Display:** controls whether the serial flexfield columns are shown.

## Performance & Optimization
*   The organization filter is applied in the inner query on `MTL_SERIAL_NUMBERS`, which limits the main scan to accessible organizations.
*   The order-header match is a scalar subquery restricted to sales order sources, so it is evaluated only for serials last moved by a sales order.
*   The source document joins are CASE-based outer joins, so each source type reads only its own table.

## FAQ
**Q: Why is the customer blank for a serial that was shipped?**
A: The customer comes from the sold-to customer of the sales order of the last transaction. It is blank when the order no longer exists or the serial was not last issued on an order.

**Q: Why is the last transaction date blank?**
A: Oracle did not record the last transaction on the serial. For the full transaction history of a serial, use INV Transaction Register (Serial Number Detail).
