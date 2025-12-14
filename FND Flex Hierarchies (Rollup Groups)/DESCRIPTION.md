# Executive Summary
The **FND Flex Hierarchies (Rollup Groups)** report documents the Rollup Groups defined for value sets. Rollup Groups are used to create summary accounts in General Ledger or to group values for reporting purposes.

# Business Challenge
*   **Summary Account Management:** Verifying which rollup groups exist before creating new summary templates.
*   **Reporting Structure:** Understanding how values are grouped for high-level financial reporting.

# The Solution
This Blitz Report lists the Rollup Groups:
*   **Value Set:** The value set the group belongs to.
*   **Rollup Group Name:** The code and description of the group.
*   **Hierarchy:** Shows the relationship between the group and the value set.

# Technical Architecture
The report queries `FND_FLEX_HIERARCHIES_VL` and `FND_FLEX_VALUE_SETS`.

# Parameters & Filtering
*   **None:** The report typically dumps all hierarchies or can be filtered by Value Set in the output.

# Performance & Optimization
*   **Lightweight:** This is a small configuration table.

# FAQ
*   **Q: How do I assign values to these groups?**
    *   A: You assign a Rollup Group to a specific Parent Value in the "Segment Values" form. Use the "FND Flex Values" report to see which values are assigned to which group.
