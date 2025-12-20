# INV Cycle count open requests listing - Case Study & Technical Analysis

## Executive Summary
The **INV Cycle count open requests listing** report focuses specifically on cycle count entries that are **incomplete**. An "open request" is a generated count task that has not yet been fully processed (counted, entered, and approved). This report is a "To-Do List" for the inventory team to ensure all counts are closed out before the period end.

## Business Use Cases
*   **Backlog Management**: Identifies counts that were generated but never executed (e.g., lost tags, forgotten aisles).
*   **Period Close Prep**: Oracle Inventory often requires all cycle count entries to be processed before certain period-end activities; this report identifies the blockers.
*   **Overdue Analysis**: Highlights counts that have been open longer than the standard SLA.

## Technical Analysis

### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: The primary source, filtered for open statuses.
*   `MTL_CC_SCHEDULE_REQUESTS`: The schedule request that spawned the entry.

### Key Joins & Logic
*   **Open Status Filter**: The query specifically looks for `ENTRY_STATUS_CODE` NOT IN (Completed, Recount).
*   **Late Logic**: If "Overdue Requests Only" is selected, it compares the `CREATION_DATE` or `COUNT_DUE_DATE` against the current date.

### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Overdue Requests Only**: Flag to show only late counts.
