# Case Study & Technical Analysis

## Abstract
The **DIS Access Privileges** report is a security auditing tool for Oracle Discoverer. It maps the complex web of permissions within the End User Layer (EUL), showing which users or responsibilities have access to specific Business Areas and Workbooks. This report is essential for compliance audits and for cleaning up access rights during a migration project.

## Technical Analysis

### Core Relationships
*   **Users/Roles**: Discoverer privileges can be granted to individual Oracle Users or to Responsibilities (Roles).
*   **Business Areas**: The primary container for data access. If a user has access to a Business Area, they can query any folder within it.
*   **Workbooks**: Specific reports shared with users.

### Key Tables
*   `EUL5_ACCESS_PRIVS`: The central table linking users/roles (`AP_EU_ID`) to objects (`AP_ELEMENT_ID`).
*   `EUL5_DOCUMENTS`: Stores workbook definitions.
*   `EUL5_BAS`: Stores Business Area definitions.

### Operational Use Cases
*   **Security Audit**: "Who has access to the 'HR Confidential' Business Area?"
*   **License Management**: Identifying inactive users who still hold Discoverer privileges.
*   **Migration Planning**: Determining which users need to be trained on the new reporting tool based on their current access.
