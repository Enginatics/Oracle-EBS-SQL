# GL Rollup Groups - Case Study & Technical Analysis

## Executive Summary
The **GL Rollup Groups** report documents the "Rollup Group" structures defined within the Chart of Accounts. Rollup Groups are used to create summary accounts and hierarchies for reporting. For example, multiple "Department" values might roll up into a "Cost Center Group". This report helps visualize these relationships and is essential for maintaining the reporting hierarchy.

## Business Use Cases
*   **Hierarchy Maintenance**: Audits the parent-child relationships in the Chart of Accounts to ensure that all child values are correctly assigned to a parent rollup group.
*   **Summary Account Planning**: Used when designing new Summary Accounts (Template) to identify which rollup groups are available to be used as parents.
*   **Reporting Structure Review**: Validates that the financial reports which rely on these rollup groups (e.g., "Total US Expenses") will capture the correct underlying data.
*   **Migration Documentation**: Documents the hierarchy structure for migration to other reporting tools (like Hyperion or BI).

## Technical Analysis

### Core Tables
*   `FND_FLEX_HIERARCHIES_VL`: Stores the definitions of the Rollup Groups themselves.
*   `FND_FLEX_VALUE_SETS`: Defines the value set to which the rollup group belongs.
*   *(Implicit)* `FND_FLEX_VALUES`: The individual segment values are assigned to these rollup groups (via `COMPILED_VALUE_ATTRIBUTE` or `HIERARCHY_LEVEL`).

### Key Joins & Logic
*   **Hierarchy Definition**: The query lists records from `FND_FLEX_HIERARCHIES_VL`.
*   **Value Set Context**: Joins to `FND_FLEX_VALUE_SETS` to ensure the rollup group is identified with the correct segment (e.g., distinguishing between a "Department" rollup and a "Product" rollup).
*   **Tree Structure**: While this report might list the groups, the underlying logic in Oracle uses these groups to build a tree structure for summary account maintenance.

### Key Parameters
*   *(None specific listed, likely filters by Value Set or Structure implicitly)*
