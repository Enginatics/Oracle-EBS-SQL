# Executive Summary
The **CE Bank Transaction Codes Listing** report provides a reference list of all transaction codes configured in the system for bank statement processing. These codes (e.g., "115" for Lockbox Deposit, "495" for Outgoing Wire) are the language the bank uses to describe transactions. Mapping these codes correctly to Oracle Transaction Types is the foundation of the Auto-Reconciliation process. This report helps verify that the system is configured to understand the electronic bank statements it receives.

# Business Challenge
Banks use standard (BAI2, SWIFT) or proprietary codes to identify transaction types. If Oracle doesn't know what "Code 501" means, it cannot automatically match that line to a payment or receipt.
*   **Auto-Reconcilition Failure**: Missing or incorrect code mappings force users to manually reconcile transactions.
*   **Configuration Drift**: Over time, as new accounts are added, transaction code mappings might not be copied or updated consistently.
*   **Bank Changes**: Banks occasionally update their code sets, requiring a system audit to ensure alignment.

# Solution
This report lists the defined transaction codes for each bank account, showing the code, description, and the Oracle Transaction Type it maps to.

**Key Features:**
*   **Account-Level Detail**: Shows mappings specific to each bank account (since different banks use different codes).
*   **Type Mapping**: Displays how the bank code translates to an Oracle type (e.g., "Code 475" = "Payment").
*   **Verification**: Used to audit the setup before going live with a new bank interface.

# Architecture
The report queries `CE_TRANSACTION_CODES_V` which holds the mapping rules.

**Key Tables:**
*   `CE_TRANSACTION_CODES_V`: The definition of bank codes and their mapping.
*   `CE_BANK_ACCOUNTS`: The bank account the codes belong to.
*   `CE_LOOKUPS`: For descriptions of the Oracle transaction types.

# Impact
*   **Automation Rates**: Accurate code mapping is the primary driver of high auto-reconciliation rates.
*   **Setup Validation**: Essential for testing and validating new bank implementations.
*   **Maintenance**: Simplifies the process of updating mappings when a bank changes its file format specifications.
