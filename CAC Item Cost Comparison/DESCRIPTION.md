# Case Study & Technical Analysis: CAC Item Cost Comparison

## Executive Summary
The **CAC Item Cost Comparison** report is a strategic sourcing and transfer pricing tool. It enables the comparison of item costs between two different inventory organizations, even if they use different currencies. This is critical for "Make vs. Buy" decisions (e.g., "Is it cheaper to make this in Plant A or Plant B?") and for validating intercompany transfer prices.

## Business Challenge
Global supply chains involve moving goods between entities with different cost structures and currencies.
*   **Currency Barrier**: Comparing a cost of 100 USD in the US to 90 EUR in Germany requires real-time currency conversion to be meaningful.
*   **Cost Structure**: Plant A might have lower labor but higher overhead than Plant B. A simple total cost comparison hides these trade-offs.
*   **Data Volume**: Manually looking up costs for thousands of items across two orgs is impossible.

## Solution
This report automates the cross-org comparison.
*   **Currency Normalization**: Converts the "Source Org" cost into the "Target Org" currency using a user-defined exchange rate type and date.
*   **Side-by-Side**: Displays Cost Type 1 (Source) and Cost Type 2 (Target) next to each other, with a calculated variance.
*   **Element Visibility**: Can optionally break down the comparison by cost element (Material, Labor, etc.) to show *where* the difference lies.

## Technical Architecture
The report performs a complex join across organizations:
*   **Self-Join**: Joins `cst_item_costs` to itself (once for Org 1, once for Org 2).
*   **Currency Engine**: Uses `gl_daily_rates` to fetch the exchange rate between the functional currencies of the two organizations.
*   **Item Matching**: Matches items based on the Item Number (Segment 1), assuming a shared Item Master.

## Parameters
*   **Org Code 1 (Source)**: The reference organization.
*   **Org Code 2 (Target)**: The comparison organization.
*   **Currency Conversion**: (Mandatory) Date and Type for the FX calculation.
*   **Min Cost Diff**: (Optional) Filter to show only significant variances.

## Performance
*   **Heavy Join**: Joining two large cost tables can be slow.
*   **Filtering**: Using the "Min Cost Diff" parameter is highly recommended to reduce the output to actionable items only.

## FAQ
**Q: Can I compare the same org to itself?**
A: Yes, you can use this to compare two different Cost Types (e.g., Frozen vs. Pending) within the same organization, effectively acting as a "Cost Impact" report.

**Q: What if the item doesn't exist in the second org?**
A: The report typically uses an outer join, so it will show the item in Org 1 with a null value for Org 2 (or vice versa).

**Q: Does it handle different Units of Measure?**
A: The report assumes the Primary UOM is the same. If Org 1 uses "Each" and Org 2 uses "Dozen", the comparison will be skewed unless a conversion is applied (which this report typically does not do automatically).
