# Executive Summary
The **FND Flex Value Hierarchy** report visualizes the parent-child relationships within your Chart of Accounts or other hierarchical value sets. It is essential for validating financial reporting structures (FSGs).

# Business Challenge
*   **FSG Troubleshooting:** Debugging why a financial report is missing data (often due to a new child value not being added to the parent range).
*   **Orphan Analysis:** Finding child values that are not included in any parent node.
*   **Structure Validation:** Ensuring that parent ranges do not overlap incorrectly.

# The Solution
This Blitz Report performs a tree-walk of the hierarchy:
*   **Tree Structure:** Shows the Parent -> Child relationship at multiple levels.
*   **Range Definition:** Displays the Low and High values for each parent node.
*   **Flattened View:** Can show a flattened list of all child values rolling up to a specific parent.

# Technical Architecture
The report uses `FND_FLEX_VALUE_NORM_HIERARCHY` for the range definitions and `FND_FLEX_VALUE_HIERARCHIES` for the compiled hierarchy.

# Parameters & Filtering
*   **Flex Value Set:** The specific segment (e.g., "Company" or "Account").
*   **Parents without Child only:** A powerful validation filter to find empty parent nodes.
*   **Show Child Values:** Toggle to expand ranges into individual child values.

# Performance & Optimization
*   **Recursion:** The report uses recursive SQL to walk the tree. For very deep hierarchies, it may take a moment to run.

# FAQ
*   **Q: Why doesn't my new account show up in the FSG?**
    *   A: Run this report for the parent value used in the FSG. If the new account falls outside the defined ranges, it won't be included.
