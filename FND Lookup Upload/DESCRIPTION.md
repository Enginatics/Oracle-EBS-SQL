# Executive Summary
The **FND Lookup Upload** report is a dual-purpose tool: it reports on existing Lookups and provides an Excel template to upload changes back to Oracle.

# Business Challenge
*   **Mass Updates:** Adding dozens of new codes to a custom lookup type without manual data entry.
*   **Migration:** Moving lookup configurations from Development to Test.
*   **Translation:** Updating descriptions for multiple languages.

# The Solution
This Blitz Report extracts the lookup definition in a format ready for upload:
*   **Type Definition:** Application, Code, and Description.
*   **Values:** The list of codes, meanings, and descriptions.
*   **Effectivity:** Enabled flag and Start/End dates.

# Technical Architecture
The report queries `FND_LOOKUP_TYPES_VL` and `FND_LOOKUP_VALUES_VL`. It is designed to work with the Blitz Report Upload framework (using the `FNDLOAD` or API mechanism).

# Parameters & Filtering
*   **Lookup Type:** Filter for the specific type you want to edit.
*   **Mode:** "Create/Update" options.

# Performance & Optimization
*   **Upload:** This report is primarily used as a download template for the "FND Lookup Upload" integration.

# FAQ
*   **Q: Can I update System lookups?**
    *   A: Generally no, System lookups are protected by Oracle. You can usually only update User or Extensible lookups.
