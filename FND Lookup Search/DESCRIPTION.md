# Executive Summary
The **FND Lookup Search** report is a developer utility designed to reverse-engineer lookup codes. It helps find the correct `LOOKUP_TYPE` for a given column in a table.

# Business Challenge
*   **Data Mapping:** When writing SQL queries, you often see a code (e.g., 'S') in a column but don't know which Lookup Type decodes it to 'Standard'.
*   **Legacy Analysis:** Understanding the data model of older or custom tables.

# The Solution
This Blitz Report analyzes the data in a specific table and column:
*   **Pattern Matching:** It compares the values in your target column against all active Lookup Types in the system.
*   **Recommendation:** It suggests the most likely Lookup Type that matches your data.
*   **SQL Generation:** It generates the SQL join syntax to link your table to `FND_LOOKUP_VALUES`.

# Technical Architecture
The report uses a heuristic approach to match distinct values from the target table with lookup codes.

# Parameters & Filtering
*   **Table Name:** The table you are investigating (e.g., `AP_SUPPLIERS`).
*   **Column Name:** The column containing the code (e.g., `VENDOR_TYPE_LOOKUP_CODE`).

# Performance & Optimization
*   **Analysis Tool:** This is an interactive tool, not a standard report. It runs a dynamic query to find matches.

# FAQ
*   **Q: Does it work for custom lookups?**
    *   A: Yes, it searches all lookups in `FND_LOOKUP_TYPES`.
