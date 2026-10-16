# GL Ledgers and Legal Entities - Case Study & Technical Analysis

## Executive Summary
The **GL Ledgers and Legal Entities** report is a comprehensive master data report that maps the complex hierarchy of the Oracle E-Business Suite financial structure. It visualizes the relationships between Ledger Sets, Ledgers, Legal Entities, and Balancing Segments. This report is essential for verifying the enterprise structure setup, ensuring that legal entities are correctly assigned to ledgers and that balancing segment values (Company Codes) are properly mapped.

## Business Use Cases
*   **Enterprise Structure Verification**: Validates that the system configuration matches the designed corporate structure (e.g., "Does the UK Legal Entity correctly roll up to the UK Ledger?").
*   **Balancing Segment Audit**: Ensures that every Balancing Segment Value (BSV) is assigned to a Legal Entity, preventing "unassigned" transactions that could cause intercompany accounting failures.
*   **Merger & Acquisition Integration**: Assists in planning the integration of new entities by providing a clear picture of the existing ledger and legal entity landscape.
*   **Tax Reporting Setup**: Verifies that Legal Entities (which are the tax reporting units) are associated with the correct Ledgers and Currencies.

## Technical Analysis

### Core Tables
*   `GL_LEDGERS`: The central table defining the ledgers.
*   `XLE_ENTITY_PROFILES` (via `XLE_FIRSTPARTY_INFORMATION_V`): Stores Legal Entity definitions.
*   `GL_LEGAL_ENTITIES_BSVS`: The mapping table that assigns Balancing Segment Values to Legal Entities.
*   `GL_LEDGER_CONFIG_DETAILS`: Stores configuration details linking ledgers to legal entities.
*   `GL_LEDGER_SET_NORM_ASSIGN_V`: Resolves Ledger Set memberships.

### Key Joins & Logic
*   **Hierarchy Traversal**: The query likely starts from `GL_LEDGERS` and joins to `GL_LEDGER_CONFIG_DETAILS` to find the associated Legal Entities.
*   **BSV Mapping**: It joins to `GL_LEGAL_ENTITIES_BSVS` to list the specific segment values (e.g., Company 01, 02) assigned to each entity.
*   **Ledger Set Expansion**: Uses `GL_LEDGER_SET_NORM_ASSIGN_V` to show which Ledger Sets these ledgers belong to, providing a top-down view.
*   **Flexfield Resolution**: Joins to `FND_FLEX_VALUES_VL` to display the descriptions of the balancing segment values.

### Key Parameters
*   **Ledger**: Filter by a specific Ledger or Ledger Set.
*   **Country**: Filter by the country defined in the Legal Entity or Location.
