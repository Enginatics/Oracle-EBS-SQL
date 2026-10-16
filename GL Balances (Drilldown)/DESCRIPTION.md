# Case Study & Technical Analysis: GL Balances (Drilldown)

## Executive Summary
The GL Balances (Drilldown) report shows General Ledger balances for each code combination, with opening balance, debit, credit, net and closing balance. It is the balance-level detail behind the GL Financial Statement and Drilldown reports, and it can be used on its own by accountants who want to see which accounts make up a financial statement line. Each row carries a drill-to-journal formula, so the user can move from a balance to the journal lines that produced it. The report supports every balance type, including period-to-date, year-to-date, quarter-to-date, project-to-date, and the financial year start and end balances.

## Business Challenge
*   **Explaining statement lines:** Financial statement totals are sums of account balances, and reviewers need the balance of each account behind a line.
*   **Balance type choice:** Accountants need to compare period, quarter, year and project balances, and each balance type answers a different question.
*   **Actual, budget and encumbrance:** The same account may hold actual, budget and encumbrance balances, and these must be kept apart.
*   **Tracing to source:** When a balance looks wrong, the user needs to reach the journals behind it without searching the journal screens.

## The Solution
*   **Balances per combination:** Balances are summed for each code combination, so every account appears once per balance type, currency and budget or encumbrance version.
*   **Full balance set:** Opening, period debit, period credit, net and closing balances are returned together.
*   **Balance-type labels:** The actual flag is translated to its batch type description, and the budget name and encumbrance type are shown for those balances.
*   **Drill to journal:** A formula is generated for each row that opens the journal details for that ledger, period, amount type, currency, balance type and code combination.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_LEDGERS`: the ledger, which supplies the ledger name, ledger ID and chart of accounts.
*   `GL_BALANCES`: the balance rows, one per ledger, code combination, period, currency, balance type and version.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations, with the concatenated segments and the chart of accounts.
*   `GL_BUDGET_VERSIONS`: the budget version name, read for budget balances.
*   `GL_ENCUMBRANCE_TYPES`: the encumbrance type name, read for encumbrance balances.

### Logical Relationships
1.  `GL_LEDGERS` is joined to `GL_BALANCES` on the ledger ID, and `GL_BALANCES` is joined to `GL_CODE_COMBINATIONS_KFV` on the code combination ID.
2.  The combination's chart of accounts must match the ledger's chart of accounts, and only detail accounts are kept.
3.  Template balances are excluded, so only balances from actual ledger postings are returned.
4.  Budget name and encumbrance type are looked up by scalar subquery from the balance's version and encumbrance type IDs.
5.  An inner aggregation sums the balance amounts by ledger, combination, balance type, actual flag, budget, encumbrance type, currency and drill formula. Rows with all amounts at zero are removed.
6.  The aggregated result is joined back to `GL_CODE_COMBINATIONS_KFV` to show the concatenated account, and sorted by it.

## Parameters & Filtering
*   **Ledger and Ledger ID:** Select the ledger whose balances are returned.
*   **Period and Amount Type:** Choose the accounting period and the balance type, such as PTD, YTD or QTD, that the balances are read for.
*   **Currency Code and Currency Type:** Select the currency of the balances.
*   **Balance Type and Budget Name:** Separate actual balances from budget balances, and choose the budget version.
*   **Encumbrance Type:** Selects the encumbrance balances to show.
*   **Concatenated Segments and Code Combination ID:** Restrict the accounts shown.
*   **Restrict CCIDs through GTT:** Limits the code combinations to a list held in a global temporary table.

## Performance & Optimization
*   **Ledger and balance filters first:** The ledger join and the balance restriction are applied before the code combination join, so the scan starts from one ledger's balances.
*   **Template balances excluded:** Balances with a template ID are removed in the inner query, so only balances from ledger postings are summed.
*   **Zero rows removed before the outer join:** Rows where every amount is zero are dropped in the inner query, which reduces the rows joined to the account table.
*   **Scalar lookups for names:** Budget and encumbrance names come from scalar subqueries, which are evaluated only for the balance rows that have those IDs.

## FAQ
**Q: How do I see the journals behind a balance?**
A: Use the drill-to-journal formula in the Drill To Journal column. It opens the journal details for that ledger, period, amount type, currency, balance type and code combination.
**Q: Why does an account appear more than once?**
A: The report returns a row for each balance type, currency, budget version and encumbrance type that has a non-zero amount for the account.
**Q: Which balance types can I run?**
A: The report supports PTD, YTD, QTD, PJTD, FYS, FYE and CTD balances, selected through the Amount Type parameter.
