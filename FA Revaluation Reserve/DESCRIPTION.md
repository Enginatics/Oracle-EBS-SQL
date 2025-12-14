# Executive Summary
The **FA Revaluation Reserve** report tracks the revaluation reserve account, which holds the unrealized gains or losses from asset revaluations. This is critical for companies that use the revaluation model for fixed assets (common in IFRS and public sector).

# Business Challenge
*   **Revaluation Tracking:** Monitoring the surplus created when an asset is revalued upwards.
*   **Equity Reporting:** The revaluation reserve is often part of Shareholder's Equity; accuracy is paramount.
*   **Amortization:** Tracking the amortization of the revaluation reserve over the asset's life.

# The Solution
This Blitz Report provides a clear view of the revaluation reserve activity:
*   **Movement Analysis:** Shows the beginning balance, revaluation impact, amortization, and ending balance.
*   **Asset Detail:** Links the reserve balance to specific assets.
*   **Compliance:** Supports reporting requirements for jurisdictions allowing asset revaluation.

# Technical Architecture
Equivalent to the standard Revaluation Reserve reports, it uses `FA_BALANCES_REPORT_GT` to calculate the buckets for the revaluation reserve. It tracks the `REVAL_RESERVE` column in the FA books.

# Parameters & Filtering
*   **Book:** The asset book (must be a book where revaluation is enabled).
*   **Period:** The reporting period.

# Performance & Optimization
*   **Revaluation Only:** This report is only relevant for books where revaluation has occurred. If you don't revalue assets, this report will be empty.
*   **Summary Mode:** Use summary mode for high-level equity reporting.

# FAQ
*   **Q: What triggers a change in this reserve?**
    *   A: Running the "Mass Revaluation" program or manually revaluing an asset.
*   **Q: Can the reserve be negative?**
    *   A: Typically, a revaluation reserve represents a gain (credit balance). A loss usually goes to the P&L unless it reverses a previous gain.
