# Case Study & Technical Analysis: CAC Subinventory Accounts Setup

## Executive Summary
The **CAC Subinventory Accounts Setup** report is a configuration audit tool for Inventory Valuation. In Oracle EBS, you can track inventory value at the Organization level or the Subinventory level. If using Subinventory-level tracking, this report validates that the GL accounts for each subinventory are defined correctly.

## Business Challenge
*   **Valuation Granularity**: "We want to track 'Raw Materials' separately from 'Finished Goods' on the Balance Sheet." This requires Subinventory-level accounts.
*   **Expense Subinventories**: "Why is the 'Floor Stock' subinventory showing up as an Asset?" (Answer: It's mapped to an Asset account instead of an Expense account).
*   **Setup Errors**: Missing accounts cause transaction errors.

## Solution
This report lists the account mapping.
*   **Accounts**: Material, Overhead, Resource, Outside Processing, Expense.
*   **Attributes**: Shows if the subinventory is "Asset" or "Expense" (Quantity Tracked / Asset Inventory flags).
*   **Context**: Organization and Subinventory Name.

## Technical Architecture
*   **Tables**: `mtl_secondary_inventories`, `gl_code_combinations`.
*   **Logic**: Simple dump of the subinventory definition table.

## Parameters
*   **Organization Code**: (Optional) Filter by plant.

## Performance
*   **Fast**: Configuration data.

## FAQ
**Q: What happens if the accounts are blank?**
A: If the subinventory accounts are blank, the system defaults to the Organization-level accounts defined in `mtl_parameters`.
