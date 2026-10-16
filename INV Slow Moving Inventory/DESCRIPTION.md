# Case Study & Technical Analysis: INV Slow Moving Inventory

## Executive Summary
The INV Slow Moving Inventory report identifies slow moving, excess and obsolete stock in Oracle Inventory. It lists items that still hold on-hand quantity at a chosen as-of date but have had no material movement over a chosen period, and shows their value, usage rate and months of supply. Inventory controllers and finance teams use it to size obsolescence provisions and to decide which stock should be reviewed, written down or redeployed. The on-hand position is rebuilt as at the as-of date, so the figures are historical rather than current. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Obsolescence provisioning:** Finance must estimate the value of stock that has not moved, supported by item-level values as at the reporting date.
*   **Excess inventory review:** Planners need the months of supply each item represents at its recent usage, to decide where to reduce purchasing.
*   **Historical accuracy:** Closing inventory for a past date must be rebuilt, because current balances change with every transaction since that date.
*   **Adjustment noise:** Cycle count and physical inventory adjustments can make an item look active when it has not been used.

## The Solution
*   **Historical on-hand:** On-hand is rebuilt as at the as-of date by reversing every material transaction posted after that date against the current on-hand detail.
*   **No-activity test:** An item is dropped as a whole if any of its subinventories had a qualifying transaction in the no-activity window.
*   **Usage and supply:** Issue quantities in the usage window give the usage quantity, average monthly usage and months of supply.
*   **Valuation:** Quantities are valued at the item cost of the organization's primary cost method.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the current on-hand per organization, item and subinventory, the starting point of the rollback.
*   `MTL_MATERIAL_TRANSACTIONS`: the material transactions used to reverse post-as-of activity and to measure usage and last activity.
*   `MTL_TRANSACTION_TYPES`: the name of the last transaction type.
*   `MTL_SECONDARY_INVENTORIES`: the subinventory description, type and asset flag.
*   `MTL_SYSTEM_ITEMS_VL`: the item, status, type, make-buy code, planner and unit of measure.
*   `CST_ITEM_COSTS` and `CST_COST_TYPES`: the item cost of the primary cost method.
*   `MTL_PARAMETERS`: the organization, its cost organization and primary cost method.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the organization name.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

### Logical Relationships
1.  The innermost query unions current on-hand rows with material transactions of the accessible organizations, excluding logical transactions.
2.  Each transaction contributes its reversal to on-hand when dated after the as-of date, usage when in the usage window and of an issue action, and a last transaction date when it falls before the as-of date.
3.  Rows are aggregated by organization, item and subinventory, then by organization and item with analytic sums.
4.  The item-level result joins to the organization, subinventory, item master, item cost and transaction type.
5.  Only rows with on-hand not equal to zero and no activity in the window are returned, ordered by organization, item value descending, item and subinventory.

## Parameters & Filtering
*   **Organization Code:** selects the inventory organization.
*   **As of Date:** the date at which the on-hand is rebuilt.
*   **No Activity Since:** the start of the window in which any material movement excludes the item.
*   **Usage Months:** the number of months before the as-of date over which usage is measured.
*   **Ignore Adjustment Transactions:** when Y, cycle count, physical inventory and cost update transactions are excluded from the activity test and from the last transaction date.
*   **Subinventory** and **Item:** narrow the output.
*   **Category Set 1** to **Category Set 3:** restrict the items by category and add category columns.

## Performance & Optimization
*   The rollback is a single pass over the material transactions, so each transaction is read once and classified by date and action in the same row.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied before both the on-hand and transaction branches.
*   Analytic sums and `KEEP (DENSE_RANK LAST)` aggregates compute item totals and the last transaction without a second join.
*   Cost is joined only through the primary cost method, so a single cost row per item is used.

## FAQ
**Q: Why are the on-hand quantities different from the current balances?**
A: On-hand is rebuilt as at the As of Date by reversing every material transaction posted after that date, so it matches the historical position.

**Q: What does an empty Months of Supply value mean?**
A: It means the item had no usage in the usage window, so months of supply cannot be calculated.

**Q: How do adjustments affect whether an item is reported as slow moving?**
A: When Ignore Adjustment Transactions is Y, cycle count, physical inventory and cost update transactions do not count as activity, so an item with only adjustments can still be reported.
