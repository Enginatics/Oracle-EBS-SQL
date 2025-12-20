# INV Cycle count unscheduled items - Case Study & Technical Analysis

## Executive Summary
The **INV Cycle count unscheduled items** report identifies items that are part of a cycle count definition (header) but have **not** been scheduled for counting within a specific timeframe. This is a "gap analysis" report used to ensure that no items are falling through the cracks of the cycle counting process, which is critical for maintaining 100% inventory coverage over the course of a year.

## Business Use Cases
*   **Coverage Verification**: Ensures that every item in the warehouse is being counted at least once per year (or as defined by its ABC class).
*   **Scheduler Troubleshooting**: If the auto-scheduler is running but items aren't appearing on count sheets, this report helps identify which items are being skipped.
*   **New Item Audit**: Verifies that newly created items have been properly picked up by the cycle count logic.

## Technical Analysis

### Core Tables
*   `MTL_CYCLE_COUNT_ITEMS`: The list of items eligible for the cycle count.
*   `MTL_CC_SCHEDULE_REQUESTS`: The table checked to see if a schedule exists.
*   `MTL_CYCLE_COUNT_HEADERS`: The cycle count definition.

### Key Joins & Logic
*   **Exclusion Logic**: The report selects items from `MTL_CYCLE_COUNT_ITEMS` where there is NO corresponding record in `MTL_CC_SCHEDULE_REQUESTS` (or `MTL_CYCLE_COUNT_ENTRIES`) for the given period.
*   **Class Logic**: It often groups by ABC class to show, for example, "Which 'A' items haven't been counted this month?".

### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Organization Code**: The inventory organization.
