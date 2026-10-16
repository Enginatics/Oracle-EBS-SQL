# Executive Summary
The **FA Asset Retirements** report details assets that have been retired or sold during a specific period. It is essential for calculating gains and losses on disposal and ensuring that retired assets are removed from the active depreciation schedule.

# Business Challenge
*   **Gain/Loss Calculation:** Accurately determining the financial impact of asset disposals.
*   **Tax Reporting:** Reporting asset disposals correctly for tax purposes.
*   **Clean Register:** Preventing "zombie assets" (retired but still on books) from inflating insurance premiums or tax liabilities.

# The Solution
This Blitz Report streamlines retirement analysis by:
*   **Gain/Loss Visibility:** Clearly showing the Proceeds of Sale, Cost of Removal, and resulting Gain/Loss.
*   **Retirement Types:** Distinguishing between sales, thefts, or casual retirements.
*   **Period-End Processing:** assisting in the month-end close process by validating all retirement transactions.

# Technical Architecture
Based on `FAS440_XML`, the report queries `FA_RETIREMENTS` and joins with `FA_BOOKS` to get the Net Book Value at the time of retirement. It calculates the gain/loss based on the formula: `Proceeds - Cost of Removal - Net Book Value`.

# Parameters & Filtering
*   **Book:** The depreciation book.
*   **From/To Period:** The period range when the retirement occurred.

# Performance & Optimization
*   **Period Range:** Keep the range consistent with your financial reporting cycle (e.g., monthly or quarterly).
*   **Currency:** Ensure the correct currency is selected if working in a multi-currency environment.

# FAQ
*   **Q: What happens if I reinstate a retirement?**
    *   A: Reinstatements are typically handled as a separate transaction type or by reversing the retirement entry, depending on how the report filters status.
*   **Q: Does this include partial retirements?**
    *   A: Yes, it shows both full and partial retirements, with the retired cost portion displayed.
