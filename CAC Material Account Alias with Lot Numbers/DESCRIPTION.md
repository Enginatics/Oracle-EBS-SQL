# Case Study & Technical Analysis: CAC Material Account Alias with Lot Numbers

## Executive Summary
The **CAC Material Account Alias with Lot Numbers** report is a compliance and traceability tool. It focuses on "Account Alias" transactions—manual inventory adjustments where the user selects a GL account alias (e.g., "Scrap", "R&D Issue", "Inventory Adjustment"). Crucially, this report includes **Lot Number** details, which are often missing from standard GL reports.

## Business Challenge
*   **Traceability**: If a specific lot of chemicals is scrapped, Quality Assurance needs to know *exactly* which lot it was to update their records. Standard GL reports only show the dollar amount.
*   **Audit**: "Miscellaneous Issue" is a high-risk transaction type. Auditors scrutinize these to ensure inventory isn't being stolen or written off without cause.
*   **Cost Control**: Tracking which departments (via Account Alias) are consuming the most material for non-production purposes.

## Solution
This report provides a detailed audit trail.
*   **Lot Visibility**: Splits transactions by Lot Number, showing the specific quantity and cost for each lot.
*   **Alias Context**: Groups by the Account Alias name (e.g., "Engineering Sample") rather than just the cryptic GL account number.
*   **Financial Impact**: Shows the Unit Cost and Total Value of the adjustment.

## Technical Architecture
The report joins the transaction history to the lot transaction table:
*   **Tables**: `mtl_material_transactions` (MMT) and `mtl_transaction_lot_numbers` (MTLN).
*   **Join Logic**: `MMT.transaction_id = MTLN.transaction_id`.
*   **Alias Resolution**: Joins to `mtl_generic_dispositions` to get the user-friendly Alias Name.

## Parameters
*   **Transaction Date From/To**: (Mandatory) Audit period.
*   **Show Lot Number**: (Mandatory) "Yes" triggers the join to the lot table.
*   **Account Alias**: (Optional) Filter for a specific type of adjustment.

## Performance
*   **Volume**: MMT is the largest table in Oracle EBS. Running this for a wide date range without filters can be slow.
*   **Lot Explosion**: If "Show Lot Number" is Yes, a single transaction for 10 lots will become 10 rows, increasing the output size.

## FAQ
**Q: What if the item is not lot controlled?**
A: The report will still show the transaction, but the Lot Number column will be blank (or the row will not split, depending on the join type).

**Q: Does this show "Account Alias Receipts" too?**
A: Yes, it shows both Issues (negative qty) and Receipts (positive qty) performed via the Account Alias screen.

**Q: Can I see who performed the transaction?**
A: Yes, the report typically includes the "Created By" user, which is essential for auditing manual adjustments.
