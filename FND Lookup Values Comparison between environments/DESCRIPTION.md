# Executive Summary
The **FND Lookup Values Comparison between environments** report is a migration validation tool. It compares the lookup configurations between the current instance (e.g., PROD) and a remote instance (e.g., DEV) via a database link.

# Business Challenge
*   **Migration Verification:** Ensuring that all new lookup codes created in DEV have been successfully migrated to PROD.
*   **Drift Analysis:** Identifying configuration changes made directly in PROD that are missing from DEV.
*   **Sync Check:** Verifying that lookup descriptions match across environments.

# The Solution
This Blitz Report compares the two datasets:
*   **Match:** Identifies codes that exist in both but have different descriptions or enabled statuses.
*   **Missing:** Identifies codes that exist in one environment but not the other.

# Technical Architecture
The report uses a `DB Link` to query the remote `FND_LOOKUP_VALUES` table and compares it with the local table using `MINUS` or `FULL OUTER JOIN` logic.

# Parameters & Filtering
*   **Remote Database:** The name of the database link to the other environment.
*   **Show Differences only:** Toggle to hide matching records and focus on discrepancies.

# Performance & Optimization
*   **Network:** Performance depends on the speed of the database link. Filter by specific Lookup Types to improve speed.

# FAQ
*   **Q: Do I need a DB Link?**
    *   A: Yes, this report requires a valid database link to the target environment.
