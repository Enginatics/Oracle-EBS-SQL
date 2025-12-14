# Executive Summary
The **FND Key Flexfields** report documents the structure of the major accounting and system keys in Oracle EBS (e.g., Accounting Flexfield, Item Category, Asset Key).

# Business Challenge
*   **Chart of Accounts Review:** Documenting the segment structure (Company, Department, Account) for the GL.
*   **System Configuration:** Verifying the setup of Item Categories or Sales Territories.
*   **Validation Analysis:** Checking which value set is attached to each segment of the key.

# The Solution
This Blitz Report details the KFF structure:
*   **Structure:** The name of the structure (e.g., "Operations Accounting Flex").
*   **Segments:** The list of segments, their order, and window prompt.
*   **Validation:** The value set and any specific segment qualifiers (e.g., "Balancing Segment").

# Technical Architecture
The report joins `FND_ID_FLEXS`, `FND_ID_FLEX_STRUCTURES`, and `FND_ID_FLEX_SEGMENTS`. It also links to `FND_SEGMENT_ATTRIBUTE_VALUES` to show qualifiers.

# Parameters & Filtering
*   **Title:** Filter by the flexfield name (e.g., "Accounting Flexfield").
*   **Structure Name:** Filter by a specific chart of accounts structure.

# Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

# FAQ
*   **Q: What is the difference between "Title" and "Code"?**
    *   A: "Title" is the user-friendly name (e.g., "Accounting Flexfield"). "Code" is the internal short code (e.g., "GL#").
