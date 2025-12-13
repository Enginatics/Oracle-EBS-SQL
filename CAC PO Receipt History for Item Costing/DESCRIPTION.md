# Case Study & Technical Analysis: CAC PO Receipt History for Item Costing

## Executive Summary
The **CAC PO Receipt History for Item Costing** report is a general-purpose purchasing analysis tool. While the "Actual Costing" version focuses on cost updates, this version focuses on the *purchasing* aspect: Supplier performance, price trends, and comparison against a fixed Standard Cost.

## Business Challenge
*   **Vendor Analysis**: "Who is selling us this part cheapest?"
*   **Inflation Tracking**: "How has the price of Steel changed over the last 6 months?"
*   **Standard Cost Validation**: "Is our Standard Cost of $10 accurate, or have we been paying $12 all year?"

## Solution
This report provides a clean list of receipts.
*   **Details**: Supplier Name, PO Number, Receipt Date, Quantity, Unit Price.
*   **Comparison**: Compares the PO Price to a selected Cost Type (e.g., "Frozen").
*   **Flexibility**: Can be run for any Costing Method (Standard, Average, etc.) as a purchasing report.

## Technical Architecture
*   **Tables**: `rcv_transactions`, `po_headers/lines`, `cst_item_costs`.
*   **Logic**: Focuses on the `RECEIVE` and `MATCH` transactions in the Receiving module.

## Parameters
*   **Comparison Cost Type**: (Optional) Defaults to the primary costing method.
*   **Category Set**: (Optional) Useful for analyzing specific commodity groups (e.g., "Electronics").

## Performance
*   **Moderate**: Joins Receiving, PO, and Costing tables. Generally performs well with date filters.

## FAQ
**Q: What is the difference between this and the "Actual Costing" report?**
A: This report does *not* show the "Prior Cost" or "New Onhand" calculation. It is simpler and focused on the receipt transaction itself vs. the cost update impact.

**Q: Does it show returns?**
A: Yes, "Return to Vendor" (RTV) transactions are typically included (often with negative quantities) to show net purchasing.
