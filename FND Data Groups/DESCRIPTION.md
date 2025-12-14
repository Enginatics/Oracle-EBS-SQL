# Executive Summary
The **FND Data Groups** report documents the Data Group configuration in EBS. Data Groups determine which Oracle ID (database schema) a concurrent program connects to when it runs.

# Business Challenge
*   **Multi-Schema Support:** Managing environments where different applications store data in different schemas (common in custom bolt-ons).
*   **Security:** Verifying that programs are connecting with the appropriate privileges.
*   **Troubleshooting:** Solving "Table or View does not exist" errors when a program runs in the wrong context.

# The Solution
This Blitz Report lists the mapping between Applications and Oracle IDs within each Data Group:
*   **Group Definition:** Shows the name of the Data Group (e.g., "Standard").
*   **Application Mapping:** Lists every application (e.g., "Assets") and the Oracle User (e.g., "FA") it maps to in that group.

# Technical Architecture
The report queries `FND_DATA_GROUPS` and `FND_DATA_GROUP_UNITS`. It joins `FND_ORACLE_USERID` to show the actual database schema name.

# Parameters & Filtering
*   **Data Group Name:** Filter for a specific group.

# Performance & Optimization
*   **Configuration Report:** Runs instantly.

# FAQ
*   **Q: What is the "Standard" data group?**
    *   A: It is the default group where each application maps to its own standard schema (e.g., GL maps to GL schema).
*   **Q: Why would I change this?**
    *   A: You might create a custom Data Group to point a standard report to a reporting schema or a custom schema for specific processing needs.
