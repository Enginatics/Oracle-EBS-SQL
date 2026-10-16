# Case Study & Technical Analysis: INL Tariff Exposure on Open POs

## Executive Summary
This report estimates the tariff cost of goods that are on approved purchase orders but not yet received. For each open purchase order shipment enabled for Landed Cost Management, it shows the open quantity and value, the duty from the latest landed cost simulation, and a projected duty based on the historical duty rate of the same item from the same country of origin. It also applies an optional what-if tariff percentage. Procurement and trade compliance teams use it to see the duty that will land with open orders, especially when a new tariff rate is announced for one country of origin. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Unplanned duty cost:** Duty on goods still in transit is often unknown until receipt, which hides the true landed cost of open orders.
*   **Sourcing decisions:** Buyers need to compare the landed cost of suppliers in different countries of origin before placing or changing orders.
*   **Tariff changes:** A newly announced rate must be tested against the open book before it takes effect.
*   **Simulation coverage:** Some orders have a landed cost simulation and others have none, and the two must be treated consistently.

## The Solution
*   **Simulated duty first:** Where a latest landed cost simulation exists, its duty per unit is scaled to the open quantity.
*   **Historical fallback:** Where no simulation exists, the open value is multiplied by the historical duty rate of the same item, organization and country of origin.
*   **Projected duty:** The projected duty is the simulated duty if present, otherwise the historical estimate.
*   **What-if tariff:** The Additional Tariff Percent is applied to the open value, so a new rate can be tested for each country of origin.
*   **Projected landed cost:** The open value, projected duty, additional tariff and other simulated charges are summed into one landed cost figure in functional currency.

## Technical Architecture (High Level)
### Primary Tables
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_LINE_LOCATIONS_ALL`: the approved purchase order, its lines and its shipments, with open quantity, price and country of origin.
*   `INL_SIMULATIONS`: the landed cost simulation for a purchase order line, with its creation date.
*   `INL_CHARGE_LINES`: the duty and other charge lines of a simulation or shipment.
*   `INL_SHIP_HEADERS_ALL`, `INL_SHIP_LINES_ALL` and `INL_ALLOCATIONS`: the shipments and allocations that give the historical duty to item value ratio.
*   `RCV_SHIPMENT_LINES`: the receipt lines that give the country of origin of received shipments.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `MTL_CATEGORY_SETS_VL`, `MTL_ITEM_CATEGORIES` and `MTL_CATEGORIES_KFV`: the tariff code category set and its category for each item.
*   `AP_SUPPLIERS`, `FND_TERRITORIES_VL`, `MTL_PARAMETERS`, `ORG_ORGANIZATION_DEFINITIONS` and `GL_LEDGERS`: the supplier, country names, organization and currency.

### Logical Relationships
1. `PO_HEADERS_ALL` joins to `PO_LINES_ALL` on purchase order header id, and `PO_LINES_ALL` to `PO_LINE_LOCATIONS_ALL` on purchase order line id.
2. The simulated duty is an inline view on the line location id, drawn from the simulations, the simulated charges and the allocations of each shipment line.
3. The historical duty rate is an inline view on organization, item and country of origin, computed from shipments that have the same item and country and a history date from the report parameter.
4. The tariff code is the category from the selected tariff category set that is assigned to the item in the ship-to organization. Where several categories match, the query takes the maximum concatenated value.
5. The inner query is wrapped in two outer levels that compute the projected duty, the additional tariff and the projected landed cost.

## Parameters & Filtering
*   **Operating Unit and Organization Code:** restrict the purchase orders to one operating unit and ship-to organization.
*   **Supplier and PO Number:** narrow the orders to one supplier or one purchase order.
*   **Item and Country of Origin:** narrow the lines to one item or one country of origin.
*   **Duty Charge Type:** identifies the charge type treated as duty in the simulation and history.
*   **Tariff Code Category Set and Tariff Code:** select the category set holding tariff codes and one tariff code.
*   **History Date From:** sets the start date of the shipments used for the historical duty rate.
*   **Additional Tariff Percent:** the what-if rate applied to the open value.

## Performance & Optimization
*   The ship-to organization is restricted by the organization access view, so the simulation and history views only read organizations the responsibility can access.
*   Open quantity is filtered to a positive value, and only approved, enabled, non-cancelled shipments are read.

## FAQ
**Q: Which duty figure is used when a purchase order has a simulation?**
A: The simulated duty per unit from the latest simulation, scaled to the open quantity, is used as the projected duty.

**Q: How is the historical duty rate calculated?**
A: It is the duty divided by the item value of shipments with the same item, organization and country of origin, since the History Date From.
