# Case Study & Technical Analysis: CAC Margin Analysis Summary

## Executive Summary
The **CAC Margin Analysis Summary** report is a high-level profitability tool. Unlike its "Account Summary" counterpart, this report strips away the General Ledger complexity to focus purely on the business metrics: Quantity, Revenue, Cost, and Margin. It is designed for Sales Managers, Product Managers, and Executives.

## Business Challenge
Business leaders need quick answers to profitability questions.
*   **Customer Profitability**: Which customers are generating the most margin?
*   **Product Mix**: Are we selling high-volume/low-margin items or low-volume/high-margin items?
*   **Trend Analysis**: How is our margin trending month-over-month?

## Solution
This report provides a clean, tabular view of margin performance.
*   **Aggregated View**: Can be summarized by Customer, Item Category, or Sales Order.
*   **Metrics**: Reports Invoiced Qty, Sales Amount, COGS Amount, Margin Amount, and Margin %.
*   **Source**: Uses the official Oracle Margin table to ensure consistency with financial reports.

## Technical Architecture
*   **Source**: `cst_margin_summary`.
*   **Simplification**: Removes the joins to `gl_code_combinations` found in the "Account Summary" version, making the output cleaner for non-finance users.
*   **Categorization**: Includes Item Category sets to allow for product line analysis.

## Parameters
*   **Transaction Date From/To**: (Mandatory) Reporting period.
*   **Category Set**: (Optional) To group items by product family.
*   **Customer**: (Optional) To focus on key accounts.

## Performance
*   **Fast**: Reading from the summary table is generally faster than querying raw Order Management and AR tables.
*   **Prerequisite**: Requires the "Margin Analysis Load Run" to be up to date.

## FAQ
**Q: Does this match the P&L?**
A: It should match the *Gross Margin* line of the P&L, assuming the "Margin Analysis Load Run" was executed for the same period and all COGS/Revenue entries were captured.

**Q: Can I see the invoice number?**
A: Yes, the underlying table links to the AR Invoice, allowing for drill-down if the report layout is modified.

**Q: How are returns handled?**
A: RMAs (Returns) typically appear as negative revenue and negative cost, reducing the total margin.
