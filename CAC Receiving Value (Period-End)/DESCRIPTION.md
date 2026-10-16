# Case Study & Technical Analysis: CAC Receiving Value (Period-End)

## Executive Summary
The **CAC Receiving Value (Period-End)** report is the "Gold Standard" for reconciling the Receiving Inspection account. It calculates the value of all goods (Inventory, Expense, and OSP) that are legally owned by the company (FOB Receipt) but have not yet been delivered to their final destination.

## Business Challenge
*   **Balance Sheet Validation**: The "Receiving Inspection" account is a temporary asset account. It must be supported by a detailed subledger listing.
*   **Audit Compliance**: Auditors require a "Point in Time" valuation. "What was the value on Dec 31st?"
*   **Data Integrity**: Identifying "Stuck" receipts that have been in receiving for months (phantom assets).

## Solution
This report provides the subledger detail.
*   **Coverage**: Includes all Destination Types (Inventory, Expense, Shop Floor).
*   **Rollback**: Accurately calculates the quantity on hand in Receiving as of the period end.
*   **Valuation**:
    *   Inventory Items: Valued at PO Price (usually).
    *   OSP: Valued at PO Price.

## Technical Architecture
*   **Tables**: `rcv_transactions`, `rcv_receiving_sub_ledger` (for historical quantities).
*   **Logic**: Similar to the "Inventory Value Report", it reconstructs the balance by taking the current state and reversing transactions.

## Parameters
*   **Period Name**: (Mandatory) The snapshot date.
*   **Show WIP Outside Processing**: (Mandatory) Toggle for OSP details.

## Performance
*   **Heavy**: This is a major period-end report. It processes the entire history of open receipts.

## FAQ
**Q: Why is there a difference between this and the GL?**
A: Common reasons: Manual journal entries to the GL account, receipts not accrued (Period End Accrual vs. On Receipt), or FX rate differences.
