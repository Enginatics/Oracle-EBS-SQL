# INV Cycle count schedule requests - Case Study & Technical Analysis

## Executive Summary
The **INV Cycle count schedule requests** report documents the *intent* to count. It lists the items that have been selected by the automatic scheduler or manually requested for counting. This is the upstream step before "Entries" are generated. It helps inventory managers understand what the system is planning to count based on the frequency rules (e.g., "Count 'A' items 12 times a year").

## Business Use Cases
*   **Schedule Validation**: Verifies that the automatic scheduler is picking up the correct items.
*   **Workload Planning**: Helps warehouse managers estimate the labor required for the upcoming week's counts.
*   **Coverage Analysis**: Ensures that all items in a specific category or subinventory are being scheduled.

## Technical Analysis

### Core Tables
*   `MTL_CC_SCHEDULE_REQUESTS`: Stores the request to count an item.
*   `MTL_CYCLE_COUNT_HEADERS`: The cycle count definition.
*   `MTL_SYSTEM_ITEMS_VL`: Item details.

### Key Joins & Logic
*   **Auto-Schedule Logic**: The system generates records in `MTL_CC_SCHEDULE_REQUESTS` based on the item's ABC class and the last count date.
*   **Request to Entry**: A schedule request becomes an "Entry" (`MTL_CYCLE_COUNT_ENTRIES`) once the "Generate Cycle Count Requests" program is run. This report shows the state *before* or *during* that generation.

### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Category Set**: Filter by item category to check scheduling for specific product lines.
