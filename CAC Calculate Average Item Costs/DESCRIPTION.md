# Case Study & Technical Analysis: CAC Calculate Average Item Costs

## Executive Summary
The **CAC Calculate Average Item Costs** report is a sophisticated analytical tool for Cost Accountants and Procurement Managers. It calculates the "true" average cost of items based on actual Purchase Order (PO) receipts over a specified period and compares these calculated values against a standard cost type (e.g., Frozen or Pending). This analysis is crucial for validating standard costs during periodic updates, ensuring that the system's cost definitions align with current market prices paid to suppliers.

## Business Challenge
Setting standard costs is often a complex exercise involving estimation and historical analysis. Organizations face challenges such as:
*   **Cost Variance:** Significant Purchase Price Variances (PPV) occurring because standard costs are outdated compared to actual procurement costs.
*   **Inflationary Pressure:** Difficulty in quantifying the impact of rising supplier prices on inventory valuation.
*   **Overhead Allocation:** Complexity in determining the correct material overheads to apply to new standard costs.
*   **Data Volume:** The inability to manually calculate weighted average costs across thousands of items and receipts.

## The Solution
The **CAC Calculate Average Item Costs** report automates the derivation of average costs. It enables users to:
*   **Validate Standards:** Compare the calculated average purchase price against the current standard cost to identify items requiring revaluation.
*   **Simulate Overheads:** Choose between using existing standard overheads or applying default overhead setups to simulate the total cost impact.
*   **Exclude Outliers:** Filter out specific supplier types or inactive items to ensure the calculated average reflects "normal" business operations.
*   **Analyze Trends:** View the last AP invoice and PO price alongside the average to spot recent pricing trends.

## Technical Architecture (High Level)
The report performs a complex aggregation of purchasing and inventory data.
*   **Data Source:** It queries `RCV_TRANSACTIONS` and `MTL_MATERIAL_TRANSACTIONS` to identify receipts and their actual transaction values.
*   **Calculation Engine:** It calculates a weighted average cost: $\frac{\sum (Quantity \times Unit Price)}{\sum Quantity}$.
*   **Cost Comparison:** It joins with `CST_ITEM_COSTS` to retrieve the comparison cost (e.g., Frozen) and calculates the variance (absolute and percentage).
*   **Overhead Logic:** The query includes conditional logic (`DECODE`) to apply material overhead rates either from the existing cost type or from the default category-based setups (`CST_DEFAULT_COST_ELEMENT_RATES`), depending on the user's parameter selection.

## Parameters & Filtering
The report offers extensive parameters for precise analysis:
*   **Transaction Date Range:** Defines the historical period for the average cost calculation (e.g., last 6 months).
*   **Comparison Cost Type:** The benchmark cost type (e.g., "Frozen" or "Pending").
*   **Use Default Material Overheads:** A toggle ('Y'/'N') to determine if overheads should be recalculated based on current default rules.
*   **Exclude Rolled Up Items:** Prevents double-counting of costs for sub-assemblies if the intention is to roll up costs later.
*   **Show Last AP Invoice:** Optionally retrieves the most recent invoice details for a "sanity check" against the average.

## Performance & Optimization
The report handles large data volumes through:
*   **Pre-Aggregation:** It aggregates receipt data by item and organization before joining to the master data, reducing the row count for subsequent joins.
*   **Indexed Lookups:** Utilizes standard indexes on transaction dates and item IDs.
*   **Efficient Currency Conversion:** Applies currency conversion rates at the transaction level (if needed) or uses the standard rate defined in the parameters.

## FAQ
**Q: How is the "Average Material Cost" calculated?**
A: It is the total value of PO receipts divided by the total quantity received during the specified date range.

**Q: What happens if there are no receipts for an item?**
A: The item will not appear in the report unless it exists in the comparison cost type, depending on the join type. Typically, this report focuses on items with activity.

**Q: Why can I exclude specific supplier types?**
A: You might want to exclude inter-company transfers or one-time spot buys from the average cost calculation to get a more representative market price.

**Q: Does this update the system costs?**
A: No, this is a reporting tool only. It provides the data needed to make decisions about updating costs, but it does not perform the update itself.
