# GL Code Combinations - Case Study & Technical Analysis

## Executive Summary
The **GL Code Combinations** report is a master data management tool designed to audit, analyze, and maintain the Chart of Accounts structure. It lists valid accounting flexfield combinations, their attributes (such as account type and enabled status), and helps identify misclassified accounts or setup inconsistencies. This report is critical for maintaining the integrity of the financial reporting structure and ensuring that data entry adheres to corporate governance standards.

## Business Use Cases
*   **Master Data Governance**: Ensures all created account combinations adhere to corporate naming conventions and validation rules, preventing the proliferation of invalid or duplicate accounts.
*   **Misclassification Audit**: Identifies accounts with incorrect types (e.g., an Asset account incorrectly flagged as an Expense), which can severely distort financial statements and trial balances.
*   **Cleanup Initiatives**: Assists in identifying disabled, end-dated, or unused code combinations to streamline the chart of accounts and improve system performance.
*   **Cross-Validation Rule Testing**: Verifies that existing combinations comply with newly defined cross-validation rules (CVRs) and security rules.
*   **Revaluation Setup**: Validates that revaluation tracking is enabled for the correct foreign currency accounts.

## Technical Analysis

### Core Tables
*   `GL_CODE_COMBINATIONS` (often aliased as `GCC`): The central table storing every unique combination of segment values used in the system.
*   `FND_FLEX_VALUES`: Stores the definitions and attributes of individual segment values.
*   `FND_ID_FLEX_STRUCTURES_VL`: Provides metadata about the Chart of Accounts structure.

### Key Joins & Logic
*   **Segment Validation**: The report iterates through `GL_CODE_COMBINATIONS`. It joins to `FND_FLEX_VALUES` for each segment to retrieve descriptions and attributes.
*   **Misclassification Logic**: A critical feature is the detection of misclassified accounts. The logic typically compares the `ACCOUNT_TYPE` on the `GL_CODE_COMBINATIONS` record (which is stamped upon creation) against the `COMPILED_VALUE_ATTRIBUTE1` (Account Type) of the natural account segment value in `FND_FLEX_VALUES`. If they differ (e.g., the natural account is now an 'Asset' but the combination remains 'Expense'), it flags the record for correction.
*   **Flexfield Hierarchy**: The query dynamically handles the number of segments defined in the user's Chart of Accounts (COA) structure.

### Key Parameters
*   **Chart of Accounts**: The specific accounting structure to analyze.
*   **Account Type**: Filter to view only Assets, Liabilities, Expenses, Revenue, or Equity.
*   **Show Misclassified Accounts**: A boolean flag to trigger the logic that identifies discrepancies between segment attributes and combination attributes.
*   **Segment Ranges**: Allows filtering by specific companies, cost centers, or natural accounts.
