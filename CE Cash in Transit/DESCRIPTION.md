# Executive Summary
The **CE Cash in Transit** report provides a detailed view of cash flows that have been recorded in the subledgers (AP/AR) but have not yet cleared the bank. This "float" is a critical component of liquidity management. The report allows Treasury Managers to see the pipeline of incoming receipts and outgoing payments, enabling more accurate cash positioning and forecasting.

# Business Challenge
Between the time a check is printed or a receipt is recorded and the time it actually clears the bank, the cash is "in transit."
*   **Liquidity Blind Spots**: Ignoring in-transit cash can lead to overdrafts (if outgoing payments clear faster than expected) or idle cash (if receipts are delayed).
*   **Reconciliation Delays**: Large volumes of aged in-transit items often indicate lost checks, failed transmissions, or reconciliation process breakdowns.
*   **Forecasting Accuracy**: To know how much cash will be available tomorrow, you must know what is currently in the banking pipeline.

# Solution
This report aggregates all uncleared transactions from AP, AR, and Payroll, presenting them by Bank Account and Transaction Type.

**Key Features:**
*   **Multi-Source Aggregation**: Combines data from Accounts Payable (Payments), Accounts Receivable (Receipts), and Payroll into a single view.
*   **Aging Analysis**: Helps identify old items that should have cleared by now (e.g., uncashed checks > 90 days).
*   **Drill-Down**: Provides details on the specific Third Party (Supplier/Customer) and transaction numbers.

# Architecture
The report queries the `CE_AVAILABLE_TRANSACTIONS_V` (or similar union views) which pulls data from `AP_CHECKS_ALL`, `AR_CASH_RECEIPTS`, and `PAY_PRE_PAYMENTS`.

**Key Tables:**
*   `AP_CHECKS_ALL`: Uncleared payments.
*   `AR_CASH_RECEIPTS`: Uncleared receipts.
*   `PAY_PRE_PAYMENTS`: Uncleared payroll payments.
*   `CE_BANK_ACCOUNTS`: The bank account associated with the transactions.

# Impact
*   **Cash Visibility**: Provides the "missing link" between book balance and bank balance.
*   **Risk Management**: Highlights potential fraud or operational issues (e.g., uncashed checks).
*   **Working Capital Optimization**: Allows for tighter management of cash buffers by understanding the exact timing of flows.
