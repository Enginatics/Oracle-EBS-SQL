# Executive Summary
The **FND Document Categories** report lists the categories used to classify documents for sequential numbering. In Oracle EBS, a "Category" is the logical bucket that gets assigned a specific sequence.

# Business Challenge
*   **Voucher Numbering:** Verifying that all necessary document types (Invoices, Journals, Payments) have a category defined for sequential numbering.
*   **Audit Compliance:** Ensuring that document categories align with legal reporting requirements (e.g., VAT registers).

# The Solution
This Blitz Report lists the defined categories:
*   **Category Name:** The internal code and user-friendly name.
*   **Table Name:** The table associated with the category (e.g., `AP_INVOICES_ALL`).
*   **Description:** The purpose of the category.

# Technical Architecture
The report queries `FND_DOC_SEQUENCE_CATEGORIES`.

# Parameters & Filtering
*   **Application:** Filter by module (e.g., "Payables", "General Ledger").

# Performance & Optimization
*   **Simple List:** This is a lightweight configuration report.

# FAQ
*   **Q: How do I assign a sequence to a category?**
    *   A: Use the "FND Document Sequence Assignments" report to see the linkage between Categories, Ledgers, and Sequences.
