# Case Study & Technical Analysis: CAC Receiving Activity Summary

## Executive Summary
The **CAC Receiving Activity Summary** report analyzes the operational flow within the Receiving Dock. It compares "Receipts" (Goods arriving) against "Deliveries" (Goods moving to Stock or WIP). The net difference represents goods sitting in "Receiving Inspection"—physically on the dock but not yet available for use.

## Business Challenge
*   **Bottlenecks**: "We received the raw materials 3 days ago, why can't production use them?" (Answer: They haven't been Delivered/Inspected).
*   **Period-End Cutoff**: Goods received at 11 PM on the last day of the month might not get delivered until the 1st of the next month. This creates a valid balance in the Receiving Inspection account.
*   **Orphaned Receipts**: Items that were received but forgotten and never delivered.

## Solution
This report performs a "Netting" logic.
*   **Inflow**: Sum of `RECEIVE` transactions.
*   **Outflow**: Sum of `DELIVER` and `RETURN TO VENDOR` transactions.
*   **Balance**: `Receive - Deliver - Return` = Remaining in Receiving.

## Technical Architecture
*   **Tables**: `rcv_transactions`, `rcv_shipment_lines`.
*   **Logic**: It matches transactions by `shipment_line_id` to ensure the flow is traced correctly for the specific shipment.

## Parameters
*   **Transaction Date From/To**: (Mandatory) The period to analyze.

## Performance
*   **Fast**: Queries the operational `rcv_transactions` table which is indexed by date.

## FAQ
**Q: Does this match the GL?**
A: It should. The "Remaining in Receiving" value should equal the balance of the Receiving Inspection account for that period.
