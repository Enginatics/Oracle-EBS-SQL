# Executive Summary
The **FA Asset Register** is a fundamental report for fixed asset management, providing a comprehensive listing of all assets in a book. It serves as the primary source of truth for asset details, including cost, depreciation, location, and invoice information.

# Business Challenge
*   **Asset Visibility:** Difficulty in getting a complete picture of an asset's financial and physical attributes in one place.
*   **Reconciliation:** Needing a detailed subledger report to reconcile with General Ledger balances.
*   **Data Integrity:** Verifying that all capitalized assets have the correct depreciation method and life assigned.

# The Solution
This Blitz Report enhances the standard Asset Register by:
*   **Comprehensive Data:** Combining asset header, book, distribution, and invoice data into a single view.
*   **Flexible Detail Levels:** Allowing users to toggle details for depreciation, distributions, and invoices.
*   **Excel Analysis:** Enabling pivot tables to summarize cost by category, location, or cost center.

# Technical Architecture
The report mimics the `FAS600_XML` standard report. It joins `FA_ADDITIONS` (header), `FA_BOOKS` (financials), `FA_DISTRIBUTION_HISTORY` (assignments), and `FA_ASSET_INVOICES` (source). It handles the complexity of showing current vs. historical data based on the selected period.

# Parameters & Filtering
*   **Book:** The depreciation book (Required).
*   **Asset Number Range:** To run for specific assets.
*   **Show Details:** Flags to include/exclude Depreciation, Distribution, and Invoice details.

# Performance & Optimization
*   **Detail Flags:** Turn off "Show Invoice Details" or "Show Distribution Details" if you only need high-level financial data to speed up execution.
*   **Asset Range:** Use for targeted analysis of specific assets rather than running the full book.

# FAQ
*   **Q: Why is the report output so wide?**
    *   A: It includes detailed sections for distributions and invoices, which adds many columns. You can hide unused columns in Blitz Report.
*   **Q: Does this show fully retired assets?**
    *   A: It typically shows assets active during the requested period or fiscal year.
