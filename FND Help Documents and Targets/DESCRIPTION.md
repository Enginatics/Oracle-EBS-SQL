# Executive Summary
The **FND Help Documents and Targets** report lists the custom help files and targets registered in the Oracle EBS Help System.

# Business Challenge
*   **Training Support:** Verifying that custom help documents are properly linked to application screens.
*   **Content Management:** Reviewing the list of uploaded help files to identify obsolete content.

# The Solution
This Blitz Report lists the help configuration:
*   **Application:** The owning application.
*   **Target:** The link target (used to call help from a form).
*   **File Data:** Can optionally show the content of the help file.

# Technical Architecture
The report queries `FND_HELP_DOCUMENTS` and `FND_HELP_TARGETS`.

# Parameters & Filtering
*   **Application Name:** Filter by module.
*   **Show File Data:** Toggle to include the BLOB/CLOB content (use with caution).

# Performance & Optimization
*   **Large Data:** Avoid "Show File Data" unless you are looking for a specific document, as it can pull large amounts of text.

# FAQ
*   **Q: Is this commonly used?**
    *   A: Less so in modern R12 environments where UPK or external knowledge bases are preferred, but still relevant for legacy help customizations.
