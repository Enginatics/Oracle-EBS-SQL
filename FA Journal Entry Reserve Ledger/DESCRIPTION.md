# Executive Summary
The **FA Journal Entry Reserve Ledger** is a specialized report used to reconcile depreciation expense and the depreciation reserve with the General Ledger. It lists the journal entries created by the depreciation run.

# Business Challenge
*   **Journal Verification:** Ensuring that the depreciation run created the correct journal entries.
*   **Account Balance Proof:** Proving the balance of the Accumulated Depreciation account at the journal line level.
*   **Audit Compliance:** Providing a detailed list of all system-generated depreciation journals.

# The Solution
This Blitz Report replicates the standard `FAS400_XML` report, providing:
*   **Journal Details:** Listing the specific accounts and amounts credited/debited during depreciation.
*   **Asset-Level Granularity:** Showing which assets contributed to each journal line.
*   **Tying to GL:** Serving as the bridge between the FA subledger and GL journal batches.

# Technical Architecture
The report queries `FA_RESERVE_LEDGER_GT`, which is populated during the reporting process to show the breakdown of depreciation by account. It links back to `FA_ADDITIONS` for asset details.

# Parameters & Filtering
*   **Book:** The asset book.
*   **Period:** The period for which depreciation was run.

# Performance & Optimization
*   **Period Specific:** This report is strictly period-based. It is designed to be run after the depreciation close for that period.
*   **Data Volume:** Can be large if there are many assets and complex account distributions.

# FAQ
*   **Q: Why doesn't this match my GL?**
    *   A: Check if the depreciation journals have been posted to GL. Also, check for manual journals in GL that wouldn't be in this report.
*   **Q: Is this the same as the "Journal Entry Reserve Ledger" PDF?**
    *   A: Yes, it is the Excel version of that standard Oracle report.
