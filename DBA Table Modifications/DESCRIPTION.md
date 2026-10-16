# Case Study & Technical Analysis

## Abstract
The **DBA Table Modifications** report leverages the database's internal monitoring mechanism to track data manipulation language (DML) activity. It queries `DBA_TAB_MODIFICATIONS`, which records the approximate number of `INSERT`, `UPDATE`, and `DELETE` operations performed on a table since the last time optimizer statistics were gathered. This report is essential for understanding data volatility and tuning statistics gathering strategies.

## Technical Analysis

### Core Metrics
*   **Inserts/Updates/Deletes**: The raw count of row changes.
*   **Timestamp**: The time of the last analysis vs. the timestamp of the modification data.
*   **Truncated**: A flag indicating if the table was truncated (which resets the high water mark but might not trigger a stats update immediately).

### Key View
*   `DBA_TAB_MODIFICATIONS`: This view is populated by the database kernel in memory and flushed to disk periodically (or manually via `DBMS_STATS.FLUSH_DATABASE_MONITORING_INFO`).

### Operational Use Cases
*   **Stale Statistics**: Identifying tables that have changed significantly (e.g., >10% of rows) but haven't been analyzed, leading to poor execution plans.
*   **Batch Verification**: Confirming that a nightly load job actually processed data.
*   **Volatility Profiling**: Distinguishing between static lookup tables and high-churn transaction tables.
