# Executive Summary
The **FND Audit Table Changes by Record** report provides a pivoted view of audit trail data. Unlike the "by Column" version, this report shows the "Old" and "New" values for all audited columns in a single row per transaction.

# Business Challenge
*   **Contextual Analysis:** Seeing all changes from a single transaction together to understand the full context of the update.
*   **Readability:** Easier for business users to read a single line describing an update rather than multiple rows.
*   **Exportability:** Better suited for Excel exports where a "flat" record structure is preferred.

# The Solution
This Blitz Report dynamically pivots the audit data:
*   **Single Row View:** One update transaction = one row in the report.
*   **Dynamic Columns:** The report automatically generates columns for "Old [Column]" and "New [Column]" based on the table definition.
*   **Transaction Type:** Clearly marks Inserts, Updates, and Deletes.

# Technical Architecture
Similar to the "by Column" report, it uses dynamic SQL. However, the query construction is more complex as it must select all relevant columns from the shadow table and present them in a wide format.

# Parameters & Filtering
*   **Audit Table:** The table to analyze.
*   **Date Range:** Timeframe for the changes.
*   **Audited User:** Filter by the person who made the change.

# Performance & Optimization
*   **Column Limit:** If a table has hundreds of audited columns, the report can become very wide.
*   **Data Volume:** As with all audit reports, querying large shadow tables without filters can be slow.

# FAQ
*   **Q: Which report should I use? "by Column" or "by Record"?**
    *   A: Use "by Record" when you want to see the full state of the record before/after the change. Use "by Column" if you are looking for specific field changes (e.g., "Who changed the credit limit?").
