# Case Study & Technical Analysis

## Abstract
The **DIS Items, Folders and Formulas** report provides a granular technical breakdown of the Discoverer End User Layer (EUL). It focuses specifically on the *logic* embedded within the EUL: calculated items (formulas), complex joins, and folder definitions. This report is a critical reference for developers tasked with re-implementing Discoverer logic in SQL or other reporting tools.

## Technical Analysis

### Core Components
*   **Formulas**: Extracts the exact PL/SQL expression used for calculated items (e.g., `CASE WHEN x > 10 THEN 'High' ELSE 'Low' END`).
*   **Joins**: Displays the join conditions defined between folders, which often contain critical business logic that isn't present in the database foreign keys.
*   **LOV Validation**: Checks if the SQL backing a List of Values is valid and performant.

### Key Tables
*   `EUL5_EXPRESSIONS`: The repository of all item formulas.
*   `EUL5_KEY_CONS`: Defines the joins (key constraints) between folders.

### Operational Use Cases
*   **Reverse Engineering**: "The 'Net Revenue' item in Discoverer doesn't match the General Ledger. What is the formula?"
*   **Migration**: Copy-pasting complex `CASE` statements from Discoverer directly into new SQL reports.
*   **Cleanup**: Identifying broken formulas that reference non-existent columns.
