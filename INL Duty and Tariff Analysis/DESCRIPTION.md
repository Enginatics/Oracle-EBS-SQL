# Case Study & Technical Analysis: INL Duty and Tariff Analysis

## Executive Summary
The INL Duty and Tariff Analysis report shows duty, other charges and taxes for each landed cost shipment line, together with the tariff code, country of origin and supplier. It supports the analysis of duty rates and of the landed cost uplift on the item value, comparing the estimated and current duty amounts. Import compliance and cost accounting teams in Oracle Landed Cost Management (LCM) use it to check how duty has been allocated to receipts, to find lines with a high duty rate or uplift, and to review the tariff classification behind the duty. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Duty cost visibility:** Duty is recorded as charges on landed cost shipments, and its effect on each item's cost is not easy to see in standard reporting.
*   **Estimate versus actual:** The first duty calculation and the current allocation can differ once customs invoices are matched, and the variance needs to be explained.
*   **Tariff classification review:** Oracle has no standard HTS field, so the tariff code must be traced to the item category used for classification.

## The Solution
*   **Charge classification:** Charges are split into duty, which is selected by the Duty Charge Type parameter, and other charges, with taxes shown separately.
*   **Estimate and current amounts:** The estimated duty from the first calculation is shown beside the current duty, with the variance between them.
*   **Rate and uplift calculations:** Duty rate, duty per unit, landed cost and landed cost uplift are calculated per shipment line, with division by zero guarded.
*   **Tariff code from category set:** The tariff code is the item's category in the Tariff Code Category Set, shown with the country of origin and supplier.

## Technical Architecture (High Level)
### Primary Tables
*   `INL_SHIP_HEADERS_ALL`: the landed cost shipment header, with shipment number, date, adjustment number and organization.
*   `INL_SHIP_LINES_ALL`, `INL_SHIP_LINE_GROUPS`: the shipment lines, their item, primary quantity and supplier party group.
*   `INL_ALLOCATIONS`: the amount allocated from each charge, tax or item component to each shipment line, with the landed cost flag and the adjustment number.
*   `INL_CHARGE_LINES`: the charge lines and their charge line types.
*   `INL_MATCHES`: the matches between charges and shipment lines, used to flag matched duty.
*   `PON_COST_FACTORS_VL`: the charge type names used to label each charge line.
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL`, `PO_HEADERS_ALL`: the purchase order documents of the shipment lines.
*   `RCV_SHIPMENT_LINES`, `RCV_SHIPMENT_HEADERS`: the receipt that the shipment line was matched to, and its receipt number.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_CATEGORY_SETS_VL`, `MTL_ITEM_CATEGORIES`, `MTL_CATEGORIES_KFV`: the item and its tariff category.
*   `AP_SUPPLIERS`, `FND_TERRITORIES_VL`: the supplier and the country name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `MTL_PARAMETERS`, `ORG_ORGANIZATION_DEFINITIONS`, `GL_LEDGERS`, `ORG_ACCESS_VIEW`: operating unit, organization, ledger and security.

### Logical Relationships
1. The inner block `x` groups the allocations by shipment header, shipment line and component type (item, charge or tax), using the allocation's adjustment number.
2. Each charge component is flagged as matched when a row exists in `INL_MATCHES` for the same shipment line and charge line type.
3. The block `z` sums the item value, estimated duty, current duty, other charges and taxes per shipment line.
4. `z` joins to `INL_SHIP_HEADERS_ALL`, `INL_SHIP_LINES_ALL` and `INL_SHIP_LINE_GROUPS`, then to the organization, ledger and item tables.
5. Purchase order and receipt details are outer joined through the shipment line source type and `RCV_SHIPMENT_LINES.LCM_SHIPMENT_LINE_ID`.

## Parameters & Filtering
*   **Operating Unit, Organization Code, Shipment Date From and To:** Restrict the shipments to the operating unit, organization and shipment date range.
*   **Supplier, Item, Country of Origin:** Restrict the lines to one supplier, item or country of origin.
*   **Duty Charge Type:** Selects the charge types that are counted as duty; all other charges are reported as Other Charges.
*   **Tariff Code Category Set and Tariff Code:** Name the item category set that holds the HTS codes and filter the tariff codes.

## Performance & Optimization
*   Allocations are filtered on the landed cost flag and on adjustment numbers 0 and the current adjustment, which limits each shipment to the estimated and current calculations.
*   The matched-duty flag is a correlated subquery on `INL_MATCHES`.
*   Divisions use `nullif`, so lines with zero item value or zero quantity return null rates rather than errors.

## FAQ
**Q: Why does the duty rate on a line differ from the customs entry?**
A: LCM allocates each charge to shipment lines by the charge type's allocation basis, so the duty per line reflects that allocation rather than the customs entry line.

**Q: Where does the tariff code come from?**
A: Oracle has no standard HTS field, so the tariff code is the item's category in the Tariff Code Category Set, which must be named as a parameter.

**Q: What does Duty Variance show?**
A: It is the current duty less the estimated duty from the first calculation, so a positive value means the duty has increased since the estimate.
