# Case Study & Technical Analysis: CAC Margin Analysis Account Summary

## Executive Summary
The **CAC Margin Analysis Account Summary** report bridges the gap between Sales Operations and Financial Accounting. It reports the Gross Margin (Revenue - COGS) for customer shipments, while explicitly listing the General Ledger accounts used for both sides of the transaction. This is essential for reconciling the "Managerial" margin to the "Financial" margin.

## Business Challenge
*   **Reconciliation**: The Sales team reports $1M in margin, but the GL shows $900k. Why? Often, specific transactions posted to unexpected accounts (e.g., a "Warranty" account instead of "COGS").
*   **Audit**: Auditors need to verify that the COGS account used matches the product type sold.
*   **Granularity**: Standard GL reports show balances; they don't show which Customer or Sales Order drove the balance.

## Solution
This report leverages the `CST_MARGIN_SUMMARY` table (populated by a concurrent request).
*   **Transaction Detail**: Lists Sales Order, Line, Item, and Customer.
*   **Account Visibility**: Shows the `Sales Account` and `COGS Account` segments.
*   **Profitability**: Calculates Margin Amount and Margin %.

## Technical Architecture
*   **Prerequisite**: The "Margin Analysis Load Run" program must be run first to populate the data.
*   **Tables**: `cst_margin_summary`, `gl_code_combinations`, `mtl_system_items`.
*   **Join**: Links the margin record to the GL code combinations to resolve the account numbers.

## Parameters
*   **Transaction Date From/To**: (Mandatory) The date range.
*   **Customer Name**: (Optional) Filter for specific account analysis.
*   **Organization**: (Optional) Inventory Org.

## Performance
*   **Dependent**: Performance depends on the `CST_MARGIN_SUMMARY` table size. If the Load Run hasn't been purged recently, this table can be huge.
*   **Indexed**: Efficiently filters by Date and Org.

## FAQ
**Q: Why is the report empty?**
A: You likely haven't run the "Margin Analysis Load Run" program for the requested period. This report reads a snapshot table, not raw transactions.

**Q: Why do I see multiple lines for one order line?**
A: If a single sales order line was shipped in multiple partial shipments, or if the COGS account was split (e.g., across cost centers), you will see multiple rows.

**Q: Does it include freight?**
A: Only if the freight is invoiced as a line item or included in the COGS calculation.
