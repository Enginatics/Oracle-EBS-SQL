# INV Transaction Source Types - Case Study & Technical Analysis

## Executive Summary
The **INV Transaction Source Types** report is a system configuration report. In Oracle Inventory, every transaction has a "Source Type" that defines *where* the transaction originated (e.g., "Purchase Order", "Sales Order", "Account", "Job or Schedule"). This report lists these system-defined sources.

## Business Challenge
Understanding the "Source" of a transaction is key to understanding the business process.
-   **Reporting:** When building custom reports, developers need to know that Source Type 1 = "Purchase Order" and Source Type 2 = "Sales Order".
-   **Validation:** Users need to know which sources are available when defining new Transaction Types.

## Solution
The **INV Transaction Source Types** report lists the values from `MTL_TXN_SOURCE_TYPES`. These are mostly seeded (system-defined) values that cannot be changed, but they are critical for reference.

**Key Features:**
-   **ID Mapping:** Shows the numeric ID and the user-friendly name.
-   **Validation:** Used as the validation set for the "Source" field in many other forms.

## Technical Architecture
The report queries the seed data table.

### Key Tables and Views
-   **`MTL_TXN_SOURCE_TYPES`**: The table storing the source definitions.

### Core Logic
1.  **Retrieval:** Selects all records from the table.
2.  **Display:** Lists the ID, Name, and Description.

## Business Impact
-   **Developer Aid:** Essential reference for anyone writing SQL queries against `MTL_MATERIAL_TRANSACTIONS`.
-   **System Understanding:** Helps users understand the different "origins" of inventory demand and supply.
