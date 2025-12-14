# Executive Summary
The **FA Asset Impairments** report provides a detailed listing of asset impairments, supporting financial compliance and accurate asset valuation. It is critical for Finance teams to track reductions in the recoverable amount of fixed assets and ensure the General Ledger reflects true asset values.

# Business Challenge
*   **Regulatory Compliance:** Meeting accounting standards (like IAS 36 or FAS 144) regarding asset impairment.
*   **Financial Accuracy:** Ensuring that the book value of assets does not exceed their recoverable amount.
*   **Audit Trail:** Maintaining a clear record of impairment losses and reversals for audit purposes.

# The Solution
This Blitz Report facilitates impairment management by:
*   **Detailed Reporting:** Listing impairment amounts, net book values, and impairment reasons for each asset.
*   **Cash Generating Units (CGU):** Supporting analysis at the CGU level, which is essential for impairment testing.
*   **Reconciliation:** Helping reconcile impairment postings to the General Ledger.

# Technical Architecture
The report extracts data from `FA_IMPAIRMENTS`, `FA_ADDITIONS_VL`, and `FA_BOOK_CONTROLS`. It links assets to their respective Cash Generating Units via `FA_CASH_GEN_UNITS`. The SQL logic handles both standard and reporting currency (MRC) impairments if applicable.

# Parameters & Filtering
*   **Book:** The depreciation book to analyze.
*   **Start/End Period:** The range of accounting periods for the report.
*   **Impairment:** Filter by specific impairment ID or status.
*   **Cash Generating Unit:** Filter for assets belonging to a specific CGU.

# Performance & Optimization
*   **Period Range:** Run for specific open periods to minimize data volume during month-end close.
*   **Book:** Always specify the corporate or tax book to avoid duplicate data from multiple books.

# FAQ
*   **Q: What is a Cash Generating Unit (CGU)?**
    *   A: A CGU is the smallest identifiable group of assets that generates cash inflows that are largely independent of the cash inflows from other assets or groups of assets.
*   **Q: Does this report show reversed impairments?**
    *   A: Yes, depending on the status and period selected, it can show impairment reversals.
