# INV Cycle counts pending approval - Case Study & Technical Analysis

## Executive Summary
The **INV Cycle counts pending approval** report is a workflow management tool for inventory supervisors. It lists all cycle count entries where the variance (difference between system and physical count) exceeds the pre-defined approval tolerances. These entries are "stuck" in a pending state until a manager reviews and approves (or rejects/recounts) them.

## Business Use Cases
*   **Approval Workflow**: The primary "inbox" for managers to review large adjustments before they hit the General Ledger.
*   **Fraud Detection**: Large variances needing approval are often the first indicator of theft or significant process failures.
*   **Period Close**: All pending approvals must be resolved before the inventory period can be closed effectively (or at least before the adjustments are reflected in finance).

## Technical Analysis

### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: The count entries.
*   `MTL_CYCLE_COUNT_HEADERS`: Defines the approval tolerances.
*   `MTL_ABC_CLASSES`: Used if tolerances are defined by ABC class.

### Key Joins & Logic
*   **Status Filter**: Filters for `ENTRY_STATUS_CODE` = 2 (Pending Approval).
*   **Tolerance Check**: The system automatically places an entry in this status if:
    *   `ABS(Variance Qty) > Quantity Tolerance` OR
    *   `ABS(Variance Value) > Value Tolerance`.
*   **Sorting**: Often sorted by value to prioritize the biggest hits.

### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Sort By**: Options usually include Item, Location, or Variance Value.
