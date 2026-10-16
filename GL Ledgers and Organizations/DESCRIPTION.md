# GL Ledgers and Organizations - Case Study & Technical Analysis

## Executive Summary
The **GL Ledgers and Organizations** report extends the structural analysis of the system by mapping Ledgers down to the Operating Unit and Inventory Organization level. It provides a complete "vertical" view of the organization structure, from the Business Group down to the specific warehouse or manufacturing plant. This report is critical for system administrators and supply chain managers to understand how operational entities relate to financial ledgers.

## Business Use Cases
*   **Multi-Org Access Control (MOAC) Review**: Helps administrators verify which Operating Units are linked to which Ledgers, aiding in the setup of security profiles.
*   **Supply Chain Configuration**: Validates that Inventory Organizations are assigned to the correct Operating Units and Ledgers, ensuring that material transactions post to the correct GL accounts.
*   **Implementation Documentation**: Generates a "As-Built" document of the organization structure after a new implementation or rollout.
*   **Troubleshooting Accounting Issues**: When a subledger transaction fails to post, this report helps confirm that the originating organization is correctly mapped to a valid ledger.

## Technical Analysis

### Core Tables
*   `HR_OPERATING_UNITS`: Defines the Operating Units (Org ID).
*   `ORG_ORGANIZATION_DEFINITIONS`: A key view that links Inventory Orgs to Operating Units and Ledgers.
*   `GL_LEDGERS`: The financial ledger.
*   `HR_ALL_ORGANIZATION_UNITS`: The base table for all organization types (Business Groups, OUs, Inv Orgs).
*   `HR_LOCATIONS_ALL`: Provides address and country information.

### Key Joins & Logic
*   **Organizational Hierarchy**: The query typically joins `ORG_ORGANIZATION_DEFINITIONS` (which contains `SET_OF_BOOKS_ID`/`LEDGER_ID`) to `GL_LEDGERS`.
*   **Operating Unit Link**: It links Inventory Orgs to their parent Operating Unit via `OPERATING_UNIT` column.
*   **Business Group Context**: It resolves the Business Group to show the highest level of the hierarchy.
*   **Location Details**: Joins to `HR_LOCATIONS_ALL` to retrieve the country and address, which is useful for tax and legal compliance checks.

### Key Parameters
*   **Ledger**: Filter by specific ledger.
*   **Operating Unit**: Filter by specific OU.
*   **Organization Code**: Filter by specific Inventory Org code (e.g., "M1").
*   **Active Organizations only**: A flag to exclude end-dated or inactive organizations.
