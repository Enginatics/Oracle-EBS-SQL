# Executive Summary
The **FND Audit Table Changes by Column** report is a universal tool for querying data from any Oracle Audit Trail table. It presents the history of changes in a normalized format, with one row per changed column.

# Business Challenge
*   **Forensic Analysis:** Investigating exactly what changed, who changed it, and when.
*   **Data Recovery:** Finding the previous value of a field to reverse an accidental update.
*   **Security Monitoring:** Tracking changes to sensitive fields like bank accounts or salary.

# The Solution
This Blitz Report uses dynamic SQL to query the specific shadow table for the selected entity:
*   **Universal Access:** Can query any table enabled for Audit Trail (e.g., `FND_USER_A`, `PO_VENDORS_A`).
*   **Granular Detail:** Shows the "Old Value" and "New Value" side-by-side for each specific column.
*   **User Context:** Identifies the EBS user who made the change, not just the database user.

# Technical Architecture
The report uses a dynamic SQL structure (indicated by `&from_audit_tables`). It constructs the query at runtime based on the `Audit Table` parameter selected by the user. It joins the shadow table (e.g., `_A`) with `FND_USER` to resolve the `WHO` columns.

# Parameters & Filtering
*   **Audit Table:** The specific table to query (Required).
*   **Date Range:** To limit the history.
*   **Record Filter:** A flexible `WHERE` clause to find specific records (e.g., `VENDOR_NAME like 'ABC%'`).

# Performance & Optimization
*   **Indexing:** Shadow tables can grow very large. Ensure the shadow table has indices on the primary key and timestamp columns for performance.
*   **Date Range:** Always use a date range to avoid scanning millions of historical audit records.

# FAQ
*   **Q: Why do I see multiple rows for one update?**
    *   A: If a user updates 5 fields in a single save, this report will show 5 rows—one for each column changed.
*   **Q: Can I see the primary key of the record?**
    *   A: Yes, the report typically includes the primary key columns to identify the record.
