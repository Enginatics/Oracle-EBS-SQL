# INV Subinventories - Case Study & Technical Analysis

## Executive Summary
The **INV Subinventories** report is a configuration audit document. It lists all the subinventories (storage areas) defined within an organization, along with their control parameters. This report is crucial for validating the physical layout of the warehouse against the system configuration.

## Business Challenge
Subinventories are the primary "zones" of a warehouse (e.g., "Raw Materials", "Finished Goods", "Returns"). Incorrect setup leads to:
-   **Accounting Errors:** If the "Expense" subinventory is linked to an Asset account, the balance sheet will be wrong.
-   **Process Failures:** If a subinventory is not "Quantity Tracked", stock will disappear from the books as soon as it is received.
-   **Planning Issues:** If the "Nettable" flag is off, MRP will ignore the stock in that area, leading to unnecessary purchasing.

## Solution
The **INV Subinventories** report provides a detailed view of each subinventory's configuration. It serves as the "BR100" (Setup Document) for the warehouse structure.

**Key Features:**
-   **Control Flags:** Shows Quantity Tracked, Asset Inventory, Nettable, and Include in ATP flags.
-   **Account Mapping:** Displays the Material and Expense accounts linked to the subinventory.
-   **Locators:** Indicates if the subinventory requires Locator control (Prespecified, Dynamic, or None).

## Technical Architecture
The report queries the secondary inventory definition table.

### Key Tables and Views
-   **`MTL_SECONDARY_INVENTORIES`**: The master table for subinventory definitions.
-   **`MTL_PARAMETERS`**: Organization context.
-   **`GL_CODE_COMBINATIONS`**: Account details.

### Core Logic
1.  **Retrieval:** Selects all records from `MTL_SECONDARY_INVENTORIES` for the organization.
2.  **Decoding:** Translates flags (1/2) into Yes/No.
3.  **Context:** Joins to the GL to show the account segments (e.g., 01-000-1210-0000).

## Business Impact
-   **Setup Validation:** Ensures that the system configuration matches the business design.
-   **Financial Integrity:** Verifies that inventory value is flowing to the correct GL accounts.
-   **Operational Control:** Confirms that restricted areas (like "Quarantine") are properly flagged to prevent accidental usage.
