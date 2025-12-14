# Executive Summary
The **FND Request Groups** report documents which concurrent programs are assigned to which Request Groups. This is the mechanism that controls which reports a user can run.

# Business Challenge
*   **Security Audit:** Verifying that sensitive reports (e.g., "Employee Salary Report") are not in standard request groups.
*   **Troubleshooting:** Explaining why a user cannot find a specific report in the "Submit Request" window.
*   **Configuration:** Documenting the contents of custom request groups.

# The Solution
This Blitz Report lists the assignments:
*   **Request Group:** The name of the group (e.g., "GL Concurrent Program Group").
*   **Unit Type:** Program, Set, or Application.
*   **Unit Name:** The specific report or set assigned.

# Technical Architecture
The report queries `FND_REQUEST_GROUPS` and `FND_REQUEST_GROUP_UNITS`.

# Parameters & Filtering
*   **Request Group:** Filter by the group name.
*   **Concurrent Program Name:** Find all groups that contain a specific report (Reverse Search).

# Performance & Optimization
*   **Fast Execution:** Runs quickly against the configuration tables.

# FAQ
*   **Q: What does "Application" unit type mean?**
    *   A: It means *all* reports belonging to that application are automatically included in the group.
