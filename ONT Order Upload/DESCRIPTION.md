# Case Study & Technical Analysis: ONT Order Upload

## Executive Summary
This upload creates, updates, books and cancels sales orders in Oracle Order Management, and adds lines to existing orders or splits lines into shipments. Order entry and order management teams use it to load and maintain large volumes of orders in one spreadsheet. It runs in Excel through Blitz Report™, and the download shows the existing orders that the upload will change.

## Business Challenge
*   **High-volume order entry:** Orders keyed one by one in the Sales Orders window are slow, and errors in customer, item or pricing data are costly to correct after booking.
*   **Maintaining open orders:** Changes to lines, quantities, dates and shipping details must be made in the right sequence and with the reason and comments that Oracle requires for a booked line.
*   **Splitting shipments:** A line sometimes has to ship in parts, each with its own request date, warehouse or ship-to address.
*   **Controlled booking:** Orders must be booked or cancelled in batch with a clear record of changes.

## The Solution
*   Downloads existing orders, one row per header or line, with customer, order type, price list, salesperson, shipping, tax and flexfield values.
*   Each row can create, update, book or cancel an order, or add a line, using the Order Action column.
*   Splits a line by entering a new row for the order with the line to split in Split From Line and the new shipment's quantity in Ordered Quantity.
*   Keeps the new shipment's other values equal to the original line, so that only Request Date, Warehouse and Ship To can differ, as in the Split Line window.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the order headers and lines, with status, quantities, dates, pricing and flexfield columns.
*   `OE_TRANSACTION_TYPES_TL`: the order type and line type names.
*   `OE_ORDER_SOURCES`: the order source of each order.
*   `OE_PRICE_ADJUSTMENTS`: the applied discount or surcharge of each line.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES` and `HZ_CUST_SITE_USES_ALL`: the customer, contact and ship-to and bill-to site locations.
*   `OE_CONTACTS_V`, `HZ_CUST_ACCOUNT_ROLES`, `HZ_RELATIONSHIPS` and `HZ_ORG_CONTACTS`: the customer contact and contact number.
*   `RA_TERMS_VL`, `OE_SHIP_METHODS_V` and `OE_AGREEMENTS_VL`: payment terms, shipping methods and agreements.
*   `QP_SECU_LIST_HEADERS_V` and `QP_LIST_HEADERS_VL`: the price lists and the discount modifiers.
*   `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_TL`: the salesperson of the header and line.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_PARAMETERS`: the item and the warehouse.
*   `PA_PROJECTS_ALL`, `PA_TASKS`, `PO_REQUISITION_HEADERS_ALL`, `ASO_QUOTE_HEADERS_ALL` and `CS_INCIDENTS_ALL_B`: the project, task and source document references.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit.

### Logical Relationships
1.  Each order header is joined to its operating unit, its customer account and party, and its order type and source.
2.  Each header is outer-joined to its lines, and each line to its line type, its item in the warehouse, and its ship-from organization.
3.  Header and line flexfield and third-party attribute contexts are displayed by their contexts and segment values.
4.  The line discount is the applied discount or surcharge adjustment, with its modifier, operator and value.
5.  Source references are resolved by source document type.
6.  Who-columns are converted to user names and client times, and header and line identifiers are kept as keys.

## Parameters & Filtering
*   **Upload Mode** and **Order Action:** set whether the file creates, updates, books or cancels orders.
*   **Operating Unit**, **Order Number**, **Customer PO**, **Customer Name** and **Account Number:** select the orders to download.
*   **Order Type**, **Line Type**, **Order Status** and **Line Status:** restrict orders and lines by their type and status.
*   **Item**, **Item Type**, **Ship From Warehouse** and **Schedule Ship Date From** and **To:** restrict lines by product and shipping.
*   **Request Date From** and **To**, **Creation Date From** and **To**, **Cancelled Date From** and **To:** restrict orders and lines by date.

## Performance & Optimization
*   Every header and line join is an outer join on an identifier, so the cost is one keyed lookup per row for each reference.
*   Discount, price list, salesperson and address values are scalar subqueries, and discount lookups stop at the first match.
*   Because the lookups are evaluated per row, the header selection by operating unit and order number is the main lever on run time.

## FAQ
**Q: How do I split an order line into two shipments in this upload?**
A: Add a row for the order with the line to split in Split From Line, and enter the new shipment's quantity in Ordered Quantity; the original line is reduced by that quantity unless its own row sets its new quantity.

**Q: Which values can differ on a split shipment?**
A: Only Request Date, Warehouse and Ship To can differ; all other values are copied from the original line, as in the Split Line window.

**Q: Why does a booked line need a change reason?**
A: Oracle requires a reason and comments to modify a booked line, so the upload carries Line Change Reason and Line Change Comments.
