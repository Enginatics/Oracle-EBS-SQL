# Case Study & Technical Analysis: CAC PO Price vs. Costing Method Comparison

## Executive Summary
The **CAC PO Price vs. Costing Method Comparison** report is a proactive audit tool. It compares the Unit Price on Open Purchase Orders against the current Item Cost in the system. This allows organizations to catch significant pricing errors or forecast large variances *before* the goods are received.

## Business Challenge
*   **Data Entry Errors**: A buyer enters $100.00 instead of $10.00. If not caught, this creates a massive variance upon receipt.
*   **Standard Cost Accuracy**: If the PO Price is consistently 20% higher than the Standard Cost, the Standard Cost is outdated and needs revaluation.
*   **Currency Impact**: Buying in EUR when the system is in USD requires checking if the exchange rate on the PO is current.

## Solution
This report highlights the discrepancies.
*   **Comparison**: `PO Unit Price` vs. `Item Cost` (Standard/Average/FIFO).
*   **Thresholds**: Parameters for "Minimum Value Difference" and "Minimum Cost Difference" allow users to filter out noise (e.g., ignore variances under $100).
*   **Currency**: Handles currency conversion to ensure an apples-to-apples comparison.

## Technical Architecture
*   **Tables**: `po_lines_all`, `cst_item_costs`.
*   **Logic**:
    *   If Invoice Match Option = 'Purchase Order', use PO Rate.
    *   If Invoice Match Option = 'Receipt', use current Daily Rate.

## Parameters
*   **Creation Date From/To**: (Mandatory) Range of POs to check.
*   **Cost Type**: (Mandatory) The standard to compare against.
*   **Min Value/Cost Diff**: (Mandatory) Filters for exception reporting.

## Performance
*   **Efficient**: Uses standard indexes on PO tables.

## FAQ
**Q: Does this affect the GL?**
A: No, this is a reporting tool for *Open* POs. No accounting has happened yet. It is for forecasting and data cleansing.

**Q: What if the item has no cost?**
A: It will show a 100% variance, highlighting that a New Item Cost needs to be set up before receipt.
