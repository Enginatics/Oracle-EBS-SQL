# Executive Summary
The **CE General Ledger Cash Account Usage** report is a configuration audit tool that maps Bank Accounts to their corresponding General Ledger (GL) Cash Accounts. In Oracle, a single bank account can be linked to multiple GL accounts (e.g., for different currencies or operating units), and conversely, a GL account might be shared. This report visualizes these relationships to ensure that cash activity is being booked to the correct ledger accounts.

# Business Challenge
The link between the Bank Account (Treasury) and the GL Account (Accounting) is defined in the Bank Account Setup.
*   **Mispostings**: If a bank account is mapped to the wrong GL account, cash transactions will be recorded in the wrong place, causing reconciliation nightmares.
*   **Segregation of Duties**: Ensuring that specific bank accounts map to specific GL accounts is often a compliance requirement.
*   **Complexity**: In multi-org environments, the mapping rules can become complex and hard to visualize one screen at a time.

# Solution
This report provides a matrix view of Bank Accounts and their assigned GL Cash Accounts.

**Key Features:**
*   **Bi-Directional Pivot**: Can be viewed by Bank Account (showing all GL accounts used) or by GL Account (showing all Bank Accounts linked).
*   **Currency Visibility**: Shows the currency of both the bank account and the GL account to ensure alignment.
*   **Legal Entity Context**: Groups accounts by Legal Entity to validate ownership.

# Architecture
The report queries `CE_BANK_ACCOUNTS` and joins to `CE_GL_ACCOUNTS_CCID` (or `CE_BANK_ACCT_USES_ALL`) to retrieve the accounting flexfield segments.

**Key Tables:**
*   `CE_BANK_ACCOUNTS`: Bank account definitions.
*   `CE_BANK_ACCT_USES_ALL`: The usage assignment (which links the bank account to a specific Org and GL Account).
*   `GL_CODE_COMBINATIONS`: The GL account details.

# Impact
*   **Configuration Accuracy**: Validates that the Treasury-to-GL mapping is correct.
*   **Reconciliation Readiness**: Ensures that the "GL Balance" used in reconciliation reports is pulling from the correct combination of accounts.
*   **System Cleanup**: Helps identify unused or incorrectly mapped GL accounts.
