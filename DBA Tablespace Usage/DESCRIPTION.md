# Case Study & Technical Analysis

## Abstract
The **DBA Tablespace Usage** report is the primary instrument for storage capacity planning and monitoring. It provides a unified view of space utilization across all types of tablespaces: Permanent (Data/Index), Temporary (Sort/Hash), and Undo (Rollback). By calculating the "Used" vs. "Allocated" vs. "Max Size" (autoextend), it gives a true picture of remaining capacity.

## Technical Analysis

### Core Logic
*   **Permanent Tablespaces**: usage is calculated based on extent allocation in `DBA_DATA_FILES`.
*   **Temp Tablespaces**: Usage is dynamic, based on `V$SORT_SEGMENT` or `DBA_TEMP_FILES`.
*   **Undo Tablespaces**: Usage is based on active vs. expired extents in `DBA_UNDO_EXTENTS`.

### Key Views
*   `DBA_TABLESPACE_USAGE_METRICS`: A convenient view that pre-calculates usage percentages, accounting for auto-extensibility.
*   `DBA_DATA_FILES` / `DBA_TEMP_FILES`: Physical file definitions.

### Operational Use Cases
*   **Alerting**: "Alert me when the `APPS_TS_TX_DATA` tablespace is 90% full."
*   **Cleanup**: Identifying tablespaces that are unexpectedly filling up due to unpurged interface tables.
*   **Undo Sizing**: Monitoring if the Undo tablespace is large enough to support the `UNDO_RETENTION` period without "Snapshot too old" errors.
