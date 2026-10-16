# Case Study & Technical Analysis: FA Asset Inventory 11i

## Executive Summary
FA Asset Inventory 11i reproduces the Oracle Assets standard Asset Inventory Report (FAS410XML) as a spreadsheet. It lists the fixed assets of a depreciation book with their cost, reserve and net book value, their location, cost center, responsible employee, units, serial and tag numbers and whether the asset was placed in service within the chosen date range. Fixed asset accountants, asset managers and controllers use it for physical verification, year-end asset reconciliations and reviews of assets assigned to each cost center.

## Business Challenge
*   **Physical Verification:** Asset managers must match the asset register to the physical items by location, tag and serial number before the count is signed off.
*   **Cost Center Accountability:** Each cost center owner needs the assets charged to it, with their current net book value.
*   **New Additions Tracking:** Finance needs to identify assets placed in service within a period, separately from the rest of the register.
*   **Reconciliation to the Ledger:** Net book value by balancing segment and cost center must agree with the general ledger balances at period close.

## The Solution
*   **Book Level Selection:** The report is driven by one depreciation book and derives its current open period from the book's period calendar.
*   **Cost and Reserve Calculation:** Cost is taken from depreciation detail rows, with the addition cost to clear used for assets in construction, and reserve is summed from the depreciation detail.
*   **Adjustment Path:** A second branch takes cost and reserve from asset adjustments created in the current period for assets that have no addition source, so transfers and retirement adjustments are reflected.
*   **Flexfield Presentation:** Balancing segment, cost center and location are returned through the Accounting Flexfield and Location Flexfield APIs, so they display as segment values.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_BOOK_CONTROLS`: the book definition, used for the accounting flexfield structure, the book class and the set of books.
*   `FA_DEPRN_PERIODS`: the period calendar of the book, used to find the open period.
*   `FA_SYSTEM_CONTROLS`: the system-level settings that supply the company name and flexfield structures.
*   `GL_SETS_OF_BOOKS`: the ledger record that supplies the currency code.
*   `FA_ADDITIONS`: the asset master with the asset number, description, serial number, tag number and asset type.
*   `FA_BOOKS`: the book-specific asset record with the date placed in service and retirement status.
*   `FA_DEPRN_DETAIL`: depreciation detail by period, with cost and reserve.
*   `FA_DISTRIBUTION_HISTORY`: the assignment of each asset to units, cost center, location and employee.
*   `FA_ADJUSTMENTS`: the adjustment records used by the second branch.
*   `FA_LOOKUPS`: the lookup definitions that identify adjustment types.
*   `FA_DEPRN_SUMMARY`: used to determine the current period counter.
*   `FA_LOCATIONS`: the asset location records.
*   `GL_CODE_COMBINATIONS`: the accounting combinations for the distribution.
*   `PER_PEOPLE_F`: the employee who is assigned the asset.

### Logical Relationships
1.  The book-level subqueries in `FA_SYSTEM_CONTROLS` derive the current period, the accounting structure and the book class from `FA_BOOK_CONTROLS` and `FA_DEPRN_PERIODS`.
2.  `FA_DISTRIBUTION_HISTORY` is joined to `FA_ADDITIONS`, `FA_LOCATIONS` and `GL_CODE_COMBINATIONS` on asset, location and code combination, with only active distributions.
3.  `FA_DEPRN_DETAIL` is joined on asset and distribution and restricted to the latest period counter for each asset.
4.  `FA_BOOKS` is joined on asset and limited to assets in the selected book that are not fully retired.
5.  `PER_PEOPLE_F` is joined as an outer join on the assigned employee, effective on the distribution date.
6.  The second branch joins `FA_ADJUSTMENTS` to `FA_LOOKUPS` and the distribution history, keyed to the current period counter.

## Parameters & Filtering
*   **Book:** The depreciation book that drives every subquery and the period calendar.
*   **From Cost Center and To Cost Center:** Bound the cost center range, compared against the derived cost center value.
*   **From Date Placed in Service and To Date Placed in Service:** Limit the assets to those placed in service within the range. Assets in this range are flagged in the New column.

## Performance & Optimization
*   **Book Driven Joins:** Every branch filters on the selected book, so the depreciation and distribution tables are read for one book only.
*   **Latest Period Subquery:** Depreciation detail is restricted to the maximum period counter per distribution, which avoids duplicate cost rows.
*   **Two Branch Aggregation:** Cost and reserve are summed in a grouped depreciation branch and a grouped adjustment branch, then combined.

## FAQ
**Q: How is net book value calculated in this report?**
A: Net book value is the cost of the asset minus the depreciation reserve, both summed from the depreciation and adjustment records of the selected book.

**Q: Which period does the report use for cost and reserve?**
A: It uses the latest period counter for each distribution, so the values reflect the current open period of the selected book.

**Q: How do I list only assets placed in service in a given quarter?**
A: Enter the start and end dates in the From and To Date Placed in Service parameters. The New column marks assets whose placed-in-service date falls within that range.
