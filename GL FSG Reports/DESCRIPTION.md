# GL FSG Reports - Case Study & Technical Analysis

## Executive Summary
The **GL FSG Reports** report is a system administration and documentation tool that lists the definitions of Financial Statement Generator (FSG) reports defined in the system. It provides a catalog of existing financial reports, including their associated row sets, column sets, and content sets. This report is essential for maintaining the financial reporting library, identifying obsolete reports, and auditing report definitions during upgrades or re-implementations.

## Business Use Cases
*   **Report Inventory**: Creates a master list of all financial reports (Balance Sheets, P&L, Cash Flow) configured in the system.
*   **Change Management**: Helps track changes to report definitions and ensures that the correct versions of row and column sets are being used.
*   **Cleanup and Optimization**: Identifies unused or duplicate reports that can be retired to declutter the request submission screens.
*   **Migration Planning**: Critical during system upgrades or migrations to document which FSG reports need to be moved or re-tested.
*   **Security Auditing**: Can be used to verify which reports are enabled and available for specific responsibilities (if joined with security data).

## Technical Analysis

### Core Tables
*   `RG_REPORTS_V`: A view containing the header-level definition of FSG reports (Report Name, Title, Row Set ID, Column Set ID).
*   `RG_REPORT_AXIS_SETS`: Stores the definitions of Row Sets and Column Sets.
*   `FND_ID_FLEX_STRUCTURES_VL`: Provides the Chart of Accounts structure name associated with the report.

### Key Joins & Logic
*   **Report Definition**: The query selects from `RG_REPORTS_V` to get the main report attributes.
*   **Structure Association**: Joins to `FND_ID_FLEX_STRUCTURES_VL` via `ID_FLEX_NUM` (Chart of Accounts ID) to indicate which accounting structure the report is built for.
*   **Component Resolution**: While this specific query might focus on the report header, it logically links to `RG_REPORT_AXIS_SETS` to resolve the names of the Row and Column sets used by the report.

### Key Parameters
*   **Structure Name**: Filters the list of reports by the Chart of Accounts structure (e.g., "Corporate Accounting Flexfield").
*   **Row Order**: (Optional) Filters by the specific Row Order definition used in the report.
