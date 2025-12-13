# Case Study & Technical Analysis: CAC Intercompany SO Price List vs. Item Cost Comparison

## Executive Summary
The **CAC Intercompany SO Price List vs. Item Cost Comparison** report is a high-value financial control tool used to validate the "Profit in Inventory" (PII) cost model. It performs a three-way comparison between the Internal Sales Order (ISO) price, the Source Organization's item cost, and the Destination Organization's item cost. This ensures that intercompany margins are calculated correctly and that the transfer price covers the cost of goods sold plus the intended markup.

## Business Challenge
Global organizations often move goods between entities with a markup (Profit in Inventory).
*   **Margin Integrity**: If the transfer price (Price List) is lower than the source cost, the sending entity loses money on the transfer.
*   **PII Accuracy**: The "Profit in Inventory" element in the destination cost must accurately reflect the difference between the transfer price and the source cost.
*   **Currency Fluctuations**: Comparing costs and prices across different currencies (e.g., USD to EUR) adds a layer of complexity that manual spreadsheets struggle to handle.

## Solution
This report automates the complex reconciliation of intercompany costs and prices.
*   **Currency Conversion**: Automatically converts sales prices to the same currency as the item cost using a user-specified exchange rate and date.
*   **PII Validation**: Explicitly calculates and reports the PII amount, allowing for immediate verification against the PII Cost Type.
*   **Sourcing Logic**: Uses the Assignment Set to determine the valid sourcing rules, ensuring the comparison reflects the actual supply chain flow.

## Technical Architecture
The report executes a sophisticated analysis across multiple modules:
*   **Pricing**: Retrieves data from `qp_list_headers` and `qp_list_lines`.
*   **Costing**: Queries `cst_item_costs` for both the Source and Destination organizations.
*   **Sourcing Rules**: Integrates with `mrp_sourcing_rules` and `mrp_sr_assignments` to identify the valid supply paths.
*   **GL Integration**: Uses `gl_daily_rates` to handle currency conversions dynamically.

## Parameters
*   **Price Effective Date**: (Mandatory) Date for price lookup.
*   **Currency Conversion Date/Type**: (Mandatory) Parameters to standardize the currency for comparison.
*   **PII Cost Type**: (Mandatory) The cost type holding the profit element (e.g., 'PII').
*   **Cost Type**: (Mandatory) The standard cost type (e.g., 'Frozen').
*   **Assignment Set**: (Mandatory) Defines the supply chain network to analyze.

## Performance
*   **Complex Calculation**: This is a computation-heavy report due to the need to resolve sourcing rules and perform currency conversions for every item.
*   **Strategic Use**: Best run for specific categories or operating units rather than a full database dump, especially in large environments.

## FAQ
**Q: What is PII?**
A: Profit in Inventory (PII) represents the intercompany profit included in the inventory value of the receiving organization. It must be eliminated for consolidated financial reporting.

**Q: Why do I need an Assignment Set?**
A: The Assignment Set tells the report which Source Organization supplies the Destination Organization, which is essential for picking the correct source cost for comparison.

**Q: Does it handle different currencies?**
A: Yes, the report includes mandatory parameters for Currency Conversion Date and Type to normalize all figures to a single currency.
