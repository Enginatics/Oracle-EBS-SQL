# Case Study & Technical Analysis: CAC Resources Associated with Overheads Setup

## Executive Summary
The **CAC Resources Associated with Overheads Setup** report is a configuration audit tool. In Oracle Costing, Overheads (like "Factory Burden") are often applied based on Resource usage (e.g., "$10 of Overhead for every 1 hour of Labor"). This report validates that the links between Resources and Overheads are correctly established.

## Business Challenge
*   **Under-Absorption**: If "Labor" is not linked to "Fringe Benefits", the product cost will exclude the benefit cost, leading to under-pricing.
*   **Complexity**: A plant might have 50 resources and 10 overheads. Checking the 500 potential combinations manually is error-prone.
*   **Troubleshooting**: "Why is the overhead calculation zero?"

## Solution
This report visualizes the matrix.
*   **Mapping**: Shows `Resource` -> `Overhead`.
*   **Status**: Explicitly flags "Missing" associations where a resource exists but has no overheads linked (if that is the business rule).
*   **Rates**: Shows the basis (Item or Lot) and the rate.

## Technical Architecture
*   **Tables**: `cst_resource_overheads`, `bom_resources`.
*   **Logic**: Uses a `LEFT JOIN` to find resources that *should* have overheads but don't.

## Parameters
*   **Resource/Overhead Cost Type**: (Optional) Defaults to the costing method.

## Performance
*   **Fast**: Configuration data.

## FAQ
**Q: Can a resource have multiple overheads?**
A: Yes, Labor might attract "Fringe", "Supervision", and "Occupancy" overheads. All will be listed.
