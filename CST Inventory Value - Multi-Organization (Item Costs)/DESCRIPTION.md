# Executive Summary
The **CST Inventory Value - Multi-Organization (Item Costs)** report is a comprehensive valuation tool that aggregates inventory data across multiple inventory organizations. Unlike the "Element Costs" version which focuses on the breakdown of cost components (Material, Labor, etc.), this report focuses on the total item cost and quantity types (Onhand, Intransit, Receiving). It serves as a consolidated "All Inventories Value Report" for the entire enterprise.

# Business Challenge
Large enterprises with multiple warehouses (Organizations) often struggle to get a single, consolidated view of their total inventory asset.
*   **Fragmented Reporting**: Standard Oracle reports must be run organization by organization, requiring manual aggregation in Excel.
*   **Intransit Visibility**: Goods moving between warehouses (Intransit) are often missed in standard on-hand reports, leading to an understatement of assets.
*   **Period-End Reconciliation**: Finance needs a snapshot of inventory value at a specific "As Of" date to support the month-end balance sheet.

# Solution
This report provides a multi-org view of inventory value, capable of rolling back to a historical date.

**Key Features:**
*   **Quantity Types**: Reports not just On-hand, but also Intransit and Receiving inspection quantities.
*   **Flexible Grouping**: Can analyze value by Ledger, Operating Unit, Organization, Subinventory, or Cost Group.
*   **Historical Reporting**: The "As of Date" parameter allows for retrospective valuation (though note the limitation on non-costed items).

# Architecture
The report relies on the `XXEN_INV_VALUE` package and standard Oracle temporary tables `CST_INV_QTY_TEMP` and `CST_INV_COST_TEMP` to calculate quantities and costs dynamically.

**Key Tables:**
*   `CST_INV_QTY_TEMP`: Stores calculated quantities based on the "As Of" date.
*   `CST_INV_COST_TEMP`: Stores calculated costs.
*   `MTL_SYSTEM_ITEMS_VL`: Item master data.
*   `ORG_ORGANIZATION_DEFINITIONS`: Organization hierarchy.

# Impact
*   **Consolidated Financials**: Provides the "big picture" number for total inventory assets across the company.
*   **Supply Chain Visibility**: Highlights how much capital is tied up in transit between locations.
*   **Efficiency**: Eliminates the need to run dozens of separate reports for each warehouse.
