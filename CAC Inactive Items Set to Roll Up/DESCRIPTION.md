# Case Study & Technical Analysis: CAC Inactive Items Set to Roll Up

## Executive Summary
The **CAC Inactive Items Set to Roll Up** report is a specialized inventory and costing diagnostic tool designed to ensure the accuracy of standard cost rollups. It identifies a specific data quality issue where items marked as "Inactive" are still flagged to be included in cost rollups. By detecting these inconsistencies, the report helps organizations prevent invalid or obsolete items from distorting product costs and inventory valuations.

## Business Challenge
In Oracle EBS Cost Management, the "Based on Rollup" flag determines if an item's cost is calculated during a standard cost rollup. A common configuration error occurs when an item is retired (set to Inactive status) but the "Based on Rollup" flag remains set to "Yes".
*   **Distorted Costs**: Inactive items might retain old, incorrect costs that get rolled up into parent assemblies, leading to inaccurate finished good costs.
*   **Processing Overhead**: The cost rollup process wastes resources calculating costs for items that are no longer in use.
*   **Data Inconsistency**: Contradictory settings (Inactive vs. Rollup=Yes) confuse users and complicate data maintenance.

## Solution
This report provides a targeted exception list to proactively manage item master data quality.
*   **Exception Reporting**: Filters specifically for items where `Inventory_Item_Status_Code` indicates inactivity (default 'Inactive') but `Based_on_Rollup` is enabled.
*   **Multi-Org Visibility**: Can be run across multiple inventory organizations, operating units, and ledgers to identify widespread issues.
*   **Actionable Output**: Provides the Item Number, Organization, and Category details needed to quickly locate and correct the master data.

## Technical Architecture
The report is built on a robust SQL query that joins key Inventory and Costing tables:
*   **Primary Tables**: `mtl_system_items_vl` (Item Master), `cst_item_costs` (Cost Details), and `mtl_item_status_vl` (Status Definitions).
*   **Security**: Implements standard Oracle EBS security (Operating Unit and Inventory Org access) via `org_access_view` and `mo_glob_org_access_tmp`.
*   **Logic**: The core logic compares the item's status against the user-provided "Inactive Item Status" parameter and checks the rollup flag.

## Parameters
*   **Cost Type**: (Mandatory) The cost type to analyze (e.g., Frozen, Pending).
*   **Inactive Item Status**: (Mandatory) The status code representing inactive items (default: 'Inactive').
*   **Category Set 1 & 2**: (Optional) Filter by specific item categories (e.g., Cost Category, Product Line).
*   **Item Number**: (Optional) Analyze a specific item.
*   **Organization Code**: (Optional) Limit to a specific inventory organization.
*   **Operating Unit**: (Optional) Filter by Operating Unit.
*   **Ledger**: (Optional) Filter by General Ledger.

## Performance
The report is optimized for large item masters:
*   **Selective Filtering**: By filtering on Cost Type and Item Status early in the execution plan, it minimizes the data set processed.
*   **Efficient Joins**: Uses standard keys (Inventory_Item_Id, Organization_Id) for high-performance joins between Item and Cost tables.

## FAQ
**Q: Why does an inactive item affect my rollup?**
A: If an inactive item is a component in an active Bill of Material (BOM) and "Based on Rollup" is Yes, the rollup process will attempt to cost it, potentially using outdated purchase prices or routing data.

**Q: How do I fix the items identified?**
A: You should update the Item Master for these items, unchecking the "Based on Rollup" flag in the Costing tab.

**Q: Can I use this for statuses other than 'Inactive'?**
A: Yes, the "Inactive Item Status" parameter allows you to check for any status code (e.g., 'Obsolete', 'Phase-Out').
