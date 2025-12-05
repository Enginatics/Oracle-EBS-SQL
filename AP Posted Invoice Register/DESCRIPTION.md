# Case Study & Technical Analysis: AP Posted Invoice Register

## 1. Executive Summary

### Business Problem
The "Posting" process (transferring data from Payables to the General Ledger) is the final step in the AP cycle. Finance teams need to verify that all approved invoices have been successfully transferred to the GL to ensure month-end completeness. Standard Oracle reports for this are often rigid, making it hard to reconcile specific GL batches back to the individual invoices that comprise them.

### Solution Overview
The **AP Posted Invoice Register** is a flexible, high-performance alternative to the standard `APXPOINV` report. It lists all AP invoices that have been posted to the General Ledger within a specific period. Crucially, it includes the **GL Batch Name** and **Header ID**, allowing users to seamlessly cross-reference a line in a GL Journal back to the specific AP Invoice Number and Supplier.

### Key Benefits
*   **Reconciliation:** The "Rosetta Stone" between AP and GL. If a GL account balance looks wrong, this report shows exactly which invoices fed into it.
*   **Period Close:** Verifies that all eligible invoices for the period have been posted (Status = 'P').
*   **Drill-Down:** Provides the granular detail (Invoice Line, Distribution Line) behind summarized GL journal entries.

## 2. Technical Analysis

### Core Tables and Views
This report is heavily anchored in the Subledger Accounting (SLA) schema:
*   **`XLA_AE_HEADERS` / `XLA_AE_LINES`**: The source of truth for posted accounting. These tables store the debits and credits exactly as they were sent to GL.
*   **`AP_INVOICES_ALL`**: Provides the operational context (Supplier, Invoice Num).
*   **`GL_JE_BATCHES` / `GL_JE_HEADERS`**: The destination in the General Ledger.
*   **`XLA_TRANSACTION_ENTITIES`**: The bridge table linking the generic SLA engine to the specific AP application.

### SQL Logic and Data Flow
The query starts from the "Accounted" perspective rather than the "Transactional" perspective.
*   **Driver:** `XLA_AE_HEADERS` where `GL_TRANSFER_STATUS_CODE = 'Y'` (Posted).
*   **Join to AP:** Uses `SOURCE_ID_INT_1` in `XLA_TRANSACTION_ENTITIES` to join back to `AP_INVOICES_ALL.INVOICE_ID`.
*   **Filtering:** Filters by `Ledger`, `Period`, and optionally `Account Flexfield` to isolate specific accounts (e.g., Liability or Expense).
*   **Relative Periods:** Supports "Relative Period" parameters (e.g., "Current Period - 1"), making it ideal for automated scheduling.

### Integration Points
*   **General Ledger:** This report is essentially a "Subledger Drilldown" report, mirroring the data found in GL Drilldown pages but in a flat, exportable format.

## 3. Functional Capabilities

### Parameters & Filtering
*   **Period From/To:** Standard date range selection.
*   **GL Batch Name:** Allows users to investigate a specific suspicious batch found in the GL.
*   **Account Flexfield:** Filter for a specific natural account (e.g., "Show me all postings to the 'Office Supplies' account").
*   **Include Zero Amount Lines:** Toggle to show/hide net-zero adjustments.

### Performance & Optimization
*   **Indexed Access:** Querying `XLA_AE_HEADERS` by `PERIOD_NAME` and `LEDGER_ID` leverages the primary partitioning keys of the SLA tables, ensuring rapid retrieval even in high-volume environments.

## 4. FAQ

**Q: Why does this report show different amounts than the "Invoice Register"?**
A: The Invoice Register shows *entered* amounts. This report shows *accounted* amounts. Differences can arise due to exchange rate variances, tax calculations, or SLA rules that modify the accounting derivation.

**Q: Can I see unposted invoices here?**
A: No, this report is specifically for *Posted* items. Use the "Unaccounted Transactions" report for items stuck in AP.

**Q: What is the "Pivot" template?**
A: The Pivot template summarizes the data by Account and Currency, mimicking the "Summarize Report = Yes" option in the standard Oracle report, but with the ability to drill down in Excel.
