# Case Study & Technical Analysis: CAC Item Master Accounts Setup

## Executive Summary
The **CAC Item Master Accounts Setup** report is a configuration audit tool. It lists the General Ledger accounts defined at the Item level (Sales, Cost of Goods Sold, Expense, Encumbrance). This is critical for validating that new items have been set up with the correct accounting drivers before transactions occur.

## Business Challenge
In Oracle EBS, the "Item" is a key driver for accounting logic.
*   **Wrong COGS**: If the COGS account on the item is wrong, every shipment will post to the wrong GL account, requiring manual journal corrections.
*   **Inconsistency**: Similar items (e.g., two types of Laptops) should map to the same Revenue account. Inconsistencies lead to messy financial reporting.
*   **Setup Gaps**: New items often get created without all the necessary accounts populated.

## Solution
This report dumps the accounting attributes for review.
*   **Full Visibility**: Shows the concatenated segments (e.g., 01-000-5000-000) for Sales, COGS, and Expense accounts.
*   **Category Context**: Includes Item Categories to help group similar items and spot outliers (e.g., a "Service" item with a "Hardware" revenue account).
*   **Multi-Org**: Can be run for a specific organization or across the enterprise.

## Technical Architecture
The report joins the Item Master to the GL Code Combinations:
*   **Tables**: `mtl_system_items` and `gl_code_combinations`.
*   **Logic**: It retrieves the `code_combination_id` for each account type (sales_account, cost_of_sales_account, expense_account) and resolves it to the user-friendly segment string.

## Parameters
*   **Organization Code**: (Optional) The inventory org to audit.
*   **Item Number**: (Optional) Specific item check.
*   **Category Set**: (Optional) To filter by product line or asset class.

## Performance
*   **Fast**: This is a straightforward metadata query.
*   **Volume**: Can be large if run for "All Items" in a large master.

## FAQ
**Q: Does this show Subinventory accounts?**
A: No, this report focuses on the *Item Master* accounts. Subinventory accounts are a separate setup (though they override item accounts in some transactions).

**Q: What if the account is blank?**
A: If the account field is null in the database, it will show as blank. This usually indicates a setup deficiency, unless the organization uses Subinventory-level accounting exclusively.

**Q: Can I see the account description?**
A: The standard output shows the account *numbers* (segments). You would typically cross-reference this with your Chart of Accounts to verify the meaning.
