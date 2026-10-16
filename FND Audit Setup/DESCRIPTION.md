# Executive Summary
The **FND Audit Setup** report validates the configuration of the Oracle Audit Trail feature. It ensures that the audit groups, tables, and columns defined in the application match the actual database triggers and shadow tables created by the system.

# Business Challenge
*   **Compliance Gaps:** Believing that auditing is active when the underlying database objects (shadow tables) haven't been created.
*   **Configuration Drift:** Identifying discrepancies between the intended audit policy and the technical implementation.
*   **Troubleshooting:** Understanding why changes to a specific table are not being captured.

# The Solution
This Blitz Report performs a health check on the audit setup:
*   **Configuration vs. Reality:** Compares the FND setup tables with the DBA dictionary tables (`DBA_TABLES`, `DBA_TAB_COLUMNS`).
*   **Completeness Check:** Verifies that every column marked for audit actually exists in the shadow table (suffix `_A`).
*   **Group Visibility:** Shows which audit groups contain which tables.

# Technical Architecture
The report joins `FND_AUDIT_GROUPS`, `FND_AUDIT_TABLES`, and `FND_AUDIT_COLUMNS` to get the definition. It then left joins to `DBA_TABLES` and `DBA_TAB_COLUMNS` to verify the existence of the physical audit objects (e.g., `_A` tables).

# Parameters & Filtering
*   **Audit Table/Group:** Filter to check specific objects.

# Performance & Optimization
*   **Dictionary Access:** Queries `DBA_` views, which can be slow on very large databases, but usually performs well for metadata checks.

# FAQ
*   **Q: What does "Audit Table Exists = No" mean?**
    *   A: It means you have defined the audit policy in the application but haven't run the "AuditTrail Update Tables" concurrent program to build the database objects.
*   **Q: Can I audit any table?**
    *   A: Generally yes, but the table must have a primary key defined in EBS.
