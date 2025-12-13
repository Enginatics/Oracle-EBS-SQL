# Executive Summary
The **CST Period Close Subinventory Value Summary** is a high-level version of the period close report, designed for multi-org or multi-ledger analysis. It aggregates the period-end inventory values by Subinventory, Organization, and Ledger. This report is ideal for corporate controllers who need to review inventory positions across the entire enterprise at month-end.

# Business Challenge
*   **Consolidated Reporting**: Running separate detailed reports for 50 different warehouses is impractical for executive review.
*   **Ledger Visibility**: Need to see inventory values grouped by the Primary Ledger they belong to.
*   **Trend Monitoring**: Quickly identifying which organizations or subinventories have spiking inventory levels.

# Solution
This report provides a summarized view of period-end inventory values.

**Key Features:**
*   **Ledger Export**: Explicitly supports export by Ledger, facilitating financial consolidation.
*   **Multi-Org**: Can report on multiple organizations in a single run.
*   **Summary Level**: Focuses on the total value per subinventory, rather than item-level detail.

# Architecture
The report uses the `CST_PERIOD_SUMMARY_V` view, which aggregates data from the underlying period close tables.

**Key Tables:**
*   `CST_PERIOD_SUMMARY_V`: The view providing the summarized data.
*   `GL_LEDGERS`: Ledger definitions.
*   `ORG_ORGANIZATION_DEFINITIONS`: Organization hierarchy.

# Impact
*   **Executive Insight**: Provides a "Dashboard" style view of inventory assets across the company.
*   **Financial Consolidation**: Simplifies the process of aggregating inventory values for corporate financial statements.
*   **Exception Management**: Highlights organizations with unusual inventory balances at period end.
