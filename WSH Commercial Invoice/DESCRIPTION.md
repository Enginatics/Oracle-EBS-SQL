# Case Study & Technical Analysis: WSH Commercial Invoice

## Executive Summary
The WSH Commercial Invoice report is a shipping commercial invoice for Oracle Shipping Execution deliveries. It lists the delivery details of each delivery, with shipped items, quantities, unit costs, extended costs, ship-from and ship-to addresses, freight and bill of lading details. It is the Blitz version of the Oracle standard Commercial Invoice (XML) concurrent program WSHRDINVXML, and its database logic is held in the WSHWSHRDINVXMLPPKG package. Export and logistics teams use it to prepare the commercial invoice that accompanies an international shipment, with the commodity classes that customs requires. It runs in Excel through Blitz Report.

## Business Challenge
*   **International shipping documents:** A cross-border shipment needs a commercial invoice that shows the goods, their values and their origin for customs clearance.
*   **Value per item:** The unit and extended cost of each shipped item must be shown in the invoice currency and in the unit of measure of the shipment.
*   **Commodity codes:** Customs classification depends on the commodity class of each item, which must appear on the invoice.
*   **Consignee and carrier details:** The invoice carries the ship-from and ship-to addresses, the contact, the carrier, the bill of lading and the freight cost of the delivery.

## The Solution
*   Lists each delivery with its ship date, currency, shipping method, gross weight, number of boxes, ports of loading and discharge, waybill and bill of lading numbers.
*   Shows the ship-from and ship-to addresses with their countries, the ship-to customer or consignee and the ship-to contact.
*   Shows, for each item, its description, commodity class, shipped quantity, unit of measure, secondary quantity, unit cost and extended cost.
*   Shows the total freight cost of the delivery and the warehouse from the organization definition of the delivery line.

## Technical Architecture (High Level)
### Primary Tables
*   `WSH_NEW_DELIVERIES`: the delivery header, with ship method, weights, ports, waybill and currency.
*   `WSH_DELIVERY_DETAILS`: the delivery lines, with items, quantities, source codes, locations and unit prices.
*   `WSH_DELIVERY_ASSIGNMENTS_V`: the assignment of each detail to its delivery.
*   `WSH_LOCATIONS`: the ship-from and ship-to locations, with their addresses and countries.
*   `WSH_CARRIER_SERVICES`, `WSH_BOLS_RD_V` and `WSH_FREIGHT_COSTS`: the ship method, bill of lading and freight costs.
*   `OE_ORDER_LINES_ALL`: the order line that is the source of a delivery line, with its selling price and component sequence.
*   `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES`, `HZ_PARTIES` and `HZ_CUST_ACCOUNT_ROLES`: the ship-to customer and contact.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_ITEM_CATEGORIES`, `MTL_CATEGORIES_KFV`, `MTL_CATEGORY_SETS_VL` and `MTL_DEFAULT_CATEGORY_SETS`: the item description and commodity class category.
*   `FND_TERRITORIES_TL`, `ORG_ORGANIZATION_DEFINITIONS` and `BOM_INVENTORY_COMPONENTS`: country names, the warehouse and the components flagged for shipping documents.

### Logical Relationships
1.  `WSH_NEW_DELIVERIES` is joined to `WSH_DELIVERY_ASSIGNMENTS_V` and then to `WSH_DELIVERY_DETAILS` on the delivery detail id.
2.  Ship-from and ship-to locations are joined to `WSH_LOCATIONS`, and their countries to `FND_TERRITORIES_TL` in the user's language.
3.  The commodity class lists the categories of the item in the WSH_COMMODITY_CODE category set, from `MTL_ITEM_CATEGORIES` and `MTL_CATEGORIES_KFV`.
4.  The unit cost comes from the order line selling price for OE lines, the agreement deliverable price for OKE lines, or another delivery line of the same source for other sources.
5.  A component is included when it is flagged for shipping documents on the bill of material.

## Parameters & Filtering
*   **Trip Stop**, **Stop Planned Depart Date (Low)** and **(High):** select deliveries by trip stop and planned departure date.
*   **Freight Carrier** and **Warehouse:** select deliveries by carrier and shipping organization.
*   **Delivery Name** and **Currency Code:** select one delivery, or the deliveries in one currency.
*   **Item Display** and **Print Customer Item:** control how the item and the customer's item number are shown.

## Performance & Optimization
*   The delivery is the driving table, so the trip stop, carrier and warehouse parameters narrow the population before the item and address lookups run.
*   Unit cost and extended cost use scalar lookups on the order line and the agreement deliverable, evaluated per detail line rather than per delivery.
*   The total freight cost is a correlated subquery on the freight cost table for each delivery, which excludes detail-level costs.
*   Filtering by Delivery Name or Trip Stop keeps the grouped output small, since the report groups every item line by delivery and category.

## FAQ
**Q: Which costs appear on the commercial invoice?**
A: Each item shows its unit cost and extended cost, derived from the order line selling price or the agreement price. The total freight cost is shown for the delivery.

**Q: How are commodity classes determined?**
A: They are the categories assigned to the item in the WSH_COMMODITY_CODE category set. Items without one show a blank commodity class.
