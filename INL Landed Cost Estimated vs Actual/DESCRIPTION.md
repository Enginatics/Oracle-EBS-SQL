# Case Study & Technical Analysis: INL Landed Cost Estimated vs Actual

## Executive Summary
The INL Landed Cost Estimated vs Actual report compares the estimated landed cost of each Landed Cost Management shipment line with its current landed cost, by cost component. The components are the item price, each charge type and each tax. The estimate is the first landed cost calculation of the shipment, and the current amount is its latest adjustment, both in functional currency. Import and cost accountants use the report to find where landed costs moved after the shipment was estimated and to match the charges to the AP invoices that paid them. It runs in Excel through Blitz Report.

## Business Challenge
*   **Estimate accuracy:** Landed costs are estimated when a shipment is created, and actual freight, duty and tax charges often differ, which changes the cost of the received goods.
*   **Charge matching:** Each charge should be matched to the AP invoice that billed it, so the team can confirm the landed cost was fully invoiced.
*   **Allocation differences:** Landed Cost Management allocates charges to shipment lines by allocation basis, so a line's amount can differ from the amount matched to its receipt line.
*   **Variance review:** Estimate changes made in the Shipment Workbench after submission must be visible as variances.

## The Solution
*   Shows the estimated and current amounts of each shipment line and component, with the difference and the variance as a percentage of the estimate.
*   Shows the estimated and current unit amounts, based on the primary quantity of the shipment line.
*   Shows the matched amount, whether a match exists, and the AP invoice numbers the matched amount came from.
*   Shows the supplier, purchase order and shipment line, the receipt number and the country of origin for each line.

## Technical Architecture (High Level)
### Primary Tables
*   `INL_SHIP_HEADERS_ALL`, `INL_SHIP_LINES_ALL` and `INL_SHIP_LINE_GROUPS`: the shipment header, its lines and the supplier group of each line.
*   `INL_ALLOCATIONS`: the allocation of each charge and tax to the shipment lines, by adjustment number.
*   `INL_CHARGE_LINES` and `INL_TAX_LINES`: the charge and tax lines that generated the allocations.
*   `INL_MATCHES`: the links between shipment lines and AP invoice distributions.
*   `AP_INVOICE_DISTRIBUTIONS_ALL` and `AP_INVOICES_ALL`: the invoice distribution and invoice that were matched.
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL`, `PO_HEADERS_ALL`, `RCV_SHIPMENT_LINES` and `RCV_SHIPMENT_HEADERS`: the purchase order and receipt of the shipment line.
*   `PON_COST_FACTORS_VL`: the names of the charge types.
*   `AP_SUPPLIERS`, `HZ_PARTIES`, `MTL_SYSTEM_ITEMS_VL`, `FND_TERRITORIES_VL` and `ORG_ACCESS_VIEW`: the supplier, party, item, country and organization access.

### Logical Relationships
1.  The estimate and current amounts are summed in an inline view from `INL_ALLOCATIONS`. The estimate is the allocation of adjustment 0, and the current amount is the allocation of the shipment's latest adjustment.
2.  Matched amounts are summed in a second inline view, which links `INL_MATCHES` to the AP invoice distributions and invoices, and excludes matches that are the parent of another match.
3.  The two inline views are joined on the shipment line, component type, charge line type and tax code, with null-safe comparisons so that item and tax components match.
4.  The shipment, lines and organization are joined to the purchase order, receipt and supplier, and to `PON_COST_FACTORS_VL` for charge names.

## Parameters & Filtering
*   **Operating Unit**, **Organization Code**, **Shipment Date From** and **Shipment Date To:** restrict the shipments reported.
*   **Shipment Number**, **Supplier** and **Item:** select one shipment, supplier or item.
*   **Component Type** and **Charge Type:** select item, charge or tax components, or one charge type.
*   **Charging Party:** selects the party that charged the component.
*   **Variances Only:** when set, keeps only components whose current amount differs from the estimate.

## Performance & Optimization
*   Allocations are read only for adjustment 0 and the shipment's current adjustment number, which avoids reading every adjustment history.
*   Matched amounts are aggregated before the join, so each shipment component joins to a single summarized row.
*   The organization restriction is applied to the shipment headers through `ORG_ACCESS_VIEW`, so the allocation scan is limited early.
*   Shipment Number, Shipment Date and Organization Code are the most selective parameters on large LCM histories.

## FAQ
**Q: Why does the Current Amount per line differ from the Matched Amount?**
A: Landed Cost Management allocates each charge to shipment lines by the allocation basis of its charge type. The Matched Amount is the amount distributed to the receipt line on the AP invoice, so the two can differ per line while the shipment totals agree.

**Q: What does a variance with no match mean?**
A: The estimate was changed in the Shipment Workbench after submission and the component has no AP invoice match yet, so the variance is shown without a matched amount.
