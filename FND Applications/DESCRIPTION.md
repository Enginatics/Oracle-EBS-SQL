# Executive Summary
The **FND Applications** report provides a high-level inventory of all registered applications within the Oracle E-Business Suite. It details their installation status, base paths, and audit configurations.

# Business Challenge
*   **License Management:** Identifying which modules are installed and active.
*   **System Auditing:** Verifying which applications have audit trails enabled.
*   **Environment Assessment:** Quickly understanding the footprint of the EBS implementation.

# The Solution
This Blitz Report offers a comprehensive system overview:
*   **Installation Status:** Shows if an app is 'Installed', 'Shared', or 'Inactive'.
*   **Schema Mapping:** Links the application to its Oracle ID (schema name).
*   **Audit Status:** Indicates if the "AuditTrail:Activate" profile is set and if the schema is audited.

# Technical Architecture
The report joins `FND_APPLICATION_VL` with `FND_PRODUCT_INSTALLATIONS` and `FND_ORACLE_USERID`. It also checks `FND_AUDIT_SCHEMAS` to report on audit configurations.

# Parameters & Filtering
*   **Application Name/Short Name:** Filter for specific modules (e.g., 'Payables', 'SQLGL').

# Performance & Optimization
*   **Fast Execution:** This report runs very quickly as it queries small metadata tables.
*   **No Parameters:** Running without parameters gives the full list of 200+ standard modules.

# FAQ
*   **Q: What does "Shared" status mean?**
    *   A: It means the application is available for use, but its data model might be shared with another installed application (common in older EBS versions).
*   **Q: Can I see patch levels here?**
    *   A: No, this report shows registration status. For patch levels, use "AD Applied Patches".
