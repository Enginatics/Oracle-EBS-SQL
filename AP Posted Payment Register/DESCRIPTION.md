# Case Study & Technical Analysis: AP Posted Payment Register

## 1. Executive Summary

### Business Problem
Cash reconciliation is a critical control function. Treasury and Accounting teams need to verify that the payments recorded in the bank statement match the payments posted to the General Ledger "Cash" and "Cash Clearing" accounts. Discrepancies here can indicate fraud, data corruption, or configuration errors in the posting program.

### Solution Overview
The **AP Posted Payment Register** provides a detailed audit trail of all Payables payments (Checks, Wires, EFTs) that have been transferred to the General Ledger. It serves as the counterpart to the Posted Invoice Register, focusing on the "Credit" side of the liability and the "Debit/Credit" to Cash. It allows users to group payments by Bank Account, Payment Document (Check Stock), or GL Batch.

### Key Benefits
*   **Bank Reconciliation:** Validates that the total credits to the GL Cash Account match the total payments issued from the Bank Account.
*   **Audit Proof:** Provides a list of every payment included in a specific GL Journal Entry.
*   **Cash Flow Analysis:** Helps analyze cash outflows by currency and payment method.

## 2. Technical Analysis

### Core Tables and Views
*   **`XLA_AE_HEADERS` / `XLA_AE_LINES`**: The accounting repository.
*   **`AP_CHECKS_ALL`**: The payment header table (despite the name, it covers all payment methods).
*   **`AP_CHECK_STOCKS_ALL`**: Provides details on the payment document (e.g., "Check Stock A").
*   **`CE_BANK_ACCOUNTS`**: Bank account details.

### SQL Logic and Data Flow
*   **Entity Type:** The query filters `XLA_TRANSACTION_ENTITIES` for Entity Code `AP_PAYMENTS`.
*   **Linkage:** `XLA_AE_HEADERS` -> `XLA_TRANSACTION_ENTITIES` -> `AP_CHECKS_ALL`.
*   **Account Derivation:** The report pulls the Code Combination ID from `XLA_AE_LINES` to show the actual account hit (Cash, Cash Clearing, or Liability), which is crucial since SLA rules can override the default bank accounts.

### Integration Points
*   **Cash Management (CE):** The Bank Account details link this report to the Cash Management module.
*   **General Ledger:** Ties directly to GL Journals sourced from Payables Payments.

## 3. Functional Capabilities

### Parameters & Filtering
*   **Bank Account:** Filter payments by the source bank account.
*   **Payment Currency:** Isolate payments made in specific currencies.
*   **GL Batch Name:** Trace a specific GL batch back to its payments.
*   **Include Manual Entries:** Option to include manual GL adjustments (though rare for subledger feeds).

### Performance & Optimization
*   **SLA Architecture:** By querying SLA tables directly, the report avoids the complex and slow logic of reconstructing accounting from raw AP distribution tables (`AP_PAYMENT_HISTORY_ALL`), which was the method in older Oracle versions (11i).

## 4. FAQ

**Q: Why do I see two lines for one payment?**
A: You are likely seeing the Debit to the Liability Account and the Credit to the Cash/Cash Clearing Account. This is the double-entry accounting representation of the payment.

**Q: Does this include voided payments?**
A: Yes, if the void has been posted. A voided payment will typically show reversing entries (Debiting Cash, Crediting Liability).

**Q: How does this help with "Cash Clearing"?**
A: By filtering for the "Cash Clearing" account, you can see exactly which payments are currently in transit (issued but not yet cleared at the bank, if using Cash Clearing accounting).
