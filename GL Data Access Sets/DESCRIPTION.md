# GL Data Access Sets - Case Study & Technical Analysis

## Executive Summary
The **GL Data Access Sets** report analyzes the security configuration of the General Ledger, specifically focusing on Data Access Sets. It details which ledgers and ledger sets are accessible to specific users or responsibilities, ensuring proper segregation of duties and data security. This report is a key component of system administration and internal audit workflows, providing visibility into "who can see what" within the financial system.

## Business Use Cases
*   **Security Audit**: Verifies that users only have access to the ledgers relevant to their role (e.g., ensuring US users access only US ledgers and cannot view or post to European ledgers).
*   **System Administration**: Assists in troubleshooting "access denied" issues or empty reports by confirming the active Data Access Set configuration for a specific responsibility.
*   **Compliance Reporting**: Documents data access controls for SOX (Sarbanes-Oxley) or internal audit requirements, proving that financial data is protected from unauthorized access.
*   **Implementation Verification**: Validates that the complex hierarchy of Ledgers and Ledger Sets has been correctly mapped to Data Access Sets during system setup.

## Technical Analysis

### Core Tables
*   `GL_ACCESS_SETS`: Defines the header information for a data access set (Name, Security Code, Chart of Accounts ID).
*   `GL_ACCESS_SET_ASSIGNMENTS`: Maps the Data Access Set to specific Ledgers or Ledger Sets.
*   `GL_LEDGERS`: Stores details about the ledgers themselves.
*   `GL_LEDGER_SET_NORM_ASSIGN_V`: A view that helps resolve the flattened list of ledgers contained within a Ledger Set.

### Key Joins & Logic
*   **Access Mapping**: The query joins `GL_ACCESS_SETS` to `GL_ACCESS_SET_ASSIGNMENTS` to find the scope of access.
*   **Ledger Resolution**: It links to `GL_LEDGERS` to retrieve the names of the accessible entities.
*   **Hierarchy Flattening**: A Data Access Set can grant access to a "Ledger Set" (a group of ledgers). The report logic often needs to expand this Ledger Set to list the individual underlying ledgers to provide a complete picture of access.
*   **Privilege Check**: The report distinguishes between `READ_ONLY` and `READ_WRITE` privileges, which is stored in the assignment table.

### Key Parameters
*   **Access Set Name**: The specific data access set to analyze.
*   **Ledger Name**: Filter to see which access sets provide access to a specific ledger.
