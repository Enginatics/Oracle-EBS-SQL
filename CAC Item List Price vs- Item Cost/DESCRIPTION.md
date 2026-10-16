# Case Study & Technical Analysis: CAC Item List Price vs. Item Cost

## Executive Summary
The **CAC Item List Price vs. Item Cost** report is a margin analysis tool that compares the official List Price (from the Item Master) against the Item Cost (Standard or Average). It also brings in the "Last PO Price" to provide a market-based reference point. This report is essential for ensuring that pricing strategies are aligned with current cost realities.

## Business Challenge
Maintaining healthy margins requires constant vigilance.
*   **Price Drift**: List prices often remain static while costs fluctuate.
*   **Currency Complexity**: A global price list in USD needs to be compared against manufacturing costs in EUR, JPY, etc.
*   **Market Reality**: The Standard Cost might be outdated; comparing against the "Last PO Price" gives a better indication of the current replacement cost.

## Solution
This report provides a multi-dimensional view of value.
*   **Currency Normalization**: Converts all figures (List Price, Cost, PO Price) to a single "To Currency" for accurate comparison.
*   **Triple Comparison**:
    1.  List Price vs. Cost Type 1 (e.g., Frozen)
    2.  List Price vs. Cost Type 2 (e.g., Pending)
    3.  List Price vs. Last PO Price
*   **Margin Calculation**: Automatically calculates the margin percentage for each comparison.

## Technical Architecture
The report integrates data from three distinct modules:
*   **Inventory**: `mtl_system_items` for List Price.
*   **Costing**: `cst_item_costs` for the internal cost.
*   **Purchasing**: `po_lines_all` (and related tables) to find the most recent Purchase Order for the item.
*   **GL**: `gl_daily_rates` for currency conversion.

## Parameters
*   **Cost Type 1**: (Mandatory) Primary cost for comparison.
*   **Cost Type 2**: (Optional) Secondary cost (e.g., Simulation).
*   **To Currency Code**: (Mandatory) The target currency for reporting.
*   **Currency Conversion Date**: (Mandatory) The date to use for exchange rates.

## Performance
*   **PO Lookup**: Finding the "Last PO" for every item can be resource-intensive. The report uses optimized logic to find the latest approved PO line.
*   **Currency**: Requires a valid exchange rate for the specified date; otherwise, conversion may fail or return null.

## FAQ
**Q: Which List Price does it use?**
A: It uses the `list_price_per_unit` field from the Master Item table (`mtl_system_items`). It does not look at Advanced Pricing modifiers.

**Q: Why is the Last PO Price blank?**
A: If the item has never been purchased (e.g., it's a Make item or a new item), there will be no PO history.

**Q: Does it include tax?**
A: Generally, Oracle PO prices and Item Costs exclude recoverable taxes (VAT/GST).
