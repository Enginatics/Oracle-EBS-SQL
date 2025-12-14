# Executive Summary
The **FND Concurrent Programs and Executables** report is the definitive documentation tool for all concurrent programs in the system. It provides a complete technical specification of each program, including its executable logic, parameters, and value sets.

# Business Challenge
*   **Documentation:** Keeping technical documentation up to date with system changes.
*   **Impact Analysis:** Identifying all programs that use a specific PL/SQL package or value set before making changes.
*   **Cleanup:** Finding obsolete or disabled programs that clutter the system.

# The Solution
This Blitz Report extracts the full definition of concurrent programs:
*   **Full Hierarchy:** Links the Program -> Executable -> Execution File (e.g., PL/SQL package name).
*   **Parameter Detail:** Lists every parameter, its sequence, prompt, and associated value set.
*   **Output Configuration:** Shows the default output format (Text, PDF, XML) and print style.

# Technical Architecture
The report joins `FND_CONCURRENT_PROGRAMS`, `FND_EXECUTABLES`, and `FND_DESCR_FLEX_COL_USAGE` (for parameters). It provides a flattened view where header information is repeated for each parameter row.

# Parameters & Filtering
*   **Program Name:** Search by user-friendly name or short code.
*   **Execution File:** Find all programs that call a specific SQL script or package.
*   **Show Parameters:** Toggle to show detailed parameter rows or just the program header.

# Performance & Optimization
*   **Data Volume:** There are thousands of standard programs. Always filter by Application or Name to avoid a massive export.

# FAQ
*   **Q: Can I see the SQL code of the program?**
    *   A: This report gives the *name* of the execution file (e.g., `XX_MY_PKG`). You would need a separate tool or SQL developer to view the package code itself.
*   **Q: Does it show Request Groups?**
    *   A: No, this report focuses on the program definition. Use "FND Request Groups" to see where the program is assigned.
