# Case Study & Technical Analysis: AP Open Items Revaluation

## 1. Executive Summary

### Business Problem
In a multi-currency environment, the value of unpaid invoices fluctuates with exchange rates. Accounting standards require these "monetary liabilities" to be revalued at the closing rate of each financial period. The difference between the booked rate and the closing rate represents an "Unrealized Gain or Loss." Finance teams need a detailed schedule to substantiate this GL entry and to analyze currency exposure.

### Solution Overview
The **AP Open Items Revaluation** report is the standard tool for this analysis. It lists every open foreign currency invoice, its original exchange rate, the new period-end rate, and the resulting variance. Unlike the legacy "Balances" report, this version is optimized for the Subledger Accounting (SLA) architecture, providing a direct link between the operational invoice and the financial impact.

### Key Benefits
*   **Audit Trail:** Provides the line-level detail supporting the high-level Revaluation journal in the General Ledger.
*   **Exposure Analysis:** Allows Treasurers to see total open liability by currency (e.g., "We owe 5M EUR, and the rate moved 2%").
*   **SLA Integration:** Fully aligned with XLA tables to ensure the "Accounted Amount" matches the Trial Balance.

## 2. Technical Analysis

### Core Tables and Views
*   **`AP_OPEN_ITEMS_REVAL_GT`**: The primary driver. This Global Temporary table is populated by the `AP_OPEN_ITEMS_REVAL_PKG` package before the report runs. It contains the calculated revaluation data.
*   **`AP_INVOICES_ALL`**: Joins to provide invoice header details (Invoice Date, Number).
*   **`XLA_AE_LINES` / `XLA_DISTRIBUTION_LINKS`**: Used to trace the original accounting of the invoice to ensure the "Booked" balance is correct.
*   **`GL_DAILY_RATES`**: Source of the revaluation rate.

### SQL Logic and Data Flow
1.  **Initialization:** The user runs the report, which triggers a PL/SQL package to calculate open balances and populate `AP_OPEN_ITEMS_REVAL_GT`.
2.  **Extraction:** The Blitz Report SQL queries this GT table.
3.  **Enrichment:** It joins to `HR_ALL_ORGANIZATION_UNITS` for Operating Unit names and `GL_LEDGERS` for Ledger context.
4.  **Formatting:** The query formats the output to show `Original_Rate`, `Revaluation_Rate`, and `Unrealized_Gain_Loss`.

### Integration Points
*   **General Ledger:** The report is designed to tie out to the GL Revaluation process.
*   **Payables:** Reflects the payment status as of the "Revaluation Period" end date.

## 3. Functional Capabilities

### Parameters & Filtering
*   **Revaluation Period:** Defines the "As Of" date for the analysis.
*   **Rate Type:** The conversion rate type (e.g., Corporate, Spot) used to fetch the closing rate.
*   **Include Up to Due Date:** Allows filtering invoices based on their maturity.
*   **Balancing Segment:** Useful for running revaluation for a specific legal entity or cost center.

### Performance & Optimization
*   **Pre-Calculation:** Because the heavy lifting (balance calculation) is done by the PL/SQL package into a temp table, the extraction SQL is extremely fast and efficient.

## 4. FAQ

**Q: Does this report create accounting entries?**
A: No, this is a *reporting* tool. The actual GL Revaluation journal is created by the "Revalue Balances" program in the General Ledger module. This report explains *why* that journal has that value.

**Q: What happens if an invoice is partially paid?**
A: The report calculates revaluation only on the *remaining* unpaid portion of the invoice.

**Q: Why is the "Unrealized Gain/Loss" zero for some lines?**
A: If the exchange rate hasn't changed between the invoice date and the revaluation date, or if the invoice is in the functional currency, the variance is zero.
