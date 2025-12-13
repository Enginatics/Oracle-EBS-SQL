# Case Study & Technical Analysis: CAC Inventory Pending Cost Adjustment - No Currencies

## Executive Summary
The **CAC Inventory Pending Cost Adjustment - No Currencies** report is a specialized version of the standard cost simulation tool. It calculates the revaluation impact of a pending standard cost update but explicitly *excludes* variances caused by foreign currency exchange rate fluctuations. This allows cost accountants to focus purely on the operational cost changes (e.g., material price, labor rate, overhead) without the noise of FX market volatility.

## Business Challenge
In global organizations, standard costs often include components sourced in foreign currencies.
*   **Signal vs. Noise**: When analyzing a cost update, a 5% increase in total inventory value might be 1% material price increase and 4% currency shift. Separating these is crucial for decision making.
*   **Operational Accountability**: Procurement teams are responsible for negotiated prices, not for the exchange rate. Reporting total variance muddies the water on performance.
*   **Revaluation Strategy**: Companies may choose to update operational costs quarterly but update currency rates monthly (or vice versa). This report supports that decoupled strategy.

## Solution
This report filters the revaluation analysis.
*   **FX Exclusion**: It compares the "Old" and "New" costs but suppresses differences that are solely due to the `Currency Conversion Rate` parameter changes.
*   **Operational Focus**: Highlights items where the base cost (in the functional currency) is changing due to BOM, Routing, or Item Price changes.
*   **Reconciliation**: Can be used in conjunction with the full "Pending Cost Adjustment" report to mathematically isolate the FX impact (Total Impact - No Currency Impact = FX Impact).

## Technical Architecture
The logic mirrors the standard Pending Cost Adjustment report but adds a filter:
*   **Cost Comparison**: Joins `cst_item_costs` for Old and New cost types.
*   **Logic**: The SQL likely includes a clause or calculation that neutralizes the exchange rate factor or filters out rows where the item cost in the *transaction currency* hasn't changed.
*   **Scope**: Covers On-hand and Intransit inventory.

## Parameters
*   **Cost Type (New/Old)**: (Mandatory) The scenarios to compare.
*   **Only Items in New Cost Type**: (Mandatory) Focuses the report.
*   **Include Zero Item Cost Differences**: (Mandatory) Toggle to show/hide unchanged items.

## Performance
*   **Efficient**: By filtering out currency-only changes, the output is often much smaller and easier to review than the full report.
*   **Pre-Update Check**: Essential to run *before* the Standard Cost Update to verify the intended operational changes.

## FAQ
**Q: Why would I ignore currency changes?**
A: If you are trying to validate that your new material prices were loaded correctly, currency fluctuations are just "noise" that makes it harder to spot data entry errors.

**Q: Does this report update the costs?**
A: No, it is a simulation/reporting tool only.

**Q: Can I see the FX impact separately?**
A: Not directly in this report. You would run this report and the standard report, then compare the totals.
