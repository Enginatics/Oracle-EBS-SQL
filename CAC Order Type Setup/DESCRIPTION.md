# Case Study & Technical Analysis: CAC Order Type Setup

## Executive Summary
The **CAC Order Type Setup** report is a configuration audit tool for Oracle Order Management (OM). It documents the setup of Sales Order Transaction Types and their critical links to Accounts Receivable (AR) and the General Ledger (GL). This setup dictates the financial orchestration of the "Order-to-Cash" cycle.

## Business Challenge
*   **Revenue Recognition**: If an Order Type is mapped to the wrong AR Transaction Type, revenue might be recognized immediately instead of being deferred (or vice versa).
*   **COGS Account**: The "Cost of Goods Sold" account is often derived from the Order Type. Errors here lead to incorrect margin analysis by product line.
*   **Invoicing Failures**: "Why didn't this order generate an invoice?" Often, the Order Type is not properly linked to an AR Transaction Type.

## Solution
This report provides a clear map of the configuration.
*   **Mapping**: Shows `Order Type` -> `Line Type` -> `AR Transaction Type`.
*   **Accounting**: Displays the COGS Account and the Revenue Account associated with the types.
*   **Workflow**: Identifies the fulfillment flow (e.g., "Order Flow - Generic").

## Technical Architecture
*   **Tables**: `oe_transaction_types_tl` (OM Types), `ra_cust_trx_types_all` (AR Types), `gl_code_combinations`.
*   **Hierarchy**: Order Management uses a hierarchy where Line Type settings can override Header Type settings. This report typically focuses on the Line Type as it drives the accounting.

## Parameters
*   **Operating Unit**: (Optional) Filter by OU.
*   **Ledger**: (Optional) Filter by Ledger.

## Performance
*   **Fast**: Configuration tables are small.

## FAQ
**Q: What is a "Line Type"?**
A: A Sales Order has a Header (Customer info) and Lines (Item info). The Line Type controls the workflow for the specific item (e.g., "Standard Line", "Return Line", "Bill Only Line").

**Q: Why is the COGS account important here?**
A: In Oracle EBS, the COGS Account Generator often uses the Order Type as a segment source. If this is wrong, your margins are wrong.
