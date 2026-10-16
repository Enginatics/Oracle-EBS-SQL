# INV Item Demand History - Case Study & Technical Analysis

## Executive Summary
The **INV Item Demand History** report provides a historical view of item usage (demand) over time. It aggregates transaction data to show how much of an item was issued or sold in specific time buckets. This data is the foundation for **Inventory Forecasting** and **Min-Max Planning**.

## Business Use Cases
*   **Forecasting**: Planners use this history to predict future demand (e.g., "We used 100 units last December, so we should stock up for this December").
*   **Min-Max Calculation**: The "Calculate Min-Max Planning" program uses this history to suggest new minimum and maximum stock levels.
*   **Slow Mover Analysis**: Identifies items with zero demand over the last 12 months.

## Technical Analysis

### Core Tables
*   `MTL_DEMAND_HISTORIES`: The summary table populated by the "Compile Demand History" concurrent program.
*   `MTL_SYSTEM_ITEMS_KFV`: Item details.

### Key Joins & Logic
*   **Compilation**: This report relies on the `MTL_DEMAND_HISTORIES` table being up-to-date. This table is NOT real-time; it is populated by a background process that summarizes `MTL_MATERIAL_TRANSACTIONS`.
*   **Bucketing**: Demand is aggregated into buckets (Day, Week, Month) based on the compilation settings.
*   **Transaction Types**: Only specific transaction types (e.g., Sales Order Issue, WIP Issue) are typically considered "Demand".

### Key Parameters
*   **Bucket Type**: Daily, Weekly, or Monthly.
*   **History Start Date**: The lookback period.
