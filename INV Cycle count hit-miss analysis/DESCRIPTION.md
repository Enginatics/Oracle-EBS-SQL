# INV Cycle count hit-miss analysis - Case Study & Technical Analysis

## Executive Summary
The **INV Cycle count hit/miss analysis** report is a performance metric report used to evaluate the accuracy of the inventory records. It classifies each count as a "Hit" (accurate within tolerance) or a "Miss" (inaccurate). This report is essential for measuring the effectiveness of the inventory management process and is often a key KPI for warehouse managers.

## Business Use Cases
*   **KPI Reporting**: Calculates the "Inventory Record Accuracy" percentage (Hits / Total Counts).
*   **Tolerance Tuning**: Helps determine if current tolerances are too strict (too many misses) or too loose (100% hits but poor operational reality).
*   **Root Cause Analysis**: By grouping misses by ABC class or Subinventory, managers can identify problem areas (e.g., "Why do we have so many misses in the Bulk Zone?").

## Technical Analysis

### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: Stores the count results.
*   `MTL_CYCLE_COUNT_CLASSES`: Defines the hit/miss tolerances for each class.
*   `MTL_ABC_CLASSES`: The ABC classes (A, B, C).

### Key Joins & Logic
*   **Hit/Miss Logic**: The system compares the `ADJUSTMENT_QUANTITY` (or value) against the tolerances defined in `MTL_CYCLE_COUNT_CLASSES`.
    *   If `ABS(Variance) <= Tolerance`, it's a **Hit**.
    *   Otherwise, it's a **Miss**.
*   **Aggregation**: The report typically aggregates these counts to show percentages by Class or Subinventory.

### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Start/End Date**: The period to analyze.
