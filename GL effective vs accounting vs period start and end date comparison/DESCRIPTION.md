# GL effective vs accounting vs period start and end date comparison - Case Study & Technical Analysis

## Executive Summary
The **GL effective vs accounting vs period start and end date comparison** report is a technical diagnostic tool designed for developers and system administrators. It analyzes the temporal relationships between three critical dates in the General Ledger: the Effective Date, the Accounting Date, and the Period Start/End Dates. By identifying discrepancies (e.g., an effective date falling outside the accounting period), this report helps diagnose data integrity issues, period close problems, and potential reporting inconsistencies.

## Business Use Cases
*   **Data Integrity Audit**: Identifies transactions where the "Effective Date" (when the business event occurred) does not align with the "Accounting Date" (when it was recorded in the books), which can impact aging reports and interest calculations.
*   **Period Close Troubleshooting**: Helps resolve "unprocessed" or "stuck" journals during month-end by highlighting entries that technically fall outside the open period's date range.
*   **SLA vs. GL Reconciliation**: Assists in reconciling Subledger Accounting (SLA) entries to GL by verifying that date logic was applied consistently during the transfer process.
*   **Developer Diagnostics**: Provides a quick way for developers to understand the distribution of date mismatches across ledgers and periods when debugging custom reports or interfaces.

## Technical Analysis

### Core Tables
*   `GL_JE_HEADERS`: Stores the `DEFAULT_EFFECTIVE_DATE` and `POSTED_DATE`.
*   `GL_JE_LINES`: Stores the `EFFECTIVE_DATE` at the line level.
*   `GL_PERIODS`: Defines the `START_DATE` and `END_DATE` for each accounting period.
*   `XLA_AE_LINES`: (Optional/Contextual) Used if tracing back to the subledger accounting layer.
*   `GL_IMPORT_REFERENCES`: Links GL lines to their source in XLA.

### Key Joins & Logic
*   **Date Comparison Logic**: The core logic involves comparing `GL_JE_LINES.EFFECTIVE_DATE` against `GL_PERIODS.START_DATE` and `GL_PERIODS.END_DATE`.
*   **Counting Discrepancies**: The report likely aggregates data to count how many records have an effective date *before* the period start or *after* the period end.
*   **Ledger Context**: Joins to `GL_LEDGERS` to ensure the analysis is specific to a legal entity or set of books.

### Key Parameters
*   **Number Of History Days**: A parameter to limit the lookback period for the analysis, ensuring performance and relevance.
