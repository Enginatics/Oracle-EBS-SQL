# Executive Summary
The **FND Flex Values** report is the standard master data report for segment values. It lists every value in an Independent or Dependent value set, along with its attributes and hierarchy status.

# Business Challenge
*   **Master Data Management:** Reviewing the list of active Cost Centers, Accounts, or Products.
*   **Hierarchy Maintenance:** Identifying "Orphan" values that are missing from a parent hierarchy (using the "Missing in Hierarchy" parameter).
*   **Attribute Audit:** Checking settings like "Allow Budgeting" or "Allow Posting" for GL accounts.

# The Solution
This Blitz Report extracts the value definition:
*   **Value:** The code and description.
*   **Status:** Enabled/Disabled, Start/End Dates.
*   **Attributes:** Segment qualifiers (Account Type, Reconcile, etc.).
*   **Hierarchy:** Shows if the value is a Parent or Child and which Rollup Group it belongs to.

# Technical Architecture
The report queries `FND_FLEX_VALUES` and `FND_FLEX_VALUES_TL`. It also checks `FND_FLEX_VALUE_NORM_HIERARCHY` to determine hierarchy status.

# Parameters & Filtering
*   **Flex Value Set:** The set to analyze (e.g., "Operations_Account").
*   **Missing in Hierarchy:** A critical filter for GL maintenance. It finds values that exist but are not rolled up to any parent.
*   **Active only:** Filter out disabled values.

# Performance & Optimization
*   **Volume:** For very large charts of accounts, filter by a specific range or value set to keep the report manageable.

# FAQ
*   **Q: How do I see the "Compiled" attributes?**
    *   A: The report shows the raw attributes stored in `COMPILED_VALUE_ATTRIBUTES`. These are often decoded into readable columns like "Account Type".
