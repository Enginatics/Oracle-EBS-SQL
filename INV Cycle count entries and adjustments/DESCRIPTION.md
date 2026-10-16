# INV Cycle count entries and adjustments - Case Study & Technical Analysis

## Executive Summary
The **INV Cycle count entries and adjustments** report is a critical audit and control document that details the results of the cycle counting process. It lists the items counted, the system quantity, the actual counted quantity, and most importantly, the **variance** (adjustment) required to reconcile the two. This report is the primary source for analyzing inventory shrinkage or gain and is often required for financial sign-off on inventory adjustments.

## Business Use Cases
*   **Variance Approval**: Managers review this report to approve large adjustments before they are posted to the General Ledger.
*   **Shrinkage Analysis**: Identifies items with consistent negative variances (missing stock), which may indicate theft or process errors.
*   **Accuracy Reporting**: Provides the raw data to calculate inventory record accuracy (IRA).
*   **Audit Trail**: Serves as the permanent record of what was counted, who counted it (if tracked), and what the result was.

## Technical Analysis

### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: The core transaction table storing the count results (System Qty, Count Qty, Adjustment Qty).
*   `MTL_CYCLE_COUNT_HEADERS`: Defines the cycle count name and parameters.
*   `MTL_SYSTEM_ITEMS_VL`: Item master details.
*   `MTL_ITEM_LOCATIONS_KFV`: Locator details.
*   `MTL_ABC_CLASSES`: ABC classification for the items.

### Key Joins & Logic
*   **Variance Calculation**: The report calculates `ADJUSTMENT_QUANTITY` = `COUNT_QUANTITY` - `SYSTEM_QUANTITY`.
*   **Value Calculation**: `ADJUSTMENT_VALUE` = `ADJUSTMENT_QUANTITY` * `ITEM_COST`.
*   **Status Filtering**: Can filter by entry status (e.g., 'Pending Approval', 'Completed').
*   **Approvals**: If the adjustment exceeds the approval tolerance defined in the Cycle Count Header, the entry is marked for approval.

### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Subinventory**: Filter by specific storage area.
*   **Start/End Date**: The period of the count.
*   **Approved Counts Only**: If 'Yes', only shows adjustments that have been finalized.
