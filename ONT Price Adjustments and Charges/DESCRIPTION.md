# Case Study & Technical Analysis: ONT Price Adjustments and Charges

## Executive Summary
ONT Price Adjustments and Charges lists the price adjustments applied to sales orders in Oracle Order Management: discounts, surcharges, price breaks, promotional goods, and freight and special charges. It returns one row for each adjustment on an order header or order line, with the modifier that created it, the adjustment amount and the extended value. Pricing analysts, order management supervisors and revenue controllers use it to review discount levels by customer or item, audit manual overrides, and reconcile charges that were billed against those that were approved.

## Business Challenge
*   **Discount Governance:** Sales management must see how much discount each order received, and from which modifier, to enforce pricing policy.
*   **Manual Overrides:** Adjustments changed by users rather than applied automatically carry a higher risk, and they must be identifiable.
*   **Charge Reconciliation:** Freight and special charges need to be checked against the order lines they belong to.
*   **Modifier Analysis:** Pricing teams need to see which price list modifiers generate the most adjustment value.

## The Solution
*   **Adjustment Level Detail:** Each adjustment is one row, with its level, type, modifier, line and operator, so the source of the price is clear.
*   **Extended Values:** The unit adjustment is multiplied by the ordered quantity to give an extended amount, and lumpsum charges are reported once per line.
*   **Sign Convention:** Discounts and credits are negative, and return lines carry the reverse sign, consistent with the Orders and Lines report.
*   **Override and Application Flags:** Automatic, overridden, applied, accrued and invoiced status are each returned as yes or no.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_PRICE_ADJUSTMENTS`: the price adjustment rows on orders, with the list line type, operand, adjusted amount and status flags.
*   `OE_ORDER_HEADERS_ALL`: the order headers, with order number, ordered date, currency and sold-to customer.
*   `OE_ORDER_LINES_ALL`: the order lines, with item, quantity, unit prices and the line category.
*   `OE_TRANSACTION_TYPES_TL`: the order type names.
*   `QP_LIST_HEADERS_VL`: the modifier list names and types.
*   `QP_PRICING_PHASES`: the pricing phase names.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit names.
*   `HZ_CUST_ACCOUNTS`: the customer accounts, with the account number.
*   `HZ_PARTIES`: the customer party names.
*   `MTL_SYSTEM_ITEMS_VL`: the items.
*   `FND_LOOKUP_VALUES_VL`: the lookup meanings of the list line types.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the user can access.
*   `DUAL`: used to add the release check to the operating unit list.

### Logical Relationships
1.  Each adjustment in `OE_PRICE_ADJUSTMENTS` is joined to its order header in `OE_ORDER_HEADERS_ALL` on the header identifier.
2.  Adjustments with a line identifier are outer joined to `OE_ORDER_LINES_ALL` on the line identifier.
3.  The header is joined to its operating unit, its order type and its customer account, and the account to its party.
4.  The line is joined to `MTL_SYSTEM_ITEMS_VL` on the inventory item and ship-from organization.
5.  The adjustment's modifier is outer joined to `QP_LIST_HEADERS_VL` on the list header identifier.
6.  Adjustment types are restricted to the list line type lookup values in `FND_LOOKUP_VALUES_VL`.

## Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit.
*   **Ordered Date From and Ordered Date To:** Limit the orders to an ordered date window.
*   **Order Number, Customer Name, Account Number, Order Type and Item:** Select orders by identifier, customer, type or product.
*   **Adjustment Type and Modifier:** Restrict the output to one list line type or one modifier.
*   **Charge Type and Change Reason:** Restrict the freight and special charges or the change reason codes.
*   **Manual or Overridden Only:** Limits the output to adjustments that were changed by a user.
*   **Applied:** Filters on whether the adjustment was applied.
*   **DFF Display:** Controls whether descriptive flexfield columns are shown.

## Performance & Optimization
*   **Operating Unit Security:** The order header is restricted through the multi-org access table, so the scan is limited to permitted operating units.
*   **Lookup Driven Adjustment Types:** The list line types come from a lookup subquery, which keeps only the adjustment types defined for the pricing setup.
*   **Outer Join to Lines:** Header-level adjustments have no line, so the line join is an outer join.
*   **Lumpsum Branch:** The extended amount expression evaluates a separate branch for lumpsum freight and header adjustments, so the calculation is decided per row.

## FAQ
**Q: Why are the Unit Adjustment and Extended Amount blank on some rows?**
A: Oracle does not store an amount for line price effects that are included in the selling price, so these fields are blank. The exception is a lumpsum order level charge, which carries an extended amount.

**Q: How do I find the manually changed discounts for one customer?**
A: Enter the customer name in the Customer Name parameter, and set Manual or Overridden Only to Yes.

**Q: Are tax lines included in this report?**
A: No. Tax records and shipping cost records are not listed.
