# Executive Summary
The **DBA Alert Log** report provides a direct interface to the Oracle Database's XML-based Alert Log, located within the Automatic Diagnostic Repository (ADR). The Alert Log is the primary chronological record of messages and errors for the database. This report allows DBAs to query, filter, and export these critical system messages without needing to log in to the database server OS.

# Business Challenge
*   **Proactive Monitoring**: "Did any critical errors (ORA-00600, ORA-07445) occur last night?"
*   **Accessibility**: Developers and functional support often need to see if a process failed due to a database error, but they don't have SSH access to the server.
*   **Audit**: Reviewing the history of database startups, shutdowns, and parameter changes.

# Solution
This report queries the `V$DIAG_ALERT_EXT` view to present the alert log contents in a tabular format.

**Key Features:**
*   **Incremental Mode**: Can be scheduled to run periodically (e.g., every hour) and report only new messages since the last run.
*   **Filtering**: Parameters allow filtering by Message Text (e.g., "ORA-"), Message Level, or Timeframe.
*   **Unified View**: In a RAC environment, it can potentially show alerts from the local instance (or all, depending on the view definition).

# Architecture
The report leverages the ADR infrastructure introduced in Oracle 11g.

**Key Tables:**
*   `V$DIAG_ALERT_EXT`: The external table view that parses the XML alert log file.

# Impact
*   **Uptime**: Enables faster detection and resolution of critical database errors.
*   **Security**: Provides read-only access to logs without granting OS privileges.
*   **Efficiency**: Automates the daily check of the alert log via scheduled email delivery.
