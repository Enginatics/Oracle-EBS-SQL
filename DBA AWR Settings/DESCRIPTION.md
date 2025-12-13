# Executive Summary
The **DBA AWR Settings** report audits the configuration of the Automatic Workload Repository itself. AWR is the "black box flight recorder" of the Oracle database. Its effectiveness depends on how it is configured: how often it takes snapshots, how long it keeps them, and how many "Top SQL" statements it captures.

# Business Challenge
*   **Data Retention**: "We had a performance issue last month, but the AWR data is gone because retention is set to 8 days."
*   **Granularity**: "We missed a short spike because the snapshot interval is set to 1 hour instead of 15 minutes."
*   **Storage Growth**: "The SYSAUX tablespace is full because AWR is keeping too much data."

# Solution
This report displays the current AWR configuration parameters.

**Key Features:**
*   **Retention**: How long history is kept (e.g., 30 days).
*   **Interval**: Frequency of snapshots (e.g., 60 minutes).
*   **Top N SQL**: How many SQL statements are captured per snapshot (e.g., Top 30 by CPU).

# Architecture
The report queries the internal workload repository control tables.

**Key Tables:**
*   `DBA_HIST_WR_CONTROL`: Stores the AWR settings.

# Impact
*   **Observability**: Ensures that when a problem occurs, the necessary diagnostic data will be available.
*   **Space Management**: Helps balance the need for history against the storage cost of the SYSAUX tablespace.
*   **Compliance**: Verifies that retention policies meet internal audit requirements.
