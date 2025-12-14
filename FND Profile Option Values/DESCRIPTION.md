# Executive Summary
The **FND Profile Option Values** report is the definitive tool for auditing system configuration. It shows the value of every profile option at every level (Site, Application, Responsibility, User, Server, Org).

# Business Challenge
*   **Troubleshooting:** Investigating why a user sees different behavior than others (often due to a User-level profile override).
*   **Environment Comparison:** Checking if the "Site" level profiles match between PROD and TEST.
*   **Security Audit:** Verifying that critical security profiles (e.g., "Signon Password Hard to Guess") are set correctly.

# The Solution
This Blitz Report lists the profile values:
*   **Profile Name:** The user-friendly name (e.g., "MO: Operating Unit").
*   **Level:** The hierarchy level (Site, Resp, User, etc.).
*   **Value:** The actual setting (e.g., "Vision Operations").
*   **Visible Value:** It decodes internal IDs (like Org ID 204) into readable names (like "Vision Operations").

# Technical Architecture
The report queries `FND_PROFILE_OPTION_VALUES` and joins to context tables like `FND_USER`, `FND_RESPONSIBILITY`, and `HR_ALL_ORGANIZATION_UNITS`.

# Parameters & Filtering
*   **User Profile Name:** Search by the friendly name.
*   **Setup Level:** Filter to see only "Site" or "User" level settings.
*   **Redundant:** A special filter to find values set at lower levels that are identical to the Site level (cleanup opportunity).

# Performance & Optimization
*   **Volume:** There are millions of profile values. Always filter by Profile Name or Level.

# FAQ
*   **Q: Why are there two value columns?**
    *   A: "Profile System Value" is what is stored in the DB (often an ID). "Profile User Value" is the translated, human-readable meaning.
