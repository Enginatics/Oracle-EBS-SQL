# Executive Summary
The **FND Document Sequences** report provides a master list of all defined document sequences in the system, regardless of whether they are currently assigned.

# Business Challenge
*   **Sequence Management:** Monitoring the consumption of sequences to prevent running out of numbers (e.g., hitting the maximum value).
*   **Cleanup:** Identifying old or unused sequences from previous years.
*   **Type Analysis:** Reviewing which sequences are "Gapless" vs. "Automatic".

# The Solution
This Blitz Report details the sequence definition:
*   **Sequence Name:** The name of the sequence object.
*   **Type:** Automatic, Manual, or Gapless.
*   **Initial Value:** The starting number.
*   **Current Value:** The last number generated (from `DBA_SEQUENCES`).

# Technical Architecture
The report queries `FND_DOCUMENT_SEQUENCES` and joins to `DBA_SEQUENCES` to fetch the current state of the database object.

# Parameters & Filtering
*   **Application:** Filter by the owning application.
*   **Table Name:** Filter by the table the sequence is intended for.

# Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

# FAQ
*   **Q: What is the difference between this and the "Assignments" report?**
    *   A: This report lists the *sequences* themselves (the number generators). The "Assignments" report shows *where* those sequences are used (linked to a Category and Ledger).
