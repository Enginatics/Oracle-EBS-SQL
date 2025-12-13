# Executive Summary
The **CST Period Close Subinventory Value** report provides a historical snapshot of inventory value at the subinventory level, specifically aligned with the accounting period close. Unlike real-time on-hand reports, this report is designed to match the General Ledger balance for a closed period. It is a critical tool for the month-end reconciliation process.

# Business Challenge
*   **GL Reconciliation**: The GL Inventory account balance is a single number. To validate it, Finance needs a detailed breakdown that sums up to exactly that number for the *closed* period.
*   **Backdated Transactions**: Real-time reports change constantly. This report captures the value as it stood at the period end, respecting the accounting date of transactions.
*   **Subinventory Analysis**: Understanding which storage locations held the value at month-end.

# Solution
This report lists the inventory value by subinventory for a specific closed period.

**Key Features:**
*   **Period-Based**: Parameters are driven by the Accounting Period (e.g., "Jan-24"), ensuring alignment with the GL.
*   **Historical Accuracy**: Uses the period-end snapshot data.
*   **Category Grouping**: Can group items by category for high-level analysis.

# Architecture
The report queries the `CST_PERIOD_CLOSE_SUMMARY` table, which is populated by the Period Close process.

**Key Tables:**
*   `CST_PERIOD_CLOSE_SUMMARY`: Stores the summarized value of inventory at period close.
*   `ORG_ACCT_PERIODS`: Defines the accounting periods.
*   `MTL_SECONDARY_INVENTORIES`: Subinventory definitions.

# Impact
*   **Audit Compliance**: Provides the "Sub-Ledger" detail required to support the General Ledger inventory balance.
*   **Reconciliation Speed**: Drastically reduces the time spent investigating differences between the GL and the perpetual inventory records.
*   **Trend Analysis**: Allows for month-over-month comparison of inventory levels by location.
