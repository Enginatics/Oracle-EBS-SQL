# INV Transaction Types - Case Study & Technical Analysis

## Executive Summary
The **INV Transaction Types** report is a configuration document that lists all the defined "Actions" that can be performed on inventory. Examples include "PO Receipt", "Subinventory Transfer", "Miscellaneous Issue", and "WIP Assembly Return". This report defines the rules for each action.

## Business Challenge
Transaction Types control the financial and operational behavior of a movement.
-   **Financial Impact:** "Does this 'Sample Issue' hit the Marketing Expense account or the Scrap account?"
-   **Process Control:** "Does this 'RMA Receipt' require a Quality Inspection?"
-   **Location Control:** "Can I perform this transaction in a WMS-enabled organization?"

## Solution
The **INV Transaction Types** report details the setup of each transaction type. It shows the link between the user-facing name (e.g., "Misc Issue") and the system behavior (e.g., "Issue from Stores").

**Key Features:**
-   **Action Definition:** Shows the "Source Type" (e.g., Inventory) and "Action" (e.g., Issue from Stores).
-   **Financial Flags:** Indicates if the transaction is "Project Enabled" or "Location Required".
-   **Status Control:** Shows if the transaction is valid for certain material statuses.

## Technical Architecture
The report queries the transaction type definition table.

### Key Tables and Views
-   **`MTL_TRANSACTION_TYPES`**: The master table for transaction definitions.
-   **`MTL_TXN_SOURCE_TYPES`**: The source type linked to the transaction.

### Core Logic
1.  **Retrieval:** Selects all records from `MTL_TRANSACTION_TYPES`.
2.  **Context:** Joins to `MTL_TXN_SOURCE_TYPES` to explain the source.
3.  **Validation:** Checks flags for Status Control and Location Control.

## Business Impact
-   **Process Standardization:** Ensures that everyone uses the correct transaction type for a given business scenario (e.g., using "Scrap Issue" instead of "Misc Issue").
-   **Financial Accuracy:** Ensures that transactions drive the correct accounting entries.
-   **System Governance:** Documents the allowed inventory movements for audit purposes.
