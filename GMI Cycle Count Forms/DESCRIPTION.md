# GMI Cycle Count Forms - Case Study & Technical Analysis

## Executive Summary
The **GMI Cycle Count Forms** report is a specialized inventory document used in Oracle Process Manufacturing (OPM). It generates the physical count sheets (forms) that warehouse personnel use to record the actual on-hand quantities of items during a cycle count. This report is the operational "instruction sheet" for the counting process, ensuring that the correct items and lots are counted in the correct locations.

## Business Use Cases
*   **Physical Inventory Execution**: Provides the paper or digital document used by warehouse staff to perform the count.
*   **Blind Counting**: Can be configured to hide the system on-hand quantity ("Blind Count"), forcing the counter to record what they actually see rather than verifying what the system says.
*   **Lot Control Verification**: Specifically designed for OPM environments where lot control and expiration dates are critical; the form includes fields to verify lot numbers.
*   **Audit Compliance**: The signed count sheets serve as physical evidence of the inventory verification process for auditors.

## Technical Analysis

### Core Tables
*   `IC_WHSE_MST`: Stores warehouse definitions.
*   `IC_PHYS_CNT`: The physical inventory count header/detail.
*   `IC_CYCL_HDR`: The cycle count header definition.
*   `IC_ITEM_MST_VL`: Item master table (OPM specific).
*   `IC_LOTS_MST`: Lot master table (OPM specific).

### Key Joins & Logic
*   **OPM Data Model**: Unlike discrete inventory (which uses `MTL_%` tables), this report uses the legacy OPM tables (`IC_%`) or their converged R12 equivalents.
*   **Count Generation**: The report logic selects items that have been scheduled for counting in the `IC_CYCL_HDR` batch.
*   **Sorting**: Organizes the output by Warehouse, Location, and Item to create an efficient "walking path" for the counter.

### Key Parameters
*   **Warehouse Code**: The specific facility to count.
*   **Cycle**: The specific cycle count batch ID.
*   **From/To Count**: Range of count IDs to print.
