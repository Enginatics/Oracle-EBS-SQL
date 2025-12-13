# Case Study & Technical Analysis: CAC Onhand Lot Value (Real-Time)

## Executive Summary
The **CAC Onhand Lot Value (Real-Time)** report provides a valuation of current inventory at the *Lot Number* level. While standard reports typically value inventory at the Item level (Average or Standard cost), this report is essential for industries where value or cost is tracked by specific batches (Lots).

## Business Challenge
*   **Lot-Specific Costing**: In some industries (Pharma, Food), specific lots might have different costs (FIFO/LIFO layers).
*   **Expiry Analysis**: High-value lots that are about to expire need to be identified and sold.
*   **Audit**: Auditors often select specific lots on the floor and ask for their specific book value.

## Solution
This report combines stock levels with cost.
*   **Granularity**: Item + Subinventory + Locator + Lot Number.
*   **Valuation**: Multiplies the On-hand Quantity of the lot by the Item Cost.
*   **Real-Time**: Queries the live `mtl_onhand_quantities_detail` table, not a snapshot.

## Technical Architecture
*   **Tables**: `mtl_onhand_quantities_detail` (MOQD), `cst_item_costs` (or `cst_quantity_layers` for FIFO/LIFO).
*   **Logic**: Sums quantity by Lot and joins to the cost table.
*   **Note**: If using Standard Costing, all lots of an item have the same unit cost. The value is simply Qty * Standard.

## Parameters
*   **Cost Type**: (Optional) Defaults to the Org's costing method.
*   **Include Expense Subinventories**: (Optional) Toggle to include non-asset locations.

## Performance
*   **Heavy**: MOQD can have millions of rows. Aggregating real-time on-hand balances can be slow during peak hours.

## FAQ
**Q: Does this show "Reserved" quantity?**
A: The report typically shows "Total Onhand". It may or may not split out "Available to Reserve" depending on the specific SQL logic (standard MOQD queries show total physical stock).

**Q: Can I see the Expiration Date?**
A: Yes, Lot attributes like Expiration Date are usually included from `mtl_lot_numbers`.
