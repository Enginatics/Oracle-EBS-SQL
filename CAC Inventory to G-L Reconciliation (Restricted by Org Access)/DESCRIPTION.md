# Case Study & Technical Analysis: CAC Inventory to G/L Reconciliation (Restricted by Org Access)

## Executive Summary
The **CAC Inventory to G/L Reconciliation (Restricted by Org Access)** report is a compliance tool that compares the General Ledger balance to the Perpetual Inventory Subledger value. It is designed for users who have restricted access (e.g., Plant Controllers) and need to reconcile only the organizations they are responsible for. It ensures that the financial statements accurately reflect the physical inventory assets.

## Business Challenge
Reconciliation is the primary control for Inventory accounting.
*   **Subledger Drift**: Inventory is a high-volume module. A single glitch in thousands of transactions can cause the GL to drift from the subledger.
*   **Security**: In large companies, a Plant Controller in Germany should not see the GL balances for the US operations. Standard reports often lack this granular security.
*   **Complexity**: Reconciling involves summing up On-hand, Intransit, WIP, and Receiving inspection values. Doing this manually is prone to error.

## Solution
This report automates the comparison within the user's security context.
*   **GL Balance**: Queries `gl_balances` for the inventory control accounts.
*   **Subledger Value**: Aggregates the period-end snapshot values for On-hand, Intransit, WIP, and Receiving.
*   **Variance Calculation**: Reports the difference. Ideally, it should be zero.

## Technical Architecture
The report combines data from multiple sources:
*   **GL**: `gl_balances` (Actuals).
*   **Inventory**: `cst_period_close_summary` (or `mtl_period_summary`).
*   **WIP**: `wip_period_balances`.
*   **Receiving**: `rcv_receiving_sub_ledger` (or calculated from transactions).
*   **Security**: Applies standard Oracle Org Access security policies to filter the output.

## Parameters
*   **Period Name**: (Mandatory) The closed period to reconcile.
*   **Ledger**: (Optional) The set of books.

## Performance
*   **Summary Level**: It queries summary tables, so it is generally fast.
*   **Drill Down**: If a variance is found, users would switch to the "Inventory Out-of-Balance" report to find the specific item causing it.

## FAQ
**Q: Why is Receiving included?**
A: "Receiving Inspection" is an inventory asset account. Goods received but not yet delivered to stock are an asset that must be reconciled.

**Q: Does it handle Project Manufacturing?**
A: Yes, the logic includes PJM Cost Group accounting if enabled.

**Q: What if I don't have access to the GL?**
A: Then this report will likely return no data for the GL side, or error out. It requires both Inventory and GL access.
