# Executive Summary
The **FND Lookup Values** report is the standard dictionary for all lookup codes in the system. It allows you to search for codes, meanings, or descriptions across all lookup types.

# Business Challenge
*   **Configuration Review:** Checking the list of available values for a dropdown list (e.g., "Payment Terms" or "Vendor Types").
*   **Translation Gap Analysis:** Finding lookup codes that are missing translations in a multi-language environment.
*   **Search:** Finding which Lookup Type contains a specific code (e.g., finding where 'NET30' is defined).

# The Solution
This Blitz Report lists the full lookup definition:
*   **Type:** The parent Lookup Type.
*   **Code:** The internal code stored in the database.
*   **Meaning:** The user-visible text.
*   **Description:** Additional details.
*   **Effectivity:** Start/End dates and Enabled flag.

# Technical Architecture
The report queries `FND_LOOKUP_TYPES_VL` and `FND_LOOKUP_VALUES`. It handles the language join to show translations.

# Parameters & Filtering
*   **Type:** Filter by the specific lookup type (e.g., `YES_NO`).
*   **Meaning contains:** Search for a specific text string across all lookups.
*   **Missing Translation to Lang Code:** A powerful filter to find codes that exist in the base language but not in the target language.

# Performance & Optimization
*   **Volume:** There are thousands of lookup types. Always filter by Type or Application to avoid a massive export.

# FAQ
*   **Q: Can I see System lookups?**
    *   A: Yes, this report shows all lookups (System, User, and Extensible).
