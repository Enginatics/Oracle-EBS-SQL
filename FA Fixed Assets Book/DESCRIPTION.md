# Case Study & Technical Analysis: FA Fixed Assets Book

## Executive Summary
The FA Fixed Assets Book report lists the assets held in one depreciation book, with their cost, depreciation and net book value as at the end of the selected period. Each row is one asset distribution, showing the balancing segment, expense account, cost center, asset category, employee and location. Fixed asset accountants and controllers use it for period-end reconciliation of the asset register to the general ledger, and for the depreciation review that precedes a close. The report is an Enginatics replacement for the standard Oracle RXi: Fixed Assets Book report, and it uses the same extraction routine as the RX-only data program, so cost and depreciation figures are identical. It runs in Excel via Blitz Report.

## Business Challenge
*   **Period-end reconciliation:** Asset cost and accumulated depreciation must agree with the balances used for the period close, and the book must be reviewed before the close is finalized.
*   **Split assets:** An asset spread across several cost centers or employees must be reported by distribution, with its share of units and percent clearly shown.
*   **Impaired assets:** Net book value must reflect impairment reserves, which the standard view may not separate from depreciation.

## The Solution
*   **Distribution-level detail:** Units and percent show each distribution's share, and the cost and depreciation amounts are the distribution's share rather than the asset total.
*   **Period balances:** Cost, year-to-date and life-to-date depreciation are taken from the last depreciation run on or before the selected period.
*   **Full segment descriptions:** Balancing segment, expense account, cost center and category segments are returned with their descriptions read from the flexfield value sets.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_RESERVE_LEDGER_GT`: the global temporary table of depreciation reserve balances for the selected period, which drives the extraction.
*   `FA_DISTRIBUTION_HISTORY`: asset distributions by cost center, location and assigned employee, with effective dates.
*   `FA_ADDITIONS`: the asset master, including asset number, description, tag, serial number and asset type.
*   `FA_ASSET_HISTORY`: the category assignment and units of each asset, with effective dates.
*   `FA_BOOKS`: the book assignment, salvage value and group asset link.
*   `FA_BOOK_CONTROLS`, `FA_DEPRN_PERIODS`, `FA_FISCAL_YEAR`: the book, period and fiscal year definitions.
*   `FA_CATEGORY_BOOKS`, `FA_CATEGORY_BOOK_DEFAULTS`, `FA_CATEGORIES_VL`, `FA_CATEGORIES_B_KFV`: category and book default information.
*   `GL_LEDGERS`, `GL_CODE_COMBINATIONS`: the ledger and the account combinations of the distributions.
*   `FND_ID_FLEX_SEGMENTS`, `FND_SEGMENT_ATTRIBUTE_VALUES`: the segment roles used to identify the balancing, account and cost center columns.
*   `FA_LOCATIONS_KFV`, `FA_ASSET_KEYWORDS_KFV`, `PER_ALL_PEOPLE_F`: location, asset key and employee details.

### Logical Relationships
1. `FA_BOOK_CONTROLS` is joined to `GL_LEDGERS` on the set of books, and `FA_DEPRN_PERIODS` supplies the period close date.
2. `FA_RESERVE_LEDGER_GT` is joined to `FA_ADDITIONS` on asset, to `FA_DISTRIBUTION_HISTORY` on asset, distribution and code combination, and to `FA_ASSET_HISTORY` on asset.
3. `FA_CATEGORY_BOOKS` and `FA_BOOKS` are joined on the book and asset, with date-effective conditions on each history row.
4. The fiscal year joins `FA_BOOK_CONTROLS` and tests the placed-in-service date against the fiscal year start and end.
5. Segment descriptions are resolved by inline views over `GL_CODE_COMBINATIONS` and the category flexfield, using the segment role columns.

## Parameters & Filtering
*   **Book and Period:** The book is required and the period sets the depreciation period close used for the balances.
*   **Drill Down into Group Assets:** When set, the member assets of group assets are included; otherwise a group asset is represented by its group alone.
*   **Balancing Segment, Expense Account and Cost Center From/To:** Restrict the output to the account ranges entered.
*   **Major Category, Minor Category and Category Segment Value From/To:** Restrict the output to the category ranges, with Category Segment naming the flexfield segment to filter on.
*   **Property Type, Asset Number From/To:** Restrict the output by property type and asset number range.

## Performance & Optimization
*   The segment description and category subqueries are wrapped in `no_merge` inline views, which prevents them from being merged into the main extraction.
*   The reserve ledger is read from a global temporary table filled for the selected period, so the depreciation balances are not recalculated.
*   Date-effective conditions on distribution, asset and book history keep each asset to the row valid at the period.

## FAQ
**Q: Why does an asset appear more than once in the FA Fixed Assets Book report?**
A: The report returns one row per asset distribution, so an asset split across several cost centers or employees appears once for each distribution, with its share of units and percent.

**Q: Why is depreciation amount zero for some assets?**
A: The depreciation amount is filled only where the last depreciation run is the selected period itself, so an asset whose last run is earlier shows zero.

**Q: How is net book value at period end calculated?**
A: It is cost less life-to-date depreciation less the impairment reserve, so an impaired asset has a lower value than cost less depreciation alone.
