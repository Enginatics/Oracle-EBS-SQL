# Case Study & Technical Analysis

## Abstract
The **DIS Discoverer and Blitz Report Users** report is a strategic migration tool designed for organizations transitioning from Oracle Discoverer to Blitz Report. It provides a comparative view of user adoption, tracking the number of reports executed in both systems over time. This helps project managers monitor the "sunset" of Discoverer and the uptake of the new solution.

## Technical Analysis

### Core Logic
*   **Discoverer Usage**: Queries `EUL5_QPP_STATS` to count worksheet executions per user/month.
*   **Blitz Report Usage**: Queries `XXEN_REPORT_RUNS` (implied context) to count Blitz Report executions.
*   **Comparison**: Aligns the data by user and period to show trends.

### Key Tables
*   `FND_USER`: The master list of application users.
*   `EUL5_QPP_STATS`: The source of Discoverer usage history.

### Operational Use Cases
*   **Adoption Tracking**: "Are users actually running the new Blitz Reports we built for them?"
*   **Intervention**: Identifying users who are exclusively using Discoverer and may need additional training or support.
*   **Decommissioning**: Determining when Discoverer usage has dropped low enough to justify turning off the server.
