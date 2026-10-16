# Executive Summary
The Blitz Upload Data report provides a historical record of data uploaded via Blitz Report. It tracks upload events, including user details, request IDs, and the volume of data processed, serving as an audit trail for data import activities.

# Business Challenge
Organizations using Blitz Report for data uploads need visibility into what data is being imported, by whom, and when. Without a log of upload activities, it is difficult to troubleshoot issues, audit changes, or monitor system usage related to data imports.

# Solution
This report offers a detailed history of data uploads, retained for a configurable period (defined by the "Blitz Upload Data Retention Days" profile option). It allows administrators to review past uploads, verify successful processing, and analyze usage patterns.

# Key Features
*   **Upload History:** Lists historical data uploads with timestamps and user information.
*   **Detailed Tracking:** Captures Upload Name, User Name, Request IDs, and Run IDs.
*   **Volume Monitoring:** Shows the number of rows processed per upload.
*   **Retention Management:** Respects the configured data retention policy.

# Technical Details
The report queries the `xxen_upload_data` table, which stores the actual uploaded data, and joins it with `xxen_report_runs` and `xxen_reports_v` to provide context about the report execution. It also references `fnd_responsibility_tl` for responsibility information.
