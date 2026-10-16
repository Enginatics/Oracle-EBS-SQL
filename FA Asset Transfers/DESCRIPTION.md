# Case Study & Technical Analysis: FA Asset Transfers

## Executive Summary
The FA Asset Transfers report lists the transfers of Oracle Assets fixed assets between distributions, where a distribution is the combination of employee, expense account and location that holds an asset. Each transfer closes the From distributions and creates the To distributions, and the report shows one row per transfer and distribution side. Fixed asset accountants use it to explain how cost, reserve and depreciation moved between cost centers, accounts and locations in a period, and to reconcile the transfers with the General Ledger. It follows the data of the asset transfer records and runs in Excel through Blitz Report.

## Business Challenge
*   **Cost center reporting:** Management reports by cost center or location must show the cost moved in and out during the period, which the asset register alone does not show.
*   **Net zero control:** A transfer should net to zero, and the team needs to verify this for each transfer before close.
*   **Back-dated transfers:** A transfer dated in an earlier period also moves depreciation expense for the periods it reaches back to, which affects prior-period reporting.
*   **Partial unit transfers:** A partial transfer closes the From distribution and recreates it with the remaining units, and the accountant must recognize the remainder to avoid double counting.

## The Solution
*   Lists each transfer with its ledger, book, currency, period, asset number, description, tag and serial number, asset type and category.
*   Shows the side of each distribution, FROM or TO, with units signed negative on the From side and positive on the To side.
*   Shows the cost, reserve, net book value, depreciation expense and revaluation reserve that the transfer moved in the selected book, taken from its accounting adjustments.
*   Shows the expense account, the cost center value from the account's flexfield, the location, the employee and the user who entered the transfer.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_TRANSACTION_HEADERS`: the transfer transaction, with its date, transaction name and the book it applies to.
*   `FA_DISTRIBUTION_HISTORY`: the From and To distributions of each transfer, with units, employee, code combination and location.
*   `FA_ADDITIONS`, `FA_CATEGORIES_B_KFV`: the asset master and its category.
*   `FA_ADJUSTMENTS`: the accounting adjustments that the transfer created, by adjustment type.
*   `FA_BOOK_CONTROLS_SEC`, `GL_SETS_OF_BOOKS` and `FA_DEPRN_PERIODS`: the book, its ledger and the period of the transfer.
*   `PER_ALL_PEOPLE_F`, `GL_CODE_COMBINATIONS_KFV` and `FA_LOCATIONS_KFV`: the employee, the expense account and the location.
*   `FA_LOOKUPS`: the asset type and side labels.

### Logical Relationships
1.  The transfer header is joined to the book controls on the distribution source book, and to the deprecation period whose open and close dates contain the transfer date.
2.  `FA_DISTRIBUTION_HISTORY` is read twice in a UNION ALL, once on the out transaction for the FROM side and once on the in transaction for the TO side.
3.  The transfer is joined to `FA_ADJUSTMENTS` on transaction header, distribution and book, where the source type is TRANSFER. Costs and reserves are summed by adjustment type with their debit or credit sign.
4.  The employee is an outer join to `PER_ALL_PEOPLE_F` valid on the entry date, and the account and location are joined on their code combination and location ids.

## Parameters & Filtering
*   **Ledger** and **Book:** select the ledger and the asset book whose transfers are listed.
*   **Period From** and **Period To:** bound the deprecation periods of the transfers.
*   **Transfer Date From** and **Transfer Date To:** bound the transfer dates.
*   **Asset Number** and **Category:** limit the list to one asset or one category.

## Performance & Optimization
*   The period join is a range match on the transfer date against the period open and close dates, so each transfer reads one period row.
*   The adjustment amounts are aggregated once in an inline view grouped by transaction, distribution and book, and then joined to the transfers.
*   The employee lookup is limited to the effective dates that contain the entry date, which keeps the join to a single row per person.
*   Narrowing the Book and the period range before the run limits the distribution history rows that the UNION ALL has to read.

## FAQ
**Q: How do I check that an asset transfer nets to zero?**
A: Sum the Units, Cost and Reserve columns for the transfer number. The From side is negative and the To side is positive, so the total is zero for a complete transfer.

**Q: Why does the To side show units for a partial transfer?**
A: A partial unit transfer closes the From distribution and recreates it with the remaining units. The remainder appears on the To side and nets against the closed distribution.