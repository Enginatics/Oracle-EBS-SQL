# Executive Summary
The **FND Concurrent Programs and Executables 11i** report is the legacy version of the program definition report, specifically tailored for the Oracle E-Business Suite 11i data model.

# Business Challenge
*   **Legacy Support:** Maintaining documentation for older 11i environments.
*   **Upgrade Analysis:** Comparing program definitions between 11i and R12 during an upgrade project.

# The Solution
This Blitz Report provides the same detailed breakdown as the R12 version but is optimized for the 11i schema:
*   **Program Definitions:** Executable, Output Format, and Print Style.
*   **Parameter Details:** Value sets, defaults, and prompts.

# Technical Architecture
The query structure is similar to the R12 version but accounts for schema differences present in the 11i version of `FND` tables.

# Parameters & Filtering
*   **Program Name:** Filter by specific program.
*   **Application:** Filter by module.

# Performance & Optimization
*   **Usage:** Only use this report if you are running on an 11i instance. For R12, use the standard "FND Concurrent Programs and Executables" report.

# FAQ
*   **Q: Will this work on R12?**
    *   A: It might run, but some columns or joins may be deprecated. Always use the version matching your EBS release.
