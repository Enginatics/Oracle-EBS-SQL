# Case Study & Technical Analysis: CAC Intercompany SO Price List

## Executive Summary
The **CAC Intercompany SO Price List** report is a specialized pricing audit tool designed for organizations managing complex intercompany supply chains. It provides a detailed view of the price lists associated with intercompany transactions, linking items to their specific price list definitions as determined by the intercompany relationship setups in Oracle Inventory. This report is crucial for ensuring that transfer prices between internal entities are correctly defined and maintained.

## Business Challenge
In a multi-entity environment, transfer pricing is a critical component of financial compliance and profitability analysis.
*   **Setup Complexity**: Intercompany price lists are assigned through complex relationships involving Customer and Supplier definitions linked to Inventory Organizations.
*   **Pricing Visibility**: It is often difficult to determine exactly which price list is active for a specific item and intercompany relationship without navigating through multiple Oracle forms.
*   **Maintenance Overhead**: Keeping thousands of intercompany prices up-to-date requires constant vigilance to prevent transaction errors or incorrect financial postings.

## Solution
This report simplifies the management of intercompany pricing by exposing the effective price list configuration.
*   **Relationship-Driven**: It derives the relevant price lists directly from the Intercompany Relationship setups, ensuring the report reflects the actual system behavior.
*   **Detailed Pricing**: Displays the Item Number, Price List Name, Price, and Effective Dates.
*   **Validation**: Helps users verify that the correct price list is being picked up for specific items and categories.

## Technical Architecture
The report logic mimics the Oracle pricing engine's retrieval method:
*   **Core Tables**: Joins `qp_list_headers_vl` and `qp_list_lines` (or `qp_price_list_lines` in older versions) to fetch pricing data.
*   **Context Derivation**: Uses `mtl_intercompany_parameters` to identify the valid price lists based on the internal customer relationships.
*   **Item Context**: Links with `mtl_system_items_vl` to provide item descriptions and category information.

## Parameters
*   **Price Effective Date**: (Mandatory) The date for which you want to see the active prices.
*   **Price List**: (Optional) Filter for a specific intercompany price list.
*   **Item Number**: (Optional) Check the price for a specific item.
*   **Category Set 1 & 2**: (Optional) Filter by item categories (e.g., Product Line, Inventory Category).

## Performance
*   **Optimized Retrieval**: The query is structured to drive from the Price List Header, which is generally the most efficient access path for this type of data.
*   **Selective Joins**: Filters by effective date early in the process to minimize the volume of price lines processed.

## FAQ
**Q: Does this show customer price lists?**
A: It focuses on price lists associated with *internal* customers used for intercompany transactions, but the underlying mechanism is the same as standard customer pricing.

**Q: Why is the Price Effective Date mandatory?**
A: Price lists are date-sensitive. The system needs a specific reference date to determine which price line is active.

**Q: Can I see expired prices?**
A: Yes, if you set the Price Effective Date to a date in the past.
