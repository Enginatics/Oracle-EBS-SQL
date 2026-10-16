# GL Trial Balance - Detail - Case Study & Technical Analysis

## Executive Summary
The **GL Trial Balance - Detail** report is a fundamental financial report that lists the balances of all General Ledger accounts, broken down by their individual segments (Company, Department, Account, etc.). Unlike a summary trial balance, this report provides the granular detail necessary for deep-dive analysis, period-end reconciliation, and audit verification. It serves as the primary "proof" that the books are in balance (Debits = Credits).

## Business Use Cases
*   **Period-End Close**: The primary tool used by accountants to verify that all subledger entries have been posted and that the trial balance nets to zero before closing the period.
*   **Account Reconciliation**: Used to compare the GL balance of a specific account (e.g., "Accounts Payable") against the corresponding subledger report (e.g., "AP Trial Balance") to identify discrepancies.
*   **Audit Support**: Provides external auditors with a complete listing of account balances at the end of the fiscal year.
*   **Variance Analysis**: Allows analysts to compare balances across periods (if run for multiple periods) or to drill down into specific cost centers or departments.

## Technical Analysis

### Core Tables
*   `GL_BALANCES`: The primary source of data, storing the period-to-date and year-to-date balances for every code combination.
*   `GL_CODE_COMBINATIONS`: Resolves the account segments.
*   `GL_LEDGERS`: Defines the currency and chart of accounts context.
*   *(XML Publisher Source)*: This report is often based on the standard Oracle XML Publisher data definition `GLTRBALD`, which uses a package to extract data.

### Key Joins & Logic
*   **Balance Calculation**: The report aggregates `BEGINNING_BALANCE`, `PERIOD_NET_DR`, and `PERIOD_NET_CR` from `GL_BALANCES` to calculate the `ENDING_BALANCE`.
*   **Currency Handling**: It handles "Entered" vs. "Accounted" currencies. For foreign currency accounts, it can show the balance in the original currency (e.g., EUR) as well as the functional currency (e.g., USD).
*   **Translation**: If run for a translated currency, it uses the translated balances.

### Key Parameters
*   **Ledger/Ledger Set**: The entity to report on.
*   **Period**: The specific accounting period.
*   **Currency**: The currency to view (Functional, Foreign, or Translated).
*   **Amount Type**: PTD (Period to Date) or YTD (Year to Date).
