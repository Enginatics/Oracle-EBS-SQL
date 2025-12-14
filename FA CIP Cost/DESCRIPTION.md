# Executive Summary
The **FA CIP Cost** report tracks Construction-In-Process (CIP) assets. It details the costs accumulated for assets that are being built or installed but are not yet placed in service. This is crucial for managing capital projects and ensuring timely capitalization.

# Business Challenge
*   **Capital Project Tracking:** Monitoring the spend on ongoing projects.
*   **Timely Capitalization:** Identifying projects that are complete and should be moved to active assets to start depreciation.
*   **Expense vs. Capital:** Verifying that only valid capital costs are accumulating in CIP accounts.

# The Solution
This Blitz Report provides visibility into CIP accounts by:
*   **Summary & Detail:** Offering both high-level project totals and detailed invoice line items.
*   **Aging Analysis:** Helping identify old CIP items that may need write-off or capitalization.
*   **Reconciliation:** Matching CIP subledger balances to the General Ledger CIP account.

# Technical Architecture
Equivalent to the standard CIP Summary/Detail reports, it queries `FA_ADDITIONS` where the asset type is 'CIP'. It sums up the cost from `FA_BOOKS` and details from `FA_ASSET_INVOICES`.

# Parameters & Filtering
*   **Book:** The corporate book used for tracking CIP.
*   **Period:** The reporting period (usually the current open period).

# Performance & Optimization
*   **Clean Up:** Regularly capitalizing or expensing CIP items keeps this report performant and the subledger clean.
*   **Detail Level:** Running in "Detail" mode can produce many rows if there are many small invoices attached to CIP assets.

# FAQ
*   **Q: Do CIP assets depreciate?**
    *   A: No, CIP assets do not depreciate until they are capitalized and placed in service.
*   **Q: How do I move items off this report?**
    *   A: You must perform a "Capitalization" transaction in Oracle Assets to move them from CIP to Capitalized status.
