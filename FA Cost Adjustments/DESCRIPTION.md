# Executive Summary
The **FA Cost Adjustments** report provides a detailed audit trail of all changes made to asset costs within a specified period. It is essential for verifying that cost adjustments—whether from invoice additions, manual adjustments, or revaluations—are correctly recorded and approved.

# Business Challenge
*   **Audit Trail:** Tracking who changed an asset's cost and why.
*   **Financial Accuracy:** Ensuring that cost adjustments are reflected in the depreciation base.
*   **Invoice Reconciliation:** Matching cost adjustments back to the source AP invoices.

# The Solution
This Blitz Report enhances the standard cost adjustment tracking by:
*   **Source Details:** Optionally showing the specific invoice lines that drove the cost change.
*   **Transaction Context:** Linking the adjustment to the specific transaction type (e.g., ADDITION, ADJUSTMENT).
*   **Supplier Visibility:** Displaying supplier information for invoice-related adjustments.

# Technical Architecture
Based on `FAS840_XML`, the report queries `FA_TRANSACTION_HEADERS` for cost-impacting transactions. It joins `FA_ASSET_INVOICES` and `AP_SUPPLIERS` to provide the upstream source document details when requested.

# Parameters & Filtering
*   **Book:** The asset book.
*   **Period Range:** The time window for the adjustments.
*   **Show Source Invoice Details:** A toggle to include granular invoice data.

# Performance & Optimization
*   **Invoice Details:** Enabling "Show Source Invoice Details" adds significant volume to the report; use only when detailed reconciliation is needed.
*   **Period Range:** Keep the range narrow (e.g., current period) for month-end validation.

# FAQ
*   **Q: Does this show mass additions?**
    *   A: Yes, if the mass addition resulted in a cost adjustment or new asset cost.
*   **Q: Why is the cost adjustment negative?**
    *   A: A negative adjustment typically indicates a credit memo or a manual reduction in asset value.
