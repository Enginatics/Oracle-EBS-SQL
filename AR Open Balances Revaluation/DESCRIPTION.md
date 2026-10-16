# AR Open Balances Revaluation - Case Study & Technical Analysis

## Executive Summary

The **AR Open Balances Revaluation** report is a key financial closing tool for multinational organizations. It calculates the unrealized foreign exchange (FX) gains or losses on outstanding customer invoices. Accounting standards (such as US GAAP and IFRS) mandate that monetary assets denominated in foreign currencies be revalued at the end of each reporting period using the closing exchange rate. This report provides the supporting detail for these adjustments.

## Business Challenge

When an invoice is issued in a foreign currency (e.g., EUR) but the company's books are kept in another (e.g., USD), the value of that receivable fluctuates with the exchange rate.
*   **Volatility:** Significant currency swings can materially impact the balance sheet.
*   **Compliance:** Failure to revalue open balances results in incorrect asset valuation and violates accounting principles.
*   **Complexity:** Manually tracking the original rate vs. the current rate for thousands of open invoices and partial payments is prone to error.

## Solution

The **AR Open Balances Revaluation** report automates the valuation process by:
*   **Snapshotting:** Identifying all open receivables as of a specific "As of Date."
*   **Rate Comparison:** Retrieving the original exchange rate used at the time of the transaction and comparing it to the closing rate for the period.
*   **Calculation:** Computing the difference (Unrealized Gain/Loss) for each transaction and summarizing it by currency and account.

## Technical Architecture

The report logic involves simulating the revaluation process without necessarily posting it.

### Key Tables & Joins

*   **Open Balances:** `AR_PAYMENT_SCHEDULES` contains the remaining amount due for each invoice.
*   **Transaction Details:** `RA_CUSTOMER_TRX` provides the original exchange rate and currency code.
*   **Market Rates:** `GL_DAILY_RATES` is queried to find the exchange rate for the "As of Date" based on the selected Rate Type (e.g., Corporate, Spot).
*   **Accounting:** `GL_CODE_COMBINATIONS` and `XLA_AE_LINES` may be referenced to determine the Receivables account associated with the transaction.

### Logic

1.  **Selection:** Finds all transactions with a non-zero balance as of the parameter date.
2.  **Rate Retrieval:** Looks up the revaluation rate. If a rate is missing for the specific date, it may look back to the last available rate depending on configuration.
3.  **Computation:**
    $$ \text{Revalued Amount} = \text{Open Foreign Amount} \times \text{Revaluation Rate} $$
    $$ \text{Unrealized Gain/Loss} = \text{Revalued Amount} - \text{Open Functional Amount} $$

## Parameters

*   **As of Date:** The valuation date (usually the last day of the month).
*   **Exchange Rate Type:** The rate type to use for revaluation (e.g., 'Month End', 'Corporate').
*   **Currency:** Option to run for a specific currency or all currencies.
*   **Include Domestic Invoices:** Typically set to 'No', as domestic transactions do not generate FX gains/losses unless the functional currency differs from the reporting currency.

## FAQ

**Q: Does this report post entries to the GL?**
A: No, this is a reporting tool. The actual "Revaluation" process in the General Ledger or the "Revaluation" program in AR is responsible for creating the journal entries. This report is used to validate those figures.

**Q: Why is the revaluation rate missing?**
A: If the report shows a missing rate, ensure that the Daily Rates are defined in the General Ledger for the "As of Date" and the selected "Exchange Rate Type."

**Q: How are partial payments handled?**
A: The report revalues only the *remaining* open balance of the invoice, not the original full amount.
