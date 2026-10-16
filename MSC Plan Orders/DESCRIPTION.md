# MSC Plan Orders - Case Study & Technical Analysis

## Executive Summary
The **MSC Plan Orders** report exports the detailed supply and demand transactions from the ASCP plan. It is the raw data feed for any detailed analysis of the plan's output, listing every Planned Order, Purchase Order, Work Order, and Sales Order considered by the engine.

## Business Challenge
Planners and analysts need access to the raw planning data for custom analysis.
-   **Custom Reporting:** "I need to build a pivot table showing the total planned spend by supplier for the next quarter."
-   **Data Validation:** "I need to check if the plan is respecting the 'Fixed Days Supply' modifier for these 20 items."
-   **Integration:** "We need to export the planned orders to a third-party logistics system."

## Solution
The **MSC Plan Orders** report provides a flat-file export of the plan data.

**Key Features:**
-   **Comprehensive:** Includes all transaction types (Supply and Demand).
-   **Detailed:** Includes dates (Suggested, Original), quantities, order numbers, and action messages.
-   **Filtering:** Allows filtering by Plan, Organization, Item, Planner, and Order Type.

## Technical Architecture
The report queries the core supply and demand tables in the ASCP schema.

### Key Tables and Views
-   **`MSC_SUPPLIES`**: Stores all supply transactions (PO, WIP, Planned Orders, On-Hand).
-   **`MSC_DEMANDS`**: Stores all demand transactions (SO, Forecast, WIP Component Demand).
-   **`MSC_SYSTEM_ITEMS`**: Item attributes.
-   **`MSC_TRADING_PARTNERS`**: Organization and Supplier details.

### Core Logic
1.  **Union:** Combines data from `MSC_SUPPLIES` and `MSC_DEMANDS` into a single list.
2.  **Joins:** Links to item and partner tables to resolve IDs to names.
3.  **Filtering:** Applies user-selected parameters to limit the output.

## Business Impact
-   **Flexibility:** Enables unlimited custom analysis using Excel or BI tools.
-   **Transparency:** Provides full visibility into the inputs and outputs of the planning engine.
-   **Collaboration:** Facilitates data sharing with external partners or internal departments.
