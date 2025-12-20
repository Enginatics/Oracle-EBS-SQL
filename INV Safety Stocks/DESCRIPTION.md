# INV Safety Stocks - Case Study & Technical Analysis

## Executive Summary
The **INV Safety Stocks** report is a master data report that lists the currently defined safety stock levels for items in an organization. It is the "System of Record" view, showing what the planning engine (MRP/ASCP) sees as the required buffer.

## Business Challenge
Planners need to verify that the system is using the correct safety stock figures.
-   **Verification:** "I uploaded the new safety stocks, but did they take effect?"
-   **Method Visibility:** "Is this item using a fixed quantity (e.g., 100 units) or a dynamic calculation (e.g., 5 days of supply)?"
-   **Audit:** "Why did MRP suggest we buy so much? Oh, the safety stock was set to 10,000 by mistake."

## Solution
The **INV Safety Stocks** report dumps the contents of the safety stock table. It shows the method, quantity, and effectivity dates for each item.

**Key Features:**
-   **Method Display:** Shows if the safety stock is User Defined (MRP Planned) or Non-MRP Planned.
-   **Time Phasing:** Shows the effective date range for the safety stock entry.
-   **Project Details:** Includes Project and Task references for project-specific safety stock.

## Technical Architecture
The report is a direct query of the safety stock definition table.

### Key Tables and Views
-   **`MTL_SAFETY_STOCKS`**: The primary table.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item details.
-   **`MTL_PARAMETERS`**: Organization details.

### Core Logic
1.  **Retrieval:** Selects all records from `MTL_SAFETY_STOCKS` for the given organization.
2.  **Decoding:** Translates the `SAFETY_STOCK_CODE` into readable text (e.g., 1 = User Defined, 2 = MRP Calculated).
3.  **Formatting:** Presents the data in a list format suitable for review.

## Business Impact
-   **Data Quality:** Helps identify outliers (e.g., negative safety stocks or impossibly high numbers).
-   **Planning Accuracy:** Ensures that the inputs to the planning engine are correct.
-   **Transparency:** Provides visibility into one of the key drivers of inventory investment.
