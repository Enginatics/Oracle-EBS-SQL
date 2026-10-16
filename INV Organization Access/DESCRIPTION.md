# INV Organization Access - Case Study & Technical Analysis

## Executive Summary
The **INV Organization Access** report is a security audit tool. In Oracle EBS, access to inventory organizations is controlled by the "Organization Access" form (mapping Responsibilities to Orgs). This report lists which responsibilities have access to which organizations, ensuring that users are not granted excessive privileges.

## Business Challenge
In multi-org environments (e.g., a company with 50 warehouses globally), managing security is complex. Risks include:
-   **Data Leakage:** A user in the "US Warehouse" responsibility accidentally seeing "China Manufacturing" data.
-   **Transaction Errors:** A user transacting in the wrong organization because they have access to too many.
-   **Audit Failures:** Auditors require proof that access is restricted on a "Need to Know" basis.

## Solution
The **INV Organization Access** report provides a clear matrix of Responsibility-to-Organization mappings. It validates the security setup defined in the `ORG_ACCESS` table.

**Key Features:**
-   **Security Matrix:** Shows exactly which Orgs are visible to which Responsibilities.
-   **Application Context:** Identifies the application (Inventory, Purchasing, BOM) associated with the responsibility.
-   **User Mapping:** Can be extended to show which *Users* have those responsibilities.

## Technical Architecture
The report queries the security definition tables used by the `ORG_ACCESS_VIEW` mechanism.

### Key Tables and Views
-   **`ORG_ACCESS`**: The table storing the link between `RESPONSIBILITY_ID` and `ORGANIZATION_ID`.
-   **`FND_RESPONSIBILITY_VL`**: Responsibility definitions.
-   **`HR_ALL_ORGANIZATION_UNITS`**: Organization definitions.
-   **`ORG_ACCESS_VIEW`**: The standard view that enforces this security at runtime.

### Core Logic
1.  **Mapping Retrieval:** Selects all records from `ORG_ACCESS`.
2.  **Resolution:** Joins IDs to names for Responsibilities and Organizations.
3.  **Validation:** Checks if the responsibility is still active.

## Business Impact
-   **Security Compliance:** Ensures adherence to Segregation of Duties (SoD) and data access policies.
-   **Error Prevention:** Reduces the risk of accidental transactions in the wrong organization.
-   **Audit Readiness:** Provides immediate evidence of access controls for IT audits.
