# Case Study & Technical Analysis: GL Balance Drilldown

## Executive Summary
The GL Balance Drilldown report shows General Ledger balances by code combination for a ledger and period, with opening balance, period debits and credits, net movement and closing balance. It is written for General Ledger accountants, financial reporting teams and consultants who need to see what makes up a balance, not only its total. Standard queries read the summary balances in `GL_BALANCES`, while queries filtered by journal source or category, or using the journal entry balance types, read journal lines instead.
## Business Challenge
*   **Explaining a balance:** Controllers must explain a closing balance by account, which requires the opening balance and the period movement for each combination.
*   **Analysing by source:** Reviewers often need to know how much of a balance came from a given journal source or category, such as payables or manual journals.
*   **Choosing the right basis:** Balances can be taken as year to date, first or last period of the fiscal year, a single period, or journal entry balances in posted or unposted state, each with different meaning.

## The Solution
*   **Balance by account:** The report returns, for each code combination, the opening balance, period debits, period credits, period net, and closing balance.
*   **Two sources, one layout:** Standard balances come from `GL_BALANCES`, and journal source or category filters, or the journal entry balance types, come from `GL_JE_LINES`, with both feeding the same columns.
*   **Balance type selection:** The Balance Type parameter switches the period basis between year to date, first and last period of the fiscal year, a single period and the journal entry types.
*   **Currency and translation control:** Currency code and translated flag parameters select the currency basis, including the statistical currency and the translation options.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_BALANCES`: the summary balances by ledger, code combination, period, currency and balance type.
*   `GL_LEDGERS`: the ledger, its chart of accounts, currency and period set.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations with their concatenated segments.
*   `GL_JE_HEADERS` and `GL_JE_LINES`: journal headers and lines, used when the source, category or journal entry balance type is selected.
*   `GL_JE_SOURCES_VL` and `GL_JE_CATEGORIES_VL`: the translated journal source and category names.
*   `GL_PERIODS`: the period dates, used for journal entry balances by effective date.
*   `GL_BUDGET_VERSIONS` and `GL_ENCUMBRANCE_TYPES`: the budget and encumbrance selections.

### Logical Relationships
1. The report combines two branches with `union all`. The first reads `GL_BALANCES` joined to `GL_LEDGERS` and `GL_CODE_COMBINATIONS_KFV`, and the second reads `GL_JE_LINES` joined to `GL_JE_HEADERS`, `GL_LEDGERS` and `GL_CODE_COMBINATIONS_KFV`.
2. The first branch runs only when no journal source or category is supplied and the balance type is not a journal entry type. The second branch runs only when one of those conditions is true.
3. Journal sources and categories are matched to their identifiers through `GL_JE_SOURCES_VL` and `GL_JE_CATEGORIES_VL`.
4. Budget and encumbrance restrictions are applied as subqueries on `GL_BUDGET_VERSIONS` and `GL_ENCUMBRANCE_TYPES`.
5. The combined rows are aggregated by ledger, account and segment, and the result is ordered by the account.

## Parameters & Filtering
*   **Ledger ID and Period Name:** Identify the ledger and period whose balances are returned.
*   **Balance Type:** Selects year to date, first or last fiscal period, a single period or the journal entry types.
*   **Currency Code and Translated Flag:** Choose the currency basis of the balance, including the ledger currency and the statistical currency.
*   **Journal Source and Journal Category:** When either is entered, the report reads journal lines instead of summary balances.
*   **Multiplier:** Scales all amounts by the value entered, with the default being one.

## Performance & Optimization
*   **Summary path by default:** Standard queries read the summary `GL_BALANCES` table and avoid the journal tables unless a source, category or journal balance type is requested.
*   **Non-summary accounts only:** Only detail accounts are included, so summary parents do not double count.
*   **Flexfield security check:** The security function is evaluated only when flexfield value security is in use, so the cost is incurred only where it applies.

## FAQ
**Q: How do I see the journals behind a GL balance in Excel?**
A: Use the drilldown formula in the drilldown column of the report, which opens the journals for that balance, or filter the report by journal source or category.

**Q: Why does the report switch to journal lines for some balance types?**
A: Journal source and category filters, and the journal entry balance types, cannot be answered from summary balances, so the report reads `GL_JE_LINES` for those cases.

**Q: What is the difference between opening balance and period net?**
A: Opening balance is the beginning balance for the period, period net is the debit less credit movement in the period, and closing balance is the sum of the two.
