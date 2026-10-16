# Executive Summary
The **CE Cleared Transactions** report is a historical record of all payments and receipts that have successfully cleared the bank. It serves as the definitive proof of payment or receipt for audit and vendor inquiry purposes. By filtering on clearance dates, Treasury teams can analyze the actual timing of cash flows compared to their issuance dates, helping to refine float assumptions.

# Business Challenge
Once a transaction clears the bank, it moves from "In Transit" to "Cleared."
*   **Vendor Inquiries**: Suppliers often ask, "Has check #1234 cleared yet?" This report provides the answer.
*   **Float Analysis**: Understanding the average time it takes for a check to clear (e.g., 3 days vs. 7 days) is essential for accurate cash forecasting.
*   **Audit Evidence**: Auditors require a list of cleared transactions to verify the bank reconciliation.

# Solution
This report lists all transactions with a status of 'CLEARED' within a specified date range.

**Key Features:**
*   **Status Confirmation**: Only includes transactions that have been matched to a bank statement line.
*   **Float Calculation**: By comparing the Transaction Date to the Cleared Date, users can calculate the actual float days.
*   **Batch Summary**: Option to summarize by batch for high-volume environments.

# Architecture
The report queries the subledger tables (`AP_CHECKS_ALL`, `AR_CASH_RECEIPTS`) where the status is 'CLEARED' or 'RECONCILED'.

**Key Tables:**
*   `AP_CHECKS_ALL`: Cleared payments.
*   `AR_CASH_RECEIPTS`: Cleared receipts.
*   `CE_BANK_ACCOUNTS`: The bank account.
*   `CE_STATEMENT_LINES`: The bank statement line that cleared the transaction.

# Impact
*   **Customer Service**: Enables rapid response to vendor and customer payment status inquiries.
*   **Forecasting Refinement**: Provides the historical data needed to calculate accurate float times.
*   **Audit Support**: Generates the detailed transaction lists required for financial audits.
