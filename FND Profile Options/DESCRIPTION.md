# Executive Summary
The **FND Profile Options** report documents the *definition* of profile options, not their values. It shows the metadata about the profile itself.

# Business Challenge
*   **Custom Development:** Checking if a custom profile option is defined correctly (e.g., valid at User level).
*   **System Discovery:** Finding all profile options related to a specific module (e.g., all "INV%" profiles).

# The Solution
This Blitz Report lists the profile definition:
*   **Profile Name:** The internal code and user name.
*   **Hierarchy:** Which levels (Site, App, Resp, User) are enabled and updateable.
*   **SQL Validation:** The SQL statement used to validate the values entered by the admin.

# Technical Architecture
The report queries `FND_PROFILE_OPTIONS_VL`.

# Parameters & Filtering
*   **User Profile Name:** Search by name.
*   **Application:** Filter by owning module.

# Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

# FAQ
*   **Q: Can I see the values here?**
    *   A: No, use "FND Profile Option Values" to see the actual settings. This report just shows the rules for the profile.
