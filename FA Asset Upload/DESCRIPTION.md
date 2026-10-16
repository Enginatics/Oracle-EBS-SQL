# Case Study & Technical Analysis: FA Asset Upload

## Executive Summary
This upload maintains fixed assets in Oracle Fixed Assets. It downloads the assets of one book with their categories, locations, distribution, cost, depreciation reserve, depreciation method and life, and lets an asset accountant create new asset additions, update descriptions, categories and adjustments, and record asset retirements in a spreadsheet. The changes are applied through Oracle's public Fixed Assets APIs, so the rules of the Fixed Assets forms still apply. It is used by asset accountants and by finance teams that load acquisitions from procurement, reclassify assets after a reorganization or retire assets at the end of their life. Blitz Report™ provides the spreadsheet layout.

## Business Challenge
*   **Bulk asset creation:** Large acquisitions, such as a batch of equipment from one project, are slow to enter one asset at a time through the forms.
*   **Reclassification and transfers:** Moving assets between categories, locations or employees must be consistent across all assets of a book.
*   **Retirement and gain or loss:** Retirements must be recorded and then finalized, with the gain or loss posted, so the process needs a clear sequence.

## The Solution
*   Downloads the assets of one book with their description, category, asset key, location, expense account, assigned employee, depreciation method, life, salvage and limit settings, and the current year depreciation.
*   Shows the depreciation reserve, net book value and the year-to-date depreciation from the latest depreciation summary period of each asset.
*   Builds an addition row and a retirement row for each asset in one result, so both can be processed from the same layout.
*   Shows fully retired assets only when Include Retired Assets is set to Yes, and it excludes them from the list otherwise.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_ADDITIONS_VL` and `FA_ADDITIONS_B`: the asset master, with asset number, description, tag, serial number, parent asset and group asset.
*   `FA_BOOKS`: the asset's book record, with cost, original cost, salvage, depreciation method, life, prorate convention and limits.
*   `FA_BOOK_CONTROLS`: the book controls, including the current fiscal year and the ledger.
*   `FA_DEPRN_SUMMARY`: the depreciation reserve and year-to-date depreciation per period.
*   `FA_DISTRIBUTION_HISTORY`: the location, expense account and assigned employee of the asset.
*   `FA_CATEGORIES_B_KFV` and `FA_CATEGORY_BOOKS`: the category and its book assignment.
*   `FA_LOCATIONS_KFV` and `GL_CODE_COMBINATIONS_KFV`: the location and expense account segments.
*   `FA_ASSET_KEYWORDS_KFV`: the asset key.
*   `FA_ADD_WARRANTIES`, `FA_WARRANTIES` and `FA_LEASES`: the warranty and lease of the asset.
*   `FA_RETIREMENTS`: the retirement record, with date, cost retired, proceeds of sale, cost of removal and retirement type.
*   `FA_TRANSACTION_HEADERS`, `FA_DEPRN_PERIODS` and `FA_LOOKUPS`: the transaction dates, the periods and the lookup meanings.
*   `FA_ADDITIONS_B`: a second reference to the asset master, used for the parent asset and the group asset.
*   `GL_LEDGERS` and `PER_ALL_PEOPLE_F`: the ledger of the book and the employee assigned to the asset, with the employee taken as current on the run date.

### Logical Relationships
1. `FA_ADDITIONS_VL` is joined to `FA_BOOKS` on asset identifier, and to `FA_BOOK_CONTROLS` and `GL_LEDGERS` on book.
2. The depreciation summary is restricted to the latest period counter of each asset and book.
3. The distribution history is restricted to the currently effective record, or to the record effective at retirement for a retired asset.
4. Category, location, expense account and asset key are joined on their identifiers.
5. The Addition branch and the Retirement branch are combined with UNION ALL, and the retirement branch adds the retirement columns.

## Parameters & Filtering
*   **Upload Mode:** selects create only, or create and update.
*   **Book:** selects the asset book to download.
*   **Asset Number**, **Category**, **From Category** and **To Category:** limit the assets to one asset or to a category or range of categories.
*   **Asset Type:** limits the assets to one asset type, using the asset type lookup.
*   **Net Book Value Greater Than** and **Net Book Value Less Than:** bound the net book value.
*   **Include Retired Assets:** when Yes, fully retired assets are included.

## Performance & Optimization
*   The depreciation summary is limited to the latest period of each asset through a correlated maximum, so only one summary row is read per asset and book.
*   The distribution history uses the date-ineffective test, or the retirement date for a retired asset, to select the distribution that applies to the row.
*   Lookups of asset type, property type, ownership and other codes are scalar subqueries on the lookup table, so each code is translated once per row.

## FAQ
**Q: How do I retire assets in bulk?**
A: Download the assets, set the Record Type to Retirement for the rows to retire and upload. Then run the Calculate Gains and Losses program to finalize the retirements and post the gain or loss.

**Q: Why are fully retired assets missing from my download?**
A: They are excluded unless Include Retired Assets is set to Yes.

