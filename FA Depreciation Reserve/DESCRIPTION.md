# Executive Summary
The **FA Depreciation Reserve** report provides a snapshot of the accumulated depreciation for assets as of a specific period. It is a key report for reconciling the Accumulated Depreciation account in the General Ledger.

# Business Challenge
*   **GL Reconciliation:** Verifying that the subledger's accumulated depreciation matches the GL balance.
*   **Net Book Value Analysis:** Understanding the remaining life and value of the asset portfolio.
*   **Impairment Tracking:** Seeing the impact of impairments on the reserve.

# The Solution
This Blitz Report offers a robust view of the reserve account:
*   **Roll-Forward Logic:** Shows the beginning balance, additions (depreciation expense), adjustments, and ending balance.
*   **Impairment Visibility:** Optionally includes impairment amounts which reduce the Net Book Value.
*   **Drill-Down:** Can be run at a summary level for reconciliation or detail level for asset analysis.

# Technical Architecture
Equivalent to the standard Reserve Summary/Detail reports, it uses `FA_BALANCES_REPORT_GT` to calculate the movement of the reserve account. It aggregates depreciation expense, retirements, and adjustments to derive the ending reserve.

# Parameters & Filtering
*   **Book:** The depreciation book.
*   **Period:** The "as-of" period for the report.
*   **Show Impairments:** Toggle to display impairment columns.

# Performance & Optimization
*   **Summary vs. Detail:** Use the Summary version for high-level GL checks. Use Detail only when investigating discrepancies.
*   **Currency:** Ensure the correct currency is selected for multi-currency books.

# FAQ
*   **Q: How does this differ from the Account Analysis?**
    *   A: This report focuses specifically on the *Reserve* (Accumulated Depreciation) account and its roll-forward, whereas Account Analysis covers all asset accounts.
*   **Q: Does it show YTD depreciation?**
    *   A: Yes, it typically shows the depreciation expense for the period and the Year-To-Date accumulation.
