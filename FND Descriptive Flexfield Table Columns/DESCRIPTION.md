# Executive Summary
The **FND Descriptive Flexfield Table Columns** report provides a technical mapping of database columns to Descriptive Flexfields (DFFs). It identifies which columns in a table are enabled for flexfield usage.

# Business Challenge
*   **Customization Analysis:** Identifying which tables have available "Attribute" columns for storing custom data.
*   **Data Migration:** Mapping legacy data to specific DFF segments during a migration project.
*   **Cleanup:** Finding unused or disabled flexfield columns.

# The Solution
This Blitz Report lists the columns in `FND_TABLES` that are registered as part of a Descriptive Flexfield:
*   **Table Mapping:** Shows the database table name (e.g., `PO_HEADERS_ALL`).
*   **Column Usage:** Lists the specific column (e.g., `ATTRIBUTE1`) and its status.

# Technical Architecture
The report joins `FND_TABLES`, `FND_COLUMNS`, and `FND_DESCRIPTIVE_FLEXS` to show the relationship between the physical table structure and the logical flexfield definition.

# Parameters & Filtering
*   **Table Name:** Filter by the database table you are investigating.
*   **Application:** Filter by module (e.g., "Purchasing").

# Performance & Optimization
*   **Metadata Report:** Runs instantly against the data dictionary.

# FAQ
*   **Q: Does this show the values in the columns?**
    *   A: No, this report shows the *definition* of the columns. To see the data, you would need to query the table itself or use the "FND Descriptive Flexfields" report to see the configuration.
