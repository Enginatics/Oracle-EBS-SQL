# Executive Summary
The **FA Tax Reserve Ledger** is a critical report for tax reporting, specifically designed to reconcile the tax book's depreciation reserve. It ensures that the accumulated depreciation for tax purposes is accurately recorded and matches the tax ledger.

# Business Challenge
*   **Tax Compliance:** Meeting the strict reporting requirements of tax authorities.
*   **Deferred Tax Calculation:** Providing the data needed to calculate deferred tax assets or liabilities (the difference between book and tax depreciation).
*   **Audit Readiness:** Having a clear, detailed ledger of tax depreciation for auditors.

# The Solution
This Blitz Report mirrors the standard `FAS480_XML` report but delivers it in Excel for easier analysis:
*   **Tax Book Focus:** Specifically targets tax books, which often have different depreciation rules than corporate books.
*   **Fiscal Year Alignment:** Respects the fiscal year definitions associated with the tax book.
*   **Detailed Listing:** Shows the reserve movement for each asset within the tax book.

# Technical Architecture
The report uses `FA_RESERVE_LEDGER_GT` to capture the depreciation run details. It joins with `FA_FISCAL_YEAR` to ensure the reporting period aligns with the tax year, which may differ from the corporate fiscal year.

# Parameters & Filtering
*   **Book:** The tax depreciation book.
*   **Period:** The period to report on.

# Performance & Optimization
*   **Run Timing:** Should be run after the tax book depreciation is closed for the period.
*   **Data Volume:** Tax books often contain the same assets as corporate books, so data volume is similar.

# FAQ
*   **Q: Can I run this for a corporate book?**
    *   A: Yes, technically, but the "Journal Entry Reserve Ledger" is usually preferred for corporate books. This report is labeled "Tax" to indicate its typical use case.
*   **Q: Why are the amounts different from the Corporate book?**
    *   A: Tax books usually use accelerated depreciation methods (like MACRS) compared to straight-line in corporate books, leading to different reserve balances.
