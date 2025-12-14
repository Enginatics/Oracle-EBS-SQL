# Executive Summary
The **FND Responsibilities** report provides a high-level overview of Responsibility definitions. It focuses on the setup of the responsibility itself, including its menu, request group, and data access controls.

# Business Challenge
*   **License Audit:** Counting the number of active users assigned to each responsibility.
*   **Configuration Review:** Checking which Menu and Request Group are linked to a responsibility.
*   **MOAC Analysis:** Verifying the "Multi-Org" setup (Security Profile) for each responsibility.

# The Solution
This Blitz Report aggregates responsibility data:
*   **Definition:** Responsibility Name, Key, and Application.
*   **Components:** Assigned Menu, Request Group, and Data Group.
*   **Access Control:** MO: Security Profile, GL Data Access Set.
*   **Usage:** Count of active users assigned.

# Technical Architecture
The report queries `FND_RESPONSIBILITY_VL` and joins to profile option values to determine the MOAC and GL security settings.

# Parameters & Filtering
*   **Responsibility Name:** Filter by name.
*   **Show Active only:** Hide end-dated responsibilities.
*   **Having Active Users only:** Filter to show only responsibilities that are actually being used.

# Performance & Optimization
*   **Complex Joins:** The report logic to determine the "Effective" Operating Unit or Ledger involves checking multiple profile levels, which makes the SQL complex but robust.

# FAQ
*   **Q: Does this show which users have the responsibility?**
    *   A: It shows the *count* of users. Use "FND Responsibility Access" or "FND User Responsibilities" to see the list of names.
