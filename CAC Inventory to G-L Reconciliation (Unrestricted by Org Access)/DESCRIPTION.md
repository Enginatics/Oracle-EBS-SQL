# Case Study & Technical Analysis: CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)

## Executive Summary
The **CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)** report is the "Super User" version of the reconciliation tool. It provides a global view of the alignment between the General Ledger and the Inventory Subledger across all organizations and ledgers. This report is typically used by Corporate Controllers or Shared Service Centers to validate the month-end close for the entire enterprise.

## Business Challenge
Corporate Finance needs a holistic view of inventory health.
*   **Global Close**: Verifying that 50 different ledgers are all reconciled requires a tool that cuts across individual org security restrictions.
*   **Intercompany Imbalances**: Often, issues in one org (e.g., an intransit shipment) cause imbalances in another. A restricted view hides this relationship.
*   **Efficiency**: Running 50 separate reports for 50 orgs is inefficient.

## Solution
This report bypasses standard org security to provide a consolidated view.
*   **Global Scope**: Can be run for "All Ledgers" or a specific Ledger Set.
*   **Full Reconciliation**: Matches GL Balances to the sum of On-hand, Intransit, WIP, and Receiving.
*   **Account Discovery**: Automatically identifies the valuation accounts based on the Costing Method and Org Parameters, reducing setup time.

## Technical Architecture
Identical to the "Restricted" version but without the security predicates:
*   **Data Sources**: `gl_balances`, `cst_period_close_summary`, `wip_period_balances`, `rcv_receiving_sub_ledger`.
*   **Logic**: Aggregates subledger data by GL Account and compares it to the GL Balance for that same account.

## Parameters
*   **Period Name**: (Mandatory) The period to reconcile.
*   **Ledger**: (Optional) Leave blank for all.

## Performance
*   **High Volume**: Running this for "All Ledgers" in a massive environment can be slow. It is best to run it by Ledger or Ledger Set.

## FAQ
**Q: Who should use this report?**
A: Corporate Controllers, System Administrators, or Central Finance users. Plant-level users should use the Restricted version.

**Q: Does it show manual journal entries?**
A: Yes, manual JEs to the inventory account will appear in the GL balance but not the subledger, causing a variance. This is a common finding.

**Q: Can I see the variance by Item?**
A: No, this is an Account-level reconciliation. For Item-level detail, use the "Inventory Out-of-Balance" report.
